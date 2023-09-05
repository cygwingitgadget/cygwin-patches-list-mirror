Return-Path: <SRS0=D3vE=EV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0003.nifty.com (mta-snd00012.nifty.com [106.153.226.44])
	by sourceware.org (Postfix) with ESMTPS id D9DC0385842C
	for <cygwin-patches@cygwin.com>; Tue,  5 Sep 2023 09:29:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D9DC0385842C
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0003.nifty.com with ESMTP
          id <20230905092858514.YOGH.106126.localhost.localdomain@nifty.com>;
          Tue, 5 Sep 2023 18:28:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/3] Cygwin: dps: Fix a bug that read() could not return -1 on error.
Date: Tue,  5 Sep 2023 18:28:41 +0900
Message-Id: <20230905092843.15849-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/fhandler/dsp.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 8e51a51c5..e872aa08c 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1192,7 +1192,9 @@ fhandler_dev_dsp::_read (void *ptr, size_t& len)
       return;
     }
 
-  audio_in_->read ((char *)ptr, (int&)len);
+  int res = len;
+  audio_in_->read ((char *)ptr, res);
+  len = (size_t)res;
 }
 
 void
-- 
2.39.0

