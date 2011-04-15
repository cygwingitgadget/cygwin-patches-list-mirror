Return-Path: <cygwin-patches-return-7282-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18215 invoked by alias); 15 Apr 2011 03:00:43 -0000
Received: (qmail 18203 invoked by uid 22791); 15 Apr 2011 03:00:42 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,TW_GT
X-Spam-Check-By: sourceware.org
Received: from mail-gw0-f43.google.com (HELO mail-gw0-f43.google.com) (74.125.83.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Apr 2011 03:00:35 +0000
Received: by gwj21 with SMTP id 21so4340279gwj.2        for <cygwin-patches@cygwin.com>; Thu, 14 Apr 2011 20:00:34 -0700 (PDT)
Received: by 10.150.164.3 with SMTP id m3mr2157701ybe.203.1302836434394;        Thu, 14 Apr 2011 20:00:34 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id m12sm2970225ybn.27.2011.04.14.20.00.31        (version=SSLv3 cipher=OTHER);        Thu, 14 Apr 2011 20:00:33 -0700 (PDT)
Subject: Re: [PATCH] pthread_getattr_np, pthread_setschedprio
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <1302489035.4944.20.camel@YAAKOV04>
References: <1302489035.4944.20.camel@YAAKOV04>
Content-Type: multipart/mixed; boundary="=-IUnOnD22HUPyV/0Sy6ZP"
Date: Fri, 15 Apr 2011 03:00:00 -0000
Message-ID: <1302836432.5296.7.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00048.txt.bz2


--=-IUnOnD22HUPyV/0Sy6ZP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1131

On Sun, 2011-04-10 at 21:30 -0500, Yaakov (Cygwin/X) wrote:
> This patch adds two pthread functions which appear to be "low-hanging
> fruit".
> 
> pthread_setschedprio(3) is a POSIX function[1][2] which changes the
> scheduling priority for the given thread.  It is similar to
> pthread_setschedparam(3) but does not change the scheduling policy and
> doesn't require the priority to be wrapped in a struct.
> 
> pthread_getattr_np(3) is a GNU extension[3] which initializes the given
> pthread_attr_t with the actual attributes of the given thread.  While
> the example code does not have the pthread_attr_t pre-initialized by
> pthread_attr_init(3), I have seen real world code where it is, so either
> possibility is handled.

After further analysis, I should work further on pthread_getattr_np() in
conjunction with adding pthread_attr_getstack(), both of which I need
for webkitgtk-1.3.13.  But it will be a couple of weeks before I'll have
the time to get to that.

So for now, lets just implement pthread_setschedprio(), which looks
pretty straight-forward and is unrelated to the others.  Revised patch
attached.


Yaakov


--=-IUnOnD22HUPyV/0Sy6ZP
Content-Disposition: attachment; filename="pthread_setschedprio.patch"
Content-Type: text/x-patch; name="pthread_setschedprio.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3718

2011-04-10  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* thread.cc (pthread_setschedprio): New function.
	* include/pthread.h (pthread_setschedprio): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* cygwin.din (pthread_setschedprio): Export.
	* posix.sgml (std-notimpl) Move pthread_setschedprio from here...
	(std-susv4) ...to here.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.234
diff -u -r1.234 cygwin.din
--- cygwin.din	29 Mar 2011 10:32:40 -0000	1.234
+++ cygwin.din	10 Apr 2011 08:49:54 -0000
@@ -1241,6 +1241,7 @@
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
@@ -1388,7 +1389,6 @@
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
@@ -194,6 +194,7 @@
 int pthread_setcancelstate (int, int *);
 int pthread_setcanceltype (int, int *);
 int pthread_setschedparam (pthread_t, int, const struct sched_param *);
+int pthread_setschedprio (pthread_t, int);
 int pthread_setspecific (pthread_key_t, const void *);
 void pthread_testcancel (void);
 
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
+      239: Export pthread_setschedprio.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 238
+#define CYGWIN_VERSION_API_MINOR 239
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-IUnOnD22HUPyV/0Sy6ZP--
