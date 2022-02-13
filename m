Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 167B4385841C
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 167B4385841C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvH000575;
 Sun, 13 Feb 2022 23:39:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvH000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763187;
 bh=Iyk6mnGyvDSR8OfmoQrTIF7AippjeJXxXYC5dKhtelo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M06/B3CbzubPJLBzUvLz4RiYjii2M1M8XqtvIZ1XW8AXc56VJD04HzSYYpDDs0kxP
 r4IdAa4ZfDc4xXeXIgLr/vVIvIVbwoCkDpGp+RInnhOK02XAheWPR71UibZS7XA2Ku
 LL7WCaaifxfFZyoCMBNWX+VDSU1K7mcEaahWswLC1wP4ZKar8o3elN9wzs6D89WA9j
 SDNvwIQyg4A0e4Bb4BEEqN6Ln2h1SjVopEc/hpFEvJmNnBgE25UE+pQQhoYCN+riZz
 TkpCEgGvC/LmpxomJH4mNCVmOamrWZUKQ8rlpJIZNNKhaGkNyEmM3Wg2uSNKHT8kF1
 7baiAwWvnRRvw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/8] Cygwin: pty: Pass Ctrl-Z (EOF) to non-cygwin apps with
 disable_pcon.
Date: Sun, 13 Feb 2022 23:39:04 +0900
Message-Id: <20220213143910.1947-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 13 Feb 2022 14:40:16 -0000

- Previously, non-cygwin app running in pty started without pseudo
  console support was suspended by Ctrl-Z rather than sending EOF.
  Even worse, suspended app could not be resumed by fg command. With
  this patch, Ctrl-Z (EOF for non-cygwin apps) is passed to non-cygwin
  app instead of suspending that app. This patch also handles Ctrl-\
  (QUIT) and Ctrl-D (EOF) as well.
---
 winsup/cygwin/fhandler_termios.cc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index fe1021520..b935a70bc 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -329,6 +329,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
       if (ti.c_iflag & ISTRIP)
 	c &= 0x7f;
       winpids pids ((DWORD) 0);
+      bool need_check_sigs = get_ttyp ()->pcon_input_state_eq (tty::to_cyg);
       if (get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 	{
 	  bool need_discard_input = false;
@@ -349,11 +350,15 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 		    GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
 		  need_discard_input = true;
 		}
+	      if (p->ctty == get_ttyp ()->ntty
+		  && p->pgid == get_ttyp ()->getpgid () && !p->cygstarted)
+		need_check_sigs = true;
 	    }
-	  if (need_discard_input
-	      && !CCEQ (ti.c_cc[VINTR], c)
+	  if (!CCEQ (ti.c_cc[VINTR], c)
 	      && !CCEQ (ti.c_cc[VQUIT], c)
 	      && !CCEQ (ti.c_cc[VSUSP], c))
+	    need_check_sigs = false;
+	  if (need_discard_input && !need_check_sigs)
 	    {
 	      if (!(ti.c_lflag & NOFLSH))
 		{
@@ -364,7 +369,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	      continue;
 	    }
 	}
-      if (ti.c_lflag & ISIG)
+      if ((ti.c_lflag & ISIG) && need_check_sigs)
 	{
 	  int sig;
 	  if (CCEQ (ti.c_cc[VINTR], c))
@@ -469,7 +474,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	    }
 	  continue;
 	}
-      else if (CCEQ (ti.c_cc[VEOF], c))
+      else if (CCEQ (ti.c_cc[VEOF], c) && need_check_sigs)
 	{
 	  termios_printf ("EOF");
 	  accept_input ();
-- 
2.35.1

