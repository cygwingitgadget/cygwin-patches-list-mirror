Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 5E7553858D35
 for <cygwin-patches@cygwin.com>; Sun, 20 Feb 2022 11:15:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5E7553858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 21KBFKKi028350;
 Sun, 20 Feb 2022 20:15:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21KBFKKi028350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645355725;
 bh=rE3ri9Q0XVa/LI/W7pY6WaPIN2sJ2Aoo/bv6zStWUxg=;
 h=From:To:Cc:Subject:Date:From;
 b=ZRx/+V0B8pGKIPj9NKhhtA2utf7T1r0zrN0rPeWSxyF+0SkYsygGBaSyVIgOte1Jc
 JNYgQHUop3GmiETzu/Eeeisfet8sihyx4ykySpt75rAdmsUbk96bYv1/QT2+M9BUdi
 FspnA8DojHdRypf2C5G9s637HenCyiEmo/ALBQHnhFZa43E+fx3rXC//blO3MWltMM
 Tdmvmn8wwIxzYiQmWIR394CS1MVUnwxZEi+KkRX70uFxq1Dsac25TsztRxyl2nDV3F
 VT0/ZUEYpOq+J0XCmejSBUiT3ojjHCRvauGNlmi66RsyMMjGjX+AldsMzbC8xvBt7w
 aeNKOA+PpQiug==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty,
 console: Refactor the code processing special keys.
Date: Sun, 20 Feb 2022 20:15:10 +0900
Message-Id: <20220220111510.978-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 20 Feb 2022 11:15:47 -0000

- This patch commonize the code which processes special keys in pty
  and console to improve maintanancibility. As a result, some small
  bugs have been fixed.
---
 winsup/cygwin/dtable.cc           |   1 +
 winsup/cygwin/exceptions.cc       |  15 ++
 winsup/cygwin/fhandler.h          |  17 +-
 winsup/cygwin/fhandler_console.cc | 135 ++++++----------
 winsup/cygwin/fhandler_termios.cc | 259 +++++++++++++++++++-----------
 winsup/cygwin/fhandler_tty.cc     |  55 ++-----
 winsup/cygwin/tty.h               |   2 +-
 7 files changed, 264 insertions(+), 220 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index e54db4446..44d6e11a9 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -422,6 +422,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
       cygheap->fdtab[fd]->inc_refcnt ();
       set_std_handle (fd);
       paranoid_printf ("fd %d, handle %p", fd, handle);
+      fh->post_open_setup (fd);
     }
 }
 
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a914110fe..356d69d6a 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1147,6 +1147,19 @@ ctrl_c_handler (DWORD type)
     return TRUE;
 
   tty_min *t = cygwin_shared->tty.get_cttyp ();
+
+  /* If process group leader is non-cygwin process or not exist,
+     send signal to myself. */
+  pinfo pi (t->getpgid ());
+  if ((!pi || (pi->process_state & PID_NOTCYGWIN))
+      && (!have_execed || have_execed_cygwin)
+      && t->getpgid () == myself->pgid
+      && type == CTRL_C_EVENT)
+    {
+      t->output_stopped = false;
+      sig_send(myself, SIGINT);
+    }
+
   /* Ignore this if we're not the process group leader since it should be
      handled *by* the process group leader. */
   if (t && (!have_execed || have_execed_cygwin)
@@ -1556,6 +1569,8 @@ dosig:
   if (have_execed)
     {
       sigproc_printf ("terminating captive process");
+      if (::cygheap->ctty)
+	::cygheap->ctty->cleanup_before_exit ();
       TerminateProcess (ch_spawn, sigExeced = si.si_signo);
     }
   /* Dispatch to the appropriate function. */
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4e86ab58a..3e0d7d5a6 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -356,6 +356,7 @@ class fhandler_base
   virtual int open (int, mode_t);
   virtual fhandler_base *fd_reopen (int, mode_t);
   virtual bool open_setup (int flags);
+  virtual void post_open_setup (int fd) {}
   void set_unique_id (int64_t u) { unique_id = u; }
   void set_unique_id () { NtAllocateLocallyUniqueId ((PLUID) &unique_id); }
 
@@ -1901,6 +1902,13 @@ class fhandler_termios: public fhandler_base
   virtual void release_input_mutex_if_necessary (void) {};
   virtual void discard_input () {};
 
+  enum process_sig_state {
+    signalled,
+    not_signalled,
+    not_signalled_but_done,
+    not_signalled_with_cyg_reader
+  };
+
  public:
   tty_min*& tc () {return _tc;}
   fhandler_termios () :
@@ -1910,6 +1918,9 @@ class fhandler_termios: public fhandler_base
   }
   HANDLE& get_output_handle () { return output_handle; }
   HANDLE& get_output_handle_nat () { return output_handle; }
