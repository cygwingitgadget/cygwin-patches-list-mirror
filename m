Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 73BCF4BA2E07
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 08:43:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 73BCF4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 73BCF4BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789461781; cv=none;
	b=bHJ1GfT+J6mF8afGSxnsK7J3GjbPLT+4y9HwO/jf0I5WCSpEBw8MsaG/f3Y+YajtiLWaLZVM320V1fYD6I9NmwtF1zi1Uq4cs/emjYIWZ9xEUPKXAjhmsGEAQAIG+Vhz4Hg8KgWKeGs/tjYUzMhEhdcGI3n/Np1mohgs8+AUXfY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789461781; c=relaxed/simple;
	bh=kUYxICdqe9OAS3xblZ2cYlyfg5OVeAeVRxBMUZmTujI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=fZSvPS7QHWGhwj1VR8+VZ63lkppGZSIc1sHq2g+rFb/+vfmLktv9SNfJC2k+7nU2mmfjgsAD+kZnNkORW2s04bt1FN3w+ty36DQI6ePL0SOg/FW1WuPdiscYITBrDsmdCw52RKYCro0W46bff2O83cvqGpvbI4WmEGTEa7WTP7g=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tnCYIKeb
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 73BCF4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tnCYIKeb
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260915084258323.OSDR.60338.HP-Z230@nifty.com>;
          Tue, 15 Sep 2026 17:42:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: console: Improve the performance of peek_console
Date: Tue, 15 Sep 2026 17:42:45 +0900
Message-ID: <20260915084252.815-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789461778;
 bh=KCoItQ8BddzRGCbcD2W6xGeHcKobjKJ70ElkLJrBWPM=;
 h=From:To:Cc:Subject:Date;
 b=tnCYIKeblGGZHWNzTjeIB2bxIa5zhAslAIAnlpzc7S+Yx+mhCTX3uml1BaIkX69yrmpW55k7
 YfewD37mVsyS6ZKb32xIKhreBMao3rcxBI4zemC8qWMH80t4YOennZlCJlubaqxaBXu/emPfbO
 0gC6F5NXTPnYqoSUuv1l/yjSMq2v5ZUJgpfCm3AAhr1yotKf0/gfXRTp/4cTE40UCe4IXZtWDm
 bkGPckI8mu893MwwWA+nvtS18Oe+OEEn9eBeATd8XiWtDnz+tfq1EaF31eZ+++7Ki2hvfRyPlK
 X95hrtn0dUzhwcbBAL2rYT9T59jjRHreDePwvN7vZv8iXQWQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, peek_console() used PeekConsoleInput() to confirm whether
the console input buffer has some input records. However, this need
attaching to the console if the process does not attach to the console.
To reduce that overhead, this patch uses WaitForSingleObject() with
console input handle instead. WaitForSingleObject() works without
attaching to the console, so this simplifies the peek_console()
code.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Do not remove PeekConsoleInputW() call.
 winsup/cygwin/select.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 48f66c954..99c52311f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1160,6 +1160,14 @@ peek_console (select_record *me, bool)
 	return me->read_ready = true;
       else
 	{
+	  if (WaitForSingleObject (h, 0) != WAIT_OBJECT_0)
+	    {
+	      fh->release_input_mutex ();
+	      break;
+	    }
+	  /* Also check using PeekConsoleInputW(), because windows terminal
+	     may leave input handle signalled when erasing non-key events.
+	     https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp#L347-L352 */
 	  fh->acquire_input_mutex (mutex_timeout);
 	  acquire_attach_mutex (mutex_timeout);
 	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
-- 
2.51.0

