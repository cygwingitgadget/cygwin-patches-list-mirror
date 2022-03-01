Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id D80B53858C78
 for <cygwin-patches@cygwin.com>; Tue,  1 Mar 2022 10:39:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D80B53858C78
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 221AdOKb011307;
 Tue, 1 Mar 2022 19:39:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 221AdOKb011307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646131169;
 bh=dIa6UJhqQGLKAYNC5TT98+f78x3GmpiK6Zn0aOJ4KKA=;
 h=From:To:Cc:Subject:Date:From;
 b=ZoacrGTtPFhGyMnLjOFb+DGlP6Mvh0vuB8kgs9KR51eB3mW0dWnz/tccRhlRtVbIe
 nb1cJUjPKCS1tTopfJxIT5ojZrS+qw7X7xdbxsPGkaaxXppRWwWMx0bAji2hD2Y6dz
 uPi60tK0s16z2DSQ/+ronuKFJmZEp+RXydvhWVrgEc575T+WkXiTsysCkeovuLRdA6
 HD/kyezQK+SFesqP4NofLUqyZz+HEt4TMEK+EC78ZIwoivg99itDiLovkqgATxbouL
 uUItkCoN/tWAQRBpmVl7+NCqVjnGxXw7yLfCR/m9cDXouXHrYLUviE1xP7rw/8r6fD
 jcGRrvCKFCAFg==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Reorganize the code path of setting up and
 closing pcon.
Date: Tue,  1 Mar 2022 19:39:15 +0900
Message-Id: <20220301103915.702-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Tue, 01 Mar 2022 10:40:03 -0000

- This patch reorganizes the code path of setting-up and cleaning-up
  of the pseudo console to improve readability and maintainability
  of pty code.
---
 winsup/cygwin/fhandler.h          |  10 +-
 winsup/cygwin/fhandler_termios.cc |   2 +-
 winsup/cygwin/fhandler_tty.cc     | 283 +++++++++++++++---------------
 3 files changed, 153 insertions(+), 142 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 7646f09cc..919479948 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2389,8 +2389,10 @@ class fhandler_pty_slave: public fhandler_pty_common
     fh->copy_from (this);
     return fh;
   }
-  bool setup_pseudoconsole (bool nopcon);
+  bool setup_pseudoconsole ();
+  static DWORD get_winpid_to_hand_over (tty *ttyp, DWORD force_switch_to);
   static void close_pseudoconsole (tty *ttyp, DWORD force_switch_to = 0);
+  static void hand_over_only (tty *ttyp, DWORD force_switch_to = 0);
   bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
@@ -2407,10 +2409,10 @@ class fhandler_pty_slave: public fhandler_pty_common
   void setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
 				 bool stdin_is_ptys);
   static void cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
-					  bool stdin_is_ptys);
+					  bool stdin_is_ptys,
+					  DWORD force_switch_to = 0);
   void setpgid_aux (pid_t pid);
-  static void close_pseudoconsole_if_necessary (tty *ttyp,
-						fhandler_termios *fh);
+  static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 094842038..a29129486 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -397,7 +397,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 		 pseudo console because this process attached to it
 		 before sending CTRL_C_EVENT. In this case, closing
 		 pseudo console is necessary. */
-	      fhandler_pty_slave::close_pseudoconsole_if_necessary (ttyp, fh);
+	      fhandler_pty_slave::release_ownership_of_nat_pipe (ttyp, fh);
 	      FreeConsole ();
 	      if (resume_pid && console_exists)
 		AttachConsole (resume_pid);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 7b099dcb9..3d74f9a0c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -236,20 +236,18 @@ atexit_func (void)
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 	    tty *ttyp = (tty *) ptys->tc ();
-	    HANDLE from = ptys->get_handle_nat ();
-	    HANDLE input_available_event = ptys->get_input_available_event ();
-	    if (ttyp->getpgid () == myself->pgid
-		&& GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ()
-		&& ttyp->pcon_input_state_eq (tty::to_nat) && !force_switch_to)
+	    bool stdin_is_ptys =
+		GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ();
+	    struct fhandler_pty_slave::handle_set_t handles =
 	      {
-		WaitForSingleObject (ptys->input_mutex, mutex_timeout);
-		fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
-						    input_available_event);
-		ReleaseMutex (ptys->input_mutex);
-	      }
-	    WaitForSingleObject (ptys->pcon_mutex, INFINITE);
-	    ptys->close_pseudoconsole (ttyp, force_switch_to);
-	    ReleaseMutex (ptys->pcon_mutex);
+		ptys->get_handle_nat (),
+		ptys->get_input_available_event (),
+		ptys->input_mutex,
+		ptys->pcon_mutex
+	      };
+	    fhandler_pty_slave::cleanup_for_non_cygwin_app (&handles, ttyp,
+							    stdin_is_ptys,
+							    force_switch_to);
 	    break;
 	  }
       CloseHandle (h_gdb_process);