+  static process_sig_state process_sigs (char c, tty *ttyp,
+					 fhandler_termios *fh);
+  static bool process_stop_start (char c, tty *ttyp, bool on_ixany);
   line_edit_status line_edit (const char *rptr, size_t nread, termios&,
 			      ssize_t *bytes_read = NULL);
   void set_output_handle (HANDLE h) { output_handle = h; }
@@ -1943,6 +1954,8 @@ class fhandler_termios: public fhandler_base
   }
   static bool path_iscygexec_a (LPCSTR n, LPSTR c);
   static bool path_iscygexec_w (LPCWSTR n, LPWSTR c);
+  virtual bool is_pty_master_with_pcon () { return false; }
+  virtual void cleanup_before_exit () {}
 };
 
 enum ansi_intensity
@@ -2047,7 +2060,6 @@ class dev_console
   char cons_rabuf[40];  // cannot get longer than char buf[40] in char_command
   char *cons_rapoi;
   bool cursor_key_app_mode;
-  bool disable_master_thread;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
@@ -2146,6 +2158,7 @@ private:
 
   int open (int flags, mode_t mode);
   bool open_setup (int flags);
+  void post_open_setup (int fd);
   int dup (fhandler_base *, int);
 
   void __reg3 read (void *ptr, size_t& len);
@@ -2369,6 +2382,7 @@ class fhandler_pty_slave: public fhandler_pty_common
 			      HANDLE input_available_event);
   HANDLE get_input_available_event (void) { return input_available_event; }
   bool pcon_activated (void) { return get_ttyp ()->pcon_activated; }
