Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 0897B3858C54
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 23:09:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0897B3858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0897B3858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740784172; cv=none;
	b=koeo6k7t8/puvprRgPtOVv0fk0YnNOrCsLopAPwiIeLiAvFdte397YcjB5gqBy7vUbtYA9lvCJG4Vp4QqKniQL8aBvR6EM5Md6uvNqlY+Nh0ejj8JjnpdpfGJAWhEF5L24nQpG1TNn18oWKrlRErcAlt1iLHKJTEymbxcS0ezcU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740784172; c=relaxed/simple;
	bh=AWMBSGMU62/6TQmvGdMSyzl8Ltw4xF7Xg9kZXNbIwdQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=MDnnUMzxSxsJlsf8RzaNVlUSWHiFWPu2Metqv6Ly1EW3qe+uf/CcjifEnHCFVSRycmpeLXhh2BGzxbngNiNuurfLGXcJ//p1psf6tTSUKCLE8VVSc7XthJkHOojV+U67C3PtXc8/I9u74fxPebBG93iDLJqaGWDXMlfsqyUJxEA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0897B3858C54
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=puwatmq9
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20250228230930247.FSXN.48684.localhost.localdomain@nifty.com>;
          Sat, 1 Mar 2025 08:09:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 3/3] Cygwin: signal: Fix a problem that process hangs on exit
Date: Sat,  1 Mar 2025 08:08:44 +0900
Message-ID: <20250228230853.671-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250228230853.671-1-takashi.yano@nifty.ne.jp>
References: <20250228230853.671-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740784170;
 bh=55MJJX7JEAZ7Dw91xmvwN17xyR7U9TlNgxcdvpvcEUQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=puwatmq9A6PjFQazfnwYPmhBShTwSw/avWCNDrYs6f7KdBIp+vpLX1OMe2QgOoimF9ds3qzI
 szj1FhbpPnJFUuZ/J/KTmXDnqOZn4h/8BIrFA8HdMLjBxXtw+WNLf4Yxj8D+WW7QbM1mR6ky5Q
 a0ezZQ3UQ7ifMamTLvPjwd1W+xjp01t63niExgDCw7QCdfT+bql599VCqdx81vDtGN08kApLU3
 Es1Fzk/r1tTezZKtSuaoZ0oaeC+COV0+P0340sECI5Yd8r8t3+I0f06hAVs9QT0Cj+8TnU8Yv4
 F0giVFun8baeCrYDGXUYQV4L3lEnm+t81wxqiXOvPGULRuQA==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The process that receives many SIGSTOP/SIGCONT signals sometimes hangs
on exit in sig_dispatch_pending(). This patch skips processing signals
in wait_sig() when exit_state > ES_EXIT_STARTING to avoid that situation.

Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257473.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8739f18f5..b519866d2 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1374,7 +1374,11 @@ wait_sig (VOID *)
 
       sigq.retry = false;
       /* Don't process signals when we start exiting */
-      if (exit_state > ES_EXIT_STARTING && pack.si.si_signo > 0)
+      if (exit_state > ES_EXIT_STARTING
+	  && (pack.si.si_signo > 0
+	      || pack.si.si_signo == __SIGNOHOLD
+	      || pack.si.si_signo == __SIGFLUSH
+	      || pack.si.si_signo == __SIGFLUSHFAST))
 	goto skip_process_signal;
 
       sigset_t dummy_mask;
-- 
2.45.1

