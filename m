Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id B320C3858419
 for <cygwin-patches@cygwin.com>; Sun, 12 Dec 2021 13:05:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B320C3858419
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1BCD59Ue022149;
 Sun, 12 Dec 2021 22:05:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BCD59Ue022149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639314317;
 bh=JtYXt31PUsKv8W2pIgQFkKGlvxhz+OGevRoiTpSv2AQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ip+uUOV9QyF6gHSW0ewimdlClL+FlZWAtDgTkIHvNO2f4Ur1OcPcsZO/AR+wRiZDm
 xB5ukBwhPLVi2j66vnmZXoKxw/4Ua+bbWuK+ki47h2SAhpdU9tzfWH6D5mjp2ghrG9
 uEUUsy3Y8+RkwxXzPgTGuFuTtWoLc1wRXYPc5zRnuIX54RDa5eDyf4AAK69V8uwhIE
 G8SbF3Iwn/cdOAYTfasmPHAU0ah9UAa2WdJdK1ptYIrs3zFIK4p3PndXTB+sgmGGMr
 x2bYoYr6d5A0I9PaLuSuzk2YhN/CfeSqN2X+PiHO5OrN5aFsXRtUVRsW0d48nKcaby
 0XvhyVRvaVOSA==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] Cygwin: pty: Fix Ctrl-C handling for non-cygwin apps in
 background.
Date: Sun, 12 Dec 2021 22:04:59 +0900
Message-Id: <20211212130501.10091-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212130501.10091-1-takashi.yano@nifty.ne.jp>
References: <20211212130501.10091-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 12 Dec 2021 13:05:41 -0000

- With pseudo console enabled, if the non-cygwin app is started in
  the background and put it into the foreground, the process cannot
  be stopped by Ctrl-C. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index dae00efd7..904398179 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2249,9 +2249,12 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 			  &mbp);
 	}
 
-      if ((ti.c_lflag & ISIG) && !(ti.c_lflag & NOFLSH)
-	  && memchr (buf, '\003', nlen))
-	get_ttyp ()->discard_input = true;
+      if ((ti.c_lflag & ISIG) && memchr (buf, '\003', nlen))
+	{
+	  get_ttyp ()->kill_pgrp (SIGINT);
+	  if (!(ti.c_lflag & NOFLSH))
+	    get_ttyp ()->discard_input = true;
+	}
       DWORD n;
       WriteFile (to_slave_nat, buf, nlen, &n, NULL);
       ReleaseMutex (input_mutex);
-- 
2.34.1

