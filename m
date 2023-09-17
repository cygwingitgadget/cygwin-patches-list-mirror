Return-Path: <SRS0=jPxW=FB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0010.nifty.com (mta-snd00009.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id A7ABE3858425
	for <cygwin-patches@cygwin.com>; Sun, 17 Sep 2023 13:09:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A7ABE3858425
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0010.nifty.com with ESMTP
          id <20230917130918757.GPPR.108497.localhost.localdomain@nifty.com>;
          Sun, 17 Sep 2023 22:09:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Avoid setting buffer that is too small.
Date: Sun, 17 Sep 2023 22:09:04 +0900
Message-Id: <20230917130904.9407-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The buffer size that is too small causes choppy sound. That is not
practical at all. With this patch, the minimum value of the buffer
size (i.e. fragstotal * fragsize) is restricted to 16384 bytes.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 7459ddc25..6140ef0c2 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1434,6 +1434,8 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
 	int *p = (int *) buf;
 	fragstotal_ = min (*p >> 16, MAX_BLOCKS);
 	fragsize_ = 1 << (*p & 0xffff);
+	while (fragsize_ * fragstotal_ < 16384)
+	  fragsize_ *= 2;
 	fragment_has_been_set = true;
 	return 0;
       }
-- 
2.39.0

