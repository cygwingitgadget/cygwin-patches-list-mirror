Return-Path: <SRS0=7NHZ=YM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 560953857712
	for <cygwin-patches@cygwin.com>; Wed, 28 May 2025 12:53:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 560953857712
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 560953857712
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748436808; cv=none;
	b=qHwzMT+DiVx/GA6+qZxnlAdXwrwhLCHiSyaLqPNqXJo86Gk/Knb9h2/N40RYoH1ZvaZ6NZallrRKolYO+471rBubcYAjFo+eoj8v2TYv7SMAo0+OlvHTfPpJmxKk4wKoTQdRtOt5jPim2JOd1cLKxMFar+suqMTKDxIxq6Z9kl4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748436808; c=relaxed/simple;
	bh=WXLc1bav2oK0/vdis5P1jqI3s79BQ5x73LtP6CFnHLE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=k2k/zHklMstCssnWFwhECciBr1xuDTMj0x83oH/sZOVLOnE8MRCcAWlThEpSVXijGIqcVG+R1CX/Ckdcth3RXgQC/ujQZC47ZUqlpONh8TotmFvU8uC53/AczXf0k1HIKqRh0cRoysGU+zXVV9qW2Z07qj23qaC/VS/tTaYarkg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250528125326509.PBLM.47226.localhost.localdomain@nifty.com>;
          Wed, 28 May 2025 21:53:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: signal: Revert _cygtls::inside_kernel() change
Date: Wed, 28 May 2025 21:53:03 +0900
Message-ID: <20250528125311.2589-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1748436806;
 bh=pUjBRl28G5XfL5CYCPWFDHRoS+wOfVlWJQepHD0zrfE=;
 h=From:To:Cc:Subject:Date;
 b=LfEpEr3fQCxxqnM/nA8vZLP/bp/SK/U2iPB+OyZYfM1IWkbH4R5Xw1tsDBFjlaGFE7LYIOOj
 AfzQnSiyuwcC/ZN62AY/O0aAfq2SDmige+nxEsFhCPgIPEh8sZdRelAg9DLWZObeGNbE5F5vkV
 LxjcMuviHuV1vvOmqGqCOg6cFLf0rTLpO3SDEyIzUyyJdLEu1PK8l6ksEiSAjRiE5CLdQ1Fbzv
 c7qd4y9vkNSgbZ1x3AkE9EGR8co4W0iqdMWPVq6ps7Mbh/Np7u4T3zNF0V2IjlpDqnFOyNWicH
 QUogotxu0NferWdJ889FOoCx3FxWiblY+MaGXnCDdlrse7pA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch partially reverts the commit b7097ab39ed0 because it
seems to cause issues when longjmp is used within a signal handler.
The problem that the commit addressed no longer occurs even if this
chage is reverted. Instead, handling incyg in call_signal_handler()
has been revised. Previously, incyg was set to false before calling
the signal handler and set to true after the handler returns. However
if incyg was originally 0, it would be unintentionally changed to 1.
This patch ensures that incyg is properly restored to its original
value.

Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 11 +++++------
 winsup/cygwin/local_includes/cygtls.h |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 892b6c68f..7791a5096 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -932,7 +930,7 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
   /* Delay the interrupt if we are
      1) somehow inside the DLL
      2) in a Windows DLL.  */
-  if (incyg || inside_kernel (cx, true))
+  if (incyg || inside_kernel (cx))
     interrupted = false;
   else
     {
@@ -1794,7 +1792,8 @@ _cygtls::call_signal_handler ()
 
       int this_errno = saved_errno;
       reset_signal_arrived ();
-      incyg = false;
+      unsigned incyg_orig = incyg;
+      incyg = 0;
       current_sig = 0;	/* Flag that we can accept another signal */
 
       /* We have to fetch the original return address from the signal stack
@@ -1907,7 +1906,7 @@ _cygtls::call_signal_handler ()
 	}
       unlock ();
 
-      incyg = true;
+      incyg = incyg_orig;
 
       set_signal_mask (_my_tls.sigmask, (this_sa_flags & SA_SIGINFO)
 					? context1.uc_sigmask : this_oldmask);
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 1b3bf65f1..669812663 100644
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

