Return-Path: <cygwin-patches-return-4608-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26831 invoked by alias); 14 Mar 2004 19:28:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26792 invoked from network); 14 Mar 2004 19:28:06 -0000
X-Authenticated: #623905
Message-ID: <4054B242.9080606@gmx.net>
Date: Sun, 14 Mar 2004 19:28:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [RFA]: Thread safe stdio again
Content-Type: multipart/mixed;
 boundary="------------030309060407060403020502"
X-SW-Source: 2004-q1/txt/msg00098.txt.bz2

This is a multi-part message in MIME format.
--------------030309060407060403020502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 708

This time i am using the non portable mutex initializers, therefore
moving __sinit is no longer needed. And i added calls to newlibs
__fp_lock_all and __fp_unlock_all at fork.

2004-03-14 Thomas Pfaff <tpfaff@gmx.net>

	* include/cygwin/_types.h: New file.
	* include/sys/lock.h: Ditto.
	* include/sys/stdio.h: Ditto.
	* thread.cc: Include sys/lock.h
	(__cygwin_lock_init): New function.
	(__cygwin_lock_init_recursive): Ditto.
	(__cygwin_lock_fini): Ditto.
	(__cygwin_lock_lock): Ditto.
	(__cygwin_lock_trylock): Ditto.
	(__cygwin_lock_unlock): Ditto.
	(pthread::atforkprepare): Lock file pointer before fork.
	(pthread::atforkparent): Unlock file pointer after fork.
	(pthread::atforkchild): Ditto.








--------------030309060407060403020502
Content-Type: text/plain;
 name="cygwin_lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin_lock.patch"
Content-length: 4658

diff -urpN cygwin.org/include/cygwin/_types.h cygwin/include/cygwin/_types.h
--- cygwin.org/include/cygwin/_types.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/cygwin/_types.h	2004-02-19 09:01:26.000000000 +0100
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
+++ cygwin/include/sys/lock.h	2004-02-19 09:01:28.000000000 +0100
@@ -0,0 +1,40 @@
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
+ * This must match cygwins PTHREAD_XXX_MUTEX_INITIALIZER_NP which are
+ * defined in <pthread.h>
+ */
+#define _LOCK_T_RECURSIVE_INITIALIZER ((_LOCK_T)18)
+#define _LOCK_T_INITIALIZER ((_LOCK_T)19)
+
+#define __LOCK_INIT(CLASS,NAME) \
+  CLASS _LOCK_T NAME = _LOCK_T_INITIALIZER; 
+#define __LOCK_INIT_RECURSIVE(CLASS,NAME) \
+  CLASS _LOCK_T NAME = _LOCK_T_RECURSIVE_INITIALIZER;
+
+#define __lock_init(__lock) __cygwin_lock_init(&__lock)
+#define __lock_init_recursive(__lock) __cygwin_lock_init_recursive(&__lock)
+#define __lock_close(__lock) __cygwin_lock_fini(&__lock)
+#define __lock_close_recursive(__lock) __cygwin_lock_fini(&__lock)
+#define __lock_acquire(__lock) __cygwin_lock_lock(&__lock)
+#define __lock_acquire_recursive(__lock) __cygwin_lock_lock(&__lock)
+#define __lock_try_acquire(lock) __cygwin_lock_trylock(&__lock)
+#define __lock_try_acquire_recursive(lock) __cygwin_lock_trylock(&__lock)
+#define __lock_release(__lock) __cygwin_lock_unlock(&__lock)
+#define __lock_release_recursive(__lock) __cygwin_lock_unlock(&__lock)
+
+#endif
diff -urpN cygwin.org/include/sys/stdio.h cygwin/include/sys/stdio.h
--- cygwin.org/include/sys/stdio.h	1970-01-01 01:00:00.000000000 +0100
+++ cygwin/include/sys/stdio.h	2004-02-19 09:01:28.000000000 +0100
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
--- cygwin.org/thread.cc	2004-03-04 21:39:29.000000000 +0100
+++ cygwin/thread.cc	2004-03-14 20:01:18.000000000 +0100
@@ -44,6 +44,10 @@ details. */
 #include <sys/timeb.h>
 #include <exceptions.h>
 #include <sys/fcntl.h>
+#include <sys/lock.h>
+
+extern "C" void __fp_lock_all ();
+extern "C" void __fp_unlock_all ();
 
 extern int threadsafe;
 
@@ -54,6 +58,43 @@ __getreent ()
   return &_my_tls.local_clib;
 }
 
+extern "C" void
+__cygwin_lock_init (_LOCK_T *lock)
+{
+  *lock = _LOCK_T_INITIALIZER;
+}
+
+extern "C" void
+__cygwin_lock_init_recursive (_LOCK_T *lock)
+{
+  *lock = _LOCK_T_RECURSIVE_INITIALIZER;
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
+__cygwin_lock_trylock (_LOCK_T *lock)
+{
+  pthread_mutex_trylock ((pthread_mutex_t*) lock);
+}
+
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
@@ -1908,11 +1949,15 @@ pthread::atforkprepare (void)
       cb->cb ();
       cb = cb->next;
     }
+
+  __fp_lock_all ();
 }
 
 void
 pthread::atforkparent (void)
 {
+  __fp_unlock_all ();
+
   callback *cb = MT_INTERFACE->pthread_parent;
   while (cb)
     {
@@ -1926,6 +1971,8 @@ pthread::atforkchild (void)
 {
   MT_INTERFACE->fixup_after_fork ();
 
+  __fp_unlock_all ();
+
   callback *cb = MT_INTERFACE->pthread_child;
   while (cb)
     {




--------------030309060407060403020502--