+  void cleanup_before_exit ();
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
@@ -2456,6 +2470,7 @@ public:
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   void set_mask_flusho (bool m) { get_ttyp ()->mask_flusho = m; }
+  bool is_pty_master_with_pcon () { return get_ttyp ()->pcon_activated; }
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 50f350c49..475c1acdb 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -188,13 +188,28 @@ cons_master_thread (VOID *arg)
 void
 fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 {
+  termios &ti = ttyp->ti;
   DWORD output_stopped_at = 0;
   while (con.owner == myself->pid)
     {
       DWORD total_read, n, i;
       INPUT_RECORD input_rec[INREC_SIZE];
 
-      if (con.disable_master_thread)
+      bool nat_fg = false;
+      bool nat_child_fg = false;
+      winpids pids ((DWORD) 0);
+      for (unsigned i = 0; i < pids.npids; i++)
+	{
+	  _pinfo *pi = pids[i];
+	  if (pi && pi->ctty == ttyp->ntty && pi->pgid == ttyp->getpgid ()
+	      && (pi->process_state & PID_NOTCYGWIN)
+	      && !(pi->process_state & PID_NEW_PG))
+	    nat_fg = true;
+	  if (pi && pi->ctty == ttyp->ntty && pi->pgid == ttyp->getpgid ()
+	      && !(pi->process_state & PID_CYGPARENT))
+	    nat_child_fg = true;
+	}
+      if (nat_fg && !nat_child_fg)
 	{
 	  cygwait (40);
 	  continue;
@@ -233,90 +248,35 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	}
       for (i = 0; i < total_read; i++)
 	{
-	  const wchar_t wc = input_rec[i].Event.KeyEvent.uChar.UnicodeChar;
-	  if ((wint_t) wc >= 0x80)
-	    continue;
-	  char c = (char) wc;
+	  wchar_t wc;
+	  char c;
+	  bool was_output_stopped;
 	  bool processed = false;
-	  termios &ti = ttyp->ti;
-	  pinfo pi (ttyp->getpgid ());
-	  if (pi && pi->ctty == ttyp->ntty
-	      && (pi->process_state & PID_NOTCYGWIN)
-	      && input_rec[i].EventType == KEY_EVENT && c == '\003')
-	    {
-	      bool not_a_sig = false;
-	      if (!CCEQ (ti.c_cc[VINTR], c)
-		  && !CCEQ (ti.c_cc[VQUIT], c)
-		  && !CCEQ (ti.c_cc[VSUSP], c))
-		not_a_sig = true;
-	      if (input_rec[i].Event.KeyEvent.bKeyDown)
-		{
-		  /* CTRL_C_EVENT does not work for the process started with
-		     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
-		     instead. */
-		  if (pi->process_state & PID_NEW_PG)
-		    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
-					      pi->dwProcessId);
-		  else
-		    GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
-		  if (not_a_sig)
-		    goto skip_writeback;
-		}
-	      processed = true;
-	      if (not_a_sig)
-		goto remove_record;
-	    }
 	  switch (input_rec[i].EventType)
 	    {
 	    case KEY_EVENT:
-	      if (ti.c_lflag & ISIG)
-		{
-		  int sig = 0;
-		  if (CCEQ (ti.c_cc[VINTR], c))
-		    sig = SIGINT;
-		  else if (CCEQ (ti.c_cc[VQUIT], c))
-		    sig = SIGQUIT;
-		  else if (CCEQ (ti.c_cc[VSUSP], c))
-		    sig = SIGTSTP;
-		  if (sig && input_rec[i].Event.KeyEvent.bKeyDown)
-		    {
-		      ttyp->kill_pgrp (sig);
-		      ttyp->output_stopped = false;
-		      ti.c_lflag &= ~FLUSHO;
-		      /* Discard type ahead input */
-		      goto skip_writeback;
-		    }
-		}
-	      if (ti.c_iflag & IXON)
-		{
-		  if (CCEQ (ti.c_cc[VSTOP], c))
-		    {
-		      if (!ttyp->output_stopped
-			  && input_rec[i].Event.KeyEvent.bKeyDown)
-			{
-			  ttyp->output_stopped = true;
-			  output_stopped_at = i;
-			}
-		      processed = true;
-		    }
-		  else if (CCEQ (ti.c_cc[VSTART], c))
-		    {
-		restart_output:
-		      if (input_rec[i].Event.KeyEvent.bKeyDown)
-			ttyp->output_stopped = false;
-		      processed = true;
-		    }
-		  else if ((ti.c_iflag & IXANY) && ttyp->output_stopped
-			   && c && i >= output_stopped_at)
-		    goto restart_output;
-		}
-	      if ((ti.c_lflag & ICANON) && (ti.c_lflag & IEXTEN)
-		  && CCEQ (ti.c_cc[VDISCARD], c))
+	      if (!input_rec[i].Event.KeyEvent.bKeyDown)
+		continue;
+	      wc = input_rec[i].Event.KeyEvent.uChar.UnicodeChar;
+	      if (!wc || (wint_t) wc >= 0x80)
+		continue;
+	      c = (char) wc;
+	      switch (process_sigs (c, ttyp, NULL))
 		{
-		  if (input_rec[i].Event.KeyEvent.bKeyDown)
-		    ti.c_lflag ^= FLUSHO;
+		case signalled:
+		case not_signalled_but_done:
 		  processed = true;
+		  ttyp->output_stopped = false;
+		  if (ti.c_lflag & NOFLSH)
+		    goto remove_record;
+		  goto skip_writeback;
+		default: /* not signalled */
+		  break;
 		}
+	      was_output_stopped = ttyp->output_stopped;
+	      processed = process_stop_start (c, ttyp, i > output_stopped_at);
+	      if (!was_output_stopped && ttyp->output_stopped)
+		output_stopped_at = i;
 	      break;
 	    case WINDOW_BUFFER_SIZE_EVENT:
 	      SHORT y = con.dwWinSize.Y;
@@ -447,7 +407,6 @@ fhandler_console::setup ()
       con.cons_rapoi = NULL;
       shared_console_info->tty_min_state.is_console = true;
       con.cursor_key_app_mode = false;
-      con.disable_master_thread = false;
     }
 }
 
@@ -503,8 +462,6 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
       else
 	flags |= ENABLE_MOUSE_INPUT;
-      if (shared_console_info)
-	con.disable_master_thread = false;
       break;
     case tty::native:
       if (t->c_lflag & ECHO)
@@ -517,8 +474,6 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 	flags &= ~ENABLE_ECHO_INPUT;
       if (t->c_lflag & ISIG)
 	flags |= ENABLE_PROCESSED_INPUT;
-      if (shared_console_info)
-	con.disable_master_thread = true;
       break;
     }
   SetConsoleMode (p->input_handle, flags);
