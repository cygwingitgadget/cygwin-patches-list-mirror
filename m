Return-Path: <SRS0=jwxA=UN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id 7F5193858D28
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 03:16:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F5193858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7F5193858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737429385; cv=none;
	b=mt9gmTXD2JR+RIk4xxu/o6kttuhSEcx9rTxSEqOSWcztoHjL+1QoGwXAvVFB9BIaw2O/+KwTptQyyHBlOvmptuh5uxjv10H1zlC7kIdfifDjdCV4w7IsI644KmKcp9coaoDquGtvCimQnPjABGmhtkmn+yav73StrhOdb710R2g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737429385; c=relaxed/simple;
	bh=At00UtfNmH8kvOFKYs3BYQdRMK1EyxrSTPjPtSrvcc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=YiQqcKQU8ChTjuJAVjKz1OB78VGjOT+zYTCE5Il1WuNO45LAuLeHbigr4hFkIstnlkaZz6KPgrLXsHnj5orJw4PqBm+XmpzkyNDA4HaHH5m1Tgqt+VHSKuap9YrgYgwCGpHJXYMEgTvCzyTPk3E9eSIImbwm1RglER58AhSBHV0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F5193858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=g4NmAWgF
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20250121031622813.PDVA.44461.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 12:16:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v6 2/3] Cygwin: cygwait: Make cygwait() reentrant
Date: Tue, 21 Jan 2025 12:15:34 +0900
Message-ID: <20250121031544.1716992-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737429382;
 bh=NpthTg7+yaEyXng5PuWwRWGVCHR9OYfO+xxk2wP4C1o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g4NmAWgFk6rd7eZ/dl8hJHnSRseQPz9XWIsWrVHcZYvr2bbpBPC0RSpuvB+s7/4Lpb6/sV+/
 wZ6kglphctbYUYh7Q+w93CVGA7fRc7VEV7bIjgkOHKBeHgVCh/AL5ZZEHOjbiXzS78y0meXWcn
 Zo17d19+TV24NdzKTIIPgW7MdgO6+bOwxg3EpNcCboZ3RPnCOAZ900yvjBKqi7TeDLUTzaMHLl
 RGtDO2Y/IKqYW7jJ5HNk9i8dmUYmbns7N1r6TEN//ikHNUrOjF/g/l+rHVePG09ObRJQHuUvtl
 whsuAB5axGYGZb6cbQVyxHcHgK6iYBNaxGxKIkqRR4TsdSZg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

To allow cygwait() to be called in the signal handler, a locally
created timer is used instead of _cygtls::locals.cw_timer if it is
in use.

Co-Authored-By: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/cygtls.cc               |  2 ++
 winsup/cygwin/cygwait.cc              | 22 +++++++++++++++-------
 winsup/cygwin/local_includes/cygtls.h |  3 ++-
 winsup/cygwin/select.cc               | 10 +++++++++-
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/cygtls.cc b/winsup/cygwin/cygtls.cc
index bfaa19867..1134adc3e 100644
--- a/winsup/cygwin/cygtls.cc
+++ b/winsup/cygwin/cygtls.cc
@@ -64,6 +64,7 @@ _cygtls::init_thread (void *x, DWORD (*func) (void *, void *))
   initialized = CYGTLS_INITIALIZED;
   errno_addr = &(local_clib._errno);
   locals.cw_timer = NULL;
+  locals.cw_timer_inuse = false;
   locals.pathbufs.clear ();
 
   if ((void *) func == (void *) cygthread::stub
@@ -85,6 +86,7 @@ _cygtls::fixup_after_fork ()
   signal_arrived = NULL;
   locals.select.sockevt = NULL;
   locals.cw_timer = NULL;
+  locals.cw_timer_inuse = false;
   locals.pathbufs.clear ();
   wq.thread_ev = NULL;
 }
diff --git a/winsup/cygwin/cygwait.cc b/winsup/cygwin/cygwait.cc
index 80c0e971c..91a63eede 100644
--- a/winsup/cygwin/cygwait.cc
+++ b/winsup/cygwin/cygwait.cc
@@ -58,16 +58,20 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
     }
 
   DWORD timeout_n;
