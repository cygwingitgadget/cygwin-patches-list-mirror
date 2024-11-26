Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id A6BD4385783C
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:56:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A6BD4385783C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A6BD4385783C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611406; cv=none;
	b=xKovhCWmg752wZtPStm12yxi5V59mohq3QraI4ZrysaHaNAj/B23LOaWu9XkGaE8cbHJUeGXJezXfIzPrcpQkDNzvNmU2G1Ng0421EfZA7n7l6fNEBNr//9myFTsKKHcUQKqBw6adccr8yFFkAOoPn9T+wvQnfizHJMRXGenSM4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611406; c=relaxed/simple;
	bh=Gh72GJQun6m06k9/RllkluVRfKVj4d03pEWGLQL7LKY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nqOQWpJXzlCnBZKVWRpLhAb9tr9xuyUunIqC1iLUTPzB484XyGFhdqpemyjTC32swdyPGcpv21UYMHo8fezM0v5A18xKcTswrHy5oQIeAcLKEvZ7b9koOh0rhIfKC01SWZmEoIVYtJuchiKf/1VEgMrAEnuV2PxEqAxv24FBe38=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A6BD4385783C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=imbz0/1i
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085644060.NQWV.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:56:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 6/7] Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
Date: Tue, 26 Nov 2024 17:55:03 +0900
Message-ID: <20241126085521.49604-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611404;
 bh=AlF5fYY611BPSsBejobn9G9h66RWAGQ1WK2DfqSfOBk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=imbz0/1ifC0zpV1LqdG5Ap7mG2pS2mo96xmKh3gEnkCvtixBz0kOCX0q4oqK2G6GRw+qcKPj
 RQ4dp9a3j8Vo5WtJz+QcMxgNOc4Ie5GD1MWFP6GJtJe7SA6ZvwzTHw0XVWsPndq481YVxRanhf
 ksECZvtlT72BlYexrI8tw3kL/HbTRkRvEVaZRYXKIjNFF3/Qrdo9UwurWDpnp4Lew8W1UUHUhH
 +yeRm1GvAnOmHPyHxnJYP5Po/PJwzoJULMcw5ZF2P0+sV1r8RxnMIj4Q8xIAz6rj9XueZCx0BN
 SAOcvpqgEUKZCoZePAfY1job9b0H3j/jFds7UP2R/vtmLnNg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch calls Sleep() in lock() in order to increase the chance
of being unlocked in other threads. The lock(), unlock() and locked()
are moved from sigfe.s to cygtls.h so that allows inline expansion.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 61522196c715 ("* Merge in cygwin-64bit-branch.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/cygtls.h | 13 +++++++---
 winsup/cygwin/scripts/gendef          | 36 ---------------------------
 2 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 28bbe60f0..fb5b02b4c 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -223,9 +223,16 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   int call_signal_handler ();
   void remove_wq (DWORD);
   void fixup_after_fork ();
-  void lock ();
-  void unlock ();
-  bool locked ();
+  void lock ()
+    {
+      while (InterlockedExchange (&stacklock, 1))
+	{
+	  __asm__ ("pause");
+	  Sleep (0);
+	}
+    }
+  void unlock () { stacklock = 0; }
+  bool locked () { return !!stacklock; }
   HANDLE get_signal_arrived (bool wait_for_lock = true)
   {
     if (!signal_arrived)
diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 720325fdd..7e14f69cf 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -322,42 +322,6 @@ _ZN7_cygtls3popEv:
 	ret
 	.seh_endproc
 
-# _cygtls::lock
-	.global _ZN7_cygtls4lockEv
-	.seh_proc _ZN7_cygtls4lockEv
-_ZN7_cygtls4lockEv:
-	pushq	%r12
-	.seh_pushreg %r12
-	.seh_endprologue
-	movq	%rcx,%r12
-1:	movl	\$1,%r11d
-	xchgl	%r11d,_cygtls.stacklock_p(%r12)	# try to acquire lock
-	testl   %r11d,%r11d
-	jz	2f
-	pause
-	jmp	1b
-2:	popq	%r12
-	ret
-	.seh_endproc
-
-# _cygtls::unlock
-	.global _ZN7_cygtls6unlockEv
-	.seh_proc _ZN7_cygtls6unlockEv
-_ZN7_cygtls6unlockEv:
-	.seh_endprologue
-	decl	_cygtls.stacklock_p(%rcx)	# release lock
-	ret
-	.seh_endproc
-
-# _cygtls::locked
-	.global _ZN7_cygtls6lockedEv
-	.seh_proc _ZN7_cygtls6lockedEv
-_ZN7_cygtls6lockedEv:
-	.seh_endprologue
-	movl	_cygtls.stacklock_p(%rcx),%eax
-	ret
-	.seh_endproc
-
 	.seh_proc stabilize_sig_stack
 stabilize_sig_stack:
 	pushq	%r12
-- 
2.45.1

