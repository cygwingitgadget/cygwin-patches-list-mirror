Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id E5DB63968C30
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 10:31:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E5DB63968C30
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 13JAUmCD006642;
 Mon, 19 Apr 2021 19:31:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 13JAUmCD006642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618828278;
 bh=tWH/iv/PePmXtKJ/IzhEACqsKF9TDRjSr5mfZQqAVEE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ftXiXYD2iO1uQEkNhNzFWrj0yUdSo4bxYnA3wnwQSiZEOaOP5sCV5rncfG/EtEEXZ
 uAH95PMltj5Z3z2rvl5whs3GCwFfcPWsPqYBxNEKYwaVHxK4gU8HIxLkts22cgtu1i
 lVduV6uKp0GLZQ7H/t0xuq0L4EhU7YptlcbClp2qB2LLQWu3btKT7AOK+i4AhJYDLb
 +tcmBY95WfYUR02Xb5y2WQTAvFLLWs2WKa5uMH2I3M/MNS9tC8kBrLMjHcC50u2ci5
 kmtllC6jCmki4RcKUaxR5PFFRh98IVSsHO093uARblnzfwNi2W5E4voiID9DmKkuhM
 KJu4EjxcpABrA==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: pty: Fix race issue in inheritance of pseudo
 console.
Date: Mon, 19 Apr 2021 19:30:46 +0900
Message-Id: <20210419103046.21838-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
References: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_BL_SPAMCOP_NET,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 19 Apr 2021 10:31:42 -0000

- If multiple non-cygwin processes are started/ended simultaneously,
  inheritance of pseudo console sometimes fails. This patch fixes
  the issue.

  Addresses:
    https://cygwin.com/pipermail/cygwin/2021-April/248292.html
---
 winsup/cygwin/fhandler_tty.cc | 108 ++++++++++++++++++++--------------
 winsup/cygwin/tty.cc          |  15 ++---
 winsup/cygwin/tty.h           |   2 +-
 3 files changed, 69 insertions(+), 56 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 73aec2ade..ba9f4117f 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1072,6 +1072,24 @@ fhandler_pty_slave::set_switch_to_pcon (void)
     }
 }
 
+inline static bool
+pcon_pid_alive (DWORD pid)
+{
+  if (pid == 0)
+    return false;
+  HANDLE h = OpenProcess (SYNCHRONIZE, FALSE, pid);
+  if (h == NULL)
+    return false;
+  CloseHandle (h);
+  return true;
+}
+
+inline static bool
+pcon_pid_self (DWORD pid)
+{
+  return (pid == myself->exec_dwProcessId);
+}
+
 void
 fhandler_pty_slave::reset_switch_to_pcon (void)
 {
@@ -1153,17 +1171,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
   if (isHybrid)
     return;
   WaitForSingleObject (pcon_mutex, INFINITE);
-  HANDLE h;
-  if (get_ttyp ()->pcon_pid > MAX_PID &&
-      (h = OpenProcess (SYNCHRONIZE, FALSE, get_ttyp ()->pcon_pid - MAX_PID)))
-    {
-      /* There is a process which is grabbing pseudo console. */
-      CloseHandle (h);
-      ReleaseMutex (pcon_mutex);
-      return;
-    }
-  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
-      && !!pinfo (get_ttyp ()->pcon_pid))
+  if (!pcon_pid_self (get_ttyp ()->pcon_pid)
+      && pcon_pid_alive (get_ttyp ()->pcon_pid))
     {
       /* There is a process which is grabbing pseudo console. */
       ReleaseMutex (pcon_mutex);
@@ -1975,19 +1984,15 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
   COORD size;
   size.X = ws->ws_col;
   size.Y = ws->ws_row;
-  pinfo p (get_ttyp ()->pcon_pid);
-  if (p)
-    {
-      HPCON_INTERNAL hpcon_local;
-      HANDLE pcon_owner =
-	OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->exec_dwProcessId);
-      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
-		       GetCurrentProcess (), &hpcon_local.hWritePipe,
-		       0, TRUE, DUPLICATE_SAME_ACCESS);
-      ResizePseudoConsole ((HPCON) &hpcon_local, size);
-      CloseHandle (pcon_owner);
-      CloseHandle (hpcon_local.hWritePipe);
-    }
+  HPCON_INTERNAL hpcon_local;
+  HANDLE pcon_owner =
+    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
+		   GetCurrentProcess (), &hpcon_local.hWritePipe,
+		   0, TRUE, DUPLICATE_SAME_ACCESS);
+  ResizePseudoConsole ((HPCON) &hpcon_local, size);
+  CloseHandle (pcon_owner);
+  CloseHandle (hpcon_local.hWritePipe);
 }
 
 void
