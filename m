Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id DF0953858D1E
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DF0953858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvF000575;
 Sun, 13 Feb 2022 23:39:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvF000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763183;
 bh=9wSOj+xHY2aFGJXwG55DWR+p72lFpiQeS3Pl6UbOX8U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bh7TpUt2U95yOZhHo9pBgQWHIS6G0BRY8FJHzJW7H0hnczVUL0MoLYpShoyX/1sbk
 jknrMaTffMTzohonEjpJsERYu8F43m6Dns2myksRUif8sEXRkNJELNToBUg9huhlJe
 4fJ/prelkikr22qiNi8bsexHJBQu6h8k4Plr4lWK0o3C75ItvIDim3SSmoO7id7OlZ
 krGYGExWDNPqIrgv9NPkeEJxJAFQZ/js8BFUDMwDHlFUlI+DuauWDTyjd1DF14EIp2
 CPOjB2V4bxxEpqxDxf3OCqXpL02ZzYr4bPglFAGuc5SmYG+OWbQfbyb7xfXSAtvm2h
 cXQVdaeM1nj9w==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/8] Cygwin: pty,
 console: Fix Ctrl-C handling for non-cygwin apps.
Date: Sun, 13 Feb 2022 23:39:03 +0900
Message-Id: <20220213143910.1947-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 13 Feb 2022 14:40:15 -0000

- Currently, if cat is started from cmd.exe which is started in cygwin
  console, Ctrl-C terminates not only cat but also cmd.exe. This also
  happens in pty in which pseudo console is disabled. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_console.cc | 28 +++++++++++++++++++++++
 winsup/cygwin/fhandler_termios.cc | 38 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b28dd66f5..da65c465e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -238,6 +238,33 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  char c = (char) wc;
 	  bool processed = false;
 	  termios &ti = ttyp->ti;
+	  pinfo pi (ttyp->getpgid ());
+	  if (pi && pi->ctty == ttyp->ntty
+	      && (pi->process_state & PID_NOTCYGWIN)
+	      && input_rec[i].EventType == KEY_EVENT && c == '\003')
+	    {
+	      bool not_a_sig = false;
+	      if (!CCEQ (ti.c_cc[VINTR], c)
+		  && !CCEQ (ti.c_cc[VQUIT], c)
+		  && !CCEQ (ti.c_cc[VSUSP], c))
+		not_a_sig = true;
+	      if (input_rec[i].Event.KeyEvent.bKeyDown)
+		{
+		  /* CTRL_C_EVENT does not work for the process started with
+		     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
+		     instead. */
+		  if (pi->process_state & PID_NEW_PG)
+		    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
+					      pi->dwProcessId);
+		  else
+		    GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
+		  if (not_a_sig)
+		    goto skip_writeback;
+		}
+	      processed = true;
+	      if (not_a_sig)
+		goto remove_record;
+	    }
 	  switch (input_rec[i].EventType)
 	    {
 	    case KEY_EVENT:
@@ -310,6 +337,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	      processed = true;
 	      break;
 	    }
+remove_record:
 	  if (processed)
 	    { /* Remove corresponding record. */
 	      memmove (input_rec + i, input_rec + i + 1,
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 3461d1785..fe1021520 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -147,6 +147,8 @@ tty_min::kill_pgrp (int sig)
       _pinfo *p = pids[i];
       if (!p || !p->exists () || p->ctty != ntty || p->pgid != pgid)
 	continue;
+      if (p->process_state & PID_NOTCYGWIN)
+	continue;
       if (p == myself)
 	killself = sig != __SIGSETPGRP && !exit_state;
       else
@@ -326,6 +328,42 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 
       if (ti.c_iflag & ISTRIP)
 	c &= 0x7f;
+      winpids pids ((DWORD) 0);
+      if (get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+	{
+	  bool need_discard_input = false;
+	  for (unsigned i = 0; i < pids.npids; i++)
+	    {
+	      _pinfo *p = pids[i];
+	      if (c == '\003' && p && p->ctty == tc ()->ntty
+		  && p->pgid == tc ()->getpgid ()
+		  && (p->process_state & PID_NOTCYGWIN))
+		{
+		  /* CTRL_C_EVENT does not work for the process started with
+		     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
+		     instead. */
+		  if (p->process_state & PID_NEW_PG)
+		    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
+					      p->dwProcessId);
+		  else
+		    GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
+		  need_discard_input = true;
+		}
+	    }
+	  if (need_discard_input
+	      && !CCEQ (ti.c_cc[VINTR], c)
+	      && !CCEQ (ti.c_cc[VQUIT], c)
+	      && !CCEQ (ti.c_cc[VSUSP], c))
+	    {
+	      if (!(ti.c_lflag & NOFLSH))
+		{
+		  eat_readahead (-1);
+		  discard_input ();
+		}
+	      ti.c_lflag &= ~FLUSHO;
+	      continue;
+	    }
+	}
       if (ti.c_lflag & ISIG)
 	{
 	  int sig;
-- 
2.35.1

