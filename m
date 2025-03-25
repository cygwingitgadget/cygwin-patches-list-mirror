Return-Path: <SRS0=MFHH=WM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 5B15A3858D33
	for <cygwin-patches@cygwin.com>; Tue, 25 Mar 2025 12:54:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B15A3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B15A3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742907277; cv=none;
	b=c7hTXrEvuLTj+Pr+0EQPZC5r7ifYHs3GT5ofGTB0GngbvfrTSRAuUbZfP/YOKOoIwdEHUwo7ip/Hzv7sMejZGpXd9QfD1hqxzHeA5ps67exkUVgx+AisoiDbZc24heygz0PFTwEnN5X1Vo5Db/37oapVlLCt9LNUAvSfM4rmdP0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742907277; c=relaxed/simple;
	bh=n2p0OT7T/Jl3Z1tT1yiZCpZC2WxrUuU4PopwbOYNekQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Mm3UCN9/kiQAfQ/hhzclWhDlYQ6eygzfWRPeeA/vGA+eDAz/W7xqDiXLtnJU/VKiZsZ1cEMqHJDXqWajgJ+73lA0AYvkt66DPG69fQPnNEYGUjPA86nLUAZyAcUrs4gXQmck0WaVpRC+OxZXHsEeoIOK0MwnGJz/ImLGoBNY8Lg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B15A3858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GWjtXyrE
Received: from localhost.localdomain by mta-snd-w10.mail.nifty.com
          with ESMTP
          id <20250325125434511.HEUE.83778.localhost.localdomain@nifty.com>;
          Tue, 25 Mar 2025 21:54:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruno Haible <bruno@clisp.org>,
	Corinna Vischen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: signal: Copy context to alternate stack in the SA_ONSTACK case
Date: Tue, 25 Mar 2025 21:54:08 +0900
Message-ID: <20250325125417.1898-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742907274;
 bh=efD4UFpKQ+TF4UROgHt8g6EuCmcpMfe8x6fbzCG2H6c=;
 h=From:To:Cc:Subject:Date;
 b=GWjtXyrEdNqjbEOMKZ3StjfVbSxOT/XeZJgFaH4rZPASHtisp8mTbd2tSqra0DOXTh+S8tO8
 4RXTL4ruHxSw+BmCviTBGPQJ834/oQwlGFfD6Zq8bzGfgxmfhTYCthXRrShTp+Afk95uXO4MwF
 aqDYl31uzcP5jKcrnTqdgQeIQ12e5ulBK3wYjvsB6jwJ2G2ZRheCS1+nEuOT4pTgLLWhrc6pgP
 36meANE0KMKQr8d7aBZHb3VFrjzt2dYOMUnYcolAM4ZogrwrbKF+siptRHmN8AvJYJabhicYpO
 6dbcVar2/5tvENnHCAqAf38eBYQDYG9v/fXCcHakVE4CcXEA==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit 0210c77311ae, the context passed to signal handler
cannot be accessed from the signal handler that uses alternate stack.
This is because the context locally copied is on the stack that is
different area from the signal handler uses. With this patch, copy
the context to alternate signal stack area to avoid this situation.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257714.html
Fixes: 0210c77311ae ("Cygwin: signal: Use context locally copied in call_signal_handler()")
Reported-by: Bruno Haible <bruno@clisp.org>
Reviewed-by: Corinna Vischen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 8 ++++++++
 winsup/cygwin/release/3.6.1 | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 2e25aa214..a3aae2ce5 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1791,6 +1791,13 @@ _cygtls::call_signal_handler ()
 	     to 16 byte. */
 	  uintptr_t new_sp = ((uintptr_t) _my_tls.altstack.ss_sp
 			      + _my_tls.altstack.ss_size) & ~0xf;
+	  /* Copy context1 to the alternate signal stack area, because the
+	     context1 allocated in the normal stack area is not accessible
+	     from the signal handler that uses alternate signal stack. */
+	  thiscontext = (ucontext_t *) ((new_sp - sizeof (ucontext_t)) & ~0xf);
+	  memcpy (thiscontext, &context1, sizeof (ucontext_t));
+	  new_sp = (uintptr_t) thiscontext;
+
 	  /* In assembler: Save regs on new stack, move to alternate stack,
 	     call thisfunc, revert stack regs. */
 #ifdef __x86_64__
@@ -1834,6 +1841,7 @@ _cygtls::call_signal_handler ()
 #else
 #error unimplemented for this target
 #endif
+	  memcpy (&context1, thiscontext, sizeof (ucontext_t));
 	}
       else
 	/* No alternate signal stack requested or available, just call
diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
index 40ef2973f..95c2c054e 100644
--- a/winsup/cygwin/release/3.6.1
+++ b/winsup/cygwin/release/3.6.1
@@ -10,3 +10,8 @@ Fixes:
 - getlocalename_l: Fix a crash and handle LC_ALL according to final
   POSIX-1.2024 docs.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257715.html
+
+- Copy context to alternate signal stack area in call_signal_handler()
+  in the SA_ONSTACK case, because locally-copied context on the normal
+  stack area is not accessible from the signal handler.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257714.html
-- 
2.45.1

