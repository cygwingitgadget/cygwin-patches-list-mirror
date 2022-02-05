Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id AD0723858D28
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 08:01:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AD0723858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 21580ic9012415;
 Sat, 5 Feb 2022 17:00:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 21580ic9012415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644048049;
 bh=84atUx5/7PA1OQJv8NEEyGbVsN9e61znHTQzoWaWa1E=;
 h=From:To:Cc:Subject:Date:From;
 b=wUS4Tkf1HhWRGIaYkGMqvXfE8m8Hriaad51gLTZ7h/zjqA6EgJde01jCohBvGZkLC
 8TNOHzutHbGzHazubQgNKEvfoQtXdIVdzgPoL6pIWEb6P779UrRHffUKJ76Lfsyo6u
 /OZ7KYwr2Mq6dZJlmIrTT/tctaVxiVz98o0U5kT1OGi4h3FY0oPBlmjqCw4JzfVhzM
 PmVi6fwHZNtVU8Y0veU2kadQV/AeGH3+eXHMxf0w27/I2Q/SnKWRYNDjIVLxJrBR0O
 ZLbjEGkyyBlV8HJX8D4ceNE8ZspWj5h7gm3dPN/rcFdwfqr1ezhWIBHlYr3Smi5Jt5
 5VV4jRJpyt21g==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Remove unnecessary (redundant) code.
Date: Sat,  5 Feb 2022 17:00:34 +0900
Message-Id: <20220205080034.899-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SOMETLD_ARE_BAD_TLD,
 PDS_OTHER_BAD_TLD, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Sat, 05 Feb 2022 08:01:14 -0000

---
 winsup/cygwin/fhandler_console.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index fa5d7ce9c..7a1a45bc1 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2177,7 +2177,6 @@ fhandler_console::char_command (char c)
 	      if (y == con.b.srWindow.Bottom)
 		{
 		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
-		  wpbuf.empty ();
 		  break;
 		}
 	      if (y == con.b.srWindow.Top
@@ -2222,7 +2221,6 @@ fhandler_console::char_command (char c)
 	      if (y == con.b.srWindow.Bottom)
 		{
 		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
-		  wpbuf.empty ();
 		  break;
 		}
 	      __small_swprintf (bufw, L"\033[%d;%dr",
-- 
2.35.1