@@ -1394,9 +1349,6 @@ fhandler_console::open (int flags, mode_t)
 	setenv ("TERM", "cygwin", 1);
     }
 
-  set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-  set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
 
@@ -1421,6 +1373,17 @@ fhandler_console::open_setup (int flags)
   return fhandler_base::open_setup (flags);
 }
 
+void
+fhandler_console::post_open_setup (int fd)
+{
+  if (fd == 0)
+    set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+  else if (fd == 1 || fd == 2)
+    set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+
+  fhandler_base::post_open_setup (fd);
+}
+
 int
 fhandler_console::close ()
 {
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index b935a70bc..477d75b96 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -130,8 +130,9 @@ is_flush_sig (int sig)
 }
 
 void
-tty_min::kill_pgrp (int sig)
+tty_min::kill_pgrp (int sig, pid_t target_pgid)
 {
+  target_pgid = target_pgid ?: pgid;
   bool killself = false;
   if (is_flush_sig (sig) && cygheap->ctty)
     cygheap->ctty->sigflush ();
@@ -145,7 +146,7 @@ tty_min::kill_pgrp (int sig)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (!p || !p->exists () || p->ctty != ntty || p->pgid != pgid)
+      if (!p || !p->exists () || p->ctty != ntty || p->pgid != target_pgid)
 	continue;
       if (p->process_state & PID_NOTCYGWIN)
 	continue;
@@ -308,6 +309,156 @@ fhandler_termios::echo_erase (int force)
     doecho ("\b \b", 3);
 }
 
