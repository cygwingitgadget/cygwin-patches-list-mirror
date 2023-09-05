Return-Path: <SRS0=D3vE=EV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0003.nifty.com (mta-snd00005.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 94853385840A
	for <cygwin-patches@cygwin.com>; Tue,  5 Sep 2023 09:29:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 94853385840A
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0003.nifty.com with ESMTP
          id <20230905092912646.YOGQ.106126.localhost.localdomain@nifty.com>;
          Tue, 5 Sep 2023 18:29:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/3] Cygwin: dsp: Fix trivial editorial issue.
Date: Tue,  5 Sep 2023 18:28:43 +0900
Message-Id: <20230905092843.15849-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230905092843.15849-1-takashi.yano@nifty.ne.jp>
References: <20230905092843.15849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/fhandler/dsp.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 00f2bab69..861443352 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1029,7 +1029,7 @@ fhandler_dev_dsp::write (const void *ptr, size_t len)
 void
 fhandler_dev_dsp::read (void *ptr, size_t& len)
 {
-  return base ()->_read (ptr, len);
+  base ()->_read (ptr, len);
 }
 
 int
-- 
2.39.0

