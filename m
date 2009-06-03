Return-Path: <cygwin-patches-return-6526-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 822 invoked by alias); 3 Jun 2009 18:04:29 -0000
Received: (qmail 806 invoked by uid 22791); 3 Jun 2009 18:04:25 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_62,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f224.google.com (HELO mail-fx0-f224.google.com) (209.85.220.224)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Jun 2009 18:04:18 +0000
Received: by fxm24 with SMTP id 24so196799fxm.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 11:04:14 -0700 (PDT)
Received: by 10.103.248.17 with SMTP id a17mr807446mus.97.1244052254630;         Wed, 03 Jun 2009 11:04:14 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm9798964mup.54.2009.06.03.11.04.12         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 11:04:13 -0700 (PDT)
Message-ID: <4A26BDE4.5060308@gmail.com>
Date: Wed, 03 Jun 2009 18:04:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Pthread fixes arising.
Content-Type: multipart/mixed;  boundary="------------080609030007060502000905"
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
X-SW-Source: 2009-q2/txt/msg00068.txt.bz2

This is a multi-part message in MIME format.
--------------080609030007060502000905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2588


    Hi everyone,

  The attached patch fixes the pthread bugs discovered and reported between
Thomas Stalder and myself.  The winbase.h inline asms bug has already been the
subject of a long thread.

  The latest fix is a simple racy optimisation in __cygwin_lock_{,un}lock;
they attempt to save themselves the bother of locking if multiple threads
aren't in operation, but when you have threads asynchronously being born and
dying, this can mean that the number of locks and unlocks becomes mismatched,
as the optimisation decision can be taken differently for both halves of a
matching lock/unlock pair of calls.  Here's an example of it going wrong in
practice:

   84   47795 [main] stalder3 3612 __cygwin_lock_lock: threadcount 2.  locking
 4981   47948 [main] stalder3 3612 __cygwin_lock_lock: threadcount 2.  locking

   ********* other thread dies here ************

-4876   43704 [main] stalder3 3612 __cygwin_lock_unlock: threadcount 1.  not
unlocking
   48   43752 [main] stalder3 3612 __cygwin_lock_unlock: threadcount 1.  not
unlocking

   ******** main thinks it has unlocked the lock but it still holds it *****

-4874   44571 [main] stalder3 3612 __cygwin_lock_lock: threadcount 2.  locking
 4982   49599 [main] stalder3 3612 __cygwin_lock_lock: threadcount 2.  locking
 4968   50294 [main] stalder3 3612 __cygwin_lock_unlock: threadcount 2.  unlocked
 4969   50398 [main] stalder3 3612 __cygwin_lock_unlock: threadcount 2.  unlocked

  *** main is now taking and releasing it recursively with a bias of one ****

  105   50554 [unknown (0x7F4)] stalder3 3612 __cygwin_lock_lock: threadcount
2.  locking

  Now this thread waits potentially forever to take the lock.  But while it is
doing this, it happens to be holding the user-level mutex.  As soon as the
main thread next waits on this mutex, while still recursively holding the
__cygwin_lock_* mutex, we have a classic deadlock caused by priority
inversion.  I don't figure the optimisation is worth the trouble - in theory
we could perhaps still try and hang onto it from program startup until the
first user thread gets created and then make sure it never gets re-enabled for
the rest of the runtime even if the number of threads drops back down again,
and the worst that would happen is excess unlock calls, but even that seems a
bit ugly.  So I dropped it altogether.

winsup/cygwin/ChangeLog

	* thread.cc (__cygwin_lock_lock):  Delete racy optimisation.
	(__cygwin_lock_unlock):  Likewise.

	* winbase.h (ilockexch):  Fix asm constraints.
	(ilockcmpexch):  Likewise.

  OK for head?

    cheers,
      DaveK



--------------080609030007060502000905
Content-Type: text/x-c;
 name="pthread-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pthread-fixes.diff"
Content-length: 2598

? winsup/cygwin/cygwin-cxx.h
? winsup/cygwin/mutex
Index: winsup/cygwin/thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.215
diff -p -u -r1.215 thread.cc
--- winsup/cygwin/thread.cc	20 Jan 2009 12:40:31 -0000	1.215
+++ winsup/cygwin/thread.cc	3 Jun 2009 17:38:06 -0000
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
Index: winsup/cygwin/winbase.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winbase.h,v
retrieving revision 1.14
diff -p -u -r1.14 winbase.h
--- winsup/cygwin/winbase.h	12 Jul 2008 18:09:17 -0000	1.14
+++ winsup/cygwin/winbase.h	3 Jun 2009 17:38:06 -0000
@@ -38,21 +38,21 @@ ilockdecr (volatile long *m)
 extern __inline__ long
 ilockexch (volatile long *t, long v)
 {
-  register int __res;
+  register long __res __asm__ ("%eax") = *t;
   __asm__ __volatile__ ("\n\
-1:	lock	cmpxchgl %3,(%1)\n\
+1:	lock	cmpxchgl %2,%1\n\
 	jne 1b\n\
- 	": "=a" (__res), "=q" (t): "1" (t), "q" (v), "0" (*t): "cc");
+ 	": "+a" (__res), "=m" (*t): "q" (v), "m" (*t) : "memory", "cc");
   return __res;
 }
 
 extern __inline__ long
 ilockcmpexch (volatile long *t, long v, long c)
 {
-  register int __res;
+  register long __res __asm ("%eax") = c;
   __asm__ __volatile__ ("\n\
-	lock cmpxchgl %3,(%1)\n\
-	": "=a" (__res), "=q" (t) : "1" (t), "q" (v), "0" (c): "cc");
+	lock cmpxchgl %2,%1\n\
+	": "+a" (__res), "=m" (*t) : "q" (v), "m" (*t) : "memory", "cc");
   return __res;
 }
 

--------------080609030007060502000905--
