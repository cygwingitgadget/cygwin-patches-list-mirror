Return-Path: <SRS0=hj9Y=YN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id B9B1938560B3
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 01:27:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B9B1938560B3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B9B1938560B3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748482038; cv=none;
	b=A2zNMnyfJ1zoV1WK73CeaTI9BkLJHUgtfU3vKC4KZ0p5SS8lw3FMRfNMqcoBVb6Pg8IBIrO/HM1CjnBx3yVrpf/vkROxb4+m44lTHHP6Q8WrrEv13+XINy+Njs9ZsCYtVS7NjH0zxAxWV3xzq1buDwa+WaqsE8hv4fF9e5oJlfo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748482038; c=relaxed/simple;
	bh=xXPBJREU+TX2lhHyp9sK3LhuFpxh+VSQLw2JpBTPV4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RXyL+CFaGrIbPZ14fB/DPTyJtm+7y2StEeoycSFaILtf83dbRpEQyoCXQ0XpkjZlTjrtmCMMzzjQvtOweSsy4UCT8Om2GNWrmgX8er4LtZ2a1PY5Sm/xts7ONzrR1hdNFxJLvmYX0/T4laBw5mxcT9NPfjswPkP00fZRZSgFgJc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9B1938560B3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kyeYT7Hv
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20250529012714453.YIY.50988.localhost.localdomain@nifty.com>;
          Thu, 29 May 2025 10:27:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: signal: Revert _cygtls::inside_kernel() change
Date: Thu, 29 May 2025 10:26:46 +0900
Message-ID: <20250529012654.2077-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1748482034;
 bh=CXnbex9GdFHIqaMNpAN5EvWUJPrIAqvkbn9sJpbLCrQ=;
 h=From:To:Cc:Subject:Date;
 b=kyeYT7HvgITTg+DYR278K6zGlklQwm/RBR9VRChXjZVEiNnim12MeNnOIPwkHL75Vuz3qw4u
 se5qnM9Gr+YviUfNhjLs0JD+xyaCDvRPBz7FpI4WaQ7EWBEGgjjDUdIM6WG7yTIBCcpRJ420IR
 KatCClRNbbwiUNy39bARB9U2oqYBxTcY8PZNNPixEP4Px5sVKiZw6Ljt76BZyjHXVlDt+U+lGC
 TM9do7ME/2EUEbevs9t5jWihxyEu4wRiOwogKq+Ux9W3HcwQcF5PYWOpGaKkH0QPsbKSGU3Tqr
 Ef7H95WQo8BgyMIHssi0lr6ZiOov3GfbL/9jerhOmO+4rp+g==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch partially reverts the commit b7097ab39ed0 because it
seems to cause issues when longjmp is used within a signal handler.
The problem that the commit addressed no longer occurs even if this
chage is reverted.

Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 6 +++---
 winsup/cygwin/local_includes/cygtls.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 804adc92b..bcc7fe6f8 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -932,7 +932,7 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
   /* Delay the interrupt if we are
      1) somehow inside the DLL
      2) in a Windows DLL.  */
-  if (incyg || inside_kernel (cx, true))
+  if (incyg || inside_kernel (cx))
     interrupted = false;
   else
     {
@@ -1797,7 +1797,7 @@ _cygtls::call_signal_handler ()
 
       int this_errno = saved_errno;
       reset_signal_arrived ();
-      incyg = false;
+      incyg = 0;
       current_sig = 0;	/* Flag that we can accept another signal */
 
       /* We have to fetch the original return address from the signal stack
@@ -1910,7 +1910,7 @@ _cygtls::call_signal_handler ()
 	}
       unlock ();
 
-      incyg = true;
+      incyg = 1;
 
       set_signal_mask (_my_tls.sigmask, (this_sa_flags & SA_SIGINFO)
 					? context1.uc_sigmask : this_oldmask);
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 1b3bf65f1..615361d3f 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -198,7 +198,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   class san *andreas;
   waitq wq;
   volatile int current_sig;
-  unsigned incyg;
+  volatile unsigned incyg;
   volatile unsigned stacklock;
   __tlsstack_t *stackptr;
   __tlsstack_t stack[TLS_STACK_SIZE];
-- 
2.45.1

