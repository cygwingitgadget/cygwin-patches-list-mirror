Return-Path: <cygwin-patches-return-4523-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6050 invoked by alias); 22 Jan 2004 21:06:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6041 invoked from network); 22 Jan 2004 21:06:24 -0000
Message-ID: <40103708.1020501@gmx.net>
Date: Thu, 22 Jan 2004 21:06:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH]: 2. Thread safe stdio update
Content-Type: multipart/mixed;
 boundary="------------060209090802010608050406"
X-SW-Source: 2004-q1/txt/msg00013.txt.bz2

This is a multi-part message in MIME format.
--------------060209090802010608050406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 437

This is an update of my previous patch. It adds support for newlibs 
__LOCK_INIT macro.

Thomas

2004-01-22 Thomas Pfaff <tpfaff@gmx.net>

	* include/sys/_types.h: New file.
	* include/sys/lock.h: Ditto.
	* include/sys/stdio.h: Ditto.
	* thread.cc: Include sys/lock.h
	(__cygwin_lock_init): New function.
	(__cygwin_lock_init_recursive): Ditto.
	(__cygwin_lock_fini): Ditto.
	(__cygwin_lock_lock): Ditto.
	(__cygwin_lock_unlock): Ditto.

--------------060209090802010608050406
Content-Type: text/plain;
 name="cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch"
Content-length: 4384

diff -urpN cygwin.org/include/sys/_types.h cygwin/include/sys/_types.h
--- cygwin.org/include/sys/_types.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/sys/_types.h	2004-01-12 08:02:01.775041600 +0100
@@ -0,0 +1,37 @@
+/* ANSI C namespace clean utility typedefs */
+
+/* This file defines various typedefs needed by the system calls that support
+   the C library.  Basically, they're just the POSIX versions with an '_'
+   prepended.  This file lives in the `sys' directory so targets can provide
+   their own if desired (or they can put target dependant conditionals here).
+*/
+
+#ifndef	_SYS__TYPES_H
+#define _SYS__TYPES_H
+
+typedef long _off_t;
+__extension__ typedef long long _off64_t;
+
+#if defined(__INT_MAX__) && __INT_MAX__ == 2147483647
+typedef int _ssize_t;
+#else
+typedef long _ssize_t;
+#endif
+
+#define __need_wint_t
+#include <stddef.h>
+
+/* Conversion state information.  */
+typedef struct
+{
+  int __count;
+  union
+  {
+    wint_t __wch;
+    unsigned char __wchb[4];
+  } __value;		/* Value so far.  */
+} _mbstate_t;
+
+typedef void *_flock_t;
+
+#endif	/* _SYS__TYPES_H */
diff -urpN cygwin.org/include/sys/lock.h cygwin/include/sys/lock.h
--- cygwin.org/include/sys/lock.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/sys/lock.h	2004-01-21 14:34:30.341939200 +0100
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
+++ cygwin/include/sys/stdio.h	2004-01-21 14:34:03.493332800 +0100
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
--- cygwin.org/thread.cc	2004-01-19 09:37:50.000000000 +0100
+++ cygwin/thread.cc	2004-01-22 13:49:27.961144000 +0100
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

--------------060209090802010608050406--
