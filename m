Return-Path: <SRS0=9Zje=CO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 3E6E04BA2E06
	for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 04:13:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E6E04BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E6E04BA2E06
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776226429; cv=none;
	b=SxVxHy15+zHIaPzA3roVXXigiKCr0LCIpnqjMHHFWKJ9XJua0+To33ciHIrJ1qNjppPZ+YmxK1VmigfdEouVIFv/key2KxI5Oh+8CqeGG08/WIM+Z1Ms6+0qCIaeFsfBb0KNnw6SvlLQSH3v42S0vNP6BFTzAi09A7GmOKeHe3k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776226429; c=relaxed/simple;
	bh=ip6FzZthA63Ft6TS6SzfgQtqYRefEvIWOMH2tHk9bl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=CYJm4WuGZKz0mKDit0BiMqflmFhDbV0KHJH84ZDjx62rKij1WBViKFCvrCZrAVJfOzzYh8uI1mZZ4GFQp12x0wIq+F91A+lv0+Qs98o0FrTpJfkuQLxOU/wYQ+Mn/RI1jEJ8nex+aFb3ni0EtWK2VLQYjx21pJK7Ma69aG1NUF4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E6E04BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nk4quyk7
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260415041344951.UFMX.19957.HP-Z230@nifty.com>;
          Wed, 15 Apr 2026 13:13:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3] Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB
Date: Wed, 15 Apr 2026 13:13:29 +0900
Message-ID: <20260415041339.1837-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776226425;
 bh=1VKn6HQ8dUXciZgYta829ctXt3Hk05SAhQY+3kZ/zz8=;
 h=From:To:Cc:Subject:Date;
 b=nk4quyk7VU8KKj4jZvdI1PpKvlWJqUX5IkuTm0ZOs8vcWBd/slUfs62IPENOxcMM0a0UTC/j
 joSahMIjFMohJFwIxpFcSoCSX+e/uT/WU/sC/PWbOdQQcT7V3tB0QSr5N0Fe5gG3AyegATgSzY
 QiVEO1M9vVfoTH7cp8RpM+10Qu5chq1Hz7t4Dcx+aIfgSWyocZv/FJstsDQc+dH6I82Lu0ASCy
 tpJozK8ZLlOOeFMf7/v/B0xNK1O++lnk7ZsY8Za2MneVPEZXK30OnH4NnbZPyIFIKZ7BGBAWlq
 ZEYmLFOOjimT+NRIFQ77oZ7450zbJOjsWaMVtfOkm1kwKOGw==
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
cygwin app.

In addition, to improve the readabiliby of the code, this patch
introduces inline functions such as:
is_foreground_special_process (),
is_gdb_with_foreground_non_cygwin_inferior (), etc.,
instead of complicated conditions in 'if' clauses.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/fhandler/pty.cc        | 32 +++++++++------------
 winsup/cygwin/fhandler/termios.cc    | 27 ++++++-----------
 winsup/cygwin/local_includes/pinfo.h | 43 ++++++++++++++++++++++++++--
 winsup/cygwin/tty.cc                 |  7 ++---
 4 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index cdfb363c9..cc74c8726 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -249,7 +249,6 @@ void release_attach_mutex (void)
 static bool isHybrid; /* Set true if the active pipe is set to nat pipe
 			 owned by myself even though the current process
 			 is a cygwin process. */
-static HANDLE h_gdb_inferior; /* Handle of GDB inferior process. */
 
 static void
 set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HANDLE *err)
@@ -362,9 +361,9 @@ atexit_func (void)
 	if (cfd->get_device () == (dev_t) myself->ctty)
 	  {
 	    DWORD force_switch_to = 0;
-	    if (WaitForSingleObject (h_gdb_inferior, 0) == WAIT_TIMEOUT
-		&& !debug_process)
-	      force_switch_to = GetProcessId (h_gdb_inferior);
+	    if (WaitForSingleObject (myself->h_debuggee_maybe, 0)
+		== WAIT_TIMEOUT && !debug_process)
+	      force_switch_to = GetProcessId (myself->h_debuggee_maybe);
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 	    tty *ttyp = (tty *) ptys->tc ();
@@ -383,7 +382,7 @@ atexit_func (void)
 							    force_switch_to);
 	    break;
 	  }
-      CloseHandle (h_gdb_inferior);
+      CloseHandle (myself->h_debuggee_maybe);
     }
 }
 
@@ -416,9 +415,9 @@ CreateProcessA_Hooked
     set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
 			    &siov->hStdError);
   BOOL ret = CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
