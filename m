Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 739053858C50
 for <cygwin-patches@cygwin.com>; Mon, 18 Apr 2022 11:51:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 739053858C50
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 23IBp9rT013485;
 Mon, 18 Apr 2022 20:51:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 23IBp9rT013485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1650282674;
 bh=JCsHPvjCxBa1vFzC+jiK4388s1pcyPeJQ4ya3Lpo3i8=;
 h=From:To:Cc:Subject:Date:From;
 b=RFZebCa3UV6XdVXFV7cyKPG/ipp00SaBOZ0Wm4mCPmVI9Iq8vj/F6EBwUFaF1cSTt
 fVDvfossL1MABWO0K9ktuCc53RYaP5Jw5DuviVfo9VA6ZNdrfCqbxZVQYm0Kb7DONd
 fXMBkKDEdr0Y8o+A5NBIb2WOVSrmX6qWYD+RB97F+SVqGqFUYf67p/3AH9KaPygMCZ
 p1CtX0KaHLuCmUfO11ALPA7c3N7NJYg6MZvx61MPvw3+Zzx7pzn3/4wPOR7U+081KU
 kNKgq5RkNYEdxTqJUymwtEcsgfhg3q9kBckx+99aAAC9axzpKkkAdVQFK9xyR64aM1
 zNtWXk7ffnWMA==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix Ctrl-C behaviour in latest GDB.
Date: Mon, 18 Apr 2022 20:51:00 +0900
Message-Id: <20220418115101.29199-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 18 Apr 2022 11:51:39 -0000

- In the latest GDB (11.2-1), Ctrl-C behaviour is broken a bit for
  non-cygwin inferior. For example, Ctrl-C on GDB prompt is not sent
  to GDB but to the inferior. This patch fixes the issue.
---
 winsup/cygwin/fhandler_termios.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 5cd44d7bf..4eff5eab3 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -350,7 +350,8 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 			 cygwin apps started from non-cygwin shell. */
       if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
 	  && ((p->process_state & PID_NOTCYGWIN)
-	      || (p->exec_dwProcessId == p->dwProcessId)
+	      || ((p->exec_dwProcessId == p->dwProcessId)
+		  && ttyp->pty_input_state_eq (tty::to_nat))
 	      || !(p->process_state & PID_CYGPARENT)))
 	{
 	  /* Ctrl-C event will be sent only to the processes attaching
@@ -406,6 +407,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	    with_debugger = true; /* inferior is cygwin app */
 	  if (!(p->process_state & PID_NOTCYGWIN)
 	      && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
+	      && ttyp->pty_input_state_eq (tty::to_nat)
 	      && p->pid == pgid)
 	    with_debugger_nat = true; /* inferior is non-cygwin app */
 	}
-- 
2.35.1

