Return-Path: <SRS0=qPmQ=IZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id CE0034BA23C1
	for <cygwin-patches@cygwin.com>; Wed,  4 Nov 2026 01:30:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CE0034BA23C1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CE0034BA23C1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793755820; cv=none;
	b=G4sRIFIzicr5pZ+hsRph3FCGJTSgibIqWUOEFwQiWt9K8bFt+LzmDl3TWcRwNKs7XTegFevj/R5217tJEIpQ55FaHKC/5jpBnkq6TMdN4O0UqyC2I5LnEFTxUe8l7Mjg1Dj6tA3AF4YWtQqxa7wG11Q5yiEHZBJzk+FRhx0qXdI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793755820; c=relaxed/simple;
	bh=49clwN9yy/7S3UGHtbfeJfQO1HhP3at9WyX5QjrhPK4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=CUmuFTV8EShi/A7z53+Is6xfT/07Z4Hug1L2G6BLSAAXuicCEYltvgZyvQshajCtwX2mznVLZeOpYRm4aCbIOwib1A2wd01VioqEkJWCyXJamRdqZqacQ/tzKrOv+rPSfIccDREQ620K9L2gDAbnfzqDnf02COqvQknKEYelNW0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fE4hdeMB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CE0034BA23C1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fE4hdeMB
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261104013013246.MTI.44671.HP-Z230@nifty.com>;
          Wed, 4 Nov 2026 10:30:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 2/2] Cygwin: pty: Handle win32 input mode rather than omitting it
Date: Wed,  4 Nov 2026 10:29:58 +0900
Message-ID: <20261104013007.112-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793755813;
 bh=iyFxJbK39IfsOXF3P+1IiStHqCa/8p7l6rt8f+ND3YE=;
 h=From:To:Cc:Subject:Date;
 b=fE4hdeMBtUeexIAZ0Ry5P3g+ByDm+bk2n7TQ8fSYU6WsgJQtyNvrAchgWBSQ3vmNFPriBYd+
 4TROcxhUqO6uNMUV14vLwCtTjcBg4f0aVzDMa4PnEyPMI9cmvqf/i/Wu2flT3hJsFRNyV9SQso
 r37eKSjvPmpOVjvH6lt3Ii2Nk/qcWMy1fHqI3Y5r7CUgaKvvxb0TNPovh6G8KCdBcsjWkXyTXy
 TJIJxUATrxzSQioTC2EwH04Lk1bWixi4wIMmDbQiRyUeEUvYz/aLjxEXDhxp9HJOjxsm+5m8+O
 bRxuAYlVXDRnlmXcJZdyyq8G80QylDFoO8WP5DA1cogxDGYg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, win32 input mode request from pseudo console is omitted
to avoid incorrect Ctrl-C handling. This patch makes pty handle win32
input mode properly instead of removing that sequence (SCI?9001h/l)
from the output of the pseudo console.

