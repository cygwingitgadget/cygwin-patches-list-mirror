Return-Path: <SRS0=Wqcg=EA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1009.nifty.com (mta-snd01009.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id D8E873858002
	for <cygwin-patches@cygwin.com>; Tue, 15 Aug 2023 23:38:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D8E873858002
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1009.nifty.com with ESMTP
          id <20230815233802780.DHVD.19111.localhost.localdomain@nifty.com>;
          Wed, 16 Aug 2023 08:38:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: shared: Fix access permissions setting in open_shared().
Date: Wed, 16 Aug 2023 08:37:46 +0900
Message-Id: <20230815233746.1424-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit 93508e5bb841, the access permissions argument passed
to open_shared() is ignored and always replaced with (FILE_MAP_READ |
FILE_MAP_WRITE). This causes the weird behaviour that sshd service
process loses its cygwin PID. This triggers the failure in pty that
transfer_input() does not work properly.

This patch resumes the access permission settings to fix that.

Fixes: 93508e5bb841 ("Cygwin: open_shared: don't reuse shared_locations parameter as output")
Signedd-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/mm/shared.cc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/mm/shared.cc b/winsup/cygwin/mm/shared.cc
index 40cdd4722..7977df382 100644
--- a/winsup/cygwin/mm/shared.cc
+++ b/winsup/cygwin/mm/shared.cc
@@ -139,8 +139,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
       if (name)
 	mapname = shared_name (map_buf, name, n);
       if (m == SH_JUSTOPEN)
-	shared_h = OpenFileMappingW (FILE_MAP_READ | FILE_MAP_WRITE, FALSE,
-				     mapname);
+	shared_h = OpenFileMappingW (access, FALSE, mapname);
       else
 	{
 	  created = true;
@@ -165,8 +164,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
   do
     {
       addr = (void *) next_address;
-      shared = MapViewOfFileEx (shared_h, FILE_MAP_READ | FILE_MAP_WRITE,
-				0, 0, 0, addr);
+      shared = MapViewOfFileEx (shared_h, access, 0, 0, 0, addr);
       next_address += wincap.allocation_granularity ();
       if (next_address >= SHARED_REGIONS_ADDRESS_HIGH)
 	{
-- 
2.39.0

