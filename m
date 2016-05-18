Return-Path: <cygwin-patches-return-8560-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109522 invoked by alias); 18 May 2016 23:14:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109387 invoked by uid 89); 18 May 2016 23:14:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=HAuthentication-Results:fail, Hood, waits, longlong
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 18 May 2016 23:14:28 +0000
Received: from minipixel.i.glup.org (unknown [198.206.215.41])	by glup.org (Postfix) with ESMTP id AC401854CE;	Wed, 18 May 2016 19:14:25 -0400 (EDT)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Authentication-Results: glup.org; dkim=none (no signature)	header.i=unknown; x-dkim-adsp=fail
From: cgull@glup.org
To: cygwin-patches@cygwin.com
Cc: John Hood <cgull@glup.org>
Subject: [PATCH 1/4] Use high-resolution timebases for select().
Date: Wed, 18 May 2016 23:14:00 -0000
Message-Id: <1463613259-2899-1-git-send-email-cgull@glup.org>
X-SW-Source: 2016-q2/txt/msg00035.txt.bz2

From: John Hood <cgull@glup.org>

* select.h: Change prototype for select_stuff::wait() for larger
  microsecond timeouts.
* select.cc (pselect): Convert from old cygwin_select().
  Implement microsecond timeouts.
  (cygwin_select): Rewrite as a wrapper on pselect().
  (select): Implement microsecond timeouts.
  (select_stuff::wait): Implement microsecond timeouts with a timer
  object.
---
 winsup/cygwin/select.cc | 182 ++++++++++++++++++++++++++++++------------------
 winsup/cygwin/select.h  |   2 +-
 2 files changed, 114 insertions(+), 70 deletions(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 272d08a..f3ba918 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -85,41 +85,68 @@ details. */
       return -1; \
     }
 
-static int select (int, fd_set *, fd_set *, fd_set *, DWORD);
+static int select (int, fd_set *, fd_set *, fd_set *, LONGLONG);
 
 /* The main select code.  */
 extern "C" int
-cygwin_select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
-	       struct timeval *to)
+pselect (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
+	const struct timespec *to, const sigset_t *set)
 {
-  select_printf ("select(%d, %p, %p, %p, %p)", maxfds, readfds, writefds, exceptfds, to);
+  sigset_t oldset = _my_tls.sigmask;
 
-  pthread_testcancel ();
-  int res;
-  if (maxfds < 0)
-    {
-      set_errno (EINVAL);
-      res = -1;
-    }
-  else
+  __try
     {
-      /* Convert to milliseconds or INFINITE if to == NULL */
-      DWORD ms = to ? (to->tv_sec * 1000) + (to->tv_usec / 1000) : INFINITE;
-      if (ms == 0 && to->tv_usec)
-	ms = 1;			/* At least 1 ms granularity */
+      if (set)
+	set_signal_mask (_my_tls.sigmask, *set);
+
+      select_printf ("pselect (%d, %p, %p, %p, %p, %p)", maxfds, readfds, writefds, exceptfds, to, set);
 
-      if (to)
-	select_printf ("to->tv_sec %ld, to->tv_usec %ld, ms %d", to->tv_sec, to->tv_usec, ms);
+      pthread_testcancel ();
+      int res;
+      if (maxfds < 0)
+	{
+	  set_errno (EINVAL);
+	  res = -1;
+	}
       else
-	select_printf ("to NULL, ms %x", ms);
+	{
+	  /* Convert to microseconds or -1 if to == NULL */
+	  LONGLONG us = to ? to->tv_sec * 1000000LL + (to->tv_nsec + 999) / 1000 : -1LL;
+
+	  if (to)
+	    select_printf ("to->tv_sec %ld, to->tv_nsec %ld, us %lld", to->tv_sec, to->tv_nsec, us);
+	  else
+	    select_printf ("to NULL, us %lld", us);
+
+	  res = select (maxfds, readfds ?: allocfd_set (maxfds),
+			writefds ?: allocfd_set (maxfds),
+			exceptfds ?: allocfd_set (maxfds), us);
+	}
+      syscall_printf ("%R = select (%d, %p, %p, %p, %p)", res, maxfds, readfds,
+		      writefds, exceptfds, to);
 
-      res = select (maxfds, readfds ?: allocfd_set (maxfds),
-		    writefds ?: allocfd_set (maxfds),
-		    exceptfds ?: allocfd_set (maxfds), ms);
+      if (set)
+	set_signal_mask (_my_tls.sigmask, oldset);
+      return res;
     }
-  syscall_printf ("%R = select(%d, %p, %p, %p, %p)", res, maxfds, readfds,
-		  writefds, exceptfds, to);
-  return res;
+  __except (EFAULT) {}
+  __endtry
+  return -1;
+}
+
+/* select () is just a wrapper on pselect (). */
+extern "C" int
+cygwin_select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
+	       struct timeval *to)
+{
+  struct timespec ts;
+  if (to)
+    {
+      ts.tv_sec = to->tv_sec;
+      ts.tv_nsec = to->tv_usec * 1000;
+    }
+  return pselect (maxfds, readfds, writefds, exceptfds,
+		  to ? &ts : NULL, NULL);
 }
 
 /* This function is arbitrarily split out from cygwin_select to avoid odd
@@ -127,13 +154,13 @@ cygwin_select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
    for the sel variable.  */
 static int
 select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
