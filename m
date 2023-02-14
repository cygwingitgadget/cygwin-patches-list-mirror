Return-Path: <SRS0=ZEYn=6K=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
	by sourceware.org (Postfix) with ESMTPS id 86D0B3858D33
	for <cygwin-patches@cygwin.com>; Tue, 14 Feb 2023 14:36:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 86D0B3858D33
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-09.nifty.com with ESMTP id 31EEa7GI018928;
	Tue, 14 Feb 2023 23:36:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 31EEa7GI018928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1676385372;
	bh=nOpHJac8ywikPxuc/XBKvquhfFsHVxGwW78l5L9nB04=;
	h=From:To:Cc:Subject:Date:From;
	b=eZaUcaWaq+PZk/f5Lp9HqushBvzSj3dVipYvMD3yUVMAwF6yzzJjwYzQeQ27VHRiZ
	 48VEyxxVObribvDxYFzMATQbm2onvdOgD6uPC1h9RBYd04wjUQkc54l/hNFWmFWUdB
	 UWHgXRAyS+aqDL/ZdQ7DttnWBilHTAwCWix9V+GJ2jPrQXBt+4gLljLxf1BqiYKhf0
	 n2L+a4SOTTJ1csV3XY8+CUUTW2nJ/4fZ7fOpt5i6IPc0C48ze2WnKbitwzGU8P14Ut
	 e8Opeef0dIgI1n1x7dW5A16U60du2wo6X1dxCEYOr2x8wlITi2gnbKt2/Cpmb+/6y2
	 4RCIT1RfjxeOQ==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Fix SNDCTL_DSP_GET[IO]SPACE before read()/write().
Date: Tue, 14 Feb 2023 23:35:55 +0900
Message-Id: <20230214143555.42161-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Even with the commit 3a4c740f59c0, SNDCTL_DSP_GET[IO]SPACE ioctl()
does not return the fragment set by SNDCTL_DSP_SETFRAGMENT if it
is issued before read()/write(). This patch fixes the issue.

Fixes: 3a4c740f59c0 ("Cygwin: dsp: Implement SNDCTL_DSP_SETFRAGMENT ioctl().")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index dd1aac8e2..16db6bb29 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1369,11 +1369,17 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-        if (audio_out_) {
-            audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-        } else {
-            Audio_out::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
-        }
+	if (audio_out_)
+	  audio_out_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+	else if (fragment_has_been_set)
+	  {
+	    p->bytes = fragsize_ * fragstotal_;
+	    p->fragsize = fragsize_;
+	    p->fragstotal = fragstotal_;
+	    p->fragments = fragstotal_;
+	  }
+	else
+	  Audio_out::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
         debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
                       buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
@@ -1387,11 +1393,17 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	    return -1;
 	  }
 	audio_buf_info *p = (audio_buf_info *) buf;
-        if (audio_in_) {
-            audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
-        } else {
-            Audio_in::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
-        }
+	if (audio_in_)
+	  audio_in_->buf_info (p, audiofreq_, audiobits_, audiochannels_);
+	else if (fragment_has_been_set)
+	  {
+	    p->bytes = 0;
+	    p->fragsize = fragsize_;
+	    p->fragstotal = fragstotal_;
+	    p->fragments = 0;
+	  }
+	else
+	  Audio_in::default_buf_info(p, audiofreq_, audiobits_, audiochannels_);
         debug_printf ("buf=%p frags=%d fragsize=%d bytes=%d",
                       buf, p->fragments, p->fragsize, p->bytes);
 	return 0;
-- 
2.39.0

