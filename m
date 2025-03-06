Return-Path: <SRS0=5XJv=VZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 237B13858D26
	for <cygwin-patches@cygwin.com>; Thu,  6 Mar 2025 11:03:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 237B13858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 237B13858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741258983; cv=none;
	b=a2fG7ZLHMERl2pxGERalTTwmt3XBrVAL7qWx4VAK4ZuNiRXtJ/WkwsmYDl3PdPVuTB1dFjmtqTEABg2AktPt0CPrMoFri+e631P5RNIsl5pa6x8vw83kwJ8a2ibPf91ejnmrx59QC/yigBpAU7DBpmVaAFFYhIDSOJPLVtDA/DQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741258983; c=relaxed/simple;
	bh=tCZNti9h1V0tmyBmrKOKpcUPa7KHbNeppxZOGPh0yGU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=okUsF/3cSngl3E4jHRWjDpcy6Ylr7ZqC5tv9a3IyW1K8WDbQ5o6ZWhdoXN6EKwc0yovL5p2jf2NDDkBiOWihdH8zqKYX2my4eK4ItIYnTjtEY/qqUmDe5R7ZA9ixPYf4LILT3dFqnzr35vJt0Cb4XI8ub7KkjXAK1KWr6ohIGms=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 237B13858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DtRJ1pFv
Received: from localhost.localdomain by mta-snd-w04.mail.nifty.com
          with ESMTP
          id <20250306110259457.JSYO.109987.localhost.localdomain@nifty.com>;
          Thu, 6 Mar 2025 20:02:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: signal: Add one more guard to stop signal handling on exit().
Date: Thu,  6 Mar 2025 20:02:32 +0900
Message-ID: <20250306110243.1233681-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741258979;
 bh=ntJanFIdddN7PBoivJGfkC+IekdaCiiuWSQN5zsnhi0=;
 h=From:To:Cc:Subject:Date;
 b=DtRJ1pFvX4TdqVAxZOtFG8ZALy0uuV6tzBj5txHtFDr8UaqRRFgldOBbXopld6bTK4EkEmpj
 Kh01TQcO1muUKur2/MXNuwvJ16q+P6Nt5tlEhBLG0kIwpegQzaWXpC6giy50c9YdzeJUFrMWbc
 Y7LEWxntlldNDFZNOoRkgg7oBHrWO1rhjUst59244tlP21Obnw3Ux4gQJf7o56vf1HRuKQbh/d
 1EpNPuyJcq//9h7mpIsUqMwMA2xUqLsqzCTNECbJQwKQHdTvUU4fRzEYNXXW8lDNs5IheOSM3o
 bQxsGMEdNMtuy2dxhsvdeRTIqpGfOlin1F3NacdsEtx6eRkw==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 3c1308ed890e adds a guard to stop signal handling on exit()
in call_signal_handler(). However, the signal that is already queued
but does not use signal handler may be going to process even with that
patch.
This patch add one more guard at the begining of sigpacket::process()
to avoid that situation.

Fixes: 3c1308ed890e ("Cygwin: signal: Fix a problem that process hangs on exit")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 759f89dca..a67529b19 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1457,7 +1457,7 @@ sigpacket::process ()
 
   /* Don't try to send signals if we're just starting up since signal masks
      may not be available.  */
-  if (!cygwin_finished_initializing)
+  if (!cygwin_finished_initializing || ext_state > ES_EXIT_STARTING)
     {
       rc = -1;
       goto done;
-- 
2.45.1