@@ -3085,9 +3090,8 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
     {
       fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
       ptys->get_ttyp ()->switch_to_pcon_in = true;
-      if (ptys->get_ttyp ()->pcon_pid == 0
-	  || !pinfo (ptys->get_ttyp ()->pcon_pid))
-	ptys->get_ttyp ()->pcon_pid = myself->pid;
+      if (!pcon_pid_alive (ptys->get_ttyp ()->pcon_pid))
+	ptys->get_ttyp ()->pcon_pid = myself->exec_dwProcessId;
     }
 
   if (nopcon)
@@ -3107,8 +3111,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
     }
 
   HANDLE hpConIn, hpConOut;
-  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
-      && !!pinfo (get_ttyp ()->pcon_pid) && get_ttyp ()->pcon_activated)
+  if (get_ttyp ()->pcon_activated)
     {
       if (GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
 	{ /* Send CSI6n just for requesting transfer input. */
@@ -3119,11 +3122,14 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 	  get_ttyp ()->pcon_start_pid = myself->pid;
 	  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
 	  ReleaseMutex (input_mutex);
+	  while (get_ttyp ()->pcon_start)
+	    Sleep (1);
 	}
       /* Attach to the pseudo console which already exits. */
-      pinfo p (get_ttyp ()->pcon_pid);
       HANDLE pcon_owner =
-	OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->exec_dwProcessId);
+	OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+      if (pcon_owner == NULL)
+	return false;
       DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
 		       GetCurrentProcess (), &hpConIn,
 		       0, TRUE, DUPLICATE_SAME_ACCESS);
@@ -3132,7 +3138,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 		       0, TRUE, DUPLICATE_SAME_ACCESS);
       CloseHandle (pcon_owner);
       FreeConsole ();
-      AttachConsole (p->exec_dwProcessId);
+      AttachConsole (get_ttyp ()->pcon_pid);
       goto skip_create;
     }
 
@@ -3287,10 +3293,10 @@ skip_create:
     }
   while (false);
 
-  if (get_ttyp ()->pcon_pid == 0 || !pinfo (get_ttyp ()->pcon_pid))
-    get_ttyp ()->pcon_pid = myself->pid;
+  if (!pcon_pid_alive (get_ttyp ()->pcon_pid))
+    get_ttyp ()->pcon_pid = myself->exec_dwProcessId;
 
