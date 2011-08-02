Return-Path: <cygwin-patches-return-7465-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6785 invoked by alias); 2 Aug 2011 04:09:43 -0000
Received: (qmail 6108 invoked by uid 22791); 2 Aug 2011 04:09:39 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_20,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_PW,TW_QT,TW_RQ
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Aug 2011 04:09:20 +0000
Received: by yib12 with SMTP id 12so4890676yib.2        for <cygwin-patches@cygwin.com>; Mon, 01 Aug 2011 21:09:19 -0700 (PDT)
Received: by 10.146.2.1 with SMTP id 1mr1741176yab.7.1312258159616;        Mon, 01 Aug 2011 21:09:19 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id w24sm4363728yhl.34.2011.08.01.21.09.17        (version=SSLv3 cipher=OTHER);        Mon, 01 Aug 2011 21:09:18 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Tue, 02 Aug 2011 04:09:00 -0000
In-Reply-To: <20110731082430.GA23564@calimero.vinschen.de>
References: <1311126880.7796.9.camel@YAAKOV04>	 <20110721103735.GJ15150@calimero.vinschen.de>	 <1311274281.6192.3.camel@YAAKOV04>	 <20110731082430.GA23564@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-9mc8cxY3B07MsbCe/lYS"
Message-ID: <1312258171.3500.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00041.txt.bz2


--=-9mc8cxY3B07MsbCe/lYS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 666

On Sun, 2011-07-31 at 10:24 +0200, Corinna Vinschen wrote:
> anything new from the clock_nanosleep frontier?

Sorry, I've been having elusive problems with CVS HEAD that have been
making it hard to test my patch.

Here's what I have so far, FWIW.  So far I've found two problems with
it: the remaining time returned is incorrect, based on testing of
nanosleep(), and the pthread_spin chunk doesn't look right (previously
the timeout would repeat in the while loop, but that won't happen the
way the waitable timer is set up).

I'll try to get back to this as soon as I am able to test this properly.
In the meantime, is there anything obvious I'm missing?


Yaakov


--=-9mc8cxY3B07MsbCe/lYS
Content-Disposition: attachment; filename="cygwin-waitable-timer.patch"
Content-Type: text/x-patch; name="cygwin-waitable-timer.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 22070

FIRST DRAFT!  DO NOT COMMIT!!!

	* cygtls.h (struct _local_storage): Add cw_timer member.
	* cygtls.cc (_cygtls::init_thread): Initialize locals.cw_timer.
	(_cygtls::fixup_after_fork): Ditto.
	* tlsoffsets.h: Regenerate.
	* ntdll.h (enum _TIMER_INFORMATION_CLASS): Define.
	(struct _TIMER_BASIC_INFORMATION): Define.
	(NtQueryTimer): Declare function.
	* thread.h (cancelable_wait): Change timeout argument to
	PLARGE_INTEGER and provide NULL default.
	(fast_mutex::lock): Adjust accordingly.
	(pthread_cond::wait): Change timeout argument to PLARGE_INTEGER
	and default to NULL.
	* thread.cc (cancelable_wait): Change timeout argument to
	PLARGE_INTEGER.  Initialize _cygtls.locals.cw_timer if needed.
	Use NT waitable timers for handling timeout.  Return remaining time
	to timeout argument if timeout was relative.
	(pthread_cond::wait): Change timeout argument to PLARGE_INTEGER.
	Adjust to change in cancelable_wait.
	(pthread_mutex::lock): Adjust to change in cancelable_wait.
	(pthread_spinlock::lock): Ditto.
	(pthread::join): Ditto.
	(__pthread_cond_dowait): Change waitlength argument to PLARGE_INTEGER.
	Adjust to changes in cancelable_wait and pthread_cond::wait.
	(pthread_cond_timedwait): Adjust to change in __pthread_cond_dowait.
	(pthread_cond_wait): Ditto.
	(semaphore::_timedwait): Adjust to change in cancelable_wait.
	(semaphore::_wait): Ditto.
	* exceptions.cc (handle_sigsuspend): Ditto.
	* signal.cc (nanosleep): Ditto.
	* wait.cc (wait4): Ditto.
	* times.cc (FACTOR, NSPERSEC): Move from here...
	* hires.h (FACTOR, NSPERSEC): ...to here.

