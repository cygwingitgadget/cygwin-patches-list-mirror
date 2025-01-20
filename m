Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:21])
	by sourceware.org (Postfix) with ESMTPS id 879933858280
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 15:47:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 879933858280
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 879933858280
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737388024; cv=none;
	b=hNfBqx2+/pYvcwjlt1O88TmjBWomG/UcvRGyKSRLSt3uUo/j/p0AVM0jQfw8+o3g92MDqoUTZznRM+842x+l6ADKyRJvjTKhSyJli1Iqnu2oSewRN+NkxnEhWavf5lURMRexc3/k7k6G81dGvJlV0Ng95VsKQra+n+VvtYtRifI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737388024; c=relaxed/simple;
	bh=PE2dz1PG2X5Ln8uNbf14bVWke6MprH7G1lNUYHj2ep8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=iT5HPejSYckTn75cAhjtQEOu5xk80tEJkJhvNfkxTPR5giNcvHiB6rYkCpQxHwkVzXdcOFbx4IB2cV8mLV3jsxEBPpCrlcj3TWa4TGjwlBZjadRqyYG1bFxOdfZyVUq5KzZ6KH22PrvilKicJB7OxhSloxCgrh0i80Uc2feTL40=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 879933858280
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Zv2kibQV
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120154701136.IUHJ.9629.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 00:47:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v4 2/3] Cygwin: cygwait: Make cygwait() reentrant
Date: Tue, 21 Jan 2025 00:44:20 +0900
Message-ID: <20250120154627.107642-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
References: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737388021;
 bh=U9gXFdjBdWaaG/VTj7ct6fo4ZM0CXCOP2Lo2Ubbf2Hc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Zv2kibQVD1ediyWV9woOUnhm58fgMx2iVmm8xCfpFdwMJkjugDdYhpFaodVF/XLt0MLUBMHP
 chSSv7JKS9Zja0RTsr7QhtZETnpAbwghYTiszAoVO1/6zPRhajE17FVlkfZtz+CGY5qtrhmaOj
 Z0vwCQoaSp7kfYkvjB3oopRnYkkeSX9V5Rewz+4Hi1mfPOJGjJ6bsaj4ukCKc5UWYQ9Oy6kttS
 84bVn4wtItpTzVhFYDsj5LhA2XaT5cHuFlW0ys1qQ7qBRm8EEsfwf0snoCh9VW3kdDw2XgLn//
 9MwqG0GLgpLhshjk2HNYd3bAR506b/6YIP4hKYQIOUDR/zuw==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

To allow cygwait() to be called in the signal handler, a locally
created timer is used instead of _cygtls::locals.cw_timer if it is
in use.

Co-Authored-By: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/cygtls.cc               |  2 ++
 winsup/cygwin/cygwait.cc              | 22 ++++++++++++++++------
 winsup/cygwin/local_includes/cygtls.h |  3 ++-
 winsup/cygwin/select.cc               |  9 +++++++++
 4 files changed, 29 insertions(+), 7 deletions(-)

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
index 80c0e971c..8613638f6 100644
--- a/winsup/cygwin/cygwait.cc
+++ b/winsup/cygwin/cygwait.cc
@@ -58,16 +58,22 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
     }
 
   DWORD timeout_n;
+  HANDLE &wait_timer = _my_tls.locals.cw_timer;
+  HANDLE local_wait_timer = NULL;
   if (!timeout)
     timeout_n = WAIT_TIMEOUT + 1;
   else
     {
+      if (_my_tls.locals.cw_timer_inuse)
+	wait_timer = local_wait_timer;
+      else
+	_my_tls.locals.cw_timer_inuse = true;
       timeout_n = WAIT_OBJECT_0 + num++;
-      if (!_my_tls.locals.cw_timer)
-	NtCreateTimer (&_my_tls.locals.cw_timer, TIMER_ALL_ACCESS, NULL,
+      if (!wait_timer)
+	NtCreateTimer (&wait_timer, TIMER_ALL_ACCESS, NULL,
 		       NotificationTimer);
-      NtSetTimer (_my_tls.locals.cw_timer, timeout, NULL, NULL, FALSE, 0, NULL);
-      wait_objects[timeout_n] = _my_tls.locals.cw_timer;
+      NtSetTimer (wait_timer, timeout, NULL, NULL, FALSE, 0, NULL);
+      wait_objects[timeout_n] = wait_timer;
     }
 
   while (1)
@@ -100,7 +106,7 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
     {
       TIMER_BASIC_INFORMATION tbi;
 
-      NtQueryTimer (_my_tls.locals.cw_timer, TimerBasicInformation, &tbi,
+      NtQueryTimer (wait_timer, TimerBasicInformation, &tbi,
 		    sizeof tbi, NULL);
       /* if timer expired, TimeRemaining is negative and represents the
 	  system uptime when signalled */
@@ -108,7 +114,11 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
 	timeout->QuadPart = tbi.SignalState || tbi.TimeRemaining.QuadPart < 0LL
                             ? 0LL : tbi.TimeRemaining.QuadPart;
       }
-      NtCancelTimer (_my_tls.locals.cw_timer, NULL);
+      NtCancelTimer (wait_timer, NULL);
+      if (local_wait_timer)
+	NtClose(local_wait_timer);
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
index a440a98d4..ca4cce34c 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -386,9 +386,14 @@ next_while:;
      in order, we append the timer as last object, otherwise it's preferred
      over actual events on the descriptors. */
   HANDLE &wait_timer = _my_tls.locals.cw_timer;
+  HANDLE local_wait_timer = NULL;
   if (us > 0LL)
     {
       NTSTATUS status;
+      if (_my_tls.locals.cw_timer_inuse)
+	wait_timer = local_wait_timer;
+      else
+	_my_tls.locals.cw_timer_inuse = true;
       if (!wait_timer)
 	{
 	  status = NtCreateTimer (&wait_timer, TIMER_ALL_ACCESS, NULL,
@@ -431,6 +436,10 @@ next_while:;
     {
       BOOLEAN current_state;
       NtCancelTimer (wait_timer, &current_state);
+      if (local_wait_timer)
+	NtClose (local_wait_timer);
+      else
+	_my_tls.locals.cw_timer_inuse = false;
     }
 
   wait_states res;
-- 
2.45.1