-	DWORD ms)
+	LONGLONG us)
 {
   select_stuff::wait_states wait_state = select_stuff::select_loop;
   int ret = 0;
 
   /* Record the current time for later use. */
-  LONGLONG start_time = gtod.msecs ();
+  LONGLONG start_time = gtod.usecs ();
 
   select_stuff sel;
   sel.return_on_signal = 0;
@@ -158,7 +185,7 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
       /* Degenerate case.  No fds to wait for.  Just wait for time to run out
 	 or signal to arrive. */
       if (sel.start.next == NULL)
-	switch (cygwait (ms))
+	switch (cygwait (us * 1000ULL))
 	  {
 	  case WAIT_SIGNALED:
 	    select_printf ("signal received");
@@ -178,12 +205,12 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 	    wait_state = select_stuff::select_set_zero;
 	    break;
 	  }
-      else if (sel.always_ready || ms == 0)
+      else if (sel.always_ready || us == 0)
 	/* Catch any active fds via sel.poll() below */
 	wait_state = select_stuff::select_ok;
       else
 	/* wait for an fd to become active or time out */
-	wait_state = sel.wait (r, w, e, ms);
+	wait_state = sel.wait (r, w, e, us);
 
       select_printf ("sel.wait returns %d", wait_state);
 
@@ -209,11 +236,11 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
       sel.cleanup ();
       sel.destroy ();
       /* Recalculate time remaining to wait if we are going to be looping. */
-      if (wait_state == select_stuff::select_loop && ms != INFINITE)
+      if (wait_state == select_stuff::select_loop && us != -1)
 	{
-	  select_printf ("recalculating ms");
-	  LONGLONG now = gtod.msecs ();
-	  if (now > (start_time + ms))
+	  select_printf ("recalculating us");
+	  LONGLONG now = gtod.usecs ();
+	  if (now > (start_time + us))
 	    {
 	      select_printf ("timed out after verification");
 	      /* Set descriptor bits to zero per POSIX. */
@@ -225,9 +252,9 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 	    }
 	  else
 	    {
-	      ms -= (now - start_time);
+	      us -= (now - start_time);
 	      start_time = now;
-	      select_printf ("ms now %u", ms);
+	      select_printf ("us now %lld", us);
 	    }
 	}
     }
@@ -238,33 +265,6 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
   return ret;
 }
 
-extern "C" int
-pselect(int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
-	const struct timespec *ts, const sigset_t *set)
-{
-  struct timeval tv;
-  sigset_t oldset = _my_tls.sigmask;
-
-  __try
-    {
-      if (ts)
-	{
-	  tv.tv_sec = ts->tv_sec;
-	  tv.tv_usec = ts->tv_nsec / 1000;
-	}
-      if (set)
-	set_signal_mask (_my_tls.sigmask, *set);
-      int ret = cygwin_select (maxfds, readfds, writefds, exceptfds,
-			       ts ? &tv : NULL);
-      if (set)
-	set_signal_mask (_my_tls.sigmask, oldset);
-      return ret;
-    }
-  __except (EFAULT) {}
-  __endtry
-  return -1;
-}
-
 /* Call cleanup functions for all inspected fds.  Gets rid of any
    executing threads. */
 void
