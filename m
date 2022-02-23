Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 01AD53858407
 for <cygwin-patches@cygwin.com>; Wed, 23 Feb 2022 17:47:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 01AD53858407
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21NHkkFK016456;
 Thu, 24 Feb 2022 02:46:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21NHkkFK016456
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645638411;
 bh=sMVQ6TcDj5e9bzH5N4++4p200hc9WBUZoctcCNovFJE=;
 h=From:To:Cc:Subject:Date:From;
 b=mf3jij6d8vJ4gu/b3EgkA8quIjvgL9kVQA0LXvJbhVA/RD997Tjwr2vP+RbK/d8Px
 nVryAnKx9oy3f/dAw3IB13gcB5iDcZTwltNpDfEAhQBO2chV3t6EWvABgp+nfVuX94
 Zz9wg0T203ZzES7EffJiWVkpKE53xO+3lx2hi9eVzlPfxS9GkyRw/ntAv7QV50Q13z
 l54HMcH4qq3lxEkXzfcWy8gvVecDSWRTUYPn1NzcoQ8xFUtZUxBrUB4cyYCioHU/p4
 A1GHotRAgCz2EYIcycsNuIgIRfYqg2tgpa1BKEldnGl5AQ2MN0puLLWoKJ7de1x1Ta
 LvtTqmlFCLWGw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Redesign handling of special keys.
Date: Thu, 24 Feb 2022 02:46:40 +0900
Message-Id: <20220223174640.35897-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
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
X-List-Received-Date: Wed, 23 Feb 2022 17:47:19 -0000

- This patch rearranges the cooperation between cons_master_thread,
  line_edit, and ctrl_c_handler so that only one of them operates
  at the same time. Since these handle Ctrl-C individually, so the
  signal may be sent multiple times to the process. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler.h          |  7 +++--
 winsup/cygwin/fhandler_console.cc | 49 +++++++++++++++++++------------
 winsup/cygwin/fhandler_termios.cc | 29 ++++++++++--------
 winsup/cygwin/sigproc.cc          |  3 +-
 4 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index f54eae4c9..b252b6e1c 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1906,7 +1906,7 @@ class fhandler_termios: public fhandler_base
     signalled,
     not_signalled,
     not_signalled_but_done,
-    not_signalled_with_cyg_reader
+    not_signalled_with_nat_reader
   };
 
  public:
@@ -1954,9 +1954,9 @@ class fhandler_termios: public fhandler_base
   }
   static bool path_iscygexec_a (LPCSTR n, LPSTR c);
   static bool path_iscygexec_w (LPCWSTR n, LPWSTR c);
-  virtual bool is_pty_master_with_pcon () { return false; }
   virtual void cleanup_before_exit () {}
   virtual void setpgid_aux (pid_t pid) {}
+  virtual bool need_console_handler () { return false; }
 };
 
 enum ansi_intensity
@@ -2061,6 +2061,7 @@ class dev_console
   char cons_rabuf[40];  // cannot get longer than char buf[40] in char_command
   char *cons_rapoi;
   bool cursor_key_app_mode;
+  bool disable_master_thread;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
@@ -2253,6 +2254,7 @@ private:
   void setup_for_non_cygwin_app ();
   static void cleanup_for_non_cygwin_app (handle_set_t *p);
   static void set_console_mode_to_native ();
+  bool need_console_handler ();
 
   friend tty_min * tty_list::get_cttyp ();
 };
@@ -2489,7 +2491,6 @@ public:
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   void set_mask_flusho (bool m) { get_ttyp ()->mask_flusho = m; }
-  bool is_pty_master_with_pcon () { return get_ttyp ()->pcon_activated; }
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index ec33a9d3c..a7516f238 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -195,21 +195,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       DWORD total_read, n, i;
       INPUT_RECORD input_rec[INREC_SIZE];
 
-      bool nat_fg = false;
-      bool nat_child_fg = false;
-      winpids pids ((DWORD) 0);
-      for (unsigned i = 0; i < pids.npids; i++)
-	{
-	  _pinfo *pi = pids[i];
-	  if (pi && pi->ctty == ttyp->ntty && pi->pgid == ttyp->getpgid ()
-	      && (pi->process_state & PID_NOTCYGWIN)
-	      && !(pi->process_state & PID_NEW_PG))
-	    nat_fg = true;
-	  if (pi && pi->ctty == ttyp->ntty && pi->pgid == ttyp->getpgid ()
-	      && !(pi->process_state & PID_CYGPARENT))
-	    nat_child_fg = true;
-	}
-      if (nat_fg && !nat_child_fg)
+      if (con.disable_master_thread)
 	{
 	  cygwait (40);
 	  continue;
@@ -403,6 +389,7 @@ fhandler_console::setup ()
       con.cons_rapoi = NULL;
       shared_console_info->tty_min_state.is_console = true;
       con.cursor_key_app_mode = false;
+      con.disable_master_thread = true;
     }
 }
 
@@ -519,6 +506,7 @@ fhandler_console::setup_for_non_cygwin_app ()
     (get_ttyp ()->getpgid ()== myself->pgid) ? tty::native : tty::restore;
   set_input_mode (conmode, &tc ()->ti, get_handle_set ());
   set_output_mode (conmode, &tc ()->ti, get_handle_set ());
+  con.disable_master_thread = true;
 }
 
 void
@@ -534,6 +522,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     (con.owner == myself->pid) ? tty::restore : tty::cygwin;
   set_output_mode (conmode, ti, p);
   set_input_mode (conmode, ti, p);
+  con.disable_master_thread = (con.owner == myself->pid);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -707,7 +696,14 @@ fhandler_console::bg_check (int sig, bool dontsignal)
      cygwin app and other non-cygwin apps are started simultaneously
      in the same process group. */
   if (sig == SIGTTIN)
