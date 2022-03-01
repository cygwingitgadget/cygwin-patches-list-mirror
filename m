Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id DCD7F3858C78
 for <cygwin-patches@cygwin.com>; Tue,  1 Mar 2022 10:38:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DCD7F3858C78
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 221AcNXa009017;
 Tue, 1 Mar 2022 19:38:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 221AcNXa009017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646131111;
 bh=UgIhVZnK1oityxLwv6YBDmArjWNU32cMhnwBVvWDxf4=;
 h=From:To:Cc:Subject:Date:From;
 b=vZGjUazHyvwIweRojm8UDc/ZrYtKsFLsRPCRvIWLEp+uCRIVhnAdnybCkrmpDLg9s
 lcVoLXAiRuckJqZre8YXQ1C2B2dfScxa6pF0GZeoG4GTmhcsWpv+1uVRipJq8o0sY4
 r0twVHhpRTFL1Po+kyZjevm2hqTngYBhUfp8hF4BJEHfSByxflM2rUArFNjsIsFf4X
 ZwEDNCZuNxcA7KTM+/6H6F6iJygzjlt2cf8Oo+KGdhTFs16ROO1OLHsml1AmIbiU77
 WRZhH623rqI11PU0RRA3aTXeghHtHdZI7yF0HZjnHKwSlShSFM9cEhwIz4jq56Repy
 XSJHo4SwkkCmQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Avoid cutting the branch the pty master is
 sitting on.
Date: Tue,  1 Mar 2022 19:38:13 +0900
Message-Id: <20220301103813.691-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Tue, 01 Mar 2022 10:38:57 -0000

- When Ctrl-C terminates a non-cygwin process on a pseudo console,
  pty master attaches to the pseudo console first, and send
  CTRL_C_EVENT. If the non-cygwin process closes the pseudo console
  before the pty master calls FreeConsole(), the pty master process
  will crash. With this patch, pty master process takes over the
  ownership of the pseudo console, and closes it by myself.
---
 winsup/cygwin/exceptions.cc       |  3 ++
 winsup/cygwin/fhandler.h          |  2 +
 winsup/cygwin/fhandler_termios.cc | 20 +++++--
 winsup/cygwin/fhandler_tty.cc     | 87 +++++++++++++++----------------
 winsup/cygwin/sigproc.cc          |  3 +-
 5 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 070e52e76..f946bed77 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1157,6 +1157,9 @@ ctrl_c_handler (DWORD type)
 
   tty_min *t = cygwin_shared->tty.get_cttyp ();
 
+  if (!t)
+    return TRUE;
+
   /* If process group leader is non-cygwin process or not exist,
      send signal to myself. */
   pinfo pi (t->getpgid ());
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index abd62d72a..7646f09cc 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2409,6 +2409,8 @@ class fhandler_pty_slave: public fhandler_pty_common
   static void cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 					  bool stdin_is_ptys);
   void setpgid_aux (pid_t pid);
+  static void close_pseudoconsole_if_necessary (tty *ttyp,
+						fhandler_termios *fh);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index f83770e66..094842038 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -357,6 +357,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	     which the target process is attaching before sending the
 	     CTRL_C_EVENT. After sending the event, reattach to the
 	     console to which the process was previously attached.  */
+	  bool console_exists = fhandler_console::exists ();
 	  pinfo pinfo_resume = pinfo (myself->ppid);
 	  DWORD resume_pid = 0;
 	  if (pinfo_resume)
@@ -364,11 +365,12 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  else
 	    resume_pid = fhandler_pty_common::get_console_process_id
 	      (myself->dwProcessId, false);
-	  if (resume_pid && fh && !fh->is_console ())
+	  if ((!console_exists || resume_pid) && fh && !fh->is_console ())
 	    {
 	      FreeConsole ();
 	      AttachConsole (p->dwProcessId);
-	      init_console_handler (true);
+	      init_console_handler (::cygheap->ctty
+				    && ::cygheap->ctty->is_console ());
 	    }
 	  if (fh && p == myself && being_debugged ())
 	    { /* Avoid deadlock in gdb on console. */
@@ -388,11 +390,19 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
 	      ctrl_c_event_sent = true;
 	    }