@@ -362,13 +362,47 @@ err:
 /* The heart of select.  Waits for an fd to do something interesting. */
 select_stuff::wait_states
 select_stuff::wait (fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
-		    DWORD ms)
+		    LONGLONG us)
 {
   HANDLE w4[MAXIMUM_WAIT_OBJECTS];
   select_record *s = &start;
   DWORD m = 0;
 
+  /* Always wait for signals. */
   wait_signal_arrived here (w4[m++]);
+
+  /* Set a timeout, or not, for WMFO. */
+  DWORD wmfo_timeout = us ? INFINITE : 0;
+
+  /* Create and set a waitable timer, if a finite timeout has been
+     requested. */
+  LARGE_INTEGER ms_clock_ticks;
+  HANDLE timer_handle;
+  NTSTATUS status;
+  select_printf ("before NtCreateTimer\n");
+  status = NtCreateTimer (&timer_handle, TIMER_ALL_ACCESS, NULL, NotificationTimer);
+  select_printf ("after NtCreateTimer\n");
+  if (!NT_SUCCESS (status))
+    {
+      select_printf ("NtCreateTimer failed (%d)\n", GetLastError ());
+      return select_error;
+    }
+  w4[m++] = timer_handle;
+  if (us >= 0)
+    {
+      ms_clock_ticks.QuadPart = -us * 10;
+      int setret;
+      select_printf ("before NtCreateTimer\n");
+      status = NtSetTimer (timer_handle, &ms_clock_ticks, NULL, NULL, FALSE, 0, NULL);
+      select_printf ("after NtCreateTimer\n");
+      if (!NT_SUCCESS (status))
+	{
+	  select_printf ("NtSetTimer failed: %d (%08x)\n", setret, GetLastError ());
+	  return select_error;
+	}
+    }
+
+  /* Optionally wait for pthread cancellation. */
   if ((w4[m] = pthread::get_cancel_event ()) != NULL)
     m++;
 
@@ -397,21 +431,30 @@ select_stuff::wait (fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 next_while:;
     }
 
-  debug_printf ("m %d, ms %u", m, ms);
+  debug_printf ("m %d, us %llu, wmfo_timeout %d", m, us, wmfo_timeout);
 
   DWORD wait_ret;
   if (!windows_used)
-    wait_ret = WaitForMultipleObjects (m, w4, FALSE, ms);
+    wait_ret = WaitForMultipleObjects (m, w4, FALSE, wmfo_timeout);
   else
     /* Using MWMO_INPUTAVAILABLE is the officially supported solution for
        the problem that the call to PeekMessage disarms the queue state
        so that a subsequent MWFMO hangs, even if there are still messages
        in the queue. */
-    wait_ret = MsgWaitForMultipleObjectsEx (m, w4, ms,
+    wait_ret = MsgWaitForMultipleObjectsEx (m, w4, wmfo_timeout,
 					    QS_ALLINPUT | QS_ALLPOSTMESSAGE,
 					    MWMO_INPUTAVAILABLE);
   select_printf ("wait_ret %d, m = %d.  verifying", wait_ret, m);
 
+  if (wmfo_timeout == INFINITE)
+    {
+      select_printf ("before timer cleanup\n");
+      BOOLEAN current_state;
+      NtCancelTimer (timer_handle, &current_state);
+      NtClose (timer_handle);
+      select_printf ("after timer cleanup\n");
+    }
+
   wait_states res;
   switch (wait_ret)
     {
@@ -434,12 +477,13 @@ next_while:;
       s->set_select_errno ();
       res = select_error;
       break;
+    case WAIT_OBJECT_0 + 1:
     case WAIT_TIMEOUT:
       select_printf ("timed out");
       res = select_set_zero;
       break;
-    case WAIT_OBJECT_0 + 1:
-      if (startfds > 1)
+    case WAIT_OBJECT_0 + 2:
+      if (startfds > 2)
 	{
 	  cleanup ();
 	  destroy ();
diff --git a/winsup/cygwin/select.h b/winsup/cygwin/select.h
index 0035820..581ee4e 100644
--- a/winsup/cygwin/select.h
+++ b/winsup/cygwin/select.h
@@ -96,7 +96,7 @@ public:
 
   bool test_and_set (int, fd_set *, fd_set *, fd_set *);
   int poll (fd_set *, fd_set *, fd_set *);
-  wait_states wait (fd_set *, fd_set *, fd_set *, DWORD);
+  wait_states wait (fd_set *, fd_set *, fd_set *, LONGLONG);
   void cleanup ();
   void destroy ();
 
-- 
2.8.2
