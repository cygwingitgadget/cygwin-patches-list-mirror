Return-Path: <SRS0=g9mI=BJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 489004BA2E1A
	for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2026 07:08:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 489004BA2E1A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 489004BA2E1A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773040107; cv=none;
	b=CLz9Bn13M0+YYEqa0ED2JkUB/Z3oqfPjBVr67kcH5iojffz+Lilp7f5xNGkKmSvOMGL0m1ga+iQhjgeFD1w8LzYLj5nUgr5eauwWHkEa5d0GqeTivQQF14vlbT3EH8L6NhpvDc4oZR1ZBVMP3lpb7olhm1nZlwfutfOwaJ9X4cI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773040107; c=relaxed/simple;
	bh=aFpOlUTEfecynU269IskBNfe+3eUillSqU12o5SH4/M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=YaUwKvfOSBWwUCFOlOlR9BNzEuQA8SxMBV349l6rvYiz+v10noG2wqp5o/DbsWA58LrbtwPUFjGVrU6SkHC0TD3hi2X7Sx2YRTXCWCpOFvKRtfDxYb/yqlTAgskryvxnmEomWl/sc3sCBNw8eXBr3vZ5P6ADLzeSnezuGJTgS3g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 489004BA2E1A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gjClvFgM
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260309070825147.TAHX.127398.HP-Z230@nifty.com>;
          Mon, 9 Mar 2026 16:08:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB
Date: Mon,  9 Mar 2026 16:08:07 +0900
Message-ID: <20260309070818.5952-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773040105;
 bh=jCIA85LwKG4AobMY+q0Ujbp6+wjfEoN4Kpk/ulklB6I=;
 h=From:To:Cc:Subject:Date;
 b=gjClvFgMzk0LBxCGdLUx/xttLjRPBaBMtycr1eTugtsjmkE1ENyV+Mz2kXtu7jIH0F1r6pch
 EEqF2K7LfJZG9rsOa+pZpYckCp43aTIhNLXEZW1iIX/CbPThf2Um/Munnsdw2Zz116hKEAjBEB
 czIn0oEIfSGlkpHr+b/6WsXom1cUr2dwNRry7yjYjAmMWVdJKqfZrH/zgmiR1R8bTYLSdJ3qJj
 r41453xV3ioQLAkp4b2JQO0vd+sOQfxPgg6wHrB3+S05EJBWO2CxFXuiw3S+ep8d0yXFYcjRfm
 e4Z81IbU6PyshlTucyCpcsNv42840AhFMlCbdhIUBL+zLubg==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

At some point in the past, GDB sets terminal pgid to inferior pid
when the inferior is running. Moreover, the inferior is non-cygwin
process, GDB sets the terminal pgid to windows pid of the inferior.
Due to this behaviour, Ctrl-C does not work if the inferior is a
non-cygwin app. This is because, the current code sends Ctrl-C to
GDB only when GDB's pgid equeals to terminal pgid. This patch omit
checking pgid when recognizing GDB process whose inferior is non-
cygwin app.

In addition, to improve the readabiliby of the code, this patch
introduces inline functions such as:
is_foreground_special_process (),
is_gdb_with_foreground_non_cygwin_inferior (), etc.,
instead of complicated conditions in 'if' clauses.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 62 +++++++++++++++++++++----------
 winsup/cygwin/tty.cc              | 24 ++++++++++--
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 694a5c20f..08cab9a01 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -311,6 +311,41 @@ fhandler_termios::echo_erase (int force)
     doecho ("\b \b", 3);
 }
 
