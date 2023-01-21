Return-Path: <SRS0=6xLJ=5S=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
	by sourceware.org (Postfix) with ESMTPS id 0ED193858D33
	for <cygwin-patches@cygwin.com>; Sat, 21 Jan 2023 12:44:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0ED193858D33
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-08.nifty.com with ESMTP id 30LCiE9S015572;
	Sat, 21 Jan 2023 21:44:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 30LCiE9S015572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1674305059;
	bh=8l+ndZJ7CeqhoQ5fGJAN9038540QLM1Ov9177EW/W8o=;
	h=From:To:Cc:Subject:Date:From;
	b=X7yZY/+NZN6uD4nYV3S9kNDWqQjKfwPVLVssvhEEG5kco5YU9/2Ap2ngEAHNMuklR
	 AKhiXPu7FhdHbUIbsxcx4FPCnT5fPpINY45z/g/pKLgWzupgguY2x9lM7wOWK3sE/W
	 7F5PTJP+I444+bYFRWEtNcHy+krBalU5p1WI5p630mjM9kxbXe5Wrgeyv+WNO7neO2
	 SuHWtvVFh8WvJEfC8JEcAdt5onj8A+BjZlWh1eSmYbzh5iNxxtwffF1QFNyEzzejqc
	 gBfqkIt5FSpEk90SPvEbrcHxGqFECX4zu6RMRBZgzSyI1/whEquDlsGmx2dESMynP1
	 OCLXeuiYBzquw==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: fsync: Fix EINVAL for block device.
Date: Sat, 21 Jan 2023 21:44:03 +0900
Message-Id: <20230121124403.1847-1-takashi.yano@nifty.ne.jp>
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
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/base.cc | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
index b2738cf20..fc0410522 100644
--- a/winsup/cygwin/fhandler/base.cc
+++ b/winsup/cygwin/fhandler/base.cc
@@ -1725,10 +1725,31 @@ fhandler_base::utimens (const struct timespec *tvp)
   return -1;
 }
 
+static bool
+is_block_device (_major_t major)
+{
+  switch (major)
+    {
+    case DEV_FLOPPY_MAJOR:
+    case DEV_SD_MAJOR:
+    case DEV_CDROM_MAJOR:
+    case DEV_SD1_MAJOR:
+    case DEV_SD2_MAJOR:
+    case DEV_SD3_MAJOR:
+    case DEV_SD4_MAJOR:
+    case DEV_SD5_MAJOR:
+    case DEV_SD6_MAJOR:
+    case DEV_SD7_MAJOR:
+      return true;
+    }
+  return false;
+}
+
 int
 fhandler_base::fsync ()
 {
-  if (!get_handle () || nohandle () || pc.isspecial ())
+  if (!get_handle () || nohandle ()
+      || (pc.isspecial () && !is_block_device (get_major ())))
     {
       set_errno (EINVAL);
       return -1;
-- 
2.39.0

