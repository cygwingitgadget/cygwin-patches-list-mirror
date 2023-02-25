Return-Path: <SRS0=KA5R=6V=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
	by sourceware.org (Postfix) with ESMTPS id 7F7C83857C45
	for <cygwin-patches@cygwin.com>; Sat, 25 Feb 2023 08:58:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F7C83857C45
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-09.nifty.com with ESMTP id 31P8wMfp014364;
	Sat, 25 Feb 2023 17:58:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 31P8wMfp014364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1677315509;
	bh=MdEfxr6wz3y5ZCkPFvvHfHw5yCLU4tfQAH/pmUxtDT8=;
	h=From:To:Cc:Subject:Date:From;
	b=L3fyCjnkt5PnPIcCKkw7mfUsGgdkoj8kqQQxOP5wuv+eFalklC7QxV6LkyqSb4fqn
	 4ZE0shDTzqohdpOrTaa0LAGYbauZdqim20dSh140AjW9qNbIMmgW0cTXoLTdOpqjoF
	 ckudz8XLR3Zwy7TltbGqxD8h00ZG9uHLy2ro5d4blo30fqzwGaYfj1pY9oc1bImrjy
	 e4lI+FZProtohjaQ4AKU1H/8gQO7rZj3ZT4SbbjPTix0SvBFmdMNxvuP6RF74FwgME
	 zjr8mAu2CwTB7lmiklah7HZJhT0ZSkm2uoGRQrJ7OhNEdHknxuVSQVmxHYtMUM20Zp
	 jLYsvakemt6Gw==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Fix SNDCTL_DSP_{POST,SYNC} ioctl() behaviour.
Date: Sat, 25 Feb 2023 17:58:12 +0900
Message-Id: <20230225085812.41341-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, SNDCTL_DSP_POST and SNDCTL_DSP_SYNC were implemented
wrongly. Due to this issue, module-oss of pulseaudio generates
choppy sound when SNDCTL_DSP_POST is called. This patch fixes that.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 16db6bb29..27f0a50ce 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -133,6 +133,8 @@ class fhandler_dev_dsp::Audio_out: public Audio
   int freq_;
   int bits_;
   int channels_;
+
+  friend fhandler_dev_dsp;
 };
 
 static void CALLBACK waveIn_callback (HWAVEIN hWave, UINT msg,
@@ -1429,11 +1431,16 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	return 0;
 
       CASE (SNDCTL_DSP_POST)
+	if (audio_out_)
+	  audio_out_->sendcurrent (); // force out last block whatever size..
+	return 0;
+
       CASE (SNDCTL_DSP_SYNC)
-	// Stop audio out device
-	close_audio_out ();
-	// Stop audio in device
-	close_audio_in ();
+	if (audio_out_)
+	  {
+	    audio_out_->sendcurrent (); // force out last block whatever size..
+	    audio_out_->waitforallsent (); // block till finished..
+	  }
 	return 0;
 
     default:
-- 
2.39.0

