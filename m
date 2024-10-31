Return-Path: <SRS0=MmMu=R3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id 0596C3857BA2
	for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 08:36:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0596C3857BA2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0596C3857BA2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730363800; cv=none;
	b=Ted/aOY2oKZqU0MKjgB6Hob6s+/QAXPDKCYczIhIbCpAHC4mPbZbEEQUV09sA1pTvqGmiMIF5Y/wcDD4qNFr+UiLjDXzrsSnYjtROKofwno06Uim6IpvW3dzO0Uca0zmuA/6qqDfbaYKAgUc1cEsuVKAGrtN+2ZrkEudj4oOi0Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730363800; c=relaxed/simple;
	bh=gGidVGvXwlxl2GNUJ74qA8aV1uPQacCc44KUYt4q8fw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Z1fb1eUdWkXxp1ht+YbfaPATDH+sHNliwOwqALr65jkvYNbUssOz7rtJReSVkEg8QEw6Iz4GoTv/anikIeQkuGPqxOo15vaJ8nWN4Z7A24JicnV0OF3VjIcHSFliFT9vXy7rWh5ISMKk4yHvagL2M7Cylocag8kzM6/g6L4JG4g=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20241031083629167.SKPQ.44461.localhost.localdomain@nifty.com>;
          Thu, 31 Oct 2024 17:36:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v3_5-branch] Cygwin: cygfe: Fix a bug that signal handler destroys fpu states
Date: Thu, 31 Oct 2024 17:16:36 +0900
Message-ID: <20241031081646.958-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730363789;
 bh=V82H/VvftsFOvvQTyAIb/zbKjTDKBErbcqBRJeO/Xtk=;
 h=From:To:Cc:Subject:Date;
 b=sTZ7zD/PiDG7QnJ/CrR/aLJOIpfwXbcpXeko1ofNPVvHptXbi6isIgphuzHApM01EzuA15OH
 NP47du5i+jGQtoC2Dv4svk/b5wp0uISs93qy3aNPqDPJOHR5CyRZTx0HdzyZcG6VdXiUPwtXMM
 MQxgqbup7UfJbZwKy60C2YPtdFXhIvTWqkh5uhwfxzDDscxtbefXbGrvupTmwi8dcdHm0lLIIz
 hP/3e67uPVoLy3MCxexVZl2tHWlNnhYREeZAKmLReKCmRBzAwUSOnhksWWNPZwUWJXFq4YEqkm
 oDvQBdOMZGHWdecz+d7f5YeWsDthAqsx1ahQxnW8kZ4LTRaw==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, sigfe had a long-standing problem that the signal handler
destroys fpu states. This is caused by fninit instruction in sigdelayed.
With this patch, instead of fnstcw/fldcw and fninit, fnstenv/fldenv
are used to maintain fpu states.
Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256503.html

Fixes: ed89fbc3ff11 ("* gendef (sigdelayed (x86_64)): Save and restore FPU control word.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/scripts/gendef | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 3b1f8b9da..c2ad5c75e 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -213,10 +213,10 @@ sigdelayed:
 	.seh_pushreg %rbx
 	pushq	%rax
 	.seh_pushreg %rax
-	subq	\$0x128,%rsp
-	.seh_stackalloc 0x128
-	stmxcsr	0x124(%rsp)
-	fnstcw	0x120(%rsp)
+	subq	\$0x148,%rsp
+	.seh_stackalloc 0x148
+	stmxcsr	0x13c(%rsp)
+	fnstenv	0x120(%rsp)
 	movdqa	%xmm15,0x110(%rsp)
 	movdqa	%xmm14,0x100(%rsp)
 	movdqa	%xmm13,0xf0(%rsp)
@@ -275,10 +275,9 @@ sigdelayed:
 	movdqa	0xf0(%rsp),%xmm13
 	movdqa	0x100(%rsp),%xmm14
 	movdqa	0x110(%rsp),%xmm15
-	fninit
-	fldcw	0x120(%rsp)
-	ldmxcsr	0x124(%rsp)
-	addq	\$0x128,%rsp
+	fldenv	0x120(%rsp)
+	ldmxcsr	0x13c(%rsp)
+	addq	\$0x148,%rsp
 	popq	%rax
 	popq	%rbx
 	popq	%rcx
-- 
2.45.1

