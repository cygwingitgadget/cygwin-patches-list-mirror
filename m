Return-Path: <cygwin-patches-return-4519-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18928 invoked by alias); 19 Jan 2004 21:01:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18912 invoked from network); 19 Jan 2004 21:01:41 -0000
Message-ID: <400C40AB.7080107@gmx.net>
Date: Mon, 19 Jan 2004 21:01:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH]: Thread safe stdio update
Content-Type: multipart/mixed;
 boundary="------------030102020700030200060606"
X-SW-Source: 2004-q1/txt/msg00009.txt.bz2

This is a multi-part message in MIME format.
--------------030102020700030200060606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 659

This is an update of my previous patch. It will add support for thread 
safe stdio by adding 3 new header files in include/sys which supersedes 
newlib headers.

One of these (_types.h) is just a copy of newlibs _types.h with a 
modified _lock_t. It is not strictly necessary since sizeof(int) == 
sizeof(void*).

2004-01-19  Thomas Pfaff  <tpfaff@gmx.net>

	* include/sys/_types.h: New file.
	* include/sys/lock.h: Ditto.
	* include/sys/stdio.h: Ditto.
	* thread.cc: Include sys/lock.h
	(__cygwin_lock_init_recursive): New function.
	(__cygwin_lock_fini_recursive): Ditto.
	(__cygwin_lock_lock_recursive): Ditto.
	(__cygwin_lock_unlock_recursive): Ditto.




--------------030102020700030200060606
Content-Type: text/plain;
 name="cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch"
Content-length: 3901

diff -urpN cygwin.org/include/sys/_types.h cygwin/include/sys/_types.h
--- cygwin.org/include/sys/_types.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/sys/_types.h	2004-01-12 08:02:00.000000000 +0100
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
+++ cygwin/include/sys/lock.h	2004-01-12 08:11:50.000000000 +0100
@@ -0,0 +1,21 @@
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
+typedef void *_LOCK_RECURSIVE_T;
+
+#define __lock_init_recursive(__lock) __cygwin_lock_init_recursive(&__lock)
+#define __lock_acquire_recursive(__lock) __cygwin_lock_lock_recursive(&__lock)
+#define __lock_release_recursive(__lock) __cygwin_lock_unlock_recursive(&__lock)
+#define __lock_close_recursive(__lock) __cygwin_lock_fini_recursive(&__lock)
+
+#endif
diff -urpN cygwin.org/include/sys/stdio.h cygwin/include/sys/stdio.h
--- cygwin.org/include/sys/stdio.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/sys/stdio.h	2004-01-16 14:15:24.000000000 +0100
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
+#    define _flockfile(fp) __cygwin_lock_lock_recursive ((_LOCK_RECURSIVE_T *)&(fp)->_lock)
+#  endif
+#  if !defined(_funlockfile)
+#    define _funlockfile(fp) __cygwin_lock_unlock_recursive ((_LOCK_RECURSIVE_T *)&(fp)->_lock)
+#  endif
+#endif
+ 
+#endif
diff -urpN cygwin.org/thread.cc cygwin/thread.cc
--- cygwin.org/thread.cc	2004-01-19 09:37:50.075833600 +0100
+++ cygwin/thread.cc	2004-01-19 09:41:09.672840000 +0100
@@ -44,6 +44,7 @@ details. */
 #include <sys/timeb.h>
 #include <exceptions.h>
 #include <sys/fcntl.h>
+#include <sys/lock.h>
 
 extern int threadsafe;
 
@@ -54,6 +55,32 @@ __getreent ()
   return &_my_tls.local_clib;
 }
 
+extern "C" void
+__cygwin_lock_init_recursive (_LOCK_RECURSIVE_T *lock)
+{
+  *lock = NULL;
+  if (!pthread_mutex_init ((pthread_mutex_t*) lock, NULL))
+    (*(pthread_mutex_t*)lock)->type = PTHREAD_MUTEX_RECURSIVE;
+}
+
+extern "C" void
+__cygwin_lock_fini_recursive (_LOCK_RECURSIVE_T *lock)
+{
+  pthread_mutex_destroy ((pthread_mutex_t*) lock);
+}
+
+extern "C" void
+__cygwin_lock_lock_recursive (_LOCK_RECURSIVE_T *lock)
+{
+  pthread_mutex_lock ((pthread_mutex_t*) lock);
+}
+
+extern "C" void
+__cygwin_lock_unlock_recursive (_LOCK_RECURSIVE_T *lock)
+{
+  pthread_mutex_unlock ((pthread_mutex_t*) lock);
+}
+
 inline LPCRITICAL_SECTION
 ResourceLocks::Lock (int _resid)
 {


--------------030102020700030200060606--