Index: cygtls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygtls.cc,v
retrieving revision 1.76
diff -u -p -r1.76 cygtls.cc
--- cygtls.cc	21 Apr 2011 08:10:28 -0000	1.76
+++ cygtls.cc	29 Jul 2011 05:56:31 -0000
@@ -98,6 +98,7 @@ _cygtls::init_thread (void *x, DWORD (*f
   thread_id = GetCurrentThreadId ();
   initialized = CYGTLS_INITIALIZED;
   errno_addr = &(local_clib._errno);
+  locals.cw_timer = NULL;
 
   if ((void *) func == (void *) cygthread::stub
       || (void *) func == (void *) cygthread::simplestub)
@@ -127,6 +128,7 @@ _cygtls::fixup_after_fork ()
     }
   stacklock = spinning = 0;
   locals.select.sockevt = NULL;
+  locals.cw_timer = NULL;
   wq.thread_ev = NULL;
 }
 
Index: cygtls.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygtls.h,v
retrieving revision 1.72
diff -u -p -r1.72 cygtls.h
--- cygtls.h	28 May 2011 18:17:08 -0000	1.72
+++ cygtls.h	29 Jul 2011 05:56:31 -0000
@@ -131,6 +131,9 @@ struct _local_storage
   int setmode_file;
   int setmode_mode;
 
+  /* thread.cc */
+  HANDLE cw_timer;
+
   /* All functions requiring temporary path buffers. */
   tls_pathbuf pathbufs;
   char ttybuf[32];
Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.359
diff -u -p -r1.359 exceptions.cc
--- exceptions.cc	13 Jul 2011 17:53:21 -0000	1.359
+++ exceptions.cc	29 Jul 2011 05:56:32 -0000
@@ -719,7 +719,7 @@ handle_sigsuspend (sigset_t tempmask)
   sigproc_printf ("oldmask %p, newmask %p", oldmask, tempmask);
 
   pthread_testcancel ();
-  cancelable_wait (signal_arrived, INFINITE);
+  cancelable_wait (signal_arrived);
 
   set_sig_errno (EINTR);	// Per POSIX
 
Index: hires.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hires.h,v
retrieving revision 1.19
diff -u -p -r1.19 hires.h
--- hires.h	17 May 2011 17:08:09 -0000	1.19
+++ hires.h	29 Jul 2011 05:56:32 -0000
@@ -29,6 +29,11 @@ details. */
    and rounding won't exceed HIRES_DELAY_MAX */
 #define HIRES_DELAY_MAX ((((UINT_MAX - 10000) / 1000) * 1000) + 10)
 
+/* 100ns difference between Windows and UNIX timebase. */
+#define FACTOR (0x19db1ded53e8000LL)
+/* # of 100ns intervals per second. */
+#define NSPERSEC 10000000LL
+
 class hires_base
 {
  protected:
Index: ntdll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v
retrieving revision 1.125
diff -u -p -r1.125 ntdll.h
--- ntdll.h	26 Jul 2011 09:54:11 -0000	1.125
+++ ntdll.h	29 Jul 2011 05:56:32 -0000
@@ -986,6 +986,15 @@ typedef struct _THREAD_BASIC_INFORMATION
     KPRIORITY  BasePriority;
 } THREAD_BASIC_INFORMATION, *PTHREAD_BASIC_INFORMATION;
 
