Return-Path: <SRS0=jPxW=FB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1012.nifty.com (mta-snd01006.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id C9EEB3858D32
	for <cygwin-patches@cygwin.com>; Sun, 17 Sep 2023 13:08:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C9EEB3858D32
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1012.nifty.com with ESMTP
          id <20230917130809553.GKXS.65725.localhost.localdomain@nifty.com>;
          Sun, 17 Sep 2023 22:08:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Fix a bug that app hangs if it killed during write().
Date: Sun, 17 Sep 2023 22:07:55 +0900
Message-Id: <20230917130755.9311-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If app is killed during blocking write(), it sometimes hangs. This
patch fixes the issue.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 5f78821d4..03c812a9c 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -590,7 +590,8 @@ fhandler_dev_dsp::Audio_out::waitforallsent ()
   while (Qisr2app_->query () != fh->fragstotal_)
     {
       debug_printf ("%d blocks in Qisr2app", Qisr2app_->query ());
-      Sleep (100);
+      cygwait (1);
+      sendcurrent ();
     }
 }
 
-- 
2.39.0

