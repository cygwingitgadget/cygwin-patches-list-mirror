Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id E55843858C55
 for <cygwin-patches@cygwin.com>; Sun,  8 May 2022 13:11:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E55843858C55
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 248DBRI3014799;
 Sun, 8 May 2022 22:11:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 248DBRI3014799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652015495;
 bh=NUTdCXQxDZ3SMCFwet+WLvuqPOnkdPkcZZqTVk3Iaog=;
 h=From:To:Cc:Subject:Date:From;
 b=pVwLnllV0mY/maRQqxSK21/tPJm8oFPvB8FJhOcUy/nUo3vvAo+LpoBvA71e8G6cv
 5W3o/WX6XdYbW0Kt0hu+c4Ly67atNwHyB5cvW20feWyBZjzV/i4wG4j99DTFxX3kSs
 zxW05E7im1F7AIEaKpvWSGSWsqEyV4ONERSMbACqGfryx2pXhg3wiqdDSL3XJK4y2K
 uLYlaZptfliUpJsx1LO0zQZh49kZfSnRICMceiXW6unTPsQZmmWolgsaxUS41Xwak1
 vGdcqpZU9kRDQtVsrb08NxeQpyMHoenufKlmuAvEJJJAMVASVjVA8CWhA6onRGs4Ms
 GUX4DGbXm6YiA==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Change the condition to send Ctrl-C event.
Date: Sun,  8 May 2022 22:11:20 +0900
Message-Id: <20220508131120.2034-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
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
X-List-Received-Date: Sun, 08 May 2022 13:12:11 -0000

- Previously, non-cygwin app started by "script -c <non-cygwin app>"
  receives Ctrl-C twice. This patch fixes the issue.
---
 winsup/cygwin/fhandler_termios.cc | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 4eff5eab3..735423bf2 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -324,9 +324,6 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
   pid_t pgid = ttyp->pgid;
 
   /* The name *_nat stands for 'native' which means non-cygwin apps. */
-  pinfo leader (pgid);
-  bool cyg_leader = /* The process leader is a cygwin process. */
-    leader && !(leader->process_state & PID_NOTCYGWIN);
   bool ctrl_c_event_sent = false;
   bool need_discard_input = false;
   bool pg_with_nat = false; /* The process group has non-cygwin processes. */
@@ -373,9 +370,9 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	     instead. */
 	  if (p->process_state & PID_NEW_PG)
 	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, p->dwProcessId);
-	  else if ((!fh || fh->need_send_ctrl_c_event () || cyg_leader)
-		   && !ctrl_c_event_sent) /* cyg_leader is needed by GDB
-					     with non-cygwin inferior */
+	  else if ((!fh || fh->need_send_ctrl_c_event ()
+		    || p->exec_dwProcessId == p->dwProcessId)
+		   && !ctrl_c_event_sent)
 	    {
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
 	      ctrl_c_event_sent = true;
-- 
2.36.0

