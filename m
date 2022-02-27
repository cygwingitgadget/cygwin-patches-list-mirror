Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 9AD9A3858D35
 for <cygwin-patches@cygwin.com>; Sun, 27 Feb 2022 03:48:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9AD9A3858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 21R3lwD6025908;
 Sun, 27 Feb 2022 12:48:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 21R3lwD6025908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645933690;
 bh=aqPcyP9z3gm39CjQh3rYU8YDcUQAZ+EivDhqvQrQB7I=;
 h=From:To:Cc:Subject:Date:From;
 b=utH1QN1+eQ5/JzEAybQ0jx24vBB6EMgl9TzirO3ExfZrs3CvxmjD/ux2Gj7aeUiS3
 USO9iDoEPr/uakBBIc/cHBj4qEKfUWg0ksYSJziFLbPjDz5L13EC+mmZ6XSPDeno/6
 W/Fv80gv4iyoRiG15rZQPJKOsVH2R/ef64F4XwkgXqWO77qwG2zsmqpuaBrPcLEmf2
 ulvdUO20U7Z1IAdx+FsDYLVY5kqNQ7LCGZTfo/3pH2X4UQt3VTjllExeQ5mSG3uZHi
 pMHJXMwLSod/n4f8wx9tuCdclfgicwmGUxhaCfYN1B1gHvcEV9Dw2FaQR8FIgVsBin
 veDljVSbI+azQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Correct the past fix for apps which open pty.
Date: Sun, 27 Feb 2022 12:47:58 +0900
Message-Id: <20220227034758.1266-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 27 Feb 2022 03:48:34 -0000

- The commit "Cygwin: console: Fix issues of apps which open pty."
  did not fix the second problem correctly. That commit looked to
  fix the issue, but the actual problem was that ctrl_c_handler()
  should be reregistered *AFTER* FreeConsole()/AttachConsole().
  This patch correct that.
---
 winsup/cygwin/fhandler_termios.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 568523390..767b28302 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -344,10 +344,10 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      (myself->dwProcessId, false);
 	  if (resume_pid && fh && !fh->is_console ())
 	    {
-	      if (::cygheap->ctty && ::cygheap->ctty->is_console ())
-		init_console_handler (false);
 	      FreeConsole ();
 	      AttachConsole (p->dwProcessId);
+	      if (::cygheap->ctty && ::cygheap->ctty->is_console ())
+		init_console_handler (true);
 	    }
 	  if (fh && p == myself && being_debugged ())
 	    { /* Avoid deadlock in gdb on console. */
-- 
2.35.1