+fhandler_termios::process_sig_state
+fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
+{
+  termios &ti = ttyp->ti;
+  pid_t pgid = ttyp->pgid;
+
+  pinfo leader (pgid);
+  bool cyg_leader = leader && !(leader->process_state & PID_NOTCYGWIN);
+  bool ctrl_c_event_sent = false;
+  bool need_discard_input = false;
+  bool pg_with_nat = false;
+  bool need_send_sig = false;
+  bool nat_shell = false;
+  bool cyg_reader = false;
+
+  winpids pids ((DWORD) 0);
+  for (unsigned i = 0; i < pids.npids; i++)
+    {
+      _pinfo *p = pids[i];
+      if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
+	  && ((p->process_state & PID_NOTCYGWIN)
+	      || !(p->process_state & PID_CYGPARENT)))
+	{
+	  pinfo pinfo_resume = pinfo (myself->ppid);
+	  DWORD resume_pid = 0;
+	  if (pinfo_resume)
+	    resume_pid = pinfo_resume->dwProcessId;
+	  else
+	    resume_pid = fhandler_pty_common::get_console_process_id
+	      (myself->dwProcessId, false);
+	  if (resume_pid && fh && !fh->is_console ())
+	    {
+	      FreeConsole ();
+	      AttachConsole (p->dwProcessId);
+	    }
+	  /* CTRL_C_EVENT does not work for the process started with
+	     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
+	     instead. */
+	  if (p->process_state & PID_NEW_PG)
+	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
+				      p->dwProcessId);
+	  else if ((!fh || !fh->is_pty_master_with_pcon () || cyg_leader)
+		   && !ctrl_c_event_sent)
+	    {
+	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
+	      ctrl_c_event_sent = true;
+	    }
+	  if (resume_pid && fh && !fh->is_console ())
+	    {
+	      FreeConsole ();
+	      AttachConsole (resume_pid);
+	    }
+	  need_discard_input = true;
+	}
+      if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
+	{
+	  if (p->process_state & PID_NOTCYGWIN)
+	    pg_with_nat = true;
+	  if (!(p->process_state & PID_NOTCYGWIN))
+	    need_send_sig = true;
+	  if (!p->cygstarted)
+	    nat_shell = true;
+	  if (p->process_state & PID_TTYIN)
+	    cyg_reader = true;
+	}
+    }
+  /* Send SIGQUIT to non-cygwin process. */
+  if ((ti.c_lflag & ISIG) && CCEQ (ti.c_cc[VQUIT], c)
+      && pg_with_nat && need_send_sig && !nat_shell)
+    {
+      for (unsigned i = 0; i < pids.npids; i++)
+	{
+	  _pinfo *p = pids[i];
+	  if (p && p->ctty == ttyp->ntty && p->pgid == pgid
+	      && (p->process_state & PID_NOTCYGWIN))
+	    sig_send (p, SIGQUIT);
+	}
+    }
+  if ((ti.c_lflag & ISIG) && need_send_sig)
+    {
+      int sig;
+      if (CCEQ (ti.c_cc[VINTR], c))
+	sig = SIGINT;
+      else if (CCEQ (ti.c_cc[VQUIT], c))
+	sig = SIGQUIT;
+      else if (pg_with_nat)
+	goto not_a_sig;
+      else if (CCEQ (ti.c_cc[VSUSP], c))
+	sig = SIGTSTP;
+      else
+	goto not_a_sig;
+
+      termios_printf ("got interrupt %d, sending signal %d", c, sig);
+      if (!(ti.c_lflag & NOFLSH) && fh)
+	{
+	  fh->eat_readahead (-1);
+	  fh->discard_input ();
+	}
+      if (fh)
+	fh->release_input_mutex_if_necessary ();
+      ttyp->kill_pgrp (sig, pgid);
+      if (fh)
+	fh->acquire_input_mutex_if_necessary (mutex_timeout);
+      ti.c_lflag &= ~FLUSHO;
+      return signalled;
+    }
+not_a_sig:
+  if (need_discard_input)
+    {
+      if (!(ti.c_lflag & NOFLSH) && fh)
+	{
+	  fh->eat_readahead (-1);
+	  fh->discard_input ();
+	}
+      ti.c_lflag &= ~FLUSHO;
+      return not_signalled_but_done;
+    }
+  bool to_cyg = cyg_reader || !pg_with_nat;
+  return to_cyg ? not_signalled_with_cyg_reader : not_signalled;
+}
+
+bool
+fhandler_termios::process_stop_start (char c, tty *ttyp, bool on_ixany)
+{
+  termios &ti = ttyp->ti;
+  if (ti.c_iflag & IXON)
+    {
+      if (CCEQ (ti.c_cc[VSTOP], c))
+	{
+	  ttyp->output_stopped = true;
+	  return true;
+	}
+      else if (CCEQ (ti.c_cc[VSTART], c))
+	{
+restart_output:
+	  ttyp->output_stopped = false;
+	  return true;
+	}
+      else if ((ti.c_iflag & IXANY) && ttyp->output_stopped && on_ixany)
+	goto restart_output;
+    }
+  if ((ti.c_lflag & ICANON) && (ti.c_lflag & IEXTEN)
+      && CCEQ (ti.c_cc[VDISCARD], c))
+    {
+      ti.c_lflag ^= FLUSHO;
+      return true;
+    }
+  return false;
+}
+
 line_edit_status
 fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 			     ssize_t *bytes_read)
