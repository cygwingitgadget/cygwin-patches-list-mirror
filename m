Return-Path: <SRS0=Wk1n=CQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 10B624BA540B
	for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2026 10:48:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10B624BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10B624BA540B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776422940; cv=none;
	b=Hi9B63c7BlzmwKUEY4dTMnO20pU1hYLF0Mg3yF2rFP9YY0UGPf0H4f3tvb30SNzO7nmBexPpYLUY8XUvXZOitP/QeiOVKMdT2KcEDQtLhA5SrPaniX9f3A+4IAtdRcvFjOZHn+rYegfmExyB4QscdwPLg2BQLueVRuqfATtjErg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776422940; c=relaxed/simple;
	bh=WpK85rf4fn2n+7h80MGQkuc5fpJ1mWNfGN2viVcQvIQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=wJKKzN2ZDsWJkN0blif9fXQPbQOsw4lf2cpKgrdovRmc/3+FezJHXuZ4DWTzU3fy+7eGl4jWhohELWuOSQPRsQMhY5nbxFSRgkyA81jSxM96sQJ/BG6yNdxCyXqsBBWP8l6Kl1DF9trAEzXzkkKSe3MxLPTF0uoBpuxIDCLQnqc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 10B624BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VhzMy0FA
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260417104855475.HLKP.19957.HP-Z230@nifty.com>;
          Fri, 17 Apr 2026 19:48:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v5] Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB
Date: Fri, 17 Apr 2026 19:48:37 +0900
Message-ID: <20260417104847.10575-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776422935;
 bh=264n/MUd7L4EhK1vh92LGv/V2q0vhx+rOVqksnnyuGI=;
 h=From:To:Cc:Subject:Date;
 b=VhzMy0FAeWvaDNr+D7z2+Lvd1xe1kiSfDdWfHh724JjC+fsq9KEZeX9ymfihwGiVPAYnFrWM
 V8zaEWrVTC2s+EGak6FU9g0UgBUQm0lfdo8LqvVZMQbLBDR7X2cEXdXowNWIW8AyWfQHK9PA0u
 eLLi3Utk9q+5gyt96j2yEGivVyeIccuEf+px+t+6jc5z4Px/r6/Y0HcLXRixcpRNBhh8GGY6YT
 zyQ+oDat5FhCvA01DdhheZQghHBcnqzcM/cUvjLlgay+V7IVmlRMoQ31EwrXCIpiU77teXU4vt
 er7oNw9/tWKI2ciTqzLgp7of5H5OO9ATlqvEsCOK7kFmxS4Q==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

At some point in the past, GDB sets terminal pgid to inferior pid
when the inferior is running. Moreover, the inferior is non-cygwin
process, GDB sets the terminal pgid to windows pid of the inferior.
Due to this behaviour, Ctrl-C does not work if the inferior is a
non-cygwin app. This is because, the current code sends Ctrl-C to
GDB only when GDB's pgid equeals to terminal pgid. This patch omit
checking pgid when recognizing GDB process whose inferior is non-
cygwin app. This patch also fixes the issue that the cygwin debuggee
under strace cannot be terminated by Ctrl-C.

In addition, to improve the readabiliby of the code, this patch
introduces inline functions such as:
is_foreground_special_process (),
is_gdb_with_foreground_non_cygwin_inferior (), etc.,
instead of complicated conditions in 'if' clauses.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/exceptions.cc          |  4 +--
 winsup/cygwin/fhandler/pty.cc        |  7 ++--
 winsup/cygwin/fhandler/termios.cc    | 54 +++++++++++-----------------
 winsup/cygwin/local_includes/pinfo.h | 42 ++++++++++++++++++++--
 winsup/cygwin/tty.cc                 |  7 ++--
 5 files changed, 69 insertions(+), 45 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 21af26ac3..1e129b319 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1215,8 +1215,8 @@ ctrl_c_handler (DWORD type)
   if (!pinfo (cygwin_pid (GetCurrentProcessId ())))
     return TRUE;
 
-  if (type == CTRL_C_EVENT && ::cygheap->ctty
-      && !cygheap->ctty->need_console_handler ())
+  if (type == CTRL_C_EVENT && !myself->is_cygwin_inferior_being_debugged ()
+      && ::cygheap->ctty && !cygheap->ctty->need_console_handler ())
     /* Ctrl-C is handled in fhandler_console::cons_master_thread(). */
     return TRUE;
 
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index cdfb363c9..80331c36d 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -384,6 +384,7 @@ atexit_func (void)
 	    break;
 	  }
       CloseHandle (h_gdb_inferior);