@@ -1089,19 +1087,8 @@ fhandler_pty_slave::set_switch_to_pcon (void)
       setup_locale ();
       myself->exec_dwProcessId = myself->dwProcessId;
       myself->process_state |= PID_NEW_PG; /* Marker for pcon_fg */
-      bool nopcon = (disable_pcon || !term_has_pcon_cap (NULL));
-      WaitForSingleObject (pcon_mutex, INFINITE);
-      bool pcon_enabled = setup_pseudoconsole (nopcon);
-      ReleaseMutex (pcon_mutex);
-      if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
-	  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
-	  && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
-	{
-	  WaitForSingleObject (input_mutex, mutex_timeout);
-	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
-			  input_available_event);
-	  ReleaseMutex (input_mutex);
-	}
+      bool stdin_is_ptys = GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
+      setup_for_non_cygwin_app (false, NULL, stdin_is_ptys);
     }
 }
 
@@ -1161,7 +1148,10 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		return;
 	      bool need_restore_handles = get_ttyp ()->pcon_activated;
 	      WaitForSingleObject (pcon_mutex, INFINITE);
-	      close_pseudoconsole (get_ttyp ());
+	      if (get_ttyp ()->pcon_activated)
+		close_pseudoconsole (get_ttyp ());
+	      else
+		hand_over_only (get_ttyp ());
 	      ReleaseMutex (pcon_mutex);
 	      if (need_restore_handles)
 		{
@@ -3218,22 +3208,8 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr,
      Slave process will attach to the pseudo console in the
      helper process using AttachConsole(). */
 bool
-fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
+fhandler_pty_slave::setup_pseudoconsole ()
 {
-  /* Setting switch_to_pcon_in is necessary even if
-     pseudo console will not be activated. */
-  fhandler_base *fh = ::cygheap->fdtab[0];
-  if (fh && fh->get_major () == DEV_PTYS_MAJOR)
-    {
-      fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-      ptys->get_ttyp ()->switch_to_pcon_in = true;
-      if (!pcon_pid_alive (ptys->get_ttyp ()->pcon_pid))
-	ptys->get_ttyp ()->pcon_pid = myself->exec_dwProcessId;
-    }
-
-  if (nopcon)
-    return false;
-
   /* If the legacy console mode is enabled, pseudo console seems
      not to work as expected. To determine console mode, registry
      key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
@@ -3249,7 +3225,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 
   HANDLE hpConIn, hpConOut;
   if (get_ttyp ()->pcon_activated)
-    {
+    { /* The pseudo console is already activated. */
       if (GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
 	{ /* Send CSI6n just for requesting transfer input. */
 	  DWORD n;
@@ -3287,7 +3263,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
   HPCON hpcon;
 
   do
-    {
+    { /* Create new pseudo console */
       COORD size = {
 	(SHORT) get_ttyp ()->winsize.ws_col,
 	(SHORT) get_ttyp ()->winsize.ws_row
@@ -3519,10 +3495,10 @@ fallback:
   return false;
 }
 
-/* The function close_pseudoconsole() should be static so that it can
-   be called even after the fhandler_pty_slave instance is deleted. */
-void
-fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
+/* Find a process to which the ownership of nat pipe should be handed over */
+DWORD
+fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
+					     DWORD force_switch_to)
 {
   DWORD switch_to = 0;
   if (force_switch_to)
@@ -3532,106 +3508,120 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
     }
   else if (pcon_pid_self (ttyp->pcon_pid))
     {
-      /* Search another process which attaches to the pseudo console */
+      /* Search another native process which attaches to the same console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
       switch_to = get_console_process_id (current_pid, false, true, true);
       if (!switch_to)
 	switch_to = get_console_process_id (current_pid, false, true, false);
     }
-  if (ttyp->pcon_activated)
+  return switch_to;
+}
+
+void
+fhandler_pty_slave::hand_over_only (tty *ttyp, DWORD force_switch_to)
+{
+  if (pcon_pid_self (ttyp->pcon_pid))
     {
-      ttyp->previous_code_page = GetConsoleCP ();
-      ttyp->previous_output_code_page = GetConsoleOutputCP ();
-      if (pcon_pid_self (ttyp->pcon_pid))
+      DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
+      if (switch_to)
+	/* The process switch_to takes over the ownership of the nat pipe. */
+	ttyp->pcon_pid = switch_to;
+      else
 	{
-	  if (switch_to)
-	    {
-	      /* Change pseudo console owner to another process */
-	      HANDLE new_owner =
-		OpenProcess (PROCESS_DUP_HANDLE, FALSE, switch_to);
-	      HANDLE new_write_pipe = NULL;
-	      HANDLE new_condrv_reference = NULL;
-	      HANDLE new_conhost_process = NULL;
-	      HANDLE new_pcon_in = NULL, new_pcon_out = NULL;
-	      DuplicateHandle (GetCurrentProcess (),
-			       ttyp->h_pcon_write_pipe,
-			       new_owner, &new_write_pipe,
-			       0, TRUE, DUPLICATE_SAME_ACCESS);
-	      DuplicateHandle (GetCurrentProcess (),
-			       ttyp->h_pcon_condrv_reference,
-			       new_owner, &new_condrv_reference,
-			       0, TRUE, DUPLICATE_SAME_ACCESS);
-	      DuplicateHandle (GetCurrentProcess (),
-			       ttyp->h_pcon_conhost_process,
-			       new_owner, &new_conhost_process,
-			       0, TRUE, DUPLICATE_SAME_ACCESS);
-	      DuplicateHandle (GetCurrentProcess (), ttyp->h_pcon_in,
-			       new_owner, &new_pcon_in,
-			       0, TRUE, DUPLICATE_SAME_ACCESS);
-	      DuplicateHandle (GetCurrentProcess (), ttyp->h_pcon_out,
-			       new_owner, &new_pcon_out,
-			       0, TRUE, DUPLICATE_SAME_ACCESS);
-	      CloseHandle (new_owner);
-	      CloseHandle (ttyp->h_pcon_write_pipe);
-	      CloseHandle (ttyp->h_pcon_condrv_reference);
-	      CloseHandle (ttyp->h_pcon_conhost_process);
-	      CloseHandle (ttyp->h_pcon_in);
-	      CloseHandle (ttyp->h_pcon_out);
-	      ttyp->pcon_pid = switch_to;
-	      ttyp->h_pcon_write_pipe = new_write_pipe;
-	      ttyp->h_pcon_condrv_reference = new_condrv_reference;
-	      ttyp->h_pcon_conhost_process = new_conhost_process;
-	      ttyp->h_pcon_in = new_pcon_in;
-	      ttyp->h_pcon_out = new_pcon_out;
-	      FreeConsole ();
-	      pinfo p (myself->ppid);
-	      if (!p || !AttachConsole (p->dwProcessId))
-		AttachConsole (ATTACH_PARENT_PROCESS);
-	      init_console_handler (false);
-	    }
-	  else
-	    { /* Close pseudo console */
-	      FreeConsole ();
-	      pinfo p (myself->ppid);
-	      if (!p || !AttachConsole (p->dwProcessId))
-		AttachConsole (ATTACH_PARENT_PROCESS);
-	      init_console_handler (false);
-	      /* Reconstruct pseudo console handler container here for close */
-	      HPCON_INTERNAL *hp =
-		(HPCON_INTERNAL *) HeapAlloc (GetProcessHeap (), 0,
-					      sizeof (HPCON_INTERNAL));
-	      hp->hWritePipe = ttyp->h_pcon_write_pipe;
-	      hp->hConDrvReference = ttyp->h_pcon_condrv_reference;
-	      hp->hConHostProcess = ttyp->h_pcon_conhost_process;
-	      /* HeapFree() will be called in ClosePseudoConsole() */
-	      ClosePseudoConsole ((HPCON) hp);
-	      CloseHandle (ttyp->h_pcon_conhost_process);
-	      ttyp->pcon_activated = false;
-	      ttyp->switch_to_pcon_in = false;
-	      ttyp->pcon_pid = 0;
-	      ttyp->pcon_start = false;
-	      ttyp->pcon_start_pid = 0;
-	    }
+	  /* Abandon the ownership of the nat pipe */
+	  ttyp->pcon_pid = 0;
+	  ttyp->switch_to_pcon_in = false;
 	}
-      else
+    }
+}
+
+/* The function close_pseudoconsole() should be static so that it can
+   be called even after the fhandler_pty_slave instance is deleted. */
+void
+fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
+{
+  DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
+  ttyp->previous_code_page = GetConsoleCP ();
+  ttyp->previous_output_code_page = GetConsoleOutputCP ();
+  if (pcon_pid_self (ttyp->pcon_pid))
+    { /* I am owner of the nat pipe. */
+      if (switch_to)
 	{
+	  /* Change pseudo console owner to another process (switch_to). */
+	  HANDLE new_owner =
+	    OpenProcess (PROCESS_DUP_HANDLE, FALSE, switch_to);
+	  HANDLE new_write_pipe = NULL;
+	  HANDLE new_condrv_reference = NULL;
+	  HANDLE new_conhost_process = NULL;
+	  HANDLE new_pcon_in = NULL, new_pcon_out = NULL;
+	  DuplicateHandle (GetCurrentProcess (),
+			   ttyp->h_pcon_write_pipe,
+			   new_owner, &new_write_pipe,
+			   0, TRUE, DUPLICATE_SAME_ACCESS);
+	  DuplicateHandle (GetCurrentProcess (),
+			   ttyp->h_pcon_condrv_reference,
+			   new_owner, &new_condrv_reference,
+			   0, TRUE, DUPLICATE_SAME_ACCESS);
+	  DuplicateHandle (GetCurrentProcess (),
+			   ttyp->h_pcon_conhost_process,
+			   new_owner, &new_conhost_process,
+			   0, TRUE, DUPLICATE_SAME_ACCESS);
+	  DuplicateHandle (GetCurrentProcess (), ttyp->h_pcon_in,
+			   new_owner, &new_pcon_in,
+			   0, TRUE, DUPLICATE_SAME_ACCESS);
+	  DuplicateHandle (GetCurrentProcess (), ttyp->h_pcon_out,
+			   new_owner, &new_pcon_out,
+			   0, TRUE, DUPLICATE_SAME_ACCESS);
+	  CloseHandle (new_owner);
+	  CloseHandle (ttyp->h_pcon_write_pipe);
+	  CloseHandle (ttyp->h_pcon_condrv_reference);
+	  CloseHandle (ttyp->h_pcon_conhost_process);
+	  CloseHandle (ttyp->h_pcon_in);
+	  CloseHandle (ttyp->h_pcon_out);
+	  ttyp->pcon_pid = switch_to;
+	  ttyp->h_pcon_write_pipe = new_write_pipe;
+	  ttyp->h_pcon_condrv_reference = new_condrv_reference;
+	  ttyp->h_pcon_conhost_process = new_conhost_process;
+	  ttyp->h_pcon_in = new_pcon_in;
+	  ttyp->h_pcon_out = new_pcon_out;
 	  FreeConsole ();
 	  pinfo p (myself->ppid);
 	  if (!p || !AttachConsole (p->dwProcessId))
 	    AttachConsole (ATTACH_PARENT_PROCESS);
 	  init_console_handler (false);
 	}
-    }
-  else if (pcon_pid_self (ttyp->pcon_pid))
-    {
-      if (switch_to)
-	ttyp->pcon_pid = switch_to;
       else
-	{
-	  ttyp->pcon_pid = 0;
+	{ /* Close pseudo console and abandon the ownership of the nat pipe. */
+	  FreeConsole ();
+	  pinfo p (myself->ppid);
+	  if (!p || !AttachConsole (p->dwProcessId))
+	    AttachConsole (ATTACH_PARENT_PROCESS);
+	  init_console_handler (false);
+	  /* Reconstruct pseudo console handler container here for close */
+	  HPCON_INTERNAL *hp =
+	    (HPCON_INTERNAL *) HeapAlloc (GetProcessHeap (), 0,
+					  sizeof (HPCON_INTERNAL));
+	  hp->hWritePipe = ttyp->h_pcon_write_pipe;
+	  hp->hConDrvReference = ttyp->h_pcon_condrv_reference;
+	  hp->hConHostProcess = ttyp->h_pcon_conhost_process;
+	  /* HeapFree() will be called in ClosePseudoConsole() */
+	  ClosePseudoConsole ((HPCON) hp);
+	  CloseHandle (ttyp->h_pcon_conhost_process);
+	  ttyp->pcon_activated = false;
 	  ttyp->switch_to_pcon_in = false;
+	  ttyp->pcon_pid = 0;
+	  ttyp->pcon_start = false;
+	  ttyp->pcon_start_pid = 0;
 	}
     }
+  else
+    { /* Just detach from the pseudo console if I am not owner. */
+      FreeConsole ();
+      pinfo p (myself->ppid);
+      if (!p || !AttachConsole (p->dwProcessId))
+	AttachConsole (ATTACH_PARENT_PROCESS);
+      init_console_handler (false);
+    }
 }
 
 static bool
@@ -4032,10 +4022,22 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
   if (disable_pcon || !term_has_pcon_cap (envblock))
     nopcon = true;
   WaitForSingleObject (pcon_mutex, INFINITE);
-  bool enable_pcon = setup_pseudoconsole (nopcon);
+  /* Setting switch_to_pcon_in is necessary even if pseudo console
+     will not be activated. */
+  fhandler_base *fh = ::cygheap->fdtab[0];
+  if (fh && fh->get_major () == DEV_PTYS_MAJOR)
+    {
+      fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+      ptys->get_ttyp ()->switch_to_pcon_in = true;
+      if (!pcon_pid_alive (ptys->get_ttyp ()->pcon_pid))
+	ptys->get_ttyp ()->pcon_pid = myself->exec_dwProcessId;
+    }
+  bool pcon_enabled = false;
+  if (!nopcon)
+    pcon_enabled = setup_pseudoconsole ();
   ReleaseMutex (pcon_mutex);
   /* For pcon enabled case, transfer_input() is called in master::write() */
-  if (!enable_pcon && get_ttyp ()->getpgid () == myself->pgid
+  if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
       && stdin_is_ptys && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
     {
       WaitForSingleObject (input_mutex, mutex_timeout);
@@ -4047,7 +4049,8 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
 
 void
 fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
-						bool stdin_is_ptys)
+						bool stdin_is_ptys,
+						DWORD force_switch_to)
 {
   ttyp->wait_pcon_fwd ();
   if (ttyp->getpgid () == myself->pgid && stdin_is_ptys
@@ -4059,7 +4062,10 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
       ReleaseMutex (p->input_mutex);
     }
   WaitForSingleObject (p->pcon_mutex, INFINITE);
-  close_pseudoconsole (ttyp);
+  if (ttyp->pcon_activated)
+    close_pseudoconsole (ttyp, force_switch_to);
+  else
+    hand_over_only (ttyp, force_switch_to);
   ReleaseMutex (p->pcon_mutex);
 }
 
@@ -4123,14 +4129,17 @@ fhandler_pty_master::need_send_ctrl_c_event ()
 }
 
 void
-fhandler_pty_slave::close_pseudoconsole_if_necessary (tty *ttyp,
-						      fhandler_termios *fh)
+fhandler_pty_slave::release_ownership_of_nat_pipe (tty *ttyp,
+						   fhandler_termios *fh)
 {
-  if (fh->get_major () == DEV_PTYM_MAJOR && ttyp->pcon_activated)
+  if (fh->get_major () == DEV_PTYM_MAJOR)
     {
       fhandler_pty_master *ptym = (fhandler_pty_master *) fh;
       WaitForSingleObject (ptym->pcon_mutex, INFINITE);
-      close_pseudoconsole (ttyp);
+      if (ttyp->pcon_activated)
+	close_pseudoconsole (ttyp);
+      else
+	hand_over_only (ttyp);
       ReleaseMutex (ptym->pcon_mutex);
     }
 }
-- 
2.35.1

