Return-Path: <SRS0=2kpu=KH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0018.nifty.com (mta-snd00009.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id C389C3858D39
	for <cygwin-patches@cygwin.com>; Fri,  1 Mar 2024 10:54:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C389C3858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C389C3858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709290469; cv=none;
	b=k8hnz3qb1R9ZlCvtTO8HdCpQ1LKT4irxMe2DPfnHyGz6MWCtQ2JaeEtu4c62PZ7BcpfVrDZ1g6+YFmYZNN3kPn1LsC2Rkc56FVL//JTjVQH7TDvlZgiUYn+f6CZWY81FFH2Bb9EtkJ63UZ9FoYy+rTAF4JPpiHy226BDwevSjtg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709290469; c=relaxed/simple;
	bh=lVBV/uf54Ump/uK5M3A9L5wquUHa10fUVepPNRW7DRs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R6TIyAEN6EzW4jmv8UV9jcCckl80W05cwQ/cHZlcIH2AG5jhT8ZbL3ItkxX2uV+AHkI5y+iwWANOjxVbEGTXAr9JeMQW46ov4/+btTGpfhkVb7An9hQR19ekgyVtUlgGnF1APju6+QmtQgBklT0qU5O+yiV45dggV6dmmeZJbpQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0018.nifty.com with ESMTP
          id <20240301105424662.YUYM.73653.localhost.localdomain@nifty.com>;
          Fri, 1 Mar 2024 19:54:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Kate Deplaix <kit-ty-kate@outlook.com>
Subject: [PATCH] Cygwin: console: Do not unmap shared console memory belonging to ctty.
Date: Fri,  1 Mar 2024 19:53:51 +0900
Message-ID: <20240301105403.8917-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the condition that console setup for CTTY and close run at the
sametime, accessing shared console memory which is already unmapped
may occur. With this patch, to avoid this race issue, shared console
memory which belongs to contorolling terminal (CTTY) is kept mapped
as before.
Addresses: https://cygwin.com/pipermail/cygwin/2024-February/255561.html

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Reported-by: Kate Deplaix <kit-ty-kate@outlook.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index c16ca3962..67ea95466 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1926,9 +1926,11 @@ fhandler_console::close ()
 	  || get_device () == (dev_t) myself->ctty))
     free_console ();
 
-  if (shared_console_info[unit])
-    UnmapViewOfFile ((void *) shared_console_info[unit]);
-  shared_console_info[unit] = NULL;
+  if (shared_console_info[unit] && myself->ctty != tc ()->ntty)
+    {
+      UnmapViewOfFile ((void *) shared_console_info[unit]);
+      shared_console_info[unit] = NULL;
+    }
 
   return 0;
 }
-- 
2.43.0