-	  if (resume_pid && fh && !fh->is_console ())
+	  if ((!console_exists || resume_pid) && fh && !fh->is_console ())
 	    {
+	      /* If a process on pseudo console is killed by Ctrl-C,
+		 this process may take over the ownership of the
+		 pseudo console because this process attached to it
+		 before sending CTRL_C_EVENT. In this case, closing
+		 pseudo console is necessary. */
+	      fhandler_pty_slave::close_pseudoconsole_if_necessary (ttyp, fh);
 	      FreeConsole ();
-	      AttachConsole (resume_pid);
-	      init_console_handler (true);
+	      if (resume_pid && console_exists)
+		AttachConsole (resume_pid);
+	      init_console_handler (::cygheap->ctty
+				    && ::cygheap->ctty->is_console ());
 	    }
 	  need_discard_input = true;
 	}
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index dde77ccf2..7b099dcb9 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -537,7 +537,8 @@ fhandler_pty_master::accept_input ()
 	resume_pid = pinfo_resume->dwProcessId;
       else
 	resume_pid = get_console_process_id (myself->dwProcessId, false);
-      if (target_pid && resume_pid)
+      bool console_exists = fhandler_console::exists ();
+      if (target_pid && (resume_pid || !console_exists))
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
@@ -546,8 +547,9 @@ fhandler_pty_master::accept_input ()
 	  AttachConsole (target_pid);
 	  cp_to = GetConsoleCP ();
 	  FreeConsole ();
-	  AttachConsole (resume_pid);
-	  init_console_handler (true);
+	  if (resume_pid && console_exists)
+	    AttachConsole (resume_pid);
+	  init_console_handler (false);
 	  release_attach_mutex ();
 	}
       else
@@ -1029,12 +1031,12 @@ fhandler_pty_slave::close ()
   if (!ForceCloseHandle (get_handle_nat ()))
     termios_printf ("CloseHandle (get_handle_nat ()<%p>), %E",
 	get_handle_nat ());
-  if ((unsigned) myself->ctty == FHDEV (DEV_PTYS_MAJOR, get_minor ()))
-    fhandler_console::free_console ();	/* assumes that we are the last pty closer */
   fhandler_pty_common::close ();
   if (!ForceCloseHandle (output_mutex))
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
-  get_ttyp ()->invisible_console_pid = 0;
+  if (get_ttyp ()->invisible_console_pid
+      && !pinfo (get_ttyp ()->invisible_console_pid))
+    get_ttyp ()->invisible_console_pid = 0;
   return 0;
 }
 
@@ -1122,7 +1124,7 @@ pcon_pid_alive (DWORD pid)
 inline static bool
 pcon_pid_self (DWORD pid)
 {
-  return (pid == myself->exec_dwProcessId);
+  return (pid == (myself->exec_dwProcessId ?: myself->dwProcessId));
 }
 
 void
@@ -1240,14 +1242,14 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
 		      FreeConsole ();
 		      AttachConsole (get_ttyp ()->pcon_pid);
-		      init_console_handler (true);
+		      init_console_handler (false);
 		      WaitForSingleObject (input_mutex, mutex_timeout);
 		      transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
 				      input_available_event);
 		      ReleaseMutex (input_mutex);
 		      FreeConsole ();
 		      AttachConsole (resume_pid);
-		      init_console_handler (true);
+		      init_console_handler (false);
 		      CloseHandle (h_pcon_in);
 		    }
 		  CloseHandle (pcon_owner);
@@ -2839,7 +2841,8 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	resume_pid = pinfo_resume->dwProcessId;
       else
 	resume_pid = get_console_process_id (myself->dwProcessId, false);
-      if (target_pid && resume_pid)
+      bool console_exists = fhandler_console::exists ();
+      if (target_pid && (resume_pid || !console_exists))
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
@@ -2848,8 +2851,9 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	  AttachConsole (target_pid);
 	  cp_from = GetConsoleOutputCP ();
 	  FreeConsole ();
-	  AttachConsole (resume_pid);
-	  init_console_handler (true);
+	  if (resume_pid && console_exists)
+	    AttachConsole (resume_pid);
+	  init_console_handler (false);
 	  release_attach_mutex ();
 	}
       else
@@ -3272,7 +3276,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       CloseHandle (pcon_owner);
       FreeConsole ();
       AttachConsole (get_ttyp ()->pcon_pid);
-      init_console_handler (true);
+      init_console_handler (false);
       goto skip_create;
     }
 
@@ -3396,7 +3400,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       /* Attach to pseudo console */
       FreeConsole ();
       AttachConsole (pi.dwProcessId);
-      init_console_handler (true);
+      init_console_handler (false);
 
       /* Terminate helper process */
       SetEvent (goodbye);
