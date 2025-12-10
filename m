Return-Path: <SRS0=1nHs=6Q=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id AECD74BA2E07
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 01:52:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AECD74BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AECD74BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765331572; cv=none;
	b=u6fNNijy9GFZobxGsJhNrPyMDnq3Huj9g+bAfmXBP7g6p96wwQREtp3e9ZKmxnLrtjl/0mTv+skHpc5XwH5iCvXM3ppv2IR3VO9qe/7f1CWTdWZT91SFzJLJGVtIZODnnsvU7b384MUX9ay/gp/Sto6AxVJhBc5oXG0bmlES2/E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765331572; c=relaxed/simple;
	bh=bfZByYH/t7/GHIQ/Fmge/MMASNTDvxuYOFJ+ArQgSSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=fho8EjmFa4uKQAYBApBo37s9AsX89gsLs2xXuDQsJhFSJEdcmeLsImKo4841uQS/Z7jAshLJ41fOdvLtpwHZ5Q6TzWfYiL+Mi0m3axFRocjO8g4tOaI6+U6Rrgh+GPZ8XpXd2PcvViFc5gq9lxGUJ7YlKKoBmLLk7uo04DX4fDQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AECD74BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HPHNEOiu
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251210015249748.EXMC.127398.HP-Z230@nifty.com>;
          Wed, 10 Dec 2025 10:52:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/2] Cygwin: pty: Fix ESC sequence parsing in pty_master_fwd_thread
Date: Wed, 10 Dec 2025 10:52:22 +0900
Message-ID: <20251210015233.1368-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
References: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765331569;
 bh=I0gGOx2GNZo46/A7kztoHugtO/4XUOFKthjkzfi40Yg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HPHNEOiuDYjSTrsJfqII8BCpDmzg73ZYf8wVYcSIZBwidNZgnxadrDQ0z73+ibYWBMzRN3Ur
 QudjM1zL+f6jAIyMp9Mftx5Wdyb29Kf/LSvUGDlVfPyPw+RpqLCdUHg2Djqt+ZVbVRZxYvLV+r
 91SUXNQa+1w8GAoc69D/CogRyYct/St3w+X0X4GJe+Yuzomg1R/WH1uQnkZnOygu1cbmKSt70w
 Yg+Wp7vGazC7Wl5wKxOg5dDMOY0N6wFeEYvyCyuUhzk/70lk0Vu7GWspmwhfDlmrDNUFXj1Wdc
 HRrWMJyL8xkbISw14w41ivEZaU8xCXrao+pDgBazr1OvCY9Q==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch fixes the bug in ESC sequence parser used when pseudo
console is enabled in pty_master_fwd_thread(). Previously, if
multiple ESC sequences exist in a fowarding chunk, the later one
might not be processed appropriately. In addition, the termination
ST was not supported, that is, only BEL was supported.

Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 679068ea2..3b0b4f073 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2680,7 +2680,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	  int state = 0;
 	  int start_at = 0;
 	  for (DWORD i=0; i<rlen; i++)
-	    if (outbuf[i] == '\033')
+	    if (state == 0 && outbuf[i] == '\033')
 	      {
 		start_at = i;
 		state = 1;
@@ -2688,12 +2688,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	      }
 	    else if ((state == 1 && outbuf[i] == ']') ||
 		     (state == 2 && outbuf[i] == '0') ||
-		     (state == 3 && outbuf[i] == ';'))
+		     (state == 3 && outbuf[i] == ';') ||
+		     (state == 4 && outbuf[i] == '\033'))
 	      {
 		state ++;
 		continue;
 	      }
-	    else if (state == 4 && outbuf[i] == '\a')
+	    else if ((state == 4 && outbuf[i] == '\a')
+		     || (state == 5 && outbuf[i] == '\\'))
 	      {
 		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
 		if (memmem (&outbuf[start_at], i + 1 - start_at,
@@ -2701,11 +2703,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 		  {
 		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
 		    rlen = wlen = start_at + rlen - i - 1;
+		    i = start_at - 1;
 		  }
 		state = 0;
 		continue;
 	      }
-	    else if (outbuf[i] == '\a')
+	    else if (state == 4)
+	      continue;
+	    else
 	      {
 		state = 0;
 		continue;
-- 
2.51.0

