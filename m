Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id E0F5A395CCBB
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 10:32:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E0F5A395CCBB
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 13JAVqDM011657;
 Mon, 19 Apr 2021 19:31:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 13JAVqDM011657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618828317;
 bh=Av19bWVb3uPlWiNxVqKSS7kWbgzlq3EhdCrG9sNY5aA=;
 h=From:To:Cc:Subject:Date:From;
 b=je7KLeAmVtNFU4uHpj2cLPVhKyASo2qoc+UNipz7hGpVHFOWtvCouX+6MT/qQd7hh
 YUjaHm4dWfOIz7rkbSE6MQIekLO8TqedOX/PVuUHZksbuIctv4m+TdE2eQUZWI08HF
 nymPmQLSW46blaqc+ZpWPt13an6qmaZqKgywqFmstrQwC14OzAfiY0XnLvqlwsFJWz
 +YaamhfLkV7rcO+dWVpXlwOdfaUWDsvWTL0/9n52zmUrmq1RBxrpNakG2nqazik6dS
 ePyPWhqZx/l0dV5b3qAorqiu8gNh40qLyQGlTFp/S1mATsrr/EtLWyaFXrGeWVEned
 SbPPEXwjHhqYw==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix a bug in the code to fix tab position.
Date: Mon, 19 Apr 2021 19:31:51 +0900
Message-Id: <20210419103151.21887-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 19 Apr 2021 10:32:19 -0000

- With this patch, a bug in the code to fix tab position after
  resizing window is fixed.
---
 winsup/cygwin/fhandler_console.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 43e404ed6..0812e91f0 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -308,7 +308,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		      /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
 			 fixes the tab position. */
 		      set_output_mode (tty::restore, &ti, p);
-		      set_input_mode (tty::cygwin, &ti, p);
+		      set_output_mode (tty::cygwin, &ti, p);
 		    }
 		  ttyp->kill_pgrp (SIGWINCH);
 		}
-- 
2.31.1

