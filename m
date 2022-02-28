Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 7EE593858C83
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 11:56:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7EE593858C83
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21SBtksh003420;
 Mon, 28 Feb 2022 20:55:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21SBtksh003420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646049353;
 bh=SuegZl6wRbgx/irpTqpdjdC+7Y5K0zJX3n7+jfEAVec=;
 h=From:To:Cc:Subject:Date:From;
 b=bDpkc1tF1e3effv5DDAwCD0//dfzHav0uuB9ivDaCxMNHHMHLRE7BwRZ+7aBJhOiE
 7h777XAXYIPnNMqrLNL9P7dwd5jpkQEUqWtx0PdoF22eWhjwysdCq0TEEPzoZ9PZ4A
 Xtqp4TXIkrAsOOkRbdZfxZmJQkzbzdNVTqYqJnqVverM/Ci/tHvLkby/sg3Hh/g2IV
 QlA1ByFF7ecTVYGY9QIuEXZvVIs+d+52QUKzaiKyjaY+V7l+k9ZgZQBSowL3waWubN
 dRbYITAHs+sqaOjS/CKuxji9h/uk7PWVJ0OvpaMNwhCe1Q6A0hvHTDyQiLlyjgWmCJ
 5+Fn2jSNdWiig==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Isolate CTRL_C_EVENTs between ptys.
Date: Mon, 28 Feb 2022 20:55:36 +0900
Message-Id: <20220228115536.1057-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 28 Feb 2022 11:56:17 -0000

- With this patch, unique invisible consoles are created for each pty
  to isolate CTRL_C_EVENTs between ptys. This is necessary by Ctrl-C
  handling in fhandler_termios::process_sigs() for non-cygwin apps
  started in pty if the pseudo console is disabled.
---
 winsup/cygwin/fhandler_termios.cc |  6 ++----
 winsup/cygwin/fhandler_tty.cc     | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 028210d98..f83770e66 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -368,8 +368,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	    {
 	      FreeConsole ();
 	      AttachConsole (p->dwProcessId);
-	      if (::cygheap->ctty && ::cygheap->ctty->is_console ())
-		init_console_handler (true);
+	      init_console_handler (true);
 	    }
 	  if (fh && p == myself && being_debugged ())
 	    { /* Avoid deadlock in gdb on console. */
@@ -393,8 +392,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	    {
 	      FreeConsole ();
 	      AttachConsole (resume_pid);
-	      if (::cygheap->ctty && ::cygheap->ctty->is_console ())
-		init_console_handler (true);
+	      init_console_handler (true);
 	    }
 	  need_discard_input = true;
 	}
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 9855f54eb..dde77ccf2 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -547,6 +547,7 @@ fhandler_pty_master::accept_input ()
 	  cp_to = GetConsoleCP ();
 	  FreeConsole ();
 	  AttachConsole (resume_pid);
+	  init_console_handler (true);
 	  release_attach_mutex ();
 	}
       else
@@ -967,6 +968,12 @@ fhandler_pty_slave::open (int flags, mode_t)
        this behaviour, protection based on attach_mutex does
        not take effect. */
     get_ttyp ()->need_invisible_console = true;
+  else if (_major (myself->ctty) != DEV_CONS_MAJOR
+	   && (!get_ttyp ()->invisible_console_pid
+	       || !pinfo (get_ttyp ()->invisible_console_pid)))
+    /* Create a new invisible console for each pty to isolate
+       CTRL_C_EVENTs between ptys. */
+    get_ttyp ()->need_invisible_console = true;
   else
     fhandler_console::need_invisible ();
 
@@ -1027,6 +1034,7 @@ fhandler_pty_slave::close ()
   fhandler_pty_common::close ();
   if (!ForceCloseHandle (output_mutex))
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
+  get_ttyp ()->invisible_console_pid = 0;
   return 0;
 }
 
@@ -1232,12 +1240,14 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
 		      FreeConsole ();
 		      AttachConsole (get_ttyp ()->pcon_pid);
+		      init_console_handler (true);
 		      WaitForSingleObject (input_mutex, mutex_timeout);
 		      transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
 				      input_available_event);
 		      ReleaseMutex (input_mutex);
 		      FreeConsole ();
 		      AttachConsole (resume_pid);
+		      init_console_handler (true);
 		      CloseHandle (h_pcon_in);
 		    }
 		  CloseHandle (pcon_owner);
@@ -2839,6 +2849,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	  cp_from = GetConsoleOutputCP ();
 	  FreeConsole ();
 	  AttachConsole (resume_pid);
+	  init_console_handler (true);
 	  release_attach_mutex ();
 	}
       else
@@ -3261,6 +3272,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       CloseHandle (pcon_owner);
       FreeConsole ();
       AttachConsole (get_ttyp ()->pcon_pid);
+      init_console_handler (true);
       goto skip_create;
     }
 
@@ -3384,6 +3396,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       /* Attach to pseudo console */
       FreeConsole ();
       AttachConsole (pi.dwProcessId);
+      init_console_handler (true);
 
       /* Terminate helper process */
       SetEvent (goodbye);
@@ -3573,6 +3586,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 		}
 	      else
 		AttachConsole (ATTACH_PARENT_PROCESS);
+	      init_console_handler (true);
 	    }
 	  else
 	    { /* Close pseudo console */
@@ -3585,6 +3599,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 		}
 	      else
 		AttachConsole (ATTACH_PARENT_PROCESS);
+	      init_console_handler (true);
 	      /* Reconstruct pseudo console handler container here for close */
 	      HPCON_INTERNAL *hp =
 		(HPCON_INTERNAL *) HeapAlloc (GetProcessHeap (), 0,
@@ -3613,6 +3628,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	    }
 	  else
 	    AttachConsole (ATTACH_PARENT_PROCESS);
+	  init_console_handler (true);
 	}
     }
   else if (pcon_pid_self (ttyp->pcon_pid))
@@ -3779,6 +3795,7 @@ fhandler_pty_slave::create_invisible_console ()
       /* Detach from console device and create new invisible console. */
       FreeConsole();
       fhandler_console::need_invisible (true);
+      init_console_handler (true);
       get_ttyp ()->need_invisible_console = false;
       get_ttyp ()->invisible_console_pid = myself->pid;
     }
@@ -4085,6 +4102,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	  CloseHandle (pcon_owner);
 	  FreeConsole ();
 	  AttachConsole (get_ttyp ()->pcon_pid);
+	  init_console_handler (true);
 	  attach_restore = true;
 	}
       WaitForSingleObject (input_mutex, mutex_timeout);
@@ -4101,6 +4119,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	    }
 	  else
 	    AttachConsole (ATTACH_PARENT_PROCESS);
+	  init_console_handler (true);
 	}
     }
   ReleaseMutex (pcon_mutex);
-- 
2.35.1

