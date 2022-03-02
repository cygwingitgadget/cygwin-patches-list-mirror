Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 94C853858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 12:59:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 94C853858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 222CxYLh007744;
 Wed, 2 Mar 2022 21:59:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 222CxYLh007744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646225980;
 bh=sUaEPTL46dml0/UHvCmUN+bHHwtTTUC7Y3wsCR4fo44=;
 h=From:To:Cc:Subject:Date:From;
 b=AFjfxE7P/G0roL7QUlugfrvjwvpPMu5rD/QwK1H9MFeZIu66GYjKM/3xJhpZn5xyo
 cFbq1fl8zATdrbgAWuOB5BNTw6dNCdTZx07zFebW2YP2I4oXS/3rjs6OJab5omtBAr
 VH3WyTBK+Cw16I4lA53aerHzve60bUCe/3U/3JvWb3beEaz/5bbE7kO+3cHT51TWlJ
 DrlK/hQ8G65VSdKTb2++zYGTfD5ZS36J2AfFJ4OZTx/jgilQPsuTFGsTUd8xArfMxs
 fDayNcK88GNBqYRUTLrHQTQUxehYtp5hjroneGlEuqd7Y8tcvwc89/UnhU4DjNK8il
 Py1f74PFlH8VQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Communalize the code for temporary attach to
 console.
Date: Wed,  2 Mar 2022 21:59:26 +0900
Message-Id: <20220302125926.1524-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 02 Mar 2022 13:00:08 -0000

- This patch communalizes the code for attaching another console
  temporarily and resuming to the original attach state, because
  there were a plurality of similar codes throughout.
---
 winsup/cygwin/fhandler.h          |   2 +
 winsup/cygwin/fhandler_termios.cc |  27 ++-----
 winsup/cygwin/fhandler_tty.cc     | 128 ++++++++++++++----------------
 3 files changed, 66 insertions(+), 91 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index fbe7135b1..c32dc7b57 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2321,6 +2321,8 @@ class fhandler_pty_common: public fhandler_termios
 				       bool cygwin = false,
 				       bool stub_only = false);
   bool to_be_read_from_nat_pipe (void);
+  static DWORD attach_console_temporarily (DWORD target_pid);
+  static void resume_from_temporarily_attach (DWORD resume_pid);
 
  protected:
   static BOOL process_opost_output (HANDLE h, const void *ptr, ssize_t& len,
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 3767c6405..3740ba011 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -357,22 +357,10 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	     which the target process is attaching before sending the
 	     CTRL_C_EVENT. After sending the event, reattach to the
 	     console to which the process was previously attached.  */
-	  bool console_exists = fhandler_console::exists ();
-	  pinfo pinfo_resume = pinfo (myself->ppid);
 	  DWORD resume_pid = 0;
-	  if (pinfo_resume)
-	    resume_pid = pinfo_resume->dwProcessId;
-	  else
-	    resume_pid = fhandler_pty_common::get_console_process_id
-	      (myself->dwProcessId, false);
-	  acquire_attach_mutex (mutex_timeout);
-	  if ((!console_exists || resume_pid) && fh && !fh->is_console ())
-	    {
-	      FreeConsole ();
-	      AttachConsole (p->dwProcessId);
-	      init_console_handler (::cygheap->ctty
-				    && ::cygheap->ctty->is_console ());
-	    }
+	  if (fh && !fh->is_console ())
+	    resume_pid =
+	      fhandler_pty_common::attach_console_temporarily (p->dwProcessId);
 	  if (fh && p == myself && being_debugged ())
 	    { /* Avoid deadlock in gdb on console. */
 	      fh->tcflush(TCIFLUSH);
@@ -391,7 +379,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
 	      ctrl_c_event_sent = true;
 	    }
-	  if ((!console_exists || resume_pid) && fh && !fh->is_console ())
+	  if (fh && !fh->is_console ())
 	    {
 	      /* If a process on pseudo console is killed by Ctrl-C,
 		 this process may take over the ownership of the
@@ -399,13 +387,8 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 		 before sending CTRL_C_EVENT. In this case, closing
 		 pseudo console is necessary. */
 	      fhandler_pty_slave::release_ownership_of_nat_pipe (ttyp, fh);
-	      FreeConsole ();
-	      if (resume_pid && console_exists)
-		AttachConsole (resume_pid);
-	      init_console_handler (::cygheap->ctty
-				    && ::cygheap->ctty->is_console ());
+	      fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
 	    }
-	  release_attach_mutex ();
 	  need_discard_input = true;
 	}
       if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a2a9eab99..433861bb4 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -530,26 +530,13 @@ fhandler_pty_master::accept_input ()
       DWORD target_pid = 0;
       if (pinfo_target)
 	target_pid = pinfo_target->dwProcessId;
-      pinfo pinfo_resume = pinfo (myself->ppid);
-      DWORD resume_pid;
-      if (pinfo_resume)
-	resume_pid = pinfo_resume->dwProcessId;
-      else
-	resume_pid = get_console_process_id (myself->dwProcessId, false);
-      bool console_exists = fhandler_console::exists ();
-      if (target_pid && (resume_pid || !console_exists))
+      if (target_pid)
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  acquire_attach_mutex (mutex_timeout);
-	  FreeConsole ();
-	  AttachConsole (target_pid);
+	  DWORD resume_pid = attach_console_temporarily (target_pid);
 	  cp_to = GetConsoleCP ();
-	  FreeConsole ();
-	  if (resume_pid && console_exists)
-	    AttachConsole (resume_pid);
-	  init_console_handler (false);
-	  release_attach_mutex ();
+	  resume_from_temporarily_attach (resume_pid);
 	}
       else
 	cp_to = GetConsoleCP ();
