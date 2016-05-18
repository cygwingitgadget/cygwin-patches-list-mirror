Return-Path: <cygwin-patches-return-8561-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109536 invoked by alias); 18 May 2016 23:14:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109383 invoked by uid 89); 18 May 2016 23:14:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=4.6 required=5.0 tests=BAYES_00,GARBLED_SUBJECT,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=no version=3.3.2 spammy=!ret, HAuthentication-Results:fail, 4947, 494,7
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 18 May 2016 23:14:28 +0000
Received: from minipixel.i.glup.org (unknown [198.206.215.41])	by glup.org (Postfix) with ESMTP id E9329854CF;	Wed, 18 May 2016 19:14:25 -0400 (EDT)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Authentication-Results: glup.org; dkim=none (no signature)	header.i=unknown; x-dkim-adsp=fail
From: cgull@glup.org
To: cygwin-patches@cygwin.com
Cc: John Hood <cgull@glup.org>
Subject: [PATCH 2/4]     Improve and simplify select().
Date: Wed, 18 May 2016 23:14:00 -0000
Message-Id: <1463613259-2899-2-git-send-email-cgull@glup.org>
In-Reply-To: <1463613259-2899-1-git-send-email-cgull@glup.org>
References: <1463613259-2899-1-git-send-email-cgull@glup.org>
X-SW-Source: 2016-q2/txt/msg00037.txt.bz2

From: John Hood <cgull@glup.org>

* select.h: Eliminate redundant select_stuff::select_loop state.
* select.cc (select): Eliminate redundant
  select_stuff::select_loop state.  Eliminate redundant code for
  zero timeout.  Do not return early on early timer return.
  (select_stuff::wait): Eliminate redundant
  select_stuff::select_loop state.
---
 winsup/cygwin/select.cc | 63 ++++++++++++-------------------------------------
 winsup/cygwin/select.h  |  1 -
 2 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index f3ba918..c0f52ec 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -32,7 +32,6 @@ details. */
 #include "pinfo.h"
 #include "sigproc.h"
 #include "cygtls.h"
-#include "cygwait.h"
 
 /*
  * All these defines below should be in sys/types.h
@@ -156,7 +155,7 @@ static int
 select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 	LONGLONG us)
 {
-  select_stuff::wait_states wait_state = select_stuff::select_loop;
+  select_stuff::wait_states wait_state = select_stuff::select_set_zero;
   int ret = 0;
 
   /* Record the current time for later use. */
@@ -182,30 +181,7 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 	  }
       select_printf ("sel.always_ready %d", sel.always_ready);
 
-      /* Degenerate case.  No fds to wait for.  Just wait for time to run out
-	 or signal to arrive. */
-      if (sel.start.next == NULL)
-	switch (cygwait (us * 1000ULL))
-	  {
-	  case WAIT_SIGNALED:
-	    select_printf ("signal received");
-	    /* select() is always interrupted by a signal so set EINTR,
-	       unconditionally, ignoring any SA_RESTART detection by
-	       call_signal_handler().  */
-	    _my_tls.call_signal_handler ();
-	    set_sig_errno (EINTR);
-	    wait_state = select_stuff::select_signalled;
-	    break;
-	  case WAIT_CANCELED:
-	    sel.destroy ();
-	    pthread::static_cancel_self ();
-	    /*NOTREACHED*/
-	  default:
-	    /* Set wait_state to zero below. */
-	    wait_state = select_stuff::select_set_zero;
-	    break;
-	  }
-      else if (sel.always_ready || us == 0)
+      if (sel.always_ready || us == 0)
 	/* Catch any active fds via sel.poll() below */
 	wait_state = select_stuff::select_ok;
       else
@@ -214,29 +190,24 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 
       select_printf ("sel.wait returns %d", wait_state);
 
-      if (wait_state >= select_stuff::select_ok)
+      if (wait_state == select_stuff::select_ok)
 	{
 	  UNIX_FD_ZERO (readfds, maxfds);
 	  UNIX_FD_ZERO (writefds, maxfds);
 	  UNIX_FD_ZERO (exceptfds, maxfds);
-	  if (wait_state == select_stuff::select_set_zero)
-	    ret = 0;
-	  else
-	    {
-	      /* Set bit mask from sel records.  This also sets ret to the
-		 right value >= 0, matching the number of bits set in the
-		 fds records.  if ret is 0, continue to loop. */
-	      ret = sel.poll (readfds, writefds, exceptfds);
-	      if (!ret)
-		wait_state = select_stuff::select_loop;
-	    }
+	  /* Set bit mask from sel records.  This also sets ret to the
+	     right value >= 0, matching the number of bits set in the
+	     fds records.  if ret is 0, continue to loop. */
+	  ret = sel.poll (readfds, writefds, exceptfds);
+	  if (!ret)
+	    wait_state = select_stuff::select_set_zero;
 	}
       /* Always clean up everything here.  If we're looping then build it
 	 all up again.  */
       sel.cleanup ();
       sel.destroy ();
-      /* Recalculate time remaining to wait if we are going to be looping. */
-      if (wait_state == select_stuff::select_loop && us != -1)
+      /* Check and recalculate timeout. */
+      if (us != -1LL && wait_state == select_stuff::select_set_zero)
 	{
 	  select_printf ("recalculating us");
 	  LONGLONG now = gtod.usecs ();
@@ -258,7 +229,7 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 	    }
 	}
     }
-  while (wait_state == select_stuff::select_loop);
+  while (wait_state == select_stuff::select_set_zero);
 
   if (wait_state < select_stuff::select_ok)
     ret = -1;
@@ -494,7 +465,7 @@ next_while:;
 	 to wait for.  */
     default:
       s = &start;
-      bool gotone = false;
+      res = select_set_zero;
       /* Some types of objects (e.g., consoles) wake up on "inappropriate"
 	 events like mouse movements.  The verify function will detect these
 	 situations.  If it returns false, then this wakeup was a false alarm
@@ -508,13 +479,9 @@ next_while:;
 	  }
 	else if ((((wait_ret >= m && s->windows_handle) || s->h == w4[wait_ret]))
 		 && s->verify (s, readfds, writefds, exceptfds))
-	  gotone = true;
+	  res = select_ok;
 
-      if (!gotone)
-	res = select_loop;
-      else
-	res = select_ok;
-      select_printf ("gotone %d", gotone);
+      select_printf ("res after verify %d", res);
       break;
     }
 out:
diff --git a/winsup/cygwin/select.h b/winsup/cygwin/select.h
index 581ee4e..3c749ad 100644
--- a/winsup/cygwin/select.h
+++ b/winsup/cygwin/select.h
@@ -78,7 +78,6 @@ public:
   enum wait_states
   {
     select_signalled = -3,
-    select_loop = -2,
     select_error = -1,
     select_ok = 0,
     select_set_zero = 1
-- 
2.8.2
