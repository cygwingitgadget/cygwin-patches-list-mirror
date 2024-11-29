Return-Path: <SRS0=zjkU=SY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 93D1C3858D3C
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 12:00:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 93D1C3858D3C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 93D1C3858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732881639; cv=none;
	b=eHGi1DkkJRLcWo0Ok0y2WJBrbe2gpgcCRObuegYPqlZooK6a3m6P1wCzU6emTHfoodh205Yp4QMhtZD/Mqq/QmGREqVvBUuytxBpR7QHGLwFBPca2zeJVZyFGWgdoN52wIMBApg3URQXd3CZjK9/TzJWylAHVH2pHJQK3PAWMm8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732881639; c=relaxed/simple;
	bh=8DV7CUgMmPeN7IuyCwBEpXAh6PSMiPTWlpHhwUFMCSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=eeTvEXizI8dZDeh1pktallcETTwQ7jkkFPTe+nhsOMt8gMsdDwnaMj9Y+/wWNFKYMwK24eAJefsBsMStv2GfTBfVxG8x7JlrcSbQiZ2xAQolfsztMD3mV8Rb+wSal40aPWc1y0CZSTeWKi+hnSY6oVDAdAPBWvYEGvUbeDPh8ZA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 93D1C3858D3C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DW4zFR2Q
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241129120037007.ZBKJ.90249.localhost.localdomain@nifty.com>;
          Fri, 29 Nov 2024 21:00:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 6/9] Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
Date: Fri, 29 Nov 2024 20:59:54 +0900
Message-ID: <20241129120007.14516-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
References: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732881637;
 bh=KBwr1Q20Az8SD/G4RTumPjk8fJANLuooU1HWqv6AHSY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DW4zFR2QeIDAwckAeXXei68V4g/tzEuEpU9i7mGAEaj0LhjvxrWBMxFKnitQYZIfxVQ795sK
 weZs8+LQK0cQOTLKBZrkfCZoI3xxR6wlk5//nQUbi5ikMqCdZc18actSp8MIELaOosgJtP21vq
 Pn0dSaFviPlExtMpHy/SOdUV9jL5GH9mmaNTmQjIVnXfloDBf2gm3V3QrXTK2XhD6U5lOZv6vG
 KXpBIE2gOL3Z5gVPaddZL/4lLWPK3fXjmIgJbKP9j1tiTE8UUdY8IjzQlCcUMVKoXKZEeysErs
 h/I0RSVO1d0ndq5piYGgJMzKBzsvhyib9ezTYpH2WYvGL9Dg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch calls Sleep(0) in the wait loop in lock() to increase the
chance of being unlocked in other threads. The lock(), unlock() and
locked() are moved from sigfe.s to cygtls.h so that allows inline
expansion.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 61522196c715 ("* Merge in cygwin-64bit-branch.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/cygtls.h | 17 ++++++++++---
 winsup/cygwin/scripts/gendef          | 36 ---------------------------
 2 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index e5a377d6b..57a0ec042 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -197,7 +197,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   int current_sig;
   unsigned incyg;
   unsigned spinning;
-  unsigned stacklock;
+  volatile unsigned stacklock;
   __tlsstack_t *stackptr;
   __tlsstack_t stack[TLS_STACK_SIZE];
   unsigned initialized;
@@ -225,9 +225,18 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   int call_signal_handler ();
   void remove_wq (DWORD);
   void fixup_after_fork ();
-  void lock ();
-  void unlock ();
-  bool locked ();
+  void lock ()
+  {
+    while (InterlockedExchange (&stacklock, 1))
+      {
+#ifdef __x86_64__
+	__asm__ ("pause");
+#endif
+	Sleep (0);
+      }
+  }
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

