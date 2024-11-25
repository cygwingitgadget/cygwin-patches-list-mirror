Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id B020C3858D37
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 12:17:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B020C3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B020C3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732537074; cv=none;
	b=AzsqXYkVMSuCYPYI6pe3whGaLI+MR+1UwJt7bjdtjFfb0vpfs4p04E9FWaH1c15grCiBrERVzFBxA9Pf9buBtATmVWsm9uplZtKvavEVMa5WV0Vf8VXS8dkwlPYctxcgfh7rW5M9YYvn+LWPdEhkK+9OGlI1H0TUjHUj/WliDEA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732537074; c=relaxed/simple;
	bh=Bp1tfdMWPtBTmlWZCM7uXXU4Yac46FMA+8yOinDnvds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=D4RCffWand6O9uZURwwNXp6u2IOYqyvg8jOe949R93mho0Xs3iDX93/KBPDKaKusG3U3Wj0Lqb7AGkN30rjgO+d0ssHU3DLlFRidWu5dByUcLiJm9RAL1LstTVPTQVBeiXrznpnbItdgoIDlRvb3hyaOCBb8vbCmYJluTEDPY+0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B020C3858D37
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UEDDkyzW
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241125121752085.KENK.47547.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 21:17:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 6/6] Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
Date: Mon, 25 Nov 2024 21:16:22 +0900
Message-ID: <20241125121632.1822-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
References: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732537072;
 bh=DWVjf3az0PzTTHqLPIdnY+7+cp6TVCs00i/y9aFhqVY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UEDDkyzWTDadKwCqPyDc5OB35CIFV+5TTh/HFFsp+reTPG4AZmiQl2bCf2+aaNMJDh94LMGW
 CQNxuEcAFrJ31udONEa9k7Z6dpypYjnX0nuVQBveoO28e/RCxAv6qIsQzc1lbURKUwmO1hcKDw
 ZM9M5k8GsTotByY1xe6t3rYfdtFWy9dj76nfn7nbLt0GWXTkI2cjAwBdH2y0PEr9NWDYtfwMtk
 kJzbAQ/jBTpWlqBjqRULipnVH8vEYE0dHjvbHeBdGbepteNLJtcCxacQV8InwV4hx5AeQ68V8R
 UTQjmOS9G0UY2A6DqZ3VILUb4T/VahEhNr4z9HFrJ+3znerA==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch replaces pause instruction with SwitchToThread() call
in wait loop in lock() to increase the chance to unlock in other
threads.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 61522196c715 ("* Merge in cygwin-64bit-branch.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/scripts/gendef | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 720325fdd..d1bcc5318 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -115,6 +115,8 @@ EOF
 	.include "tlsoffsets"
 	.text
 
+	.global SwitchToThread
+
 	.seh_proc _sigfe_maybe
 _sigfe_maybe:					# stack is aligned on entry!
 	.seh_endprologue
@@ -334,7 +336,7 @@ _ZN7_cygtls4lockEv:
 	xchgl	%r11d,_cygtls.stacklock_p(%r12)	# try to acquire lock
 	testl   %r11d,%r11d
 	jz	2f
-	pause
+	call	SwitchToThread
 	jmp	1b
 2:	popq	%r12
 	ret
-- 
2.45.1