@@ -3531,6 +3535,8 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
       /* Search another process which attaches to the pseudo console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
       switch_to = get_console_process_id (current_pid, false, true, true);
+      if (!switch_to)
+	switch_to = get_console_process_id (current_pid, false, true, false);
     }
   if (ttyp->pcon_activated)
     {
@@ -3579,27 +3585,17 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	      ttyp->h_pcon_out = new_pcon_out;
 	      FreeConsole ();
 	      pinfo p (myself->ppid);
-	      if (p)
-		{
-		  if (!AttachConsole (p->dwProcessId))
-		    AttachConsole (ATTACH_PARENT_PROCESS);
-		}
-	      else
+	      if (!p || !AttachConsole (p->dwProcessId))
 		AttachConsole (ATTACH_PARENT_PROCESS);
-	      init_console_handler (true);
+	      init_console_handler (false);
 	    }
 	  else
 	    { /* Close pseudo console */
 	      FreeConsole ();
 	      pinfo p (myself->ppid);
-	      if (p)
-		{
-		  if (!AttachConsole (p->dwProcessId))
-		    AttachConsole (ATTACH_PARENT_PROCESS);
-		}
-	      else
+	      if (!p || !AttachConsole (p->dwProcessId))
 		AttachConsole (ATTACH_PARENT_PROCESS);
-	      init_console_handler (true);
+	      init_console_handler (false);
 	      /* Reconstruct pseudo console handler container here for close */
 	      HPCON_INTERNAL *hp =
 		(HPCON_INTERNAL *) HeapAlloc (GetProcessHeap (), 0,
@@ -3621,14 +3617,9 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	{
 	  FreeConsole ();
 	  pinfo p (myself->ppid);
-	  if (p)
-	    {
-	      if (!AttachConsole (p->dwProcessId))
-		AttachConsole (ATTACH_PARENT_PROCESS);
-	    }
-	  else
+	  if (!p || !AttachConsole (p->dwProcessId))
 	    AttachConsole (ATTACH_PARENT_PROCESS);
-	  init_console_handler (true);
+	  init_console_handler (false);
 	}
     }
   else if (pcon_pid_self (ttyp->pcon_pid))
@@ -3795,7 +3786,7 @@ fhandler_pty_slave::create_invisible_console ()
       /* Detach from console device and create new invisible console. */
       FreeConsole();
       fhandler_console::need_invisible (true);
-      init_console_handler (true);
+      init_console_handler (false);
       get_ttyp ()->need_invisible_console = false;
       get_ttyp ()->invisible_console_pid = myself->pid;
     }
@@ -4102,7 +4093,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	  CloseHandle (pcon_owner);
 	  FreeConsole ();
 	  AttachConsole (get_ttyp ()->pcon_pid);
-	  init_console_handler (true);
+	  init_console_handler (false);
 	  attach_restore = true;
 	}
       WaitForSingleObject (input_mutex, mutex_timeout);
@@ -4112,14 +4103,9 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	{
 	  FreeConsole ();
 	  pinfo p (myself->ppid);
-	  if (p)
-	    {
-	      if (!AttachConsole (p->dwProcessId))
-		AttachConsole (ATTACH_PARENT_PROCESS);
-	    }
-	  else
+	  if (!p || !AttachConsole (p->dwProcessId))
 	    AttachConsole (ATTACH_PARENT_PROCESS);
-	  init_console_handler (true);
+	  init_console_handler (false);
 	}
     }
   ReleaseMutex (pcon_mutex);
@@ -4135,3 +4121,16 @@ fhandler_pty_master::need_send_ctrl_c_event ()
   return !(to_be_read_from_pcon () && get_ttyp ()->pcon_activated
     && get_ttyp ()->pcon_input_state == tty::to_nat);
 }
+
+void
+fhandler_pty_slave::close_pseudoconsole_if_necessary (tty *ttyp,
+						      fhandler_termios *fh)
+{
+  if (fh->get_major () == DEV_PTYM_MAJOR && ttyp->pcon_activated)
+    {
+      fhandler_pty_master *ptym = (fhandler_pty_master *) fh;
+      WaitForSingleObject (ptym->pcon_mutex, INFINITE);
+      close_pseudoconsole (ttyp);
+      ReleaseMutex (ptym->pcon_mutex);
+    }
+}
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 4d7d273ae..edfdffd7c 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1392,7 +1392,8 @@ wait_sig (VOID *)
 	  sig_held = true;
 	  break;
 	case __SIGSETPGRP:
-	  init_console_handler (true);
+	  init_console_handler (::cygheap->ctty
+				&& ::cygheap->ctty->is_console ());
 	  break;
 	case __SIGTHREADEXIT:
 	  {
-- 
2.35.1

