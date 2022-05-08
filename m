Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 313443858D32
 for <cygwin-patches@cygwin.com>; Sun,  8 May 2022 15:46:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 313443858D32
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 248Fk0fC015055;
 Mon, 9 May 2022 00:46:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 248Fk0fC015055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652024767;
 bh=OIItOsX1uxXUEe7p9a9zElMBWoXFUb36TIQvjp2DUe8=;
 h=From:To:Cc:Subject:Date:From;
 b=j6XoIFPrfIxycT2fbNaRVwN+MIfiX4XAD6pX5WzzsthFS4rXC00s4v5CVFsjU0s8T
 TtgD0Bf1hj559YcUfTv6GUwf5vvu/PHJUblpImeky8UufRGezOObgJLX5ng6VWuxCo
 ZyJUKqQUwdYgGgCTj0XwOGIn0ulGzV5YGNVf2HNEJoXkyeC60G80CiiICCHr1rE1Zo
 +lV/z9bwAGWvzVcNsFZPSIVHhWsopDGApAidHtIAB1bL64h3YvhQQiasoPtDfbF3Zv
 tDSAvS/yJBmHvqQ8FgfY6NagA/mU0PhRaAuLzbfN9yrKrs/3HrBCxyOr9tQVAYd/ke
 xUgwLzZ5nh+Tw==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Avoid deadlock when pcon is started on console.
Date: Mon,  9 May 2022 00:45:54 +0900
Message-Id: <20220508154554.1300-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 08 May 2022 15:46:34 -0000

- Previously, "env SHELL=cmd script" command in console caused
  deadlock when starting cmd.exe. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 34 +++++++++++++++++-----------------
 winsup/cygwin/select.cc       |  2 --
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 9ab681d6c..f6a7a6cf9 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1171,11 +1171,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	      bool need_restore_handles = get_ttyp ()->pcon_activated;
 	      WaitForSingleObject (pipe_sw_mutex, INFINITE);
 	      if (get_ttyp ()->pcon_activated)
-		{
-		  acquire_attach_mutex (mutex_timeout);
-		  close_pseudoconsole (get_ttyp ());
-		  release_attach_mutex ();
-		}
+		close_pseudoconsole (get_ttyp ());
 	      else
 		hand_over_only (get_ttyp ());
 	      ReleaseMutex (pipe_sw_mutex);
@@ -3244,9 +3240,11 @@ fhandler_pty_slave::setup_pseudoconsole ()
 		       GetCurrentProcess (), &hpConOut,
 		       0, TRUE, DUPLICATE_SAME_ACCESS);
       CloseHandle (pcon_owner);
+      acquire_attach_mutex (mutex_timeout);
       FreeConsole ();
       AttachConsole (get_ttyp ()->nat_pipe_owner_pid);
       init_console_handler (false);
+      release_attach_mutex ();
       goto skip_create;
     }
 
@@ -3368,9 +3366,11 @@ fhandler_pty_slave::setup_pseudoconsole ()
       HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
 
       /* Attach to pseudo console */
+      acquire_attach_mutex (mutex_timeout);
       FreeConsole ();
       AttachConsole (pi.dwProcessId);
       init_console_handler (false);
+      release_attach_mutex ();
 
       /* Terminate helper process */
       SetEvent (goodbye);
@@ -3535,8 +3535,10 @@ void
 fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 {
   DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
+  acquire_attach_mutex (mutex_timeout);
   ttyp->previous_code_page = GetConsoleCP ();
   ttyp->previous_output_code_page = GetConsoleOutputCP ();
+  release_attach_mutex ();
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     { /* I am owner of the nat pipe. */
       if (switch_to)
@@ -3578,19 +3580,23 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  ttyp->h_pcon_conhost_process = new_conhost_process;
 	  ttyp->h_pcon_in = new_pcon_in;
 	  ttyp->h_pcon_out = new_pcon_out;
+	  acquire_attach_mutex (mutex_timeout);
 	  FreeConsole ();
 	  pinfo p (myself->ppid);
 	  if (!p || !AttachConsole (p->dwProcessId))
 	    AttachConsole (ATTACH_PARENT_PROCESS);
 	  init_console_handler (false);
+	  release_attach_mutex ();
 	}
       else
 	{ /* Close pseudo console and abandon the ownership of the nat pipe. */
+	  acquire_attach_mutex (mutex_timeout);
 	  FreeConsole ();
 	  pinfo p (myself->ppid);
 	  if (!p || !AttachConsole (p->dwProcessId))
 	    AttachConsole (ATTACH_PARENT_PROCESS);
 	  init_console_handler (false);
+	  release_attach_mutex ();
 	  /* Reconstruct pseudo console handler container here for close */
 	  HPCON_INTERNAL *hp =
 	    (HPCON_INTERNAL *) HeapAlloc (GetProcessHeap (), 0,
@@ -3610,11 +3616,13 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
     }
   else
     { /* Just detach from the pseudo console if I am not owner. */
+      acquire_attach_mutex (mutex_timeout);
       FreeConsole ();
       pinfo p (myself->ppid);
       if (!p || !AttachConsole (p->dwProcessId))
 	AttachConsole (ATTACH_PARENT_PROCESS);
       init_console_handler (false);
+      release_attach_mutex ();
     }
 }
 
@@ -4040,11 +4048,7 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
     }
   bool pcon_enabled = false;
   if (!nopcon)
-    {
-      acquire_attach_mutex (mutex_timeout);
-      pcon_enabled = setup_pseudoconsole ();
-      release_attach_mutex ();
-    }
+    pcon_enabled = setup_pseudoconsole ();
   ReleaseMutex (pipe_sw_mutex);
   /* For pcon enabled case, transfer_input() is called in master::write() */
   if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
@@ -4077,11 +4081,7 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
     }
   WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
-    {
-      acquire_attach_mutex (mutex_timeout);
-      close_pseudoconsole (ttyp, force_switch_to);
-      release_attach_mutex ();
-    }
+    close_pseudoconsole (ttyp, force_switch_to);
   else
     hand_over_only (ttyp, force_switch_to);
   ReleaseMutex (p->pipe_sw_mutex);
@@ -4111,6 +4111,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
       DWORD resume_pid = 0;
+      WaitForSingleObject (input_mutex, mutex_timeout);
       if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
 	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
 	{
@@ -4126,13 +4127,12 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	}
       else
 	acquire_attach_mutex (mutex_timeout);
-      WaitForSingleObject (input_mutex, mutex_timeout);
       transfer_input (tty::to_cyg, from, get_ttyp (), input_available_event);
-      ReleaseMutex (input_mutex);
       if (attach_restore)
 	resume_from_temporarily_attach (resume_pid);
       else
 	release_attach_mutex ();
+      ReleaseMutex (input_mutex);
     }
   ReleaseMutex (pipe_sw_mutex);
 }
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 4f23dfdef..0fa60bcdb 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1125,7 +1125,6 @@ peek_console (select_record *me, bool)
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
 	{
-	  release_attach_mutex ();
 	  fh->release_input_mutex ();
 	  return me->read_ready = true;
 	}
@@ -1142,7 +1141,6 @@ peek_console (select_record *me, bool)
 	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
 	{
 	  set_sig_errno (EINTR);
-	  release_attach_mutex ();
 	  fh->release_input_mutex ();
 	  return -1;
 	}
-- 
2.36.0