+typedef enum _TIMER_INFORMATION_CLASS {
+  TimerBasicInformation = 0
+} TIMER_INFORMATION_CLASS, *PTIMER_INFORMATION_CLASS;
+
+typedef struct _TIMER_BASIC_INFORMATION {
+  LARGE_INTEGER TimeRemaining;
+  BOOLEAN SignalState;
+} TIMER_BASIC_INFORMATION, *PTIMER_BASIC_INFORMATION;
+
 #define RTL_QUERY_REGISTRY_SUBKEY 0x01
 #define RTL_QUERY_REGISTRY_TOPKEY 0x02
 #define RTL_QUERY_REGISTRY_REQUIRED 0x04
@@ -1155,6 +1164,8 @@ extern "C"
   NTSTATUS NTAPI NtQuerySecurityObject (HANDLE, SECURITY_INFORMATION,
 					PSECURITY_DESCRIPTOR, ULONG, PULONG);
   NTSTATUS NTAPI NtQuerySymbolicLinkObject (HANDLE, PUNICODE_STRING, PULONG);
+  NTSTATUS NTAPI NtQueryTimer (HANDLE, TIMER_INFORMATION_CLASS, PVOID,
+			       ULONG, PULONG);
   NTSTATUS NTAPI NtQueryTimerResolution (PULONG, PULONG, PULONG);
   NTSTATUS NTAPI NtQueryValueKey (HANDLE, PUNICODE_STRING,
 				  KEY_VALUE_INFORMATION_CLASS, PVOID, ULONG,
Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.98
diff -u -p -r1.98 signal.cc
--- signal.cc	10 Jul 2011 00:01:33 -0000	1.98
+++ signal.cc	29 Jul 2011 05:56:32 -0000
@@ -92,61 +92,31 @@ nanosleep (const struct timespec *rqtp, 
       set_errno (EINVAL);
       return -1;
     }
-  unsigned int sec = rqtp->tv_sec;
-  DWORD resolution = gtod.resolution ();
-  bool done = false;
-  DWORD req;
-  DWORD rem;
-
-  while (!done)
-    {
-      /* Divide user's input into transactions no larger than 49.7
-	 days at a time.  */
-      if (sec > HIRES_DELAY_MAX / 1000)
-	{
-	  req = ((HIRES_DELAY_MAX + resolution - 1)
-		 / resolution * resolution);
-	  sec -= HIRES_DELAY_MAX / 1000;
-	}
-      else
-	{
-	  req = ((sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
-		  + resolution - 1) / resolution) * resolution;
-	  sec = 0;
-	  done = true;
-	}
+  LARGE_INTEGER timeout;
 
-      DWORD end_time = gtod.dmsecs () + req;
-      syscall_printf ("nanosleep (%ld)", req);
+  timeout.QuadPart = (LONGLONG) rqtp->tv_sec * NSPERSEC
+		     + ((LONGLONG) rqtp->tv_nsec + 99LL) / 100LL;
+  timeout.QuadPart *= -1LL;
 
-      int rc = cancelable_wait (signal_arrived, req);
-      if ((rem = end_time - gtod.dmsecs ()) > HIRES_DELAY_MAX)
-	rem = 0;
-      if (rc == WAIT_OBJECT_0)
-	{
-	  _my_tls.call_signal_handler ();
-	  set_errno (EINTR);
-	  res = -1;
-	  break;
-	}
+  syscall_printf ("nanosleep (%ld.%09ld)", rqtp->tv_sec, rqtp->tv_nsec);
+
+  int rc = cancelable_wait (signal_arrived, &timeout);
+  if (rc == WAIT_OBJECT_0)
+    {
+      _my_tls.call_signal_handler ();
+      set_errno (EINTR);
+      res = -1;
     }
 
   if (rmtp)
     {
-      rmtp->tv_sec = sec + rem / 1000;
-      rmtp->tv_nsec = (rem % 1000) * 1000000;
-      if (sec)
-	{
-	  rmtp->tv_nsec += rqtp->tv_nsec;
-	  if (rmtp->tv_nsec >= 1000000000)
-	    {
-	      rmtp->tv_nsec -= 1000000000;
-	      rmtp->tv_sec++;
-	    }
-	}
+      rmtp->tv_sec = (time_t) (timeout.QuadPart / NSPERSEC);
+      rmtp->tv_nsec = (long) ((timeout.QuadPart % NSPERSEC) * 100LL);
     }
 
-  syscall_printf ("%d = nanosleep (%ld, %ld)", res, req, rem);
+  syscall_printf ("%d = nanosleep (%ld.%09ld, %ld.%09.ld)", res, rqtp->tv_sec,
+		  rqtp->tv_nsec, rmtp ? rmtp->tv_sec : 0,
+		  rmtp ? rmtp->tv_nsec : 0);
   return res;
 }
 
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.244
diff -u -p -r1.244 thread.cc
--- thread.cc	21 Jul 2011 09:39:21 -0000	1.244
+++ thread.cc	29 Jul 2011 05:56:32 -0000
@@ -906,13 +906,13 @@ pthread::static_cancel_self ()
 }
 
 DWORD