@@ -328,92 +479,24 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 
       if (ti.c_iflag & ISTRIP)
 	c &= 0x7f;
-      winpids pids ((DWORD) 0);
-      bool need_check_sigs = get_ttyp ()->pcon_input_state_eq (tty::to_cyg);
-      if (get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+      bool disable_eof_key = true;
+      switch (process_sigs (c, get_ttyp (), this))
 	{
-	  bool need_discard_input = false;
-	  for (unsigned i = 0; i < pids.npids; i++)
-	    {
-	      _pinfo *p = pids[i];
-	      if (c == '\003' && p && p->ctty == tc ()->ntty
-		  && p->pgid == tc ()->getpgid ()
-		  && (p->process_state & PID_NOTCYGWIN))
-		{
-		  /* CTRL_C_EVENT does not work for the process started with
-		     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
-		     instead. */
-		  if (p->process_state & PID_NEW_PG)
-		    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
-					      p->dwProcessId);
-		  else
-		    GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
-		  need_discard_input = true;
-		}
-	      if (p->ctty == get_ttyp ()->ntty
-		  && p->pgid == get_ttyp ()->getpgid () && !p->cygstarted)
-		need_check_sigs = true;
-	    }
-	  if (!CCEQ (ti.c_cc[VINTR], c)
-	      && !CCEQ (ti.c_cc[VQUIT], c)
-	      && !CCEQ (ti.c_cc[VSUSP], c))
-	    need_check_sigs = false;
-	  if (need_discard_input && !need_check_sigs)
-	    {
-	      if (!(ti.c_lflag & NOFLSH))
-		{
-		  eat_readahead (-1);
-		  discard_input ();
-		}
-	      ti.c_lflag &= ~FLUSHO;
-	      continue;
-	    }
-	}
-      if ((ti.c_lflag & ISIG) && need_check_sigs)
-	{
-	  int sig;
-	  if (CCEQ (ti.c_cc[VINTR], c))
-	    sig = SIGINT;
-	  else if (CCEQ (ti.c_cc[VQUIT], c))
-	    sig = SIGQUIT;
-	  else if (CCEQ (ti.c_cc[VSUSP], c))
-	    sig = SIGTSTP;
-	  else
-	    goto not_a_sig;
-
-	  termios_printf ("got interrupt %d, sending signal %d", c, sig);
-	  if (!(ti.c_lflag & NOFLSH))
-	    {
-	      eat_readahead (-1);
-	      discard_input ();
-	    }
-	  release_input_mutex_if_necessary ();
-	  tc ()->kill_pgrp (sig);
-	  acquire_input_mutex_if_necessary (mutex_timeout);
-	  ti.c_lflag &= ~FLUSHO;
+	case signalled:
 	  sawsig = true;
-	  goto restart_output;
-	}
-    not_a_sig:
-      if (ti.c_iflag & IXON)
-	{
-	  if (CCEQ (ti.c_cc[VSTOP], c))
-	    {
-	      if (!tc ()->output_stopped)
-		tc ()->output_stopped = true;
-	      continue;
-	    }
-	  else if (CCEQ (ti.c_cc[VSTART], c))
-	    {
-    restart_output:
-	      tc ()->output_stopped = false;
-	      continue;
-	    }
-	  else if ((ti.c_iflag & IXANY) && tc ()->output_stopped)
-	    goto restart_output;
+	  fallthrough;
+	case not_signalled_but_done:
+	  get_ttyp ()->output_stopped = false;
+	  continue;
+	case not_signalled_with_cyg_reader:
+	  disable_eof_key = false;
+	  break;
+	default: /* Not signalled */
+	  break;
 	}
+      if (process_stop_start (c, get_ttyp (), true))
+	continue;
       /* Check for special chars */
-
       if (c == '\r')
 	{
 	  if (ti.c_iflag & IGNCR)
@@ -432,12 +515,6 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	    set_input_done (iscanon);
 	}
 
