Return-Path: <cygwin-patches-return-4568-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3408 invoked by alias); 11 Feb 2004 10:09:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3397 invoked from network); 11 Feb 2004 10:09:17 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <4029FF39.9080806@gmx.net>
Date: Wed, 11 Feb 2004 10:09:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To: cygpatches <cygwin-patches@cygwin.com>
Subject: [PATCH] Thread safe stdio
Content-Type: multipart/mixed;
 boundary="------------010804020202050304030501"
X-SW-Source: 2004-q1/txt/msg00058.txt.bz2

This is a multi-part message in MIME format.
--------------010804020202050304030501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1163

_flock_t is now defined in cygwin/_types.h. I will sent following patch 
for newlib when this one is applied:

--- _types.h.org	2004-01-26 23:33:11.000000000 +0100
+++ _types.h	2004-02-10 12:28:44.359443200 +0100
@@ -9,6 +9,10 @@
  #ifndef	_SYS__TYPES_H
  #define _SYS__TYPES_H

+#ifdef __CYGWIN__
+#include <cygwin/_types.h>
+#endif
+
  typedef long _off_t;
  __extension__ typedef long long _off64_t;

@@ -32,7 +36,9 @@ typedef struct
    } __value;		/* Value so far.  */
  } _mbstate_t;

+#ifndef __CYGWIN__
  typedef int _flock_t;
+#endif

  /* Iconv descriptor type */
  typedef void *_iconv_t;


The __sinit call must be done after malloc is initialized, otherwise the 
mutex creation will fail.

Thomas

2004-02-11 Thomas Pfaff <tpfaff@gmx.net>

	* include/cygwin/_types.h: New file.
	* include/sys/lock.h: Ditto.
	* include/sys/stdio.h: Ditto.
	* dcrt0.cc (dll_crt0_1): Add __sinit call after malloc
	initialization.
	(_dll_crt0): Remove __sinit call.
	* thread.cc: Include sys/lock.h
	(__cygwin_lock_init): New function.
	(__cygwin_lock_init_recursive): Ditto.
	(__cygwin_lock_fini): Ditto.
	(__cygwin_lock_lock): Ditto.
	(__cygwin_lock_unlock): Ditto.


--------------010804020202050304030501
Content-Type: plain/text;
 name="stdio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stdio.patch"
Content-length: 4813

diff -urpN cygwin.org/dcrt0.cc cygwin/dcrt0.cc
--- cygwin.org/dcrt0.cc	2004-02-10 12:09:20.469726400 +0100
+++ cygwin/dcrt0.cc	2004-02-10 13:08:02.549700800 +0100
@@ -756,10 +756,13 @@ dll_crt0_1 (char *)
   ProtectHandle (hMainProc);
   ProtectHandle (hMainThread);
 
-  /* Initialize pthread mainthread when not forked and it is safe to call new,
-     otherwise it is reinitalized in fixup_after_fork */
+  /* Initialize pthread mainthread and stdio when not forked.
+     Note: Must be done after malloc is initialized */
   if (!user_data->forkee)
-    pthread::init_mainthread ();
+    {
+      pthread::init_mainthread ();
+      __sinit (_impure_ptr);
+    }
 
 #ifdef DEBUGGING
   strace.microseconds ();
@@ -946,8 +949,6 @@ _dll_crt0 ()
 
   if (child_proc_info && child_proc_info->type == _PROC_FORK)
     user_data->forkee = child_proc_info->cygpid;
-  else
-    __sinit (_impure_ptr);
 
   initialize_main_tls (padding);
   dll_crt0_1 (padding);