-cancelable_wait (HANDLE object, DWORD timeout,
+cancelable_wait (HANDLE object, PLARGE_INTEGER timeout,
 		 const cw_cancel_action cancel_action,
 		 const enum cw_sig_wait sig_wait)
 {
   DWORD res;
   DWORD num = 0;
-  HANDLE wait_objects[3];
+  HANDLE wait_objects[4];
   pthread_t thread = pthread::self ();
 
   /* Do not change the wait order.
@@ -939,15 +939,30 @@ cancelable_wait (HANDLE object, DWORD ti
       wait_objects[sig_n] = signal_arrived;
     }
 
+  DWORD timeout_n;
+  if (!timeout)
+    timeout_n = WAIT_TIMEOUT + 1;
+  else
+    {
+      timeout_n = WAIT_OBJECT_0 + num++;
+      if (!_my_tls.locals.cw_timer)
+	NtCreateTimer (&_my_tls.locals.cw_timer, TIMER_ALL_ACCESS, NULL,
+		       NotificationTimer);
+      NtSetTimer (_my_tls.locals.cw_timer, timeout, NULL, NULL, FALSE, 0, NULL);
+      wait_objects[timeout_n] = _my_tls.locals.cw_timer;
+    }
+
   while (1)
     {
-      res = WaitForMultipleObjects (num, wait_objects, FALSE, timeout);
+      res = WaitForMultipleObjects (num, wait_objects, FALSE, INFINITE);
       if (res == cancel_n)
 	{
 	  if (cancel_action == cw_cancel_self)
 	    pthread::static_cancel_self ();
 	  res = WAIT_CANCELED;
 	}
+      else if (res == timeout_n)
+	res = WAIT_TIMEOUT;
       else if (res != sig_n)
 	/* all set */;
       else if (sig_wait == cw_sig_eintr)
@@ -959,6 +974,20 @@ cancelable_wait (HANDLE object, DWORD ti
 	}
       break;
     }
+
+  if (timeout)
+    {
+      PTIMER_BASIC_INFORMATION tbi;
+      const size_t sizeof_tbi = sizeof (TIMER_BASIC_INFORMATION);
+
+      tbi = (PTIMER_BASIC_INFORMATION) malloc (sizeof_tbi);
+      NtQueryTimer (_my_tls.locals.cw_timer, TimerBasicInformation, tbi,
+		    sizeof_tbi, NULL);
+      if (timeout->QuadPart < 0LL)
+	*timeout = tbi->TimeRemaining;
+      NtCancelTimer (_my_tls.locals.cw_timer, NULL);
+    }
+
   return res;
 }
 
@@ -1228,7 +1257,7 @@ pthread_cond::unblock (const bool all)
 }
 
 int
