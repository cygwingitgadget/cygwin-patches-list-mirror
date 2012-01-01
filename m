Return-Path: <cygwin-patches-return-7581-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 317 invoked by alias); 1 Jan 2012 18:59:16 -0000
Received: (qmail 303 invoked by uid 22791); 1 Jan 2012 18:59:15 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-qw0-f50.google.com (HELO mail-qw0-f50.google.com) (209.85.216.50)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 01 Jan 2012 18:59:02 +0000
Received: by qaea17 with SMTP id a17so10086188qae.2        for <cygwin-patches@cygwin.com>; Sun, 01 Jan 2012 10:59:01 -0800 (PST)
Received: by 10.224.186.130 with SMTP id cs2mr14121765qab.82.1325444339481;        Sun, 01 Jan 2012 10:58:59 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id fe5sm62026879qab.5.2012.01.01.10.58.57        (version=SSLv3 cipher=OTHER);        Sun, 01 Jan 2012 10:58:58 -0800 (PST)
Message-ID: <1325444340.6724.15.camel@YAAKOV04>
Subject: [PATCH] Add pthread_sigqueue(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Sun, 01 Jan 2012 18:59:00 -0000
Content-Type: multipart/mixed; boundary="=-Z15XPrLOqmOSghkppxZN"
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
X-SW-Source: 2012-q1/txt/msg00004.txt.bz2


--=-Z15XPrLOqmOSghkppxZN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 281

This patchset adds pthread_sigqueue(3), a GNU extension:

http://www.kernel.org/doc/man-pages/online/pages/man3/pthread_sigqueue.3.html

The implementation is based on the existing sigqueue(2) and
pthread_kill(3) code.

Patches for winsup/cygwin and winsup/doc attached.


Yaakov


--=-Z15XPrLOqmOSghkppxZN
Content-Disposition: attachment; filename="cygwin-pthread_sigqueue.patch"
Content-Type: text/x-patch; name="cygwin-pthread_sigqueue.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3540

2012-01-??  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (pthread_sigqueue): Export.
	* posix.sgml (std-gnu): Add pthread_sigqueue.
	* thread.cc (pthread_sigqueue): New function.
	* include/thread.h (pthread_sigqueue): New function.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.246
diff -u -p -r1.246 cygwin.din
--- cygwin.din	3 Aug 2011 19:17:02 -0000	1.246
+++ cygwin.din	4 Aug 2011 09:21:52 -0000
@@ -1270,6 +1270,7 @@ pthread_setschedparam SIGFE
 pthread_setschedprio SIGFE
 pthread_setspecific SIGFE
 pthread_sigmask SIGFE
+pthread_sigqueue SIGFE
 pthread_suspend SIGFE
 pthread_spin_destroy SIGFE
 pthread_spin_init SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.70
diff -u -p -r1.70 posix.sgml
--- posix.sgml	3 Aug 2011 19:17:02 -0000	1.70
+++ posix.sgml	4 Aug 2011 09:21:53 -0000
@@ -1133,6 +1133,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     pow10f
     ppoll
     pthread_getattr_np
+    pthread_sigqueue
     ptsname_r
     removexattr
     setxattr
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.246
diff -u -p -r1.246 thread.cc
--- thread.cc	3 Aug 2011 19:17:02 -0000	1.246
+++ thread.cc	4 Aug 2011 09:21:53 -0000
@@ -3093,6 +3093,24 @@ pthread_sigmask (int operation, const si
   return res;
 }
 
+extern "C" int
+pthread_sigqueue (pthread_t *thread, int sig, const union sigval value)
+{
+  siginfo_t si = {0};
+
+  if (!pthread::is_good_object (thread))
+    return EINVAL;
+  if (!(*thread)->valid)
+    return ESRCH;
+
+  si.si_signo = sig;
+  si.si_code = SI_QUEUE;
+  si.si_value = value;
+  si.si_pid = myself->pid;
+  si.si_uid = myself->uid;
+  return sig_send (NULL, si, (*thread)->cygtls);
+}
+
 /* ID */
 
 extern "C" int
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.34
diff -u -p -r1.34 pthread.h
--- include/pthread.h	21 Jul 2011 09:39:22 -0000	1.34
+++ include/pthread.h	4 Aug 2011 09:21:53 -0000
@@ -202,6 +202,7 @@ void pthread_testcancel (void);
 /* Non posix calls */
 
 int pthread_getattr_np (pthread_t, pthread_attr_t *);
+int pthread_sigqueue (pthread_t *, int, const union sigval);
 int pthread_suspend (pthread_t);
 int pthread_continue (pthread_t);
 int pthread_yield (void);
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.351
diff -u -p -r1.351 version.h
--- include/cygwin/version.h	3 Aug 2011 19:17:02 -0000	1.351
+++ include/cygwin/version.h	4 Aug 2011 09:21:53 -0000
@@ -427,12 +427,13 @@ details. */
       256: Add CW_ALLOC_DRIVE_MAP, CW_MAP_DRIVE_MAP, CW_FREE_DRIVE_MAP.
       257: Export getpt.
       258: Export get_current_dir_name.
+      259: Export pthread_sigqueue.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 258
+#define CYGWIN_VERSION_API_MINOR 259
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-Z15XPrLOqmOSghkppxZN
Content-Disposition: attachment; filename="doc-pthread_sigqueue.patch"
Content-Type: text/x-patch; name="doc-pthread_sigqueue.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 735

2012-01-??  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document pthread_sigqueue.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.96
diff -u -p -r1.96 new-features.sgml
--- new-features.sgml	1 Jan 2012 18:55:40 -0000	1.96
+++ new-features.sgml	1 Jan 2012 18:56:51 -0000
@@ -103,7 +103,7 @@ dlopen now supports the Glibc-specific R
 <listitem><para>
 Other new API: clock_settime, __fpurge, getgrouplist, get_current_dir_name,
 getpt, ppoll, psiginfo, psignal, ptsname_r, sys_siglist, pthread_setschedprio,
-sysinfo.
+pthread_sigqueue, sysinfo.
 </para></listitem>
 
 </itemizedlist>

--=-Z15XPrLOqmOSghkppxZN--