+      myself->wpid_debuggee_maybe = 0;
     }
 }
 
@@ -420,6 +421,7 @@ CreateProcessA_Hooked
   DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
 		   GetCurrentProcess (), &h_gdb_inferior,
 		   0, 0, DUPLICATE_SAME_ACCESS);
+  myself->wpid_debuggee_maybe = pi->dwProcessId;
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
     mutex_timeout = 0; /* to avoid deadlock in GDB */
@@ -459,6 +461,7 @@ CreateProcessW_Hooked
   DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
 		   GetCurrentProcess (), &h_gdb_inferior,
 		   0, 0, DUPLICATE_SAME_ACCESS);
+  myself->wpid_debuggee_maybe = pi->dwProcessId;
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
     mutex_timeout = 0; /* to avoid deadlock in GDB */
@@ -1236,9 +1239,6 @@ fhandler_pty_slave::set_switch_to_nat_pipe (void)
     {
       isHybrid = true;
       setup_locale ();
-      myself->exec_dwProcessId = myself->dwProcessId; /* Set this as a marker
-							 for tty::nat_fg()
-							 and process_sigs() */
       bool stdin_is_ptys = GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
       setup_for_non_cygwin_app (false, NULL, stdin_is_ptys);
     }
@@ -1270,6 +1270,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	{
 	  CloseHandle (h_gdb_inferior);
 	  h_gdb_inferior = NULL;
+	  myself->wpid_debuggee_maybe = 0;
 	  mutex_timeout = INFINITE;
 	  if (isHybrid)
 	    {
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 694a5c20f..ca5fa4b7e 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -338,19 +338,9 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      /* PID_NOTCYGWIN: check this for non-cygwin process.
-	 exec_dwProcessId == dwProcessId:
-		     check this for GDB with non-cygwin inferior in pty
-		     without pcon enabled. In this case, the inferior is not
-		     cygwin process list. This condition is set true as
-		     a marker for GDB with non-cygwin inferior in pty code.
-	 !PID_CYGPARENT: check this for GDB with cygwin inferior or
-			 cygwin apps started from non-cygwin shell. */
-      if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
-	  && ((p->process_state & PID_NOTCYGWIN)
-	      || ((p->exec_dwProcessId == p->dwProcessId)
-		  && ttyp->pty_input_state_eq (tty::to_nat))
-	      || !(p->process_state & PID_CYGPARENT)))
+      if (c == '\003' && p && p->ctty == ttyp->ntty
+	  && (p->is_foreground_special_process (pgid)
+	      || p->is_gdb_with_foreground_non_cygwin_inferior (pgid)))
 	{
 	  /* Ctrl-C event will be sent only to the processes attaching
 	     to the same console. Therefore, attach to the console to
@@ -372,7 +362,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  if (p->process_state & PID_NEW_PG)
 	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, p->dwProcessId);
 	  else if ((!fh || fh->need_send_ctrl_c_event ()
-		    || p->exec_dwProcessId == p->dwProcessId)
+		    || p->is_gdb_with_foreground_non_cygwin_inferior (pgid))
 		   && !ctrl_c_event_sent)
 	    {
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
@@ -390,24 +380,23 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	    }
 	  need_discard_input = true;
 	}
-      if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
+      if (p && p->ctty == ttyp->ntty)
 	{
-	  if (p->process_state & PID_NOTCYGWIN)
-	    pg_with_nat = true; /* The process group has non-cygwin process */
-	  if (!(p->process_state & PID_NOTCYGWIN))
-	    need_send_sig = true; /* Process which needs signal exists */
-	  if (!p->cygstarted)
-	    nat_shell = true; /* The shell seems to a non-cygwin shell */
-	  if (p->process_state & PID_TTYIN)
-	    cyg_reader = true; /* Theh process is reading the tty */
-	  if (!p->cygstarted && !(p->process_state & PID_NOTCYGWIN)
-	      && (p->process_state & PID_DEBUGGED))
-	    with_debugger = true; /* inferior is cygwin app */
-	  if (!(p->process_state & PID_NOTCYGWIN)
-	      && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
-	      && ttyp->pty_input_state_eq (tty::to_nat)
-	      && p->pid == pgid)
-	    with_debugger_nat = true; /* inferior is non-cygwin app */
+	  if (p->pgid == pgid)
+	    {
+	      if (p->process_state & PID_NOTCYGWIN)
+		pg_with_nat = true; /* The process group has non-cygwin app */
+	      if (!(p->process_state & PID_NOTCYGWIN))
+		need_send_sig = true; /* Process which needs signal exists */
+	      if (!p->cygstarted)
+		nat_shell = true; /* The shell seems to a non-cygwin shell */
+	      if (p->process_state & PID_TTYIN)
+		cyg_reader = true; /* Theh process is reading the tty */
+	      if (p->is_cygwin_inferior_being_debugged ())
+		with_debugger = true;
+	    }
+	  if (p->is_gdb_with_foreground_non_cygwin_inferior (pgid))
+	    with_debugger_nat = true;
 	}
     }
   if ((with_debugger || with_debugger_nat) && need_discard_input)
