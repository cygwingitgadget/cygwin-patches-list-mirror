Return-Path: <SRS0=jpFv=5W=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
	by sourceware.org (Postfix) with ESMTPS id C7BCC3858D28
	for <cygwin-patches@cygwin.com>; Wed, 25 Jan 2023 10:56:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7BCC3858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-10.nifty.com with ESMTP id 30PAuVnE003412;
	Wed, 25 Jan 2023 19:56:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 30PAuVnE003412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1674644196;
	bh=PyBlQw0zSWaxuYtLYyQ0tvCqZijPD79Lxiw/cEj5PVs=;
	h=From:To:Cc:Subject:Date:From;
	b=TR6yHm238LQzyV6PO11slB4xiAna6gAZetg0N0epyeQAviv6JYV/FFVC71L0Wv9HA
	 9JoLwooOw4+6esSeR1jUV9xtQbmTt1azmv3eTRP5IaXm44eap5uCmFvrx5KFTCv8DO
	 I8QGClNzxvLROjY3k5S6mKiVT3U1TOG72HGuZnpUCViwdtVcpRdZ0hS7+k9aNbTS6o
	 qAcKRLV2E7a5Mqh71MOHhlOyfDcYSSm6WDrqE4XA10LSZw4d7rL2cYnne66PicMZA3
	 4DWVgA0rGtA7bScY0VH1UojDJAhgAKVoqbyIrvODchvHVH6SQUs7tz6YXDE/3Lnquz
	 brKIF+fVoKDww==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Fix hang on close() if another thread calls write().
Date: Wed, 25 Jan 2023 19:56:22 +0900
Message-Id: <20230125105622.473-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

fhandler_dev_dsp (OSS) has a problem that waitforallsent(), which is
called from close(), falls into infinite loop if another thread calls
write() accidentally after close(). This patch fixes the issue.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc           | 9 +++++++++
 winsup/cygwin/local_includes/fhandler.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index 8798cf876..cfbf6bec7 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1093,6 +1093,8 @@ fhandler_dev_dsp::open (int flags, mode_t)
 
   debug_printf ("ACCMODE=%y audio_in=%d audio_out=%d, err=%d, ret=%d",
 		flags & O_ACCMODE, num_in, num_out, err, ret);
+  if (ret)
+    being_closed = false;
   return ret;
 }
 
@@ -1106,6 +1108,12 @@ fhandler_dev_dsp::_write (const void *ptr, size_t len)
   int len_s = len;
   const char *ptr_s = static_cast <const char *> (ptr);
 
+  if (being_closed)
+    {
+      set_errno (EBADF);
+      return -1;
+    }
+
   if (audio_out_)
     /* nothing to do */;
   else if (IS_WRITE ())
@@ -1207,6 +1215,7 @@ int
 fhandler_dev_dsp::close ()
 {
   debug_printf ("audio_in=%p audio_out=%p", audio_in_, audio_out_);
+  being_closed = true;
   close_audio_in ();
   close_audio_out ();
   return fhandler_base::close ();
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 5fe979538..e7315ae16 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2758,6 +2758,7 @@ class fhandler_dev_dsp: public fhandler_base
   int audiochannels_;
   Audio_out *audio_out_;
   Audio_in  *audio_in_;
+  bool being_closed;
  public:
   fhandler_dev_dsp ();
   fhandler_dev_dsp *base () const {return (fhandler_dev_dsp *)archetype;}
-- 
2.39.0

