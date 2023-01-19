Return-Path: <SRS0=YyUz=5Q=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
	by sourceware.org (Postfix) with ESMTPS id 22D3D3858C52
	for <cygwin-patches@cygwin.com>; Thu, 19 Jan 2023 13:10:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 22D3D3858C52
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-09.nifty.com with ESMTP id 30JDAFnW014716;
	Thu, 19 Jan 2023 22:10:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 30JDAFnW014716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1674133819;
	bh=AM4pulie0abHy0O9T9RpliX2HZJkXIyGaUVUYRptsQo=;
	h=From:To:Cc:Subject:Date:From;
	b=cwA9Ln9NJGvO53k4EO4bPySDsIwn1U0KVQi7OXFMp/PvNyUHTuatXPuMRHdYI6g4j
	 VXRpPVdEAxrymk5JloDUfEYZIu4k5iNCX4XFIepM+2am4sU2Ku1b5STi36VBQ0wQ5l
	 a2RzaS0hOvTSiqAYYjh7gXoPR/AlGIdiK4gn3dp+n8TreTqXWBszdGwfUkQeFlK90/
	 1ocxnAh5aNfvOmOK35+BLE/GL7JpqSiQN06XXg6qRvCLQcP8214BWRKQjRzXeUaz72
	 bEq4K8LVboiSm+nCoiGVH7nn6UmP6MTL8r1sNepRy/HiLbn39++PI5gcRycbOUvlTC
	 YNm7G0r1d/ulA==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: dsp: Fix a problem that fcntl() does not take effect.
Date: Thu, 19 Jan 2023 22:10:05 +0900
Message-Id: <20230119131005.2012-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, fhandler_dev_dsp (OSS) has a problem that fcntl() does
not take effect at all. This patch fixes the issue.

Sighed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/dsp.cc           | 12 ++++++++++++
 winsup/cygwin/local_includes/fhandler.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/winsup/cygwin/fhandler/dsp.cc b/winsup/cygwin/fhandler/dsp.cc
index c37bedea5..8798cf876 100644
--- a/winsup/cygwin/fhandler/dsp.cc
+++ b/winsup/cygwin/fhandler/dsp.cc
@@ -1038,6 +1038,12 @@ fhandler_dev_dsp::ioctl (unsigned int cmd, void *buf)
   return base ()->_ioctl (cmd, buf);
 }
 
+int
+fhandler_dev_dsp::fcntl (int cmd, intptr_t arg)
+{
+  return base ()->_fcntl (cmd, arg);
+}
+
 void
 fhandler_dev_dsp::fixup_after_fork (HANDLE parent)
 {
@@ -1417,6 +1423,12 @@ fhandler_dev_dsp::_ioctl (unsigned int cmd, void *buf)
     }
 }
 
+int
+fhandler_dev_dsp::_fcntl (int cmd, intptr_t arg)
+{
+  return fhandler_base::fcntl(cmd, arg);
+}
+
 void
 fhandler_dev_dsp::_fixup_after_fork (HANDLE parent)
 { // called from new child process
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index bc02eae66..5fe979538 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2766,6 +2766,7 @@ class fhandler_dev_dsp: public fhandler_base
   ssize_t write (const void *, size_t);
   void read (void *, size_t&);
   int ioctl (unsigned int, void *);
+  int fcntl (int cmd, intptr_t);
   int close ();
   void fixup_after_fork (HANDLE);
   void fixup_after_exec ();
@@ -2774,6 +2775,7 @@ class fhandler_dev_dsp: public fhandler_base
   ssize_t _write (const void *, size_t);
   void _read (void *, size_t&);
   int _ioctl (unsigned int, void *);
+  int _fcntl (int cmd, intptr_t);
   void _fixup_after_fork (HANDLE);
   void _fixup_after_exec ();
 
-- 
2.39.0

