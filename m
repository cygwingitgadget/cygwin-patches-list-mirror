Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 8E2FF3858C2C
 for <cygwin-patches@cygwin.com>; Thu,  3 Feb 2022 12:18:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8E2FF3858C2C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (v036249.dynamic.ppp.asahi-net.or.jp
 [124.155.36.249]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 213CIRXE021762;
 Thu, 3 Feb 2022 21:18:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 213CIRXE021762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1643890713;
 bh=ARC1s9mj763Fq+uvQMdG1D593o8YJ/hXHOH5F+8Te4A=;
 h=From:To:Cc:Subject:Date:From;
 b=p4uCcRxQfF3bQ+Uw6JHKScE28YS5/uvUUZ4ydsSiHZvpyqkatmZng8jiRZGgW/bqF
 gle1tq5uDU7ZxRuT1RJ9lv7buNnyY+pogPrfyBHXSqEbAHbyc+x2Z60aeecbO3c8OZ
 jNoUo8U5GHwe3a8EEgfjWV4RZrT/Vm6n2O9bfB7UzlYIIWeUfTrid6y7iVmNIFxUvL
 E+9kSc+C9UZlNj/n4mnK57YeXWNRFPntAo/wKHO9oFlkwlywNDId/n8o0lcbAhfBPt
 df1K4/LGfPPGfygG6YUknkaYivXVGeEoeAfnuWmDFpZJUzLbgzcRN6+KWbdiCUYcvK
 c5KE1u9sRdlxw==
X-Nifty-SrcIP: [124.155.36.249]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix IL/DL escape sequence on the last line.
Date: Thu,  3 Feb 2022 21:18:18 +0900
Message-Id: <20220203121818.530-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SOMETLD_ARE_BAD_TLD,
 PDS_OTHER_BAD_TLD, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 03 Feb 2022 12:18:53 -0000

- Currently, escape sequence IL/DL (CSI Ps L, CSI Ps M) does not
  work correctly at the last (bottom end) line. This patch fixes
  the issue.

Addresses:
  https://cygwin.com/pipermail/cygwin/2022-February/250736.html
---
 winsup/cygwin/fhandler_console.cc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 0e4b41559..fa5d7ce9c 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2174,6 +2174,12 @@ fhandler_console::char_command (char c)
 	      cursor_get (&x, &y);
 	      if (y < srTop || y > srBottom)
 		break;
+	      if (y == con.b.srWindow.Bottom)
+		{
+		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
+		  wpbuf.empty ();
+		  break;
+		}
 	      if (y == con.b.srWindow.Top
 		  && srBottom == con.b.srWindow.Bottom)
 		{
@@ -2213,6 +2219,12 @@ fhandler_console::char_command (char c)
 	      cursor_get (&x, &y);
 	      if (y < srTop || y > srBottom)
 		break;
+	      if (y == con.b.srWindow.Bottom)
+		{
+		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
+		  wpbuf.empty ();
+		  break;
+		}
 	      __small_swprintf (bufw, L"\033[%d;%dr",
 				y + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
-- 
2.34.1