diff -urpN cygwin.org/include/cygwin/_types.h cygwin/include/cygwin/_types.h
--- cygwin.org/include/cygwin/_types.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/cygwin/_types.h	2004-02-10 12:25:45.382086400 +0100
@@ -0,0 +1,16 @@
+/* cygwin/_types.h
+
+   Copyright 2004 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _CYGWIN__TYPES_H
+#define _CYGWIN__TYPES_H
+
+typedef void *_flock_t;
+
+#endif	/* _CYGWIN__TYPES_H */
diff -urpN cygwin.org/include/sys/lock.h cygwin/include/sys/lock.h
--- cygwin.org/include/sys/lock.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/sys/lock.h	2004-02-10 12:19:32.649998400 +0100
@@ -0,0 +1,36 @@
+/* sys/lock.h
+
+   Copyright 2004 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _SYS_LOCK_H_
+#define _SYS_LOCK_H_
+
+typedef void *_LOCK_T;
+#define _LOCK_RECURSIVE_T _LOCK_T
+
+/*
+ * This must match cygwins PTHREAD_MUTEX_INITIALIZER which is
+ * defined in <pthread.h>
+ */
+#define _LOCK_T_INITIALIZER ((_LOCK_T)20)
+
+#define __LOCK_INIT(CLASS,NAME) \
+  CLASS _LOCK_T NAME = _LOCK_T_INITIALIZER; 
+
+#define __lock_init(__lock) __cygwin_lock_init(&__lock)
+#define __lock_close(__lock) __cygwin_lock_fini(&__lock)
+#define __lock_acquire(__lock) __cygwin_lock_lock(&__lock)
+#define __lock_release(__lock) __cygwin_lock_unlock(&__lock)
+
+#define __lock_init_recursive(__lock) __cygwin_lock_init_recursive(&__lock)
+#define __lock_close_recursive(__lock) __cygwin_lock_fini(&__lock)
+#define __lock_acquire_recursive(__lock) __cygwin_lock_lock(&__lock)
+#define __lock_release_recursive(__lock) __cygwin_lock_unlock(&__lock)
+
+#endif
diff -urpN cygwin.org/include/sys/stdio.h cygwin/include/sys/stdio.h
--- cygwin.org/include/sys/stdio.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/sys/stdio.h	2004-02-10 12:19:32.740128000 +0100
@@ -0,0 +1,25 @@
+/* sys/stdio.h
+
+   Copyright 2004 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _SYS_STDIO_H_
+#define _SYS_STDIO_H_
+
+#include <sys/lock.h>
+
+#if !defined(__SINGLE_THREAD__)
+#  if !defined(_flockfile)
+#    define _flockfile(fp) __cygwin_lock_lock ((_LOCK_T *)&(fp)->_lock)
+#  endif
+#  if !defined(_funlockfile)
+#    define _funlockfile(fp) __cygwin_lock_unlock ((_LOCK_T *)&(fp)->_lock)
+#  endif
+#endif
+ 
+#endif
diff -urpN cygwin.org/thread.cc cygwin/thread.cc
--- cygwin.org/thread.cc	2004-02-10 12:09:00.180552000 +0100
+++ cygwin/thread.cc	2004-02-10 12:19:32.900358400 +0100
@@ -44,6 +44,7 @@ details. */
 #include <sys/timeb.h>
 #include <exceptions.h>
 #include <sys/fcntl.h>
+#include <sys/lock.h>
 
 extern int threadsafe;
 
@@ -54,6 +55,39 @@ __getreent ()
   return &_my_tls.local_clib;
 }
 
+extern "C" void
+__cygwin_lock_init (_LOCK_T *lock)
+{
+  *lock = NULL;
+  pthread_mutex_init ((pthread_mutex_t*) lock, NULL);
+}
+
+extern "C" void
+__cygwin_lock_init_recursive (_LOCK_T *lock)
+{
+  *lock = NULL;
+  if (!pthread_mutex_init ((pthread_mutex_t*) lock, NULL))
+    (*(pthread_mutex_t*)lock)->type = PTHREAD_MUTEX_RECURSIVE;
+}
+
+extern "C" void
+__cygwin_lock_fini (_LOCK_T *lock)
+{
+  pthread_mutex_destroy ((pthread_mutex_t*) lock);
+}
+
+extern "C" void
+__cygwin_lock_lock (_LOCK_T *lock)
+{
+  pthread_mutex_lock ((pthread_mutex_t*) lock);
+}
+
+extern "C" void
+__cygwin_lock_unlock (_LOCK_T *lock)
+{
+  pthread_mutex_unlock ((pthread_mutex_t*) lock);
+}
+
 inline LPCRITICAL_SECTION
 ResourceLocks::Lock (int _resid)
 {

--------------010804020202050304030501--