Fixes: b7541ef1242a ("Cygwin: pty: Omit win32-input-mode sequence from pseudo console")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
v2: Remove SCI?9001h/l if the foreground process is cygwin process.
v3: Toggle win32 input mode based on pty_input_state in transfer_input().
v4: Add missing initialization for win32input_mode.
v5: Disable win32 input mode before calling transfer_input() in
    cleanup_for_non_cygwin_app().
    Check if the terminal has win32-input-mode and remember the result.

 winsup/cygwin/fhandler/pty.cc      | 178 ++++++++++++++++++++++++++---
 winsup/cygwin/local_includes/tty.h |   3 +
 winsup/cygwin/tty.cc               |   2 +
 3 files changed, 169 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 39525bd08..bd450f0d5 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2734,6 +2734,71 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       len = nlen;
       for (size_t i = 0, j = 0; i < len; i++)
 	{
+	  const int max_w32i_len = 64;
+	  static char w32i_buf[max_w32i_len];
+	  static int w32i_idx;
+	  if (get_ttyp ()->win32input_mode && (buf[i] == '\033' || w32i_idx))
+	    {
+	      DWORD n;
+	      char c = buf[i];
+	      nlen--;
+	      /* Workaround for pseudo console in Windows 11 */
+	      if (!(cons_mode & ENABLE_VIRTUAL_TERMINAL_INPUT))
+		/* Undesired backspace conversion in pseudo console does
+		   not happen if ENABLE_VIRTUAL_TERMINAL_INPUT is set. */
+		if (c == '\010') /* Ctrl-H */
+		  c = '\177';  /* Backspace */
+	      if (c == '\003')
+		{
+		  WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+		  w32i_idx = 0;
+		  /* Ctrl-C should be written separately */
+		  process_sigs ('\003', get_ttyp (), this);
+		  WriteFile (to_slave_nat, "\003", 1, &n, NULL);
+		  continue;
+		}
+	      if (c == '\033')
+		{
+		  if (w32i_idx)
+		    WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+		  w32i_idx = 0;
+		}
+	      w32i_buf[w32i_idx++] = c;
+	      w32i_buf[w32i_idx] = '\0';
+	      bool do_flush = false;
+	      if (c == '_')
+		{
+		  int a1, a2, a3, a4, a5, a6;
+		  if (sscanf (w32i_buf, "\033[%d;%d;%d;%d;%d;%d_",
+			      &a1, &a2, &a3, &a4, &a5, &a6) == 6
+		      && a1 == 0x43 && a4 == 1 && a5 == 8) /* Ctrl-C */
+		    process_sigs ('\003', get_ttyp (), this);
+		  do_flush = true;
+		}
+	      else if (c == 'R' && get_ttyp ()->eow32i)
+		{
+		  int x, y;
+		  if (sscanf (w32i_buf, "\033[%d;%dR", &y, &x) == 2)
+		    {
+		      get_ttyp ()->eow32i = false;
+		      w32i_idx = 0;
+		    }
+		}
+	      else if (isalpha (c))
+		do_flush = true;
+	      if (do_flush || w32i_idx == max_w32i_len - 1)
+		{
+		  WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+		  w32i_idx = 0;
+		}
+	      continue;
+	    }
+	  if (w32i_idx)
+	    {
+	      DWORD n;
+	      WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+	      w32i_idx = 0;
+	    }
 	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
 	  if (r != done_with_debugger &&
 	      (r != signalled || (ti.c_lflag & NOFLSH) || buf[i] == '\003'))
@@ -3238,8 +3304,7 @@ fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
 	      }
 	    state = 0;
 	  }