+/* PID_NOTCYGWIN: check this for non-cygwin process.
+   exec_dwProcessId == dwProcessId:
+	       check this for GDB with non-cygwin inferior in pty
+	       without pcon enabled. In this case, the inferior is not
+	       cygwin process list. This condition is set true as
+	       a marker for GDB with non-cygwin inferior in pty code.
+   !PID_CYGPARENT: check this for GDB with cygwin inferior or
+		   cygwin apps started from non-cygwin shell. */
+
+/* "Special" here means a non-cygwin process or a process whose parent
+   is not a cygwin process */
+inline static bool
+is_foreground_special_process (_pinfo *p, pid_t tty_pgid)
+{
+  if (!p)
+    return false;
+  if (p->pgid != tty_pgid)
+    return false;
+  return !((p->process_state & PID_CYGPARENT)
+	   && !(p->process_state & PID_NOTCYGWIN));
+}
+
+/* exec_dwProcessId == dwProcessId:
+       check this for GDB with non-cygwin inferior in pty
+       In this case, the inferior is not cygwin process list.
+       This condition is set true as a marker for GDB with
+       non-cygwin inferior in pty code. */
+inline static bool
+is_gdb_with_foreground_non_cygwin_inferior (_pinfo *p, tty *ttyp)
+{
+  if (p->exec_dwProcessId != p->dwProcessId)
+    return false;
+  return ttyp->pty_input_state_eq (tty::to_nat);
+}
+
 /* The basic policy is as follows:
    - The signal generated by key press will be sent only to cygwin process.
    - For non-cygwin process, CTRL_C_EVENT will be sent on Ctrl-C. */
@@ -338,19 +373,9 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
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
+	  && (is_foreground_special_process (p, pgid)
+	      || is_gdb_with_foreground_non_cygwin_inferior (p, ttyp)))
 	{
 	  /* Ctrl-C event will be sent only to the processes attaching
 	     to the same console. Therefore, attach to the console to
@@ -372,7 +397,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  if (p->process_state & PID_NEW_PG)
 	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, p->dwProcessId);
 	  else if ((!fh || fh->need_send_ctrl_c_event ()
-		    || p->exec_dwProcessId == p->dwProcessId)
+		    || is_gdb_with_foreground_non_cygwin_inferior (p, ttyp))
 		   && !ctrl_c_event_sent)
 	    {
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
@@ -403,12 +428,11 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  if (!p->cygstarted && !(p->process_state & PID_NOTCYGWIN)
 	      && (p->process_state & PID_DEBUGGED))
 	    with_debugger = true; /* inferior is cygwin app */
-	  if (!(p->process_state & PID_NOTCYGWIN)
-	      && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
-	      && ttyp->pty_input_state_eq (tty::to_nat)
-	      && p->pid == pgid)
-	    with_debugger_nat = true; /* inferior is non-cygwin app */
 	}
+      if (p &&  p->ctty == ttyp->ntty
+	  && !(p->process_state & PID_NOTCYGWIN)
+	  && is_gdb_with_foreground_non_cygwin_inferior (p, ttyp))
+	with_debugger_nat = true; /* inferior is non-cygwin app */
     }
   if ((with_debugger || with_debugger_nat) && need_discard_input)
     {
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 0c49dc2bd..acc21c0ca 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -331,6 +331,23 @@ tty::wait_fwd ()
     }
 }
 
+inline static bool
+is_non_cygwin_foreground_process (_pinfo *p, pid_t pgid)
+{
+  if (p->pgid != pgid)
+    return false;
+  return !!(p->process_state & PID_NOTCYGWIN);
+}
+
+inline static bool
+is_gdb_with_foreground_non_cygwin_inferior (_pinfo *p, pid_t pgid)
+{
+  if (p->pgid == pgid) /* GDB is the foreground process */
+    return false;
+  /* Below is true for GDB with non-cygwin inferior */
+  return p->exec_dwProcessId == p->dwProcessId;
+}
+
 bool
 tty::nat_fg (pid_t pgid)
 {
@@ -340,10 +357,9 @@ tty::nat_fg (pid_t pgid)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (p->ctty == ntty && p->pgid == pgid
-	  && ((p->process_state & PID_NOTCYGWIN)
-	      /* Below is true for GDB with non-cygwin inferior */
-	      || p->exec_dwProcessId == p->dwProcessId))
+      if (p->ctty == ntty
+	  && (is_non_cygwin_foreground_process (p, pgid)
+	      || is_gdb_with_foreground_non_cygwin_inferior (p, pgid)))
 	return true;
     }
   if (pgid > MAX_PID)
-- 
2.51.0