-pthread_cond::wait (pthread_mutex_t mutex, DWORD dwMilliseconds)
+pthread_cond::wait (pthread_mutex_t mutex, PLARGE_INTEGER timeout)
 {
   DWORD rv;
 
@@ -1249,7 +1278,7 @@ pthread_cond::wait (pthread_mutex_t mute
   ++mutex->condwaits;
   mutex->unlock ();
 
-  rv = cancelable_wait (sem_wait, dwMilliseconds, cw_no_cancel_self, cw_sig_eintr);
+  rv = cancelable_wait (sem_wait, timeout, cw_no_cancel_self, cw_sig_eintr);
 
   mtx_out.lock ();
 
@@ -1764,7 +1793,7 @@ pthread_mutex::lock ()
   else if (type == PTHREAD_MUTEX_NORMAL /* potentially causes deadlock */
 	   || !pthread::equal (owner, self))
     {
-      cancelable_wait (win32_obj_id, INFINITE, cw_no_cancel, cw_sig_resume);
+      cancelable_wait (win32_obj_id, NULL, cw_no_cancel, cw_sig_resume);
       set_owner (self);
     }
   else
@@ -1899,8 +1928,13 @@ pthread_spinlock::lock ()
 	}
       else if (pthread::equal (owner, self))
 	result = EDEADLK;
-      else /* Minimal timeout to minimize CPU usage while still spinning. */
-	cancelable_wait (win32_obj_id, 1L, cw_no_cancel, cw_sig_resume);
+      else
+	{
+	  /* Minimal timeout to minimize CPU usage while still spinning. */
+	  LARGE_INTEGER timeout;
+	  timeout.QuadPart = -10000LL;
+	  cancelable_wait (win32_obj_id, &timeout, cw_no_cancel, cw_sig_resume);
+	}
     }
   while (result == -1);
   pthread_printf ("spinlock %p, self %p, owner %p", this, self, owner);