-	else if (saw_question_mark
-		 && (arg == 9001 || arg == 1004)
+	else if (saw_question_mark && arg == 1004
 		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
 	  {
 	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
@@ -3247,6 +3312,18 @@ fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
 	    i = start_at - 1;
 	    state = 0;
 	  }
+	else if (saw_question_mark && ttyp->has_win32input_mode
+		 && arg == 9001 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
+	  {
+	    ttyp->win32input_mode = (outbuf[i] == 'h');
+	    if (ttyp->pty_input_state == tty::to_cyg && outbuf[i] == 'h')
+	      {
+		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		rlen = start_at + rlen - i - 1;
+		i = start_at - 1;
+	      }
+	    state = 0;
+	  }
 	else if (outbuf[i] == '\033')
 	  {
 	    start_at = i;
@@ -4328,6 +4405,49 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   get_ttyp ()->has_csi6n = true;
   get_ttyp ()->pcon_cap_checked = true;
 
+  /* Check for win32 input mode */
+  WaitForSingleObject (input_mutex, mutex_timeout);
+  get_ttyp ()->pcon_activated = true;
+  get_ttyp ()->pty_input_state = tty::to_nat;
+  WriteFile (get_output_handle (), "\033[?9001h", 8, &n, NULL);
+  WriteFile (get_output_handle (), "\033[?9001$p", 9, &n, NULL);
+  ReleaseMutex (input_mutex);
+  p = buf;
+  len = sizeof (buf) - 1;
+  wait_cnt = 0;
+  do
+    {
+      if (::bytes_available (n, get_handle_nat ()) && n)
+	{
+	  ReadFile (get_handle_nat (), p, len, &n, NULL);
+	  p += n;
+	  len -= n;
+	  *p = '\0';
+	  char *p1 = strrchr (buf, '\033');
+	  int a1, a2;
+	  char c, d;
+	  if (p1 == NULL
+	      || sscanf (p1, "\033[?%d;%d%c%c", &a1, &a2, &c, &d) != 4
+	      || a1 != 9001 || c != '$' || d != 'y')
+	    continue;
+	  get_ttyp ()->has_win32input_mode = (a2 == 1);
+	  break;
+	}
+      else if (++wait_cnt > 100) /* Timeout */
+	{
+	  get_ttyp ()->has_win32input_mode = false;
+	  break;
+	}
+      else
+	Sleep (1);
+    }
+  while (len);
+  WaitForSingleObject (input_mutex, mutex_timeout);
+  get_ttyp ()->pty_input_state = tty::to_cyg;
+  get_ttyp ()->pcon_activated = false;
+  WriteFile (get_output_handle (), "\033[?9001l", 8, &n, NULL);
+  ReleaseMutex (input_mutex);
+
   return true;
 
 not_has_csi6n:
@@ -4410,7 +4530,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	return;
     }
 
-  HANDLE to;
+  HANDLE to, to_master = NULL;
   if (dir == tty::to_nat)
     to = ttyp->to_slave_nat ();
   else
@@ -4418,8 +4538,11 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 
   pinfo p (ttyp->master_pid);
   if (p)
-    to = get_handle_from_process (p->dwProcessId, to, true);
-  if (to == NULL)
+    {
+      to = get_handle_from_process (p->dwProcessId, to);
+      to_master = get_handle_from_process (p->dwProcessId, ttyp->to_master ());
+    }
+  if (to == NULL || to_master == NULL)
     {
       char pipe[MAX_PATH];
       __small_sprintf (pipe,
@@ -4434,7 +4557,6 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
       CloseHandle (repl.from_master_nat); /* not used. */
       CloseHandle (repl.from_master); /* not used. */
       CloseHandle (repl.to_master_nat); /* not used. */
-      CloseHandle (repl.to_master); /* not used. */
       if (dir == tty::to_nat)
 	{
 	  CloseHandle (repl.to_slave); /* not used. */
@@ -4445,6 +4567,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	  CloseHandle (repl.to_slave_nat); /* not used. */
 	  to = repl.to_slave;
 	}
+      to_master = repl.to_master;
     }
 
   UINT cp_from = 0, cp_to = 0;
@@ -4606,6 +4729,13 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
       while (IsEventSignalled (input_transferred_to_cyg))
 	yield ();
     }
+  if (ttyp->win32input_mode)
+    {
+      const char *str = dir == tty::to_nat ? "\033[?9001h" : "\033[?9001l";
+      DWORD n;
+      WriteFile (to_master, str, strlen (str), &n, NULL);
+    }
+  CloseHandle (to_master);
   ttyp->discard_input = false;
 }
 
@@ -4656,9 +4786,9 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
 					      const WCHAR *envblock,
 					      bool stdin_is_ptys)
 {
-  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   if (disable_pcon || !term_has_pcon_cap (envblock))
     nopcon = true;
+  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   /* Setting switch_to_nat_pipe is necessary even if pseudo console
      will not be activated. */
   fhandler_base *fh = ::cygheap->fdtab[0];
@@ -4702,14 +4832,33 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
-      if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
-	  && ttyp->pty_input_state_eq (tty::to_nat))
+      if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys)))
 	{
-	  acquire_attach_mutex (mutex_timeout);
-	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
-			  p->input_available_event,
-			  p->input_transferred_to_cyg);
-	  release_attach_mutex ();
+	  if (ttyp->win32input_mode && ttyp->pty_input_state_eq (tty::to_nat))
+	    {
+	      DWORD n;
+	      pinfo pp (ttyp->master_pid);
+	      HANDLE to_master = get_handle_from_process (pp->dwProcessId,
+							  ttyp->to_master ());
+	      WriteFile(to_master, "\033[?9001l", 8, &n, NULL);
+	      ttyp->eow32i = true;
+	      WriteFile(to_master, "\033[6n", 4, &n, NULL);
+	      CloseHandle (to_master);
+	      DWORD t0 = GetTickCount ();
+	      ReleaseMutex (p->input_mutex);
+	      while (ttyp->eow32i && GetTickCount () - t0 < 100)
+		Sleep (1);
+	      WaitForSingleObject (p->input_mutex, mutex_timeout);
+	      ttyp->win32input_mode = false;
+	    }
+	  if (ttyp->pty_input_state_eq (tty::to_nat))
+	    {
+	      acquire_attach_mutex (mutex_timeout);
+	      transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
+			      p->input_available_event,
+			      p->input_transferred_to_cyg);
+	      release_attach_mutex ();
+	    }
 	}
     }
   ReleaseMutex (p->input_mutex);
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index c5102eb81..765db71ee 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -146,6 +146,9 @@ private:
   bool discard_input;
   bool stop_fwd_thread;
   bool req_fixup_pcon_cur_pos;
+  bool has_win32input_mode;
+  bool win32input_mode;
+  volatile bool eow32i;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index ba65aca3d..dd84ca2b7 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -306,6 +306,9 @@ tty::init ()
   last_sig = 0;
   discard_input = false;
   stop_fwd_thread = false;
+  has_win32input_mode = false;
+  win32input_mode = false;
+  eow32i = false;
 }
 
 HANDLE
-- 
2.51.0

