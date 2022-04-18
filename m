Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id BCB943858D28
 for <cygwin-patches@cygwin.com>; Mon, 18 Apr 2022 11:49:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BCB943858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 23IBn29r020469;
 Mon, 18 Apr 2022 20:49:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 23IBn29r020469
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1650282549;
 bh=n231ttCPnMSUvRisx/xInA67R39i4bEwODiOdteeGX8=;
 h=From:To:Cc:Subject:Date:From;
 b=QxpMqoNAaLDxfPW//zBN4UPE/B8VVJOLAicPYs/QLC8KOx3YOesxzPAX2a552RXb+
 vYMpoLB7HU36IbyPhQtp28yY2tUKqAqKjAefWP4MiReA5XndJ6uI/Ld+IVyTpv0sys
 WVbHUB6kVaYSDGs+WJVndtp1F+2CG8dvTkY47TN2k1pjnr4wlzKzXOlSSG3Va518VV
 B6jn9hrCyXOROnsD/FzxJpMyh1CTKR0W0TFzJ7U74fd6NhYV+3AZTd6g/RBLawstWC
 ShzuZ3CfrdJkSW11RCirZABnaZSoDt/lkDN8afrK5Rq3cXzlVbib3H8XSLdbdzEPIG
 VpOppuZ3S2X8g==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Do not set internal handles in HPCON inheritable.
Date: Mon, 18 Apr 2022 20:48:53 +0900
Message-Id: <20220418114853.27705-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Mon, 18 Apr 2022 11:49:28 -0000

- The internal handles in HPCON should not be inheritable, however,
  the current code duplicates them as inheritable when handing over
  ownership of the pseudo console. This patch fixes the issue.

Addresses: https://cygwin.com/pipermail/cygwin/2022-April/251222.html
---
 winsup/cygwin/fhandler_tty.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c02dfb8ed..b03087ba5 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2056,7 +2056,7 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
     OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->nat_pipe_owner_pid);
   DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
 		   GetCurrentProcess (), &hpcon_local.hWritePipe,
-		   0, TRUE, DUPLICATE_SAME_ACCESS);
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
   acquire_attach_mutex (mutex_timeout);
   ResizePseudoConsole ((HPCON) &hpcon_local, size);
   release_attach_mutex ();
@@ -3551,15 +3551,15 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  DuplicateHandle (GetCurrentProcess (),
 			   ttyp->h_pcon_write_pipe,
 			   new_owner, &new_write_pipe,
-			   0, TRUE, DUPLICATE_SAME_ACCESS);
+			   0, FALSE, DUPLICATE_SAME_ACCESS);
 	  DuplicateHandle (GetCurrentProcess (),
 			   ttyp->h_pcon_condrv_reference,
 			   new_owner, &new_condrv_reference,
-			   0, TRUE, DUPLICATE_SAME_ACCESS);
+			   0, FALSE, DUPLICATE_SAME_ACCESS);
 	  DuplicateHandle (GetCurrentProcess (),
 			   ttyp->h_pcon_conhost_process,
 			   new_owner, &new_conhost_process,
-			   0, TRUE, DUPLICATE_SAME_ACCESS);
+			   0, FALSE, DUPLICATE_SAME_ACCESS);
 	  DuplicateHandle (GetCurrentProcess (), ttyp->h_pcon_in,
 			   new_owner, &new_pcon_in,
 			   0, TRUE, DUPLICATE_SAME_ACCESS);
-- 
2.35.1