@@ -2377,7 +2411,7 @@ pthread::join (pthread_t *thread, void *
       (*thread)->attr.joinable = PTHREAD_CREATE_DETACHED;
       (*thread)->mutex.unlock ();
 
-      switch (cancelable_wait ((*thread)->win32_obj_id, INFINITE, cw_no_cancel_self, cw_sig_resume))
+      switch (cancelable_wait ((*thread)->win32_obj_id, NULL, cw_no_cancel_self, cw_sig_resume))
 	{
 	case WAIT_OBJECT_0:
 	  if (return_val)
@@ -2702,7 +2736,7 @@ pthread_cond_signal (pthread_cond_t *con
 
 static int
 __pthread_cond_dowait (pthread_cond_t *cond, pthread_mutex_t *mutex,
-		       DWORD waitlength)
+		       PLARGE_INTEGER waitlength)
 {
   if (!pthread_mutex::is_good_object (mutex))
     return EINVAL;
@@ -2722,7 +2756,7 @@ pthread_cond_timedwait (pthread_cond_t *
 			const struct timespec *abstime)
 {
   struct timespec tp;
-  DWORD waitlength;
+  LARGE_INTEGER timeout;
 
   myfault efault;
   if (efault.faulted ())
@@ -2738,17 +2772,26 @@ pthread_cond_timedwait (pthread_cond_t *
 
   clock_gettime ((*cond)->clock_id, &tp);
 
-  /* Check for immediate timeout before converting to microseconds, since
-     the resulting value can easily overflow long.  This also allows to
-     evaluate microseconds directly in DWORD. */
+  /* Check for immediate timeout before converting */
   if (tp.tv_sec > abstime->tv_sec
       || (tp.tv_sec == abstime->tv_sec
 	  && tp.tv_nsec > abstime->tv_nsec))
     return ETIMEDOUT;
 
-  waitlength = (abstime->tv_sec - tp.tv_sec) * 1000;
-  waitlength += (abstime->tv_nsec - tp.tv_nsec) / 1000000;
-  return __pthread_cond_dowait (cond, mutex, waitlength);
+  switch ((*cond)->clock_id)
+    {
+    case CLOCK_REALTIME:
+      timeout.QuadPart = abstime->tv_sec * NSPERSEC
+			 + (abstime->tv_nsec + 99LL) / 100LL + FACTOR;
+      break;
+    default:
+      /* other clocks must be handled as relative timeout */
+      timeout.QuadPart = (abstime->tv_sec - tp.tv_sec) * NSPERSEC;
+      timeout.QuadPart += (abstime->tv_nsec - tp.tv_nsec + 99LL) / 100LL;
+      timeout.QuadPart *= -1LL;
+      break;
+    }
+  return __pthread_cond_dowait (cond, mutex, &timeout);
 }
 
 extern "C" int
@@ -2756,7 +2799,7 @@ pthread_cond_wait (pthread_cond_t *cond,
 {
   pthread_testcancel ();
 
-  return __pthread_cond_dowait (cond, mutex, INFINITE);
+  return __pthread_cond_dowait (cond, mutex, NULL);
 }
 
 extern "C" int
@@ -3439,8 +3482,7 @@ semaphore::_trywait ()
 int
 semaphore::_timedwait (const struct timespec *abstime)
 {
-  struct timeval tv;
-  long waitlength;
+  LARGE_INTEGER timeout;
 
   myfault efault;
   if (efault.faulted ())
@@ -3453,12 +3495,10 @@ semaphore::_timedwait (const struct time
       return -1;
     }
 
-  gettimeofday (&tv, NULL);
-  waitlength = abstime->tv_sec * 1000 + abstime->tv_nsec / (1000 * 1000);
-  waitlength -= tv.tv_sec * 1000 + tv.tv_usec / 1000;
-  if (waitlength < 0)
-    waitlength = 0;
-  switch (cancelable_wait (win32_obj_id, waitlength, cw_cancel_self, cw_sig_eintr))
+  timeout.QuadPart = abstime->tv_sec * NSPERSEC
+		     + (abstime->tv_nsec + 99) / 100 + FACTOR;
+
+  switch (cancelable_wait (win32_obj_id, &timeout, cw_cancel_self, cw_sig_eintr))
     {
     case WAIT_OBJECT_0:
       currentvalue--;
@@ -3480,7 +3520,7 @@ semaphore::_timedwait (const struct time
 int
 semaphore::_wait ()
 {
-  switch (cancelable_wait (win32_obj_id, INFINITE, cw_cancel_self, cw_sig_eintr))
+  switch (cancelable_wait (win32_obj_id, NULL, cw_cancel_self, cw_sig_eintr))
     {
     case WAIT_OBJECT_0:
       currentvalue--;
Index: thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.122
diff -u -p -r1.122 thread.h
--- thread.h	21 Jul 2011 09:39:22 -0000	1.122
+++ thread.h	29 Jul 2011 05:56:32 -0000
@@ -37,7 +37,8 @@ enum cw_cancel_action
   cw_no_cancel
 };
 
-DWORD cancelable_wait (HANDLE, DWORD, const cw_cancel_action = cw_cancel_self,
+DWORD cancelable_wait (HANDLE, PLARGE_INTEGER timeout = NULL,
+		       const cw_cancel_action = cw_cancel_self,
 		       const enum cw_sig_wait = cw_sig_nosig)
   __attribute__ ((regparm (3)));
 
@@ -70,7 +71,7 @@ public:
   void lock ()
   {
     if (InterlockedIncrement ((long *) &lock_counter) != 1)
-      cancelable_wait (win32_obj_id, INFINITE, cw_no_cancel, cw_sig_resume);
+      cancelable_wait (win32_obj_id, NULL, cw_no_cancel, cw_sig_resume);
   }
 
   void unlock ()
@@ -517,7 +518,7 @@ public:
   pthread_mutex_t mtx_cond;
 
   void unblock (const bool all);
-  int wait (pthread_mutex_t mutex, DWORD dwMilliseconds = INFINITE);
+  int wait (pthread_mutex_t mutex, PLARGE_INTEGER timeout = NULL);
 
   pthread_cond (pthread_condattr *);
   ~pthread_cond ();
Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.110
diff -u -p -r1.110 times.cc
--- times.cc	6 Jun 2011 05:02:13 -0000	1.110
+++ times.cc	29 Jul 2011 05:56:32 -0000
@@ -27,10 +27,6 @@ details. */
 #include "cygtls.h"
 #include "ntdll.h"
 
-/* 100ns difference between WIndows and UNIX timebase. */
-#define FACTOR (0x19db1ded53e8000LL)
-/* # of 100ns intervals per second. */
-#define NSPERSEC 10000000LL
 /* Max allowed diversion in 100ns of internal timer from system time.  If
    this difference is exceeded, the internal timer gets re-primed. */
 #define JITTER (40 * 10000LL)
@@ -737,7 +733,7 @@ hires_ms::resolution ()
 
       status = NtQueryTimerResolution (&coarsest, &finest, &actual);
       if (NT_SUCCESS (status))
-	minperiod = (DWORD) actual / 10000L;
+	minperiod = (DWORD) actual;
       else
 	{
 	  /* Try to empirically determine current timer resolution */
@@ -757,13 +753,9 @@ hires_ms::resolution ()
 	      period += now - then;
 	    }
 	  SetThreadPriority (GetCurrentThread (), priority);
-	  period /= 40000L;
+	  period /= 4L;
 	  minperiod = (DWORD) period;
 	}
-      /* The resolution can be as low as 5000 100ns intervals on recent OSes.
-	 We have to make sure that the resolution in ms is never 0. */
-      if (!minperiod)
-	minperiod = 1L;
     }
   return minperiod;
 }
@@ -786,8 +778,8 @@ clock_getres (clockid_t clk_id, struct t
       case CLOCK_REALTIME:
 	{
 	  DWORD period = gtod.resolution ();
-	  tp->tv_sec = period / 1000;
-	  tp->tv_nsec = (period % 1000) * 1000000;
+	  tp->tv_sec = period / NSPERSEC;
+	  tp->tv_nsec = (period % NSPERSEC) * 100;
 	  break;
 	}
 
@@ -838,7 +830,7 @@ clock_setres (clockid_t clk_id, struct t
     }
 
   if (period_set
-      && NT_SUCCESS (NtSetTimerResolution (minperiod * 10000L, FALSE, &actual)))
+      && NT_SUCCESS (NtSetTimerResolution (minperiod, FALSE, &actual)))
     period_set = false;
 
   status = NtSetTimerResolution (period, TRUE, &actual);
@@ -847,11 +839,7 @@ clock_setres (clockid_t clk_id, struct t
       __seterrno_from_nt_status (status);
       return -1;
     }
-  minperiod = actual / 10000L;
-  /* The resolution can be as low as 5000 100ns intervals on recent OSes.
-     We have to make sure that the resolution in ms is never 0. */
-  if (!minperiod)
-    minperiod = 1L;
+  minperiod = actual;
   period_set = true;
   return 0;
 }
Index: tlsoffsets.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/tlsoffsets.h,v
retrieving revision 1.47
diff -u -p -r1.47 tlsoffsets.h
--- tlsoffsets.h	28 May 2011 18:17:09 -0000	1.47
+++ tlsoffsets.h	29 Jul 2011 05:56:32 -0000
@@ -1,6 +1,6 @@
 //;# autogenerated:  Do not edit.
 
-//; $tls::sizeof__cygtls = 4044;
+//; $tls::sizeof__cygtls = 4048;
 //; $tls::func = -12700;
 //; $tls::pfunc = 0;
 //; $tls::saved_errno = -12696;
@@ -37,26 +37,26 @@
 //; $tls::p__dontuse = 412;
 //; $tls::locals = -11200;
 //; $tls::plocals = 1500;
-//; $tls::_ctinfo = -9740;
-//; $tls::p_ctinfo = 2960;
-//; $tls::andreas = -9736;
-//; $tls::pandreas = 2964;
-//; $tls::wq = -9732;
-//; $tls::pwq = 2968;
-//; $tls::sig = -9704;
-//; $tls::psig = 2996;
-//; $tls::incyg = -9700;
-//; $tls::pincyg = 3000;
-//; $tls::spinning = -9696;
-//; $tls::pspinning = 3004;
-//; $tls::stacklock = -9692;
-//; $tls::pstacklock = 3008;
-//; $tls::stackptr = -9688;
-//; $tls::pstackptr = 3012;
-//; $tls::stack = -9684;
-//; $tls::pstack = 3016;
-//; $tls::initialized = -8660;
-//; $tls::pinitialized = 4040;
+//; $tls::_ctinfo = -9736;
+//; $tls::p_ctinfo = 2964;
+//; $tls::andreas = -9732;
+//; $tls::pandreas = 2968;
+//; $tls::wq = -9728;
+//; $tls::pwq = 2972;
+//; $tls::sig = -9700;
+//; $tls::psig = 3000;
+//; $tls::incyg = -9696;
+//; $tls::pincyg = 3004;
+//; $tls::spinning = -9692;
+//; $tls::pspinning = 3008;
+//; $tls::stacklock = -9688;
+//; $tls::pstacklock = 3012;
+//; $tls::stackptr = -9684;
+//; $tls::pstackptr = 3016;
+//; $tls::stack = -9680;
+//; $tls::pstack = 3020;
+//; $tls::initialized = -8656;
+//; $tls::pinitialized = 4044;
 //; __DATA__
 
 #define tls_func (-12700)
@@ -95,23 +95,23 @@
 #define tls_p__dontuse (412)
 #define tls_locals (-11200)
 #define tls_plocals (1500)
-#define tls__ctinfo (-9740)
-#define tls_p_ctinfo (2960)
-#define tls_andreas (-9736)
-#define tls_pandreas (2964)
-#define tls_wq (-9732)
-#define tls_pwq (2968)
-#define tls_sig (-9704)
-#define tls_psig (2996)
-#define tls_incyg (-9700)
-#define tls_pincyg (3000)
-#define tls_spinning (-9696)
-#define tls_pspinning (3004)
-#define tls_stacklock (-9692)
-#define tls_pstacklock (3008)
-#define tls_stackptr (-9688)
-#define tls_pstackptr (3012)
-#define tls_stack (-9684)
-#define tls_pstack (3016)
-#define tls_initialized (-8660)
-#define tls_pinitialized (4040)
+#define tls__ctinfo (-9736)
+#define tls_p_ctinfo (2964)
+#define tls_andreas (-9732)
+#define tls_pandreas (2968)
+#define tls_wq (-9728)
+#define tls_pwq (2972)
+#define tls_sig (-9700)
+#define tls_psig (3000)
+#define tls_incyg (-9696)
+#define tls_pincyg (3004)
+#define tls_spinning (-9692)
+#define tls_pspinning (3008)
+#define tls_stacklock (-9688)
+#define tls_pstacklock (3012)
+#define tls_stackptr (-9684)
+#define tls_pstackptr (3016)
+#define tls_stack (-9680)
+#define tls_pstack (3020)
+#define tls_initialized (-8656)
+#define tls_pinitialized (4044)
Index: wait.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wait.cc,v
retrieving revision 1.37
diff -u -p -r1.37 wait.cc
--- wait.cc	18 Jul 2009 20:25:07 -0000	1.37
+++ wait.cc	29 Jul 2011 05:56:32 -0000
@@ -78,7 +78,7 @@ wait4 (int intpid, int *status, int opti
       if ((waitfor = w->ev) == NULL)
 	goto nochildren;
 
-      res = cancelable_wait (waitfor, INFINITE);
+      res = cancelable_wait (waitfor);
 
       sigproc_printf ("%d = WaitForSingleObject (...)", res);
 

--=-9mc8cxY3B07MsbCe/lYS--
