Return-Path: <SRS0=EsSo=5T=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
	by sourceware.org (Postfix) with ESMTPS id 5597C3858D32
	for <cygwin-patches@cygwin.com>; Sun, 22 Jan 2023 00:09:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5597C3858D32
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-12.nifty.com with ESMTP id 30M08tnb006156;
	Sun, 22 Jan 2023 09:09:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 30M08tnb006156
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1674346140;
	bh=UtZ2HvGC0Gyx+ZTl57AfT+3fQ3kmkkSgUhFqpOoEVKg=;
	h=From:To:Cc:Subject:Date:From;
	b=XBJP9cQ2HTqfZcEDgJytSWRcWBj1X2E66fgRSvGqtH/pM5lc8E0jgdbjFHeMxdA1Q
	 ixLsv7d7Xmk+shQc3AUlg/SQBOFPOb8ErM94flcw8U/D21g6o/aPUKr0GAkXzdxm5B
	 RwCLgpfuqCJgAW2Z75OOYsJaseIPjuA5cSeE1kxnAXNf54W8IPZGS5dIbXuX4kYaXd
	 hpIoHo5DLW37hiOMPi2MYPPyRr6HOAv00V+oDjHdsVO1DuvYCYxkKjetjibW+RuHJO
	 faz7O4s+9APoPAyn11ZL7JabAIzmlU9tFjugUFbelkn/DvCgSfLdLsvce2ofr3HeyF
	 kAmYBg7Y0ST8A==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>, Yano Ray <yanorei@hotmail.co.jp>,
        Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: fsync: Fix EINVAL for block device.
Date: Sun, 22 Jan 2023 09:08:46 +0900
Message-Id: <20230122000846.54372-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit af8a7c13b516 has a problem that fsync returns EINVAL for
block device. This patch treats block devices as a special case.
https://cygwin.com/pipermail/cygwin/2023-January/252916.html

Fixes: af8a7c13b516 ("Cygwin: fsync: Return EINVAL for special files.")
Reported-by: Yano Ray <yanorei@hotmail.co.jp>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/base.cc | 3 ++-
 winsup/cygwin/release/3.4.6    | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 winsup/cygwin/release/3.4.6

diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
index b2738cf20..9b49ec7b9 100644
--- a/winsup/cygwin/fhandler/base.cc
+++ b/winsup/cygwin/fhandler/base.cc
@@ -1728,7 +1728,8 @@ fhandler_base::utimens (const struct timespec *tvp)
 int
 fhandler_base::fsync ()
 {
-  if (!get_handle () || nohandle () || pc.isspecial ())
+  if (!get_handle () || nohandle ()
+      || (pc.isspecial () && !S_ISBLK (pc.dev.mode ())))
     {
       set_errno (EINVAL);
       return -1;
diff --git a/winsup/cygwin/release/3.4.6 b/winsup/cygwin/release/3.4.6
new file mode 100644
index 000000000..c1476ff46
--- /dev/null
+++ b/winsup/cygwin/release/3.4.6
@@ -0,0 +1,5 @@
+Bug Fixes
+---------
+
+Fix a problem that fsync returns EINVAL for block device.
+Addresses: https://cygwin.com/pipermail/cygwin/2023-January/252916.html
-- 
2.39.0

