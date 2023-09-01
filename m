Return-Path: <SRS0=48SA=ER=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1010.nifty.com (mta-snd01010.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 637933858D20
	for <cygwin-patches@cygwin.com>; Fri,  1 Sep 2023 10:04:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 637933858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1010.nifty.com with ESMTP
          id <20230901100415109.HZAN.19104.localhost.localdomain@nifty.com>;
          Fri, 1 Sep 2023 19:04:15 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Takashi Yano <takashi.yanao@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Fix a few trivial bugs.
Date: Fri,  1 Sep 2023 19:03:59 +0900
Message-Id: <20230901100359.58550-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Takashi Yano <takashi.yanao@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc           | 4 ++--
 winsup/cygwin/local_includes/fhandler.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 27f0a50ce..8e51a51c5 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1060,7 +1060,7 @@ fhandler_dev_dsp::fixup_after_exec ()
 int
 fhandler_dev_dsp::open (int flags, mode_t)
 {
-  int ret = 0, err = 0;
+  int ret = -1, err = 0;
   UINT num_in = 0, num_out = 0;
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   // Work out initial sample format & frequency, /dev/dsp defaults
@@ -1095,7 +1095,7 @@ fhandler_dev_dsp::open (int flags, mode_t)
 
   debug_printf ("ACCMODE=%y audio_in=%d audio_out=%d, err=%d, ret=%d",
 		flags & O_ACCMODE, num_in, num_out, err, ret);
-  if (ret)
+  if (ret >= 0)
     being_closed = false;
   return ret;
 }
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 9af5f716c..098b8dd19 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2817,6 +2817,8 @@ class fhandler_dev_dsp: public fhandler_base
 
   void close_audio_in ();
   void close_audio_out (bool = false);
+
+ public:
   bool use_archetype () const {return true;}
 
   fhandler_dev_dsp (void *) {}
-- 
2.39.0