@@ -1231,33 +1218,18 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 					   get_ttyp ()->nat_pipe_owner_pid);
 	      if (pcon_owner)
 		{
-		  pinfo pinfo_resume = pinfo (myself->ppid);
-		  DWORD resume_pid;
-		  if (pinfo_resume)
-		    resume_pid = pinfo_resume->dwProcessId;
-		  else
-		    resume_pid =
-		      get_console_process_id (myself->dwProcessId, false);
-		  if (resume_pid)
-		    {
-		      HANDLE h_pcon_in;
-		      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
-				       GetCurrentProcess (), &h_pcon_in,
-				       0, TRUE, DUPLICATE_SAME_ACCESS);
-		      acquire_attach_mutex (mutex_timeout);
-		      FreeConsole ();
-		      AttachConsole (get_ttyp ()->nat_pipe_owner_pid);
-		      init_console_handler (false);
-		      WaitForSingleObject (input_mutex, mutex_timeout);
-		      transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
-				      input_available_event);
-		      ReleaseMutex (input_mutex);
-		      FreeConsole ();
-		      AttachConsole (resume_pid);
-		      init_console_handler (false);
-		      release_attach_mutex ();
-		      CloseHandle (h_pcon_in);
-		    }
+		  HANDLE h_pcon_in;
+		  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+				   GetCurrentProcess (), &h_pcon_in,
+				   0, TRUE, DUPLICATE_SAME_ACCESS);
+		  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
+		  DWORD resume_pid = attach_console_temporarily (target_pid);
+		  WaitForSingleObject (input_mutex, mutex_timeout);
+		  transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
+				  input_available_event);
+		  ReleaseMutex (input_mutex);
+		  resume_from_temporarily_attach (resume_pid);
+		  CloseHandle (h_pcon_in);
 		  CloseHandle (pcon_owner);
 		}
 	    }
@@ -2853,26 +2825,13 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
       DWORD target_pid = 0;
       if (pinfo_target)
 	target_pid = pinfo_target->dwProcessId;
-      pinfo pinfo_resume = pinfo (myself->ppid);
-      DWORD resume_pid;
-      if (pinfo_resume)
-	resume_pid = pinfo_resume->dwProcessId;
-      else
-	resume_pid = get_console_process_id (myself->dwProcessId, false);
-      bool console_exists = fhandler_console::exists ();
-      if (target_pid && (resume_pid || !console_exists))
+      if (target_pid)
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  acquire_attach_mutex (mutex_timeout);
-	  FreeConsole ();
-	  AttachConsole (target_pid);
+	  DWORD resume_pid = attach_console_temporarily (target_pid);
 	  cp_from = GetConsoleOutputCP ();
-	  FreeConsole ();
-	  if (resume_pid && console_exists)
-	    AttachConsole (resume_pid);
-	  init_console_handler (false);
-	  release_attach_mutex ();
+	  resume_from_temporarily_attach (resume_pid);
 	}
       else
 	cp_from = GetConsoleOutputCP ();
@@ -4130,6 +4089,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
     {
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
+      DWORD resume_pid = 0;
       if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
 	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
 	{
@@ -4139,22 +4099,15 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 			   GetCurrentProcess (), &from,
 			   0, TRUE, DUPLICATE_SAME_ACCESS);
 	  CloseHandle (pcon_owner);
-	  FreeConsole ();
-	  AttachConsole (get_ttyp ()->nat_pipe_owner_pid);
-	  init_console_handler (false);
+	  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
+	  resume_pid = attach_console_temporarily (target_pid);
 	  attach_restore = true;
 	}
       WaitForSingleObject (input_mutex, mutex_timeout);
       transfer_input (tty::to_cyg, from, get_ttyp (), input_available_event);
       ReleaseMutex (input_mutex);
       if (attach_restore)
-	{
-	  FreeConsole ();
-	  pinfo p (myself->ppid);
-	  if (!p || !AttachConsole (p->dwProcessId))
-	    AttachConsole (ATTACH_PARENT_PROCESS);
-	  init_console_handler (false);
-	}
+	resume_from_temporarily_attach (resume_pid);
     }
   ReleaseMutex (pipe_sw_mutex);
 }
@@ -4187,3 +4140,40 @@ fhandler_pty_slave::release_ownership_of_nat_pipe (tty *ttyp,
       ReleaseMutex (ptym->pipe_sw_mutex);
     }
 }
+
+DWORD
+fhandler_pty_common::attach_console_temporarily (DWORD target_pid)
+{
+  DWORD resume_pid = 0;
+  pinfo pinfo_resume (myself->ppid);
+  if (pinfo_resume)
+    resume_pid = pinfo_resume->dwProcessId;
+  if (!resume_pid)
+    resume_pid = get_console_process_id (myself->dwProcessId, false);
+  bool console_exists = fhandler_console::exists ();
+  acquire_attach_mutex (mutex_timeout);
+  if (!console_exists || resume_pid)
+    {
+      FreeConsole ();
+      AttachConsole (target_pid);
+      init_console_handler (::cygheap->ctty
+			    && ::cygheap->ctty->is_console ());
+    }
+  return console_exists ? resume_pid : (DWORD) -1;
+}
+
+void
+fhandler_pty_common::resume_from_temporarily_attach (DWORD resume_pid)
+{
+  bool console_exists = (resume_pid != (DWORD) -1);
+  if (!console_exists || resume_pid)
+    {
+      FreeConsole ();
+      if (console_exists)
+	if (!resume_pid || !AttachConsole (resume_pid))
+	  AttachConsole (ATTACH_PARENT_PROCESS);
+      init_console_handler (::cygheap->ctty
+			    && ::cygheap->ctty->is_console ());
+    }
+  release_attach_mutex ();
+}
-- 
2.35.1