+  HANDLE local_timer = NULL;
+  HANDLE &wait_timer =
+    _my_tls.locals.cw_timer_inuse ? local_timer : _my_tls.locals.cw_timer;
   if (!timeout)
     timeout_n = WAIT_TIMEOUT + 1;
   else
     {
+      if (!_my_tls.locals.cw_timer_inuse)
+	_my_tls.locals.cw_timer_inuse = true;
       timeout_n = WAIT_OBJECT_0 + num++;
-      if (!_my_tls.locals.cw_timer)
-	NtCreateTimer (&_my_tls.locals.cw_timer, TIMER_ALL_ACCESS, NULL,
-		       NotificationTimer);
-      NtSetTimer (_my_tls.locals.cw_timer, timeout, NULL, NULL, FALSE, 0, NULL);
-      wait_objects[timeout_n] = _my_tls.locals.cw_timer;
+      if (!wait_timer)
+	NtCreateTimer (&wait_timer, TIMER_ALL_ACCESS, NULL, NotificationTimer);
+      NtSetTimer (wait_timer, timeout, NULL, NULL, FALSE, 0, NULL);
+      wait_objects[timeout_n] = wait_timer;
     }
 
   while (1)
@@ -100,7 +104,7 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
     {
       TIMER_BASIC_INFORMATION tbi;
 
-      NtQueryTimer (_my_tls.locals.cw_timer, TimerBasicInformation, &tbi,
+      NtQueryTimer (wait_timer, TimerBasicInformation, &tbi,
 		    sizeof tbi, NULL);
       /* if timer expired, TimeRemaining is negative and represents the
 	  system uptime when signalled */
@@ -108,7 +112,11 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
 	timeout->QuadPart = tbi.SignalState || tbi.TimeRemaining.QuadPart < 0LL
                             ? 0LL : tbi.TimeRemaining.QuadPart;
       }
-      NtCancelTimer (_my_tls.locals.cw_timer, NULL);
+      NtCancelTimer (wait_timer, NULL);
+      if (local_timer)
+	NtClose(local_timer);
+      else
+	_my_tls.locals.cw_timer_inuse = false;
     }
 
   if (res == WAIT_CANCELED && is_cw_cancel_self)
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index e0de712f4..d814814b1 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -135,6 +135,7 @@ struct _local_storage
 
   /* thread.cc */
   HANDLE cw_timer;
+  bool cw_timer_inuse;
 
   tls_pathbuf pathbufs;
   char ttybuf[32];
@@ -180,7 +181,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   siginfo_t *sigwait_info;
   HANDLE signal_arrived;
   bool will_wait_for_signal;
-#if 0
+#if 1
   long __align;			/* Needed to align context to 16 byte. */
 #endif
   /* context MUST be aligned to 16 byte, otherwise RtlCaptureContext fails.
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index a440a98d4..c9a558f35 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -385,10 +385,14 @@ next_while:;
      to create the timer once per thread.  Since WFMO checks the handles
      in order, we append the timer as last object, otherwise it's preferred
      over actual events on the descriptors. */
-  HANDLE &wait_timer = _my_tls.locals.cw_timer;
+  HANDLE local_timer = NULL;
+  HANDLE &wait_timer =
+    _my_tls.locals.cw_timer_inuse ? local_timer : _my_tls.locals.cw_timer;
   if (us > 0LL)
     {
       NTSTATUS status;
+      if (!_my_tls.locals.cw_timer_inuse)
+	_my_tls.locals.cw_timer_inuse = true;
       if (!wait_timer)
 	{
 	  status = NtCreateTimer (&wait_timer, TIMER_ALL_ACCESS, NULL,
@@ -431,6 +435,10 @@ next_while:;
     {
       BOOLEAN current_state;
       NtCancelTimer (wait_timer, &current_state);
+      if (local_timer)
+	NtClose (local_timer);
+      else
+	_my_tls.locals.cw_timer_inuse = false;
     }
 
   wait_states res;
-- 
2.45.1

