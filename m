Return-Path: <SRS0=oEc+=IV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id E58C04BA23EF
	for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2026 20:31:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E58C04BA23EF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E58C04BA23EF
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793478706; cv=none;
	b=VVjbz3hjpU79mE8iFF79FcAuaNi8csl82kvDzUEkXRoXkQRPCMv1Cc6X61ntgniloRNVj4S8aijuYO8VrB2TQ2b8pKocpZzFPhDrSdbocXlSaiEFIYkXID3bCsDEbPju0KUcfYu+oFgdta8dAH07in8CCNIxErF6YyFts/z5z78=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793478706; c=relaxed/simple;
	bh=Ij8zy1KAvJ/Va9Uk+BGkErdsVU8pRsy3hd6riUKqEBQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nP3qFY0KXAHZDywr1xemEsyGe2YTnfAM3jSwpVRRL/rGNfCCkuwdTonzl4GneDA4eQ94Rv8FUSEbjYeNEohQfYWl0dk+uK6IueNQeUjOKajT1gIjRsPMla1CKKMEGyOckos0G2SQa6roqGhap7SVHiNhe30gliZZKhBJKXcqxdU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AjK/KiU2
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E58C04BA23EF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AjK/KiU2
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261031203141086.YOJV.44671.HP-Z230@nifty.com>;
          Sun, 1 Nov 2026 05:31:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 2/2] Cygwin: pty: Handle win32 input mode rather than omitting it
Date: Sun,  1 Nov 2026 05:31:26 +0900
Message-ID: <20261031203134.1838-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793478701;
 bh=oDR7ZUkheEWTNB6ZpXC7pixosJqEZxMu2ZEtGQjHB34=;
 h=From:To:Cc:Subject:Date;
 b=AjK/KiU2tRssHjbCmylt89bV+gCO2g3PU8be2ITLj6zw94DwXZy3VmkyV2sP6COHt4/zeg1B
 x7WUl1cJLPid9dn42UcLKT5hQWLX9n7LX/nxhnad6bUrdioRF9H1rMicPVJ/e2YNE7Ek8DJz8S
 lhE2MjXpFT92VK8McEqFdNuy3yAikHrqJwI/pxWU5gA/SLLlnUQWM+FVgOmrPEHHRFvDrYLJix
 nZxPiRj+9N846xpvE4yheA08kbYcRzjdiMqpy8LLWMVmEFtFWN0XlmAaL6JITJLUggsynL4mRT
 p1/RNZucPDibgJHIOAn5xnKyslPs/MKh2n9m3VFmwPTm8hfw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
v4: Add missing initialization for win32input_mode_maybe.

 winsup/cygwin/fhandler/pty.cc      | 65 +++++++++++++++++++++++++++---
 winsup/cygwin/local_includes/tty.h |  1 +
 winsup/cygwin/tty.cc               |  1 +
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 39525bd08..9c4779030 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2734,6 +2734,37 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       len = nlen;
       for (size_t i = 0, j = 0; i < len; i++)
 	{
+	  const int max_w32i_len = 64;
+	  static char w32i_buf[max_w32i_len];
+	  static int w32i_idx;
+	  if (get_ttyp ()->win32input_mode_maybe
+	      && (buf[i] == '\033' || w32i_idx))
+	    {
+	      DWORD n;
+	      if (buf[i] == '\033')
+		{
+		  if (w32i_idx)
+		    WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+		  w32i_idx = 0;
+		}
+	      if (w32i_idx < max_w32i_len - 1)
+		{
+		  w32i_buf[w32i_idx++] = buf[i];
+		  w32i_buf[w32i_idx] = '\0';
+		}
+	      nlen--;
+	      if (buf[i] == '_')
+		{
+		  int a1, a2, a3, a4, a5, a6;
+		  if (sscanf (w32i_buf, "\033[%d;%d;%d;%d;%d;%d_",
+			      &a1, &a2, &a3, &a4, &a5, &a6) == 6
+		      && a1 == 0x43 && a4 == 1 && a5 == 8) /* Ctrl-C */
+		    process_sigs ('\003', get_ttyp (), this);
+		  WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+		  w32i_idx = 0;
+		}
+	      continue;
+	    }
 	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
 	  if (r != done_with_debugger &&
 	      (r != signalled || (ti.c_lflag & NOFLSH) || buf[i] == '\003'))
@@ -3238,8 +3269,7 @@ fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
 	      }
 	    state = 0;
 	  }
-	else if (saw_question_mark
-		 && (arg == 9001 || arg == 1004)
+	else if (saw_question_mark && arg == 1004
 		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
 	  {
 	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
@@ -3247,6 +3277,18 @@ fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
 	    i = start_at - 1;
 	    state = 0;
 	  }
+	else if (saw_question_mark && arg == 9001
+		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
+	  {
+	    ttyp->win32input_mode_maybe = (outbuf[i] == 'h');
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
@@ -4410,7 +4452,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	return;
     }
 
-  HANDLE to;
+  HANDLE to, to_master = NULL;
   if (dir == tty::to_nat)
     to = ttyp->to_slave_nat ();
   else
@@ -4418,8 +4460,12 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 
   pinfo p (ttyp->master_pid);
   if (p)
-    to = get_handle_from_process (p->dwProcessId, to, true);
-  if (to == NULL)
+    {
+      to = get_handle_from_process (p->dwProcessId, to, true);
+      to_master = get_handle_from_process (p->dwProcessId,
+					   ttyp->to_master (), true);
+    }
+  if (to == NULL || to_master == NULL)
     {
       char pipe[MAX_PATH];
       __small_sprintf (pipe,
@@ -4434,7 +4480,6 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
       CloseHandle (repl.from_master_nat); /* not used. */
       CloseHandle (repl.from_master); /* not used. */
       CloseHandle (repl.to_master_nat); /* not used. */
-      CloseHandle (repl.to_master); /* not used. */
       if (dir == tty::to_nat)
 	{
 	  CloseHandle (repl.to_slave); /* not used. */
@@ -4445,6 +4490,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	  CloseHandle (repl.to_slave_nat); /* not used. */
 	  to = repl.to_slave;
 	}
+      to_master = repl.to_master;
     }
 
   UINT cp_from = 0, cp_to = 0;
@@ -4606,6 +4652,13 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
       while (IsEventSignalled (input_transferred_to_cyg))
 	yield ();
     }
+  if (ttyp->win32input_mode_maybe)
+    {
+      const char *str = dir == tty::to_nat ? "\033[?9001h" : "\033[?9001l";
+      DWORD n;
+      WriteFile (to_master, str, strlen (str), &n, NULL);
+    }
+  CloseHandle (to_master);
   ttyp->discard_input = false;
 }
 
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index c5102eb81..eb9457181 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -146,6 +146,7 @@ private:
   bool discard_input;
   bool stop_fwd_thread;
   bool req_fixup_pcon_cur_pos;
+  bool win32input_mode_maybe;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index ba65aca3d..f21d9ec41 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -306,6 +306,7 @@ tty::init ()
   last_sig = 0;
   discard_input = false;
   stop_fwd_thread = false;
+  win32input_mode_maybe = false;
 }
 
 HANDLE
-- 
2.51.0

