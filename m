Return-Path: <cygwin-patches-return-6529-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14198 invoked by alias); 3 Jun 2009 22:59:43 -0000
Received: (qmail 14187 invoked by uid 22791); 3 Jun 2009 22:59:42 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_62,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f224.google.com (HELO mail-fx0-f224.google.com) (209.85.220.224)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Jun 2009 22:59:37 +0000
Received: by fxm24 with SMTP id 24so382970fxm.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 15:59:34 -0700 (PDT)
Received: by 10.204.64.136 with SMTP id e8mr1380658bki.46.1244069973903;         Wed, 03 Jun 2009 15:59:33 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 21sm10827826fkx.14.2009.06.03.15.59.31         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 15:59:33 -0700 (PDT)
Message-ID: <4A27031C.7030800@gmail.com>
Date: Wed, 03 Jun 2009 22:59:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Separate pthread fixes #1
Content-Type: multipart/mixed;  boundary="------------000905080905090900050502"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00071.txt.bz2

This is a multi-part message in MIME format.
--------------000905080905090900050502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 253


  The attached patch separates out the uncontroversial change to the
__cygwin_lock* functions.

winsup/cygwin/ChangeLog

	* thread.cc (__cygwin_lock_lock):  Delete racy optimisation.
	(__cygwin_lock_unlock):  Likewise.

  OK?

    cheers,
      DaveK


--------------000905080905090900050502
Content-Type: text/x-c;
 name="cygwin-lock-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-lock-fix.diff"
Content-length: 1418

Index: winsup/cygwin/thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.215
diff -p -u -r1.215 thread.cc
--- winsup/cygwin/thread.cc	20 Jan 2009 12:40:31 -0000	1.215
+++ winsup/cygwin/thread.cc	3 Jun 2009 22:53:40 -0000
@@ -76,13 +76,8 @@ __cygwin_lock_fini (_LOCK_T *lock)
 extern "C" void
 __cygwin_lock_lock (_LOCK_T *lock)
 {
-  if (MT_INTERFACE->threadcount <= 1)
-    paranoid_printf ("threadcount %d.  not locking", MT_INTERFACE->threadcount);
-  else
-    {
-      paranoid_printf ("threadcount %d.  locking", MT_INTERFACE->threadcount);
-      pthread_mutex_lock ((pthread_mutex_t*) lock);
-    }
+  paranoid_printf ("threadcount %d.  locking", MT_INTERFACE->threadcount);
+  pthread_mutex_lock ((pthread_mutex_t*) lock);
 }
 
 extern "C" int
@@ -95,13 +90,8 @@ __cygwin_lock_trylock (_LOCK_T *lock)
 extern "C" void
 __cygwin_lock_unlock (_LOCK_T *lock)
 {
-  if (MT_INTERFACE->threadcount <= 1)
-    paranoid_printf ("threadcount %d.  not unlocking", MT_INTERFACE->threadcount);
-  else
-    {
-      pthread_mutex_unlock ((pthread_mutex_t*) lock);
-      paranoid_printf ("threadcount %d.  unlocked", MT_INTERFACE->threadcount);
-    }
+  pthread_mutex_unlock ((pthread_mutex_t*) lock);
+  paranoid_printf ("threadcount %d.  unlocked", MT_INTERFACE->threadcount);
 }
 
 static inline verifyable_object_state

--------------000905080905090900050502--