-    set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+    {
+      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+      if (con.disable_master_thread)
+	{
+	  con.disable_master_thread = false;
+	  init_console_handler (false);
+	}
+    }
   if (sig == SIGTTOU)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
 
@@ -1409,8 +1405,7 @@ bool
 fhandler_console::open_setup (int flags)
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
-  if (myself->set_ctty (this, flags) && !myself->cygstarted)
-    init_console_handler (true);
+  myself->set_ctty (this, flags);
   return fhandler_base::open_setup (flags);
 }
 
@@ -1419,10 +1414,15 @@ fhandler_console::post_open_setup (int fd)
 {
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
   if (fd == 0)
-    set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+    {
+      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+      con.disable_master_thread = false;
+    }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
 
+  init_console_handler (need_console_handler ());
+
   fhandler_base::post_open_setup (fd);
 }
 
@@ -1446,6 +1446,7 @@ fhandler_console::close ()
 	  /* Cleaning-up console mode for cygwin apps. */
 	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
 	  set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
+	  con.disable_master_thread = true;
 	}
     }
 
@@ -3617,6 +3618,7 @@ fhandler_console::set_console_mode_to_native ()
 	    termios *cons_ti = &cons->tc ()->ti;
 	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
 	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
+	    con.disable_master_thread = true;
 	    break;
 	  }
       }
@@ -3639,6 +3641,7 @@ CreateProcessA_Hooked
   gdb_inferior_noncygwin = !fhandler_termios::path_iscygexec_a (n, c);
   if (gdb_inferior_noncygwin)
     fhandler_console::set_console_mode_to_native ();
+  init_console_handler (false);
   return CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
@@ -3653,6 +3656,7 @@ CreateProcessW_Hooked
   gdb_inferior_noncygwin = !fhandler_termios::path_iscygexec_w (n, c);
   if (gdb_inferior_noncygwin)
     fhandler_console::set_console_mode_to_native ();
+  init_console_handler (false);
   return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
@@ -3662,6 +3666,7 @@ ContinueDebugEvent_Hooked
 {
   if (gdb_inferior_noncygwin)
     fhandler_console::set_console_mode_to_native ();
+  init_console_handler (false);
   return ContinueDebugEvent_Orig (p, t, s);
 }
 
@@ -3929,3 +3934,9 @@ fhandler_console::close_handle_set (handle_set_t *p)
   CloseHandle (p->output_mutex);
   p->output_mutex = NULL;
 }
+
+bool
+fhandler_console::need_console_handler ()
+{
+  return con.disable_master_thread;
+}
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 46c861928..953aeade0 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -315,8 +315,6 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
   termios &ti = ttyp->ti;
   pid_t pgid = ttyp->pgid;
 
-  pinfo leader (pgid);
-  bool cyg_leader = leader && !(leader->process_state & PID_NOTCYGWIN);
   bool ctrl_c_event_sent = false;
   bool need_discard_input = false;
   bool pg_with_nat = false;
@@ -344,24 +342,31 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      FreeConsole ();
 	      AttachConsole (p->dwProcessId);
 	    }
+	  if (fh && p == myself)
+	    { /* Avoid deadlock in gdb on console. */
+	      fh->tcflush(TCIFLUSH);
+	      fh->release_input_mutex_if_necessary ();
+	    }
 	  /* CTRL_C_EVENT does not work for the process started with
 	     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
 	     instead. */
 	  if (p->process_state & PID_NEW_PG)
-	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
-				      p->dwProcessId);
-	  else if ((!fh || !fh->is_pty_master_with_pcon () || cyg_leader)
-		   && !ctrl_c_event_sent)
+	    {
+	      GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
+					p->dwProcessId);
+	      need_discard_input = true;
+	    }
+	  else if (!ctrl_c_event_sent)
 	    {
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
 	      ctrl_c_event_sent = true;
+	      need_discard_input = true;
 	    }
 	  if (resume_pid && fh && !fh->is_console ())
 	    {
 	      FreeConsole ();
 	      AttachConsole (resume_pid);
 	    }
-	  need_discard_input = true;
 	}
       if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
 	{
@@ -426,8 +431,8 @@ not_a_sig:
       ti.c_lflag &= ~FLUSHO;
       return not_signalled_but_done;
     }
-  bool to_cyg = cyg_reader || !pg_with_nat;
-  return to_cyg ? not_signalled_with_cyg_reader : not_signalled;
+  bool to_nat = !cyg_reader && pg_with_nat;
+  return to_nat ? not_signalled_with_nat_reader : not_signalled;
 }
 
 bool
@@ -479,7 +484,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 
       if (ti.c_iflag & ISTRIP)
 	c &= 0x7f;
-      bool disable_eof_key = true;
+      bool disable_eof_key = false;
       switch (process_sigs (c, get_ttyp (), this))
 	{
 	case signalled:
@@ -488,8 +493,8 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	case not_signalled_but_done:
 	  get_ttyp ()->output_stopped = false;
 	  continue;
-	case not_signalled_with_cyg_reader:
-	  disable_eof_key = false;
+	case not_signalled_with_nat_reader:
+	  disable_eof_key = true;
 	  break;
 	default: /* Not signalled */
 	  break;
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 4d7d273ae..16ea5031b 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1392,7 +1392,8 @@ wait_sig (VOID *)
 	  sig_held = true;
 	  break;
 	case __SIGSETPGRP:
-	  init_console_handler (true);
+	  if (::cygheap->ctty)
+	    init_console_handler (::cygheap->ctty->need_console_handler ());
 	  break;
 	case __SIGTHREADEXIT:
 	  {
-- 
2.35.1