@@ -536,10 +525,9 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
       switch (process_sigs (c, get_ttyp (), this))
 	{
 	case signalled:
-	  sawsig = true;
-	  fallthrough;
 	case not_signalled_but_done:
 	case done_with_debugger:
+	  sawsig = true;
 	  get_ttyp ()->output_stopped &= ~BY_VSTOP;
 	  continue;
 	case not_signalled_with_nat_reader:
diff --git a/winsup/cygwin/local_includes/pinfo.h b/winsup/cygwin/local_includes/pinfo.h
index d1c9b001b..6f817de6b 100644
--- a/winsup/cygwin/local_includes/pinfo.h
+++ b/winsup/cygwin/local_includes/pinfo.h
@@ -46,6 +46,9 @@ enum picom
 
 class fhandler_pipe;
 
+pid_t create_cygwin_pid ();
+pid_t cygwin_pid (DWORD);
+
 class _pinfo
 {
 public:
@@ -126,10 +129,46 @@ public:
   bool exists ();
   const char *_ctty (char *);
 
+  /* "Special" here means a non-cygwin process or a process whose parent
+     is not a cygwin process */
+  inline bool is_foreground_special_process (pid_t tty_pgid)
+  {
+    if (pgid != tty_pgid) /* The process is background */
+      return false;
+    if (!(process_state & PID_CYGPARENT))
+      return true;
+    return !!(process_state & PID_NOTCYGWIN);
+  }
+  inline bool is_foreground_non_cygwin_process (pid_t tty_pgid)
+  {
+    if (pgid != tty_pgid)
+      return false;
+    return !!(process_state & PID_NOTCYGWIN);
+  }
+  inline bool is_gdb_with_foreground_non_cygwin_inferior (pid_t tty_pgid)
+  {
+    if (pgid == tty_pgid) /* GDB is the foreground process */
+      return false;
+    if (wpid_debuggee_maybe == 0)
+      return false;
+    /* Below is true for GDB with non-cygwin inferior */
+    return !cygwin_pid (wpid_debuggee_maybe);
+  }
+  inline bool is_cygwin_inferior_being_debugged ()
+  {
+    if (cygstarted)
+      return false;
+    if (process_state & PID_NOTCYGWIN)
+      return false;
+    return !!(process_state & PID_DEBUGGED);
+  }
+
   /* signals */
   HANDLE sendsig;
   HANDLE exec_sendsig;
   DWORD exec_dwProcessId;
+
+  DWORD wpid_debuggee_maybe;
 public:
   friend class pinfo_minimal;
 };
@@ -254,9 +293,6 @@ public:
   void release ();
 };
 
-pid_t create_cygwin_pid ();
-pid_t cygwin_pid (DWORD);
-
 void pinfo_init (char **, int);
 extern pinfo myself;
 
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 40b270309..e8083dc1f 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -341,10 +341,9 @@ tty::nat_fg (pid_t pgid)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (p->ctty == ntty && p->pgid == pgid
-	  && ((p->process_state & PID_NOTCYGWIN)
-	      /* Below is true for GDB with non-cygwin inferior */
-	      || p->exec_dwProcessId == p->dwProcessId))
+      if (p->ctty == ntty
+	  && (p->is_foreground_non_cygwin_process (pgid)
+	      || p->is_gdb_with_foreground_non_cygwin_inferior (pgid)))
 	return true;
     }
   if (pgid > MAX_PID)
-- 
2.51.0

