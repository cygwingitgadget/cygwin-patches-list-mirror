Return-Path: <cygwin-patches-return-3749-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24444 invoked by alias); 26 Mar 2003 22:56:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24422 invoked from network); 26 Mar 2003 22:56:58 -0000
Date: Wed, 26 Mar 2003 22:56:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [ford@vss.fsi.com: [PATCH] Trivial pthread testsuite fixes]
Message-ID: <20030326225727.GC12110@redhat.com>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00398.txt.bz2

I assume that these patches are to clean up some warnings.  Do they
make sense?

For the record, cygwin's goal is a "No warnings ever" policy.  If you
see warnings after making a change, you should fix the warnings.  Please
don't ignore them.

cgf

----- Forwarded message from Brian Ford <ford@vss.fsi.com> -----

From: Brian Ford <ford@vss.fsi.com>
To: cygwin@cygwin.com
Subject: [PATCH] Trivial pthread testsuite fixes
Date: Wed, 26 Mar 2003 15:59:44 -0600 (CST)
Mail-Followup-To: cygwin@cygwin.com

2003-03-26  Brian Ford  <ford@vss.fsi.com>

	* winsup.api/pthread/condvar7.c (mythread): Cast pthread_mutex_unlock
	argument of pthread_cleanup_push to void *, preventing a compiler
	warning / testsuite failure.
	* winsup.api/pthread/condvar9.c (mythread): Likewise.
	* winsup.api/pthread/rwlock7.c (main): Use ftime instead of _ftime.

Index: winsup.api/pthread/condvar7.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/pthread/condvar7.c,v
retrieving revision 1.1
diff -u -p -r1.1 condvar7.c
--- winsup.api/pthread/condvar7.c	18 Mar 2003 19:51:58 -0000	1.1
+++ winsup.api/pthread/condvar7.c	26 Mar 2003 21:45:47 -0000
@@ -97,7 +97,7 @@ mythread(void * arg)
 #ifdef _MSC_VER
 #pragma inline_depth(0)
 #endif
-  pthread_cleanup_push(pthread_mutex_unlock, (void *) &cvthing.lock);
+  pthread_cleanup_push((void *) pthread_mutex_unlock, (void *) &cvthing.lock);
 
   while (! (cvthing.shared > 0))
     assert(pthread_cond_timedwait(&cvthing.notbusy, &cvthing.lock, &abstime) == 0);
Index: winsup.api/pthread/condvar9.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/pthread/condvar9.c,v
retrieving revision 1.1
diff -u -p -r1.1 condvar9.c
--- winsup.api/pthread/condvar9.c	18 Mar 2003 19:51:58 -0000	1.1
+++ winsup.api/pthread/condvar9.c	26 Mar 2003 21:45:47 -0000
@@ -102,7 +102,7 @@ mythread(void * arg)
 #ifdef _MSC_VER
 #pragma inline_depth(0)
 #endif
-  pthread_cleanup_push(pthread_mutex_unlock, (void *) &cvthing.lock);
+  pthread_cleanup_push((void *) pthread_mutex_unlock, (void *) &cvthing.lock);
 
   while (! (cvthing.shared > 0))
     assert(pthread_cond_timedwait(&cvthing.notbusy, &cvthing.lock, &abstime) == 0);
Index: winsup.api/pthread/rwlock7.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/pthread/rwlock7.c,v
retrieving revision 1.1
diff -u -p -r1.1 rwlock7.c
--- winsup.api/pthread/rwlock7.c	18 Mar 2003 20:04:24 -0000	1.1
+++ winsup.api/pthread/rwlock7.c	26 Mar 2003 21:45:47 -0000
@@ -131,7 +131,7 @@ main (int argc, char *argv[])
       assert(pthread_rwlock_init (&data[data_count].lock, NULL) == 0);
     }
 
-  _ftime(&currSysTime1);
+  ftime(&currSysTime1);
 
   /*
    * Create THREADS threads to access shared data.
@@ -177,7 +177,7 @@ main (int argc, char *argv[])
   printf ("%d thread updates, %d data updates\n",
           thread_updates, data_updates);
 
-  _ftime(&currSysTime2);
+  ftime(&currSysTime2);
 
   printf( "\nstart: %ld/%d, stop: %ld/%d, duration:%ld\n",
           currSysTime1.time,currSysTime1.millitm,

--
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
Bug reporting:         http://cygwin.com/bugs.html
Documentation:         http://cygwin.com/docs.html
FAQ:                   http://cygwin.com/faq/

----- End forwarded message -----