-      if (iscanon && ti.c_lflag & IEXTEN && CCEQ (ti.c_cc[VDISCARD], c))
-	{
-	  ti.c_lflag ^= FLUSHO;
-	  continue;
-	}
-
       if (!iscanon)
 	/* nothing */;
       else if (CCEQ (ti.c_cc[VERASE], c))
@@ -474,7 +551,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	    }
 	  continue;
 	}
-      else if (CCEQ (ti.c_cc[VEOF], c) && need_check_sigs)
+      else if (CCEQ (ti.c_cc[VEOF], c) && !disable_eof_key)
 	{
 	  termios_printf ("EOF");
 	  accept_input ();
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5ba50cc73..a25690a0e 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2291,47 +2291,12 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 			  &mbp);
 	}
 
-      if ((ti.c_lflag & ISIG) && memchr (buf, '\003', nlen))
-	{
-	  /* If the process is started with CREATE_NEW_PROCESS_GROUP
-	     flag, Ctrl-C will not be sent to that process. Therefore,
-	     send Ctrl-break event to that process here. */
-	  DWORD wpid = 0;
-	  winpids pids ((DWORD) 0);
-	  for (unsigned i = 0; i < pids.npids; i++)
-	    {
-	      _pinfo *p = pids[i];
-	      if (p->ctty == get_ttyp ()->ntty
-		  && p->pgid == get_ttyp ()->getpgid ()
-		  && (p->process_state & PID_NOTCYGWIN)
-		  && (p->process_state & PID_NEW_PG))
-		{
-		  wpid = p->dwProcessId;
-		  break;
-		}
-	    }
-	  pinfo pinfo_resume = pinfo (myself->ppid);
-	  DWORD resume_pid;
-	  if (pinfo_resume)
-	    resume_pid = pinfo_resume->dwProcessId;
-	  else
-	    resume_pid = get_console_process_id (myself->dwProcessId, false);
-	  if (wpid && resume_pid)
-	    {
-	      WaitForSingleObject (pcon_mutex, INFINITE);
-	      FreeConsole ();
-	      AttachConsole (wpid);
-	      /* CTRL_C_EVENT does not work for the process started with
-		 CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
-		 instead. */
-	      GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, wpid);
-	      FreeConsole ();
-	      AttachConsole (resume_pid);
-	      ReleaseMutex (pcon_mutex);
-	    }
-	  if (!(ti.c_lflag & NOFLSH))
-	    get_ttyp ()->discard_input = true;
+      for (size_t i = 0; i < nlen; i++)
+	{
+	  fhandler_termios::process_sigs (buf[i], get_ttyp (), this);
+	  process_stop_start (buf[i], get_ttyp (), true);
 	}
+
       DWORD n;
       WriteFile (to_slave_nat, buf, nlen, &n, NULL);
       ReleaseMutex (input_mutex);
@@ -2885,7 +2850,8 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
       WaitForSingleObject (p->output_mutex, mutex_timeout);
       while (rlen>0)
 	{
-	  if (!process_opost_output (p->to_master, ptr, wlen, false,
+	  if (!process_opost_output (p->to_master, ptr, wlen,
+				     true /* disable output_stopped */,
 				     p->ttyp, false))
 	    {
 	      termios_printf ("WriteFile for forwarding failed, %E");
@@ -4006,3 +3972,10 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
   ttyp->pcon_input_state = dir;
   ttyp->discard_input = false;
 }
+
+void
+fhandler_pty_slave::cleanup_before_exit ()
+{
+  if (myself->process_state & PID_NOTCYGWIN)
+    get_ttyp ()->wait_pcon_fwd ();
+}
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 2cd12a665..87ff43ea2 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -75,7 +75,7 @@ public:
   void setpgid (int pid);
   int getsid () const {return sid;}
   void setsid (pid_t tsid) {sid = tsid;}
-  void kill_pgrp (int);
+  void kill_pgrp (int, pid_t target_pgid = 0);
   int is_orphaned_process_group (int);
   const __reg1 char *ttyname () __attribute (());
 };
-- 
2.35.1

