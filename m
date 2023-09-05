Return-Path: <SRS0=D3vE=EV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0003.nifty.com (mta-snd00008.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id C47D23857701
	for <cygwin-patches@cygwin.com>; Tue,  5 Sep 2023 09:29:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C47D23857701
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0003.nifty.com with ESMTP
          id <20230905092906749.YOGO.106126.localhost.localdomain@nifty.com>;
          Tue, 5 Sep 2023 18:29:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/3] Cygwin: dsp: Reduce wait time for blocking read().
Date: Tue,  5 Sep 2023 18:28:42 +0900
Message-Id: <20230905092843.15849-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230905092843.15849-1-takashi.yano@nifty.ne.jp>
References: <20230905092843.15849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previous wait time of 100msec is too long if application specifies
smaller buffer. With this patch, the wait time is reduced to 1msec.
---
 winsup/cygwin/fhandler/dsp.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index e872aa08c..00f2bab69 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -931,8 +931,8 @@ fhandler_dev_dsp::Audio_in::waitfordata ()
 	  set_errno (EAGAIN);
 	  return false;
 	}
-      debug_printf ("100ms");
-      switch (cygwait (100))
+      debug_printf ("1ms");
+      switch (cygwait (1))
 	{
 	case WAIT_SIGNALED:
 	  if (!_my_tls.call_signal_handler ())
-- 
2.39.0