-  if (hpcon && get_ttyp ()->pcon_pid == myself->pid)
+  if (hpcon && pcon_pid_self (get_ttyp ()->pcon_pid))
     {
       HPCON_INTERNAL *hp = (HPCON_INTERNAL *) hpcon;
       get_ttyp ()->h_pcon_write_pipe = hp->hWritePipe;
@@ -3381,15 +3387,14 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
   if (force_switch_to)
     {
       switch_to_stub = force_switch_to;
-      new_pcon_pid = force_switch_to + MAX_PID;
-      ttyp->setpgid (new_pcon_pid);
+      new_pcon_pid = force_switch_to;
+      ttyp->setpgid (force_switch_to + MAX_PID);
     }
-  else if (ttyp->pcon_pid == myself->pid)
+  else if (pcon_pid_self (ttyp->pcon_pid))
     {
       /* Search another process which attaches to the pseudo console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
-      switch_to =
-	get_console_process_id (current_pid, false, true);
+      switch_to = get_console_process_id (current_pid, false, true);
       if (switch_to)
 	{
 	  pinfo p (cygwin_pid (switch_to));
@@ -3397,15 +3402,21 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	    {
 	      if (p->exec_dwProcessId)
 		switch_to_stub = p->exec_dwProcessId;
-	      new_pcon_pid = p->pid;
+	      new_pcon_pid = p->exec_dwProcessId;
 	    }
 	}
+      else
+	{
+	  switch_to = get_console_process_id (current_pid, false, false);
+	  if (switch_to)
+	    new_pcon_pid = switch_to;
+	}
     }
   if (ttyp->pcon_activated)
     {
       ttyp->previous_code_page = GetConsoleCP ();
       ttyp->previous_output_code_page = GetConsoleOutputCP ();
-      if (ttyp->pcon_pid == myself->pid)
+      if (pcon_pid_self (ttyp->pcon_pid))
 	{
 	  switch_to = switch_to_stub ?: switch_to;
 	  if (switch_to)
@@ -3447,6 +3458,15 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	      ttyp->h_pcon_conhost_process = new_conhost_process;
 	      ttyp->h_pcon_in = new_pcon_in;
 	      ttyp->h_pcon_out = new_pcon_out;
+	      FreeConsole ();
+	      pinfo p (myself->ppid);
+	      if (p)
+		{
+		  if (!AttachConsole (p->dwProcessId))
+		    AttachConsole (ATTACH_PARENT_PROCESS);
+		}
+	      else
+		AttachConsole (ATTACH_PARENT_PROCESS);
 	    }
 	  else
 	    { /* Close pseudo console */
@@ -3462,7 +3482,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	      /* Reconstruct pseudo console handler container here for close */
 	      HPCON_INTERNAL *hp =
 		(HPCON_INTERNAL *) HeapAlloc (GetProcessHeap (), 0,
-					      sizeof (*hp));
+					      sizeof (HPCON_INTERNAL));
 	      hp->hWritePipe = ttyp->h_pcon_write_pipe;
 	      hp->hConDrvReference = ttyp->h_pcon_condrv_reference;
 	      hp->hConHostProcess = ttyp->h_pcon_conhost_process;
@@ -3489,7 +3509,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	    AttachConsole (ATTACH_PARENT_PROCESS);
 	}
     }
-  else if (ttyp->pcon_pid == myself->pid)
+  else if (pcon_pid_self (ttyp->pcon_pid))
     {
       if (switch_to_stub)
 	ttyp->pcon_pid = new_pcon_pid;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 96acde387..2566f4c45 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -327,25 +327,18 @@ tty_min::setpgid (int pid)
 	       && ttyp->pcon_input_state_eq (tty::to_nat))
 	{
 	  bool attach_restore = false;
-	  DWORD pcon_winpid = 0;
-	  if (ttyp->pcon_pid)
-	    {
-	      pinfo p (ttyp->pcon_pid);
-	      if (p)
-		pcon_winpid = p->exec_dwProcessId ?: p->dwProcessId;
-	    }
 	  HANDLE from = ptys->get_handle_nat ();
-	  if (ttyp->pcon_activated && pcon_winpid
-	      && !ptys->get_console_process_id (pcon_winpid, true))
+	  if (ttyp->pcon_activated && ttyp->pcon_pid
+	      && !ptys->get_console_process_id (ttyp->pcon_pid, true))
 	    {
 	      HANDLE pcon_owner =
-		OpenProcess (PROCESS_DUP_HANDLE, FALSE, pcon_winpid);
+		OpenProcess (PROCESS_DUP_HANDLE, FALSE, ttyp->pcon_pid);
 	      DuplicateHandle (pcon_owner, ttyp->h_pcon_in,
 			       GetCurrentProcess (), &from,
 			       0, TRUE, DUPLICATE_SAME_ACCESS);
 	      CloseHandle (pcon_owner);
 	      FreeConsole ();
-	      AttachConsole (pcon_winpid);
+	      AttachConsole (ttyp->pcon_pid);
 	      attach_restore = true;
 	    }
 	  WaitForSingleObject (ptys->input_mutex, INFINITE);
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 12c926ec0..8479dd2ec 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -113,7 +113,7 @@ private:
   bool pcon_start;
   pid_t pcon_start_pid;
   bool switch_to_pcon_in;
-  pid_t pcon_pid;
+  DWORD pcon_pid;
   UINT term_code_page;
   DWORD pcon_last_time;
   HANDLE h_pcon_write_pipe;
-- 
2.31.1

