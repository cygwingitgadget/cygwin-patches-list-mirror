Return-Path: <SRS0=/Ih6=67=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
	by sourceware.org (Postfix) with ESMTPS id D471F3858D39
	for <cygwin-patches@cygwin.com>; Tue,  7 Mar 2023 02:33:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D471F3858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id 3272Woa0008406;
	Tue, 7 Mar 2023 11:32:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 3272Woa0008406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1678156375;
	bh=/eTP/TZ7yPc7RVc3BGkMInTFjoshVio2pbayUmLOWNw=;
	h=From:To:Cc:Subject:Date:From;
	b=TJD9u3OGYTg5oV8TtSrQE+OZnLDxLy4lERxsegtenUkwnPcwFTlFKOa4rQMikOrhO
	 VedkePEUMHIUu4FtL5JT8Ly913qoNiENG3YVagawP7uFzOAK0sBPV+avTIszy0DtRj
	 A4DGdvghWDm2d6bQ26/UghxcTnzdzbBHeXaX2lcbyVNtubXxncHEHbl+92ie0aLkgb
	 lNzULOWZ3unH0qFm9LYTBLad9AVixuH6RYSV8xwKLeFhva4lT5u5Ef4T0qIvg2nINA
	 ffGuw/Cferz2l8GH8ASHCfGwF5PB2EKWDFGkpWuApgrR9IWS8q/mgUj/T/SAwfGBgQ
	 jrwYWi3xGc7KQ==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Suppress unnecessary open_shared_console() calls.
Date: Tue,  7 Mar 2023 11:32:42 +0900
Message-Id: <20230307023242.1180-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 4a4cf1897..d4b09dc79 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -645,7 +645,7 @@ scan_console (HWND hw, LPARAM lp)
        {
 	 *p->shared_console_info = cs;
 	 CloseHandle (h);
-	 return TRUE;
+	 return FALSE;
        }
       UnmapViewOfFile ((void *) cs);
       CloseHandle (h);
-- 
2.39.0