-  h_gdb_inferior = pi->hProcess;
-  DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
-		   GetCurrentProcess (), &h_gdb_inferior,
+  myself->h_debuggee_maybe = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), myself->h_debuggee_maybe,
+		   GetCurrentProcess (), &myself->h_debuggee_maybe,
 		   0, 0, DUPLICATE_SAME_ACCESS);
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
@@ -455,9 +454,9 @@ CreateProcessW_Hooked
     set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
 			    &siov->hStdError);
   BOOL ret = CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
-  h_gdb_inferior = pi->hProcess;
-  DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
-		   GetCurrentProcess (), &h_gdb_inferior,
+  myself->h_debuggee_maybe = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), myself->h_debuggee_maybe,
+		   GetCurrentProcess (), &myself->h_debuggee_maybe,
 		   0, 0, DUPLICATE_SAME_ACCESS);
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
@@ -1236,9 +1235,6 @@ fhandler_pty_slave::set_switch_to_nat_pipe (void)
     {
       isHybrid = true;
       setup_locale ();
-      myself->exec_dwProcessId = myself->dwProcessId; /* Set this as a marker
-							 for tty::nat_fg()
-							 and process_sigs() */
       bool stdin_is_ptys = GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
       setup_for_non_cygwin_app (false, NULL, stdin_is_ptys);
     }
@@ -1259,17 +1255,17 @@ nat_pipe_owner_self (DWORD pid)
 void
 fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 {
-  if (h_gdb_inferior)
+  if (myself->h_debuggee_maybe)
     {
-      if (WaitForSingleObject (h_gdb_inferior, 0) == WAIT_TIMEOUT)
+      if (WaitForSingleObject (myself->h_debuggee_maybe, 0) == WAIT_TIMEOUT)
 	{
 	  if (isHybrid)
 	    get_ttyp ()->wait_fwd ();
 	}
       else
 	{
-	  CloseHandle (h_gdb_inferior);
-	  h_gdb_inferior = NULL;
+	  CloseHandle (myself->h_debuggee_maybe);
+	  myself->h_debuggee_maybe = NULL;
 	  mutex_timeout = INFINITE;
 	  if (isHybrid)
 	    {
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 694a5c20f..d5721494d 100644
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
+	      || p->is_gdb_with_foreground_non_cygwin_inferior (ttyp)))
 	{
 	  /* Ctrl-C event will be sent only to the processes attaching
 	     to the same console. Therefore, attach to the console to
@@ -372,7 +362,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  if (p->process_state & PID_NEW_PG)
 	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, p->dwProcessId);
 	  else if ((!fh || fh->need_send_ctrl_c_event ()
-		    || p->exec_dwProcessId == p->dwProcessId)
+		    || p->is_gdb_with_foreground_non_cygwin_inferior (ttyp))
 		   && !ctrl_c_event_sent)
 	    {
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
@@ -403,12 +393,11 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
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
+	  && p->is_gdb_with_foreground_non_cygwin_inferior (ttyp))
+	with_debugger_nat = true; /* inferior is non-cygwin app */
     }
   if ((with_debugger || with_debugger_nat) && need_discard_input)
     {
diff --git a/winsup/cygwin/local_includes/pinfo.h b/winsup/cygwin/local_includes/pinfo.h
index d1c9b001b..9553ce1eb 100644
--- a/winsup/cygwin/local_includes/pinfo.h
+++ b/winsup/cygwin/local_includes/pinfo.h
@@ -10,6 +10,7 @@ details. */
 
 #include <sys/resource.h>
 #include "thread.h"
+#include "tty.h"
 
 union commune_result
 {
@@ -46,6 +47,9 @@ enum picom
 
 class fhandler_pipe;
 
+pid_t create_cygwin_pid ();
+pid_t cygwin_pid (DWORD);
+
 class _pinfo
 {
 public:
@@ -126,10 +130,46 @@ public:
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
+  inline bool is_gdb_with_foreground_non_cygwin_inferior (tty *ttyp)
+  {
+    if (h_debuggee_maybe == NULL)
+      return false;
+    if (cygwin_pid (GetProcessId (h_debuggee_maybe)))
+      return false;
+    return ttyp->pty_input_state_eq (tty::to_nat);
+  }
+  inline bool is_gdb_with_foreground_non_cygwin_inferior (pid_t tty_pgid)
+  {
+    if (pgid == tty_pgid) /* GDB is the foreground process */
+      return false;
+    if (h_debuggee_maybe == NULL)
+      return false;
+    /* Below is true for GDB with non-cygwin inferior */
+    return !cygwin_pid (GetProcessId (h_debuggee_maybe));
+  }
+
   /* signals */
   HANDLE sendsig;
   HANDLE exec_sendsig;
   DWORD exec_dwProcessId;
+
+  HANDLE h_debuggee_maybe;
 public:
   friend class pinfo_minimal;
 };
@@ -254,9 +294,6 @@ public:
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

