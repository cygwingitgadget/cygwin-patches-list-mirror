Return-Path: <cygwin-patches-return-7279-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28789 invoked by alias); 11 Apr 2011 02:30:46 -0000
Received: (qmail 28491 invoked by uid 22791); 11 Apr 2011 02:30:43 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 11 Apr 2011 02:30:38 +0000
Received: by gye5 with SMTP id 5so2489232gye.2        for <cygwin-patches@cygwin.com>; Sun, 10 Apr 2011 19:30:37 -0700 (PDT)
Received: by 10.236.95.10 with SMTP id o10mr5796175yhf.410.1302489037370;        Sun, 10 Apr 2011 19:30:37 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id g2sm2300025yhc.76.2011.04.10.19.30.35        (version=SSLv3 cipher=OTHER);        Sun, 10 Apr 2011 19:30:36 -0700 (PDT)
Subject: [PATCH] pthread_getattr_np, pthread_setschedprio
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-f7LSjyBPiEg21gsChUfH"
Date: Mon, 11 Apr 2011 02:30:00 -0000
Message-ID: <1302489035.4944.20.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00045.txt.bz2


--=-f7LSjyBPiEg21gsChUfH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1201

This patch adds two pthread functions which appear to be "low-hanging
fruit".

pthread_setschedprio(3) is a POSIX function[1][2] which changes the
scheduling priority for the given thread.  It is similar to
pthread_setschedparam(3) but does not change the scheduling policy and
doesn't require the priority to be wrapped in a struct.

pthread_getattr_np(3) is a GNU extension[3] which initializes the given
pthread_attr_t with the actual attributes of the given thread.  While
the example code does not have the pthread_attr_t pre-initialized by
pthread_attr_init(3), I have seen real world code where it is, so either
possibility is handled.

This is my first contribution to the threading code, so I'd appreciate a
thorough double-check of my understanding of the specs and code.

Patch for winsup/cygwin attached.  As for winsup/doc/new-features.sgml,
should this be merged with the pthread spinlocks line item or kept
separate?

Yaakov


[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_setschedprio.html
[2] http://www.kernel.org/doc/man-pages/online/pages/man3/pthread_setschedprio.3.html
[3] http://www.kernel.org/doc/man-pages/online/pages/man3/pthread_getattr_np.3.html


--=-f7LSjyBPiEg21gsChUfH
Content-Disposition: attachment; filename="pthread_funcs.patch"
Content-Type: text/x-patch; name="pthread_funcs.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 5111

2011-04-10  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* thread.cc (pthread_getattr_np, pthread_setschedprio): New functions.
	* include/pthread.h (pthread_getattr_np, pthread_setschedprio): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* cygwin.din (pthread_getattr_np, pthread_setschedprio): Export.
	* posix.sgml (std-gnu): Add pthread_getattr_np.
	(std-notimpl) Move pthread_setschedprio from here...
	(std-susv4) ...to here.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.234
diff -u -r1.234 cygwin.din
--- cygwin.din	29 Mar 2011 10:32:40 -0000	1.234
+++ cygwin.din	10 Apr 2011 08:49:54 -0000
@@ -1199,6 +1199,7 @@
 pthread_detach SIGFE
 pthread_equal SIGFE
 pthread_exit SIGFE
+pthread_getattr_np SIGFE
 pthread_getconcurrency SIGFE
 pthread_getschedparam SIGFE
 pthread_getsequence_np SIGFE
@@ -1241,6 +1242,7 @@
 pthread_setcanceltype SIGFE
 pthread_setconcurrency SIGFE
 pthread_setschedparam SIGFE
+pthread_setschedprio SIGFE
 pthread_setspecific SIGFE
 pthread_sigmask SIGFE
 pthread_suspend SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.55
diff -u -r1.55 posix.sgml
--- posix.sgml	29 Mar 2011 10:32:40 -0000	1.55
+++ posix.sgml	10 Apr 2011 08:49:54 -0000
@@ -598,6 +598,7 @@
     pthread_setcanceltype
     pthread_setconcurrency
     pthread_setschedparam
+    pthread_setschedprio
     pthread_setspecific
     pthread_sigmask
     pthread_spin_destroy
@@ -1115,6 +1116,7 @@
     pipe2
     pow10
     pow10f
+    pthread_getattr_np
     removexattr
     setxattr
     strchrnul
@@ -1388,7 +1390,6 @@
     pthread_mutex_timedlock
     pthread_rwlock_timedrdlock
     pthread_rwlock_timedwrlock
-    pthread_setschedprio
     putmsg
     reminderl
     remquol
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.227
diff -u -r1.227 thread.cc
--- thread.cc	29 Mar 2011 10:32:40 -0000	1.227
+++ thread.cc	10 Apr 2011 08:49:55 -0000
@@ -2228,6 +2228,29 @@
   return 0;
 }
 
+extern "C" int
+pthread_getattr_np (pthread_t thread, pthread_attr_t *attr)
+{
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  /* attr may not be pre-initialized */
+  if (!pthread_attr::is_good_object (attr))
+  {
+    int rv = pthread_attr_init (attr);
+    if (rv != 0)
+      return rv;
+  }
+
+  (*attr)->joinable = thread->attr.joinable;
+  (*attr)->contentionscope = thread->attr.contentionscope;
+  (*attr)->inheritsched = thread->attr.inheritsched;
+  (*attr)->schedparam = thread->attr.schedparam;
+  (*attr)->stacksize = thread->attr.stacksize;
+
+  return 0;
+}
+
 /* provided for source level compatability.
    See http://www.opengroup.org/onlinepubs/007908799/xsh/pthread_getconcurrency.html
 */
@@ -2306,6 +2329,17 @@
   return rv;
 }
 
+extern "C" int
+pthread_setschedprio (pthread_t thread, int priority)
+{
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+  int rv =
+    sched_set_thread_priority (thread->win32_obj_id, priority);
+  if (!rv)
+    thread->attr.schedparam.sched_priority = priority;
+  return rv;
+}
 
 extern "C" int
 pthread_setspecific (pthread_key_t key, const void *value)
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.29
diff -u -r1.29 pthread.h
--- include/pthread.h	29 Mar 2011 10:32:40 -0000	1.29
+++ include/pthread.h	10 Apr 2011 08:49:55 -0000
@@ -194,11 +194,13 @@
 int pthread_setcancelstate (int, int *);
 int pthread_setcanceltype (int, int *);
 int pthread_setschedparam (pthread_t, int, const struct sched_param *);
+int pthread_setschedprio (pthread_t, int);
 int pthread_setspecific (pthread_key_t, const void *);
 void pthread_testcancel (void);
 
 /* Non posix calls */
 
+int pthread_getattr_np (pthread_t, pthread_attr_t *);
 int pthread_suspend (pthread_t);
 int pthread_continue (pthread_t);
 int pthread_yield (void);
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.339
diff -u -r1.339 version.h
--- include/cygwin/version.h	29 Mar 2011 10:32:40 -0000	1.339
+++ include/cygwin/version.h	10 Apr 2011 08:49:55 -0000
@@ -403,12 +403,13 @@
       237: Export strchrnul.
       238: Export pthread_spin_destroy, pthread_spin_init, pthread_spin_lock,
 	   pthread_spin_trylock, pthread_spin_unlock.
+      239: Export pthread_getattr_np, pthread_setschedprio.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 238
+#define CYGWIN_VERSION_API_MINOR 239
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-f7LSjyBPiEg21gsChUfH--
