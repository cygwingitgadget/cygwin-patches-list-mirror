Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id B7ACB3858D35
 for <cygwin-patches@cygwin.com>; Sun, 20 Feb 2022 11:16:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B7ACB3858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21KBG1hb001942;
 Sun, 20 Feb 2022 20:16:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21KBG1hb001942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645355766;
 bh=vAjkJrswwiNeDLQsESGzI//JnHBRYsE04RWn8zezQtQ=;
 h=From:To:Cc:Subject:Date:From;
 b=bQc83ayFYIWefILgFwehCLzSEpizhoGRekmH29NvA6Uh1NRgdCUOLHCN4XDmBNdtT
 ScNK0CiTijCkfj370xkLUnjBWwu7n7Zy2+J0oM272/0CfcXkQMZ05plmHOguXRisdF
 dp8ZOOCtH+Cm9lASz3qtzQi6K/Otrb972qypyESzGZJvI0Kp5t+MV6mVKMQGfkBABq
 VY5Je9wfCA2DsY3e5JHRYL7wC2f5UAW9TALFigu/17eDmLKdobyTD0G+mRDVYr9IQV
 pPQITZKYOrsVEVnLNz6qDNvwbsUVnDh3EgIz4fuDz/+//yYk/hrEyZTV3wfGfj8JPW
 wSEstBIxPXtnQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Rearrange set_(in|out)put_mode() calls.
Date: Sun, 20 Feb 2022 20:15:51 +0900
Message-Id: <20220220111551.989-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 20 Feb 2022 11:16:22 -0000

- With this patch, all set_(in|out)put_mode() calls are rearranged
  as follows.

  1) Setup for cygwin apps, started from non-cygwin app, is done
     in fhandler_console::post_open_setup(), which overrides
     fhandler_base::post_open_setup() called from dtable.cc.
  2) Cleanup for cygwin app is done in fhandler_console::close().
  3) Setup for cygwin apps is also in fhandler_console::bg_check(),
     which overrides fhandler_termios::bg_check(). This is called
     on read(), write() and select() for console. It is necessary
     if cygwin and non-cygwin apps are started simultaneously in
     the same process group.
  4) Setup for non-cygwin apps is done in spawn.cc via
     fhandler_console::setup_console_for_non_cygwin_app().
  5) Cleanup for non-cygwin app is done in spawn.cc vid
     fhandler_console::cleanup_console_for_non_cygwin_app().
  6) Setup for non-cygwin app started by GDB is done in
     fhandler_console::set_console_mode_to_native().
  7) No explicit cleanup for non-cygwin app started by GDB, because
     console mode is automatically reset to tty::cygwin on read()/
     write() in GDB thanks to 3).
---
 winsup/cygwin/fhandler.h          | 19 ++++---
 winsup/cygwin/fhandler_console.cc | 93 ++++++++++++++++++++++---------
 winsup/cygwin/select.cc           |  4 --
 winsup/cygwin/spawn.cc            | 40 ++-----------
 4 files changed, 84 insertions(+), 72 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 3e0d7d5a6..4fadbd82a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2138,7 +2138,14 @@ private:
   void set_cursor_maybe ();
   static bool create_invisible_console_workaround (bool force);
   static console_state *open_shared_console (HWND, HANDLE&, bool&);
-  void fix_tab_position (void);
+  static void fix_tab_position (HANDLE h);
+
+/* console mode calls */
+  const handle_set_t *get_handle_set (void) {return &handle_set;}
+  static void set_input_mode (tty::cons_mode m, const termios *t,
+			      const handle_set_t *p);
+  static void set_output_mode (tty::cons_mode m, const termios *t,
+			       const handle_set_t *p);
 
  public:
   static pid_t tc_getpgid ()
@@ -2215,6 +2222,7 @@ private:
     return fh;
   }
   input_states process_input_message ();
+  bg_check_types bg_check (int sig, bool dontsignal = false);
   void setup_io_mutex (void);
   DWORD __acquire_input_mutex (const char *fn, int ln, DWORD ms);
   void __release_input_mutex (const char *fn, int ln);
@@ -2237,17 +2245,14 @@ private:
   size_t &raixput ();
   size_t &rabuflen ();
 
-  const handle_set_t *get_handle_set (void) {return &handle_set;}
   void get_duplicated_handle_set (handle_set_t *p);
   static void close_handle_set (handle_set_t *p);
 
-  static void set_input_mode (tty::cons_mode m, const termios *t,
-			      const handle_set_t *p);
-  static void set_output_mode (tty::cons_mode m, const termios *t,
-			       const handle_set_t *p);
-
   static void cons_master_thread (handle_set_t *p, tty *ttyp);
   pid_t get_owner (void) { return shared_console_info->con.owner; }
+  void setup_console_for_non_cygwin_app ();
+  void cleanup_console_for_non_cygwin_app ();
+  static void set_console_mode_to_native ();
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 475c1acdb..1dfe8e0c7 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -287,12 +287,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		  con.scroll_region.Top = 0;
 		  con.scroll_region.Bottom = -1;
 		  if (wincap.has_con_24bit_colors () && !con_is_legacy)
-		    { /* Fix tab position */
-		      /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
-			 fixes the tab position. */
-		      set_output_mode (tty::restore, &ti, p);
-		      set_output_mode (tty::cygwin, &ti, p);
-		    }
+		    fix_tab_position (p->output_handle);
 		  ttyp->kill_pgrp (SIGWINCH);
 		}
 	      processed = true;
@@ -511,6 +506,38 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
   ReleaseMutex (p->output_mutex);
 }
 
+static fhandler_console::handle_set_t NO_COPY duplicated_handle_set;
+
+void
+fhandler_console::setup_console_for_non_cygwin_app ()
+{
+  /* Setting-up console mode for non-cygwin app. */
+  /* If conmode is set to tty::native for non-cygwin apps
+     in background, tty settings of the shell is reflected
+     to the console mode of the app. So, use tty::restore
+     for background process instead. */
+  tty::cons_mode conmode =
+    (get_ttyp ()->getpgid ()== myself->pgid) ? tty::native : tty::restore;
+  set_input_mode (conmode, &tc ()->ti, get_handle_set ());
+  set_output_mode (conmode, &tc ()->ti, get_handle_set ());
+  /* Console handles will be already closed by close_all_files()
+     when cleaning up, therefore, duplicate them here. */
+  get_duplicated_handle_set (&duplicated_handle_set);
+}
+
+void
+fhandler_console::cleanup_console_for_non_cygwin_app ()
+{
+  /* Cleaning-up console mode for non-cygwin app. */
+  /* conmode can be tty::restore when non-cygwin app is
+     exec'ed from login shell. */
+  tty::cons_mode conmode =
+    (con.owner == myself->pid) ? tty::restore : tty::cygwin;
+  set_output_mode (conmode, &tc ()->ti, &duplicated_handle_set);
+  set_input_mode (conmode, &tc ()->ti, &duplicated_handle_set);
+  close_handle_set (&duplicated_handle_set);
+}
+
 /* Return the tty structure associated with a given tty number.  If the
    tty number is < 0, just return a dummy record. */
 tty_min *
@@ -616,12 +643,14 @@ fhandler_console::set_cursor_maybe ()
 /* Workaround for a bug of windows xterm compatible mode. */
 /* The horizontal tab positions are broken after resize. */
 void
-fhandler_console::fix_tab_position (void)
+fhandler_console::fix_tab_position (HANDLE h)
 {
   /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
      fixes the tab position. */
-  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-  set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+  DWORD mode;
+  GetConsoleMode (h, &mode);
+  SetConsoleMode (h, mode & ~ENABLE_VIRTUAL_TERMINAL_PROCESSING);
+  SetConsoleMode (h, mode);
 }
 
 bool
@@ -636,7 +665,7 @@ fhandler_console::send_winch_maybe ()
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
-	fix_tab_position ();
+	fix_tab_position (get_output_handle ());
       get_ttyp ()->kill_pgrp (SIGWINCH);
       return true;
     }
@@ -671,6 +700,21 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECORD& mouse_event)
 		 || con.use_mouse >= 3));
 }
 
+
+bg_check_types
+fhandler_console::bg_check (int sig, bool dontsignal)
+{
+  /* Setting-up console mode for cygwin app. This is necessary if the
+     cygwin app and other non-cygwin apps are started simultaneously
+     in the same process group. */
+  if (sig == SIGTTIN)
+    set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+  if (sig == SIGTTOU)
+    set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+
+  return fhandler_termios::bg_check (sig, dontsignal);
+}
+
 void __reg3
 fhandler_console::read (void *pv, size_t& buflen)
 {
@@ -682,8 +726,6 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   DWORD timeout = is_nonblocking () ? 0 : INFINITE;
 
-  set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-
   while (!input_ready && !get_cons_readahead_valid ())
     {
       int bgres;
@@ -1376,6 +1418,7 @@ fhandler_console::open_setup (int flags)
 void
 fhandler_console::post_open_setup (int fd)
 {
+  /* Setting-up console mode for cygwin app started from non-cygwin app. */
   if (fd == 0)
     set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
   else if (fd == 1 || fd == 2)
@@ -1401,6 +1444,7 @@ fhandler_console::close ()
       if ((NT_SUCCESS (status) && obi.HandleCount == 1)
 	  || myself->pid == con.owner)
 	{
+	  /* Cleaning-up console mode for cygwin apps. */
 	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
 	  set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
 	}
@@ -2284,7 +2328,7 @@ fhandler_console::char_command (char c)
 		}
 	      /* Call fix_tab_position() if screen has been alternated. */
 	      if (need_fix_tab_position)
-		fix_tab_position ();
+		fix_tab_position (get_output_handle ());
 	    }
 	  break;
 	case 'p':
@@ -3101,8 +3145,6 @@ fhandler_console::write (const void *vsrc, size_t len)
   acquire_attach_mutex (mutex_timeout);
   push_process_state process_state (PID_TTYOU);
 
-  set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-
   acquire_output_mutex (mutex_timeout);
 
   /* Run and check for ansi sequences */
@@ -3560,9 +3602,12 @@ set_console_title (char *title)
 }
 
 static bool NO_COPY gdb_inferior_noncygwin = false;
-static void
-set_console_mode_to_native ()
+
+void
+fhandler_console::set_console_mode_to_native ()
 {
+  /* Setting-up console mode for non-cygwin app started by GDB. This is
+     called from hooked CreateProcess() and ContinueDebugEvent(). */
   cygheap_fdenum cfd (false);
   while (cfd.next () >= 0)
     if (cfd->get_major () == DEV_CONS_MAJOR)
@@ -3570,11 +3615,9 @@ set_console_mode_to_native ()
 	fhandler_console *cons = (fhandler_console *) (fhandler_base *) cfd;
 	if (cons->get_device () == cons->tc ()->getntty ())
 	  {
-	    termios *cons_ti = &((tty *) cons->tc ())->ti;
-	    fhandler_console::set_input_mode (tty::native, cons_ti,
-					      cons->get_handle_set ());
-	    fhandler_console::set_output_mode (tty::native, cons_ti,
-					       cons->get_handle_set ());
+	    termios *cons_ti = &cons->tc ()->ti;
+	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
+	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
 	    break;
 	  }
       }
@@ -3596,7 +3639,7 @@ CreateProcessA_Hooked
     mutex_timeout = 0; /* to avoid deadlock in GDB */
   gdb_inferior_noncygwin = !fhandler_termios::path_iscygexec_a (n, c);
   if (gdb_inferior_noncygwin)
-    set_console_mode_to_native ();
+    fhandler_console::set_console_mode_to_native ();
   return CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
@@ -3610,7 +3653,7 @@ CreateProcessW_Hooked
     mutex_timeout = 0; /* to avoid deadlock in GDB */
   gdb_inferior_noncygwin = !fhandler_termios::path_iscygexec_w (n, c);
   if (gdb_inferior_noncygwin)
-    set_console_mode_to_native ();
+    fhandler_console::set_console_mode_to_native ();
   return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
@@ -3619,7 +3662,7 @@ ContinueDebugEvent_Hooked
      (DWORD p, DWORD t, DWORD s)
 {
   if (gdb_inferior_noncygwin)
-    set_console_mode_to_native ();
+    fhandler_console::set_console_mode_to_native ();
   return ContinueDebugEvent_Orig (p, t, s);
 }
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index d01a319ef..b20cef78f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1196,10 +1196,6 @@ thread_console (void *arg)
 static int
 console_startup (select_record *me, select_stuff *stuff)
 {
-  fhandler_console *fh = (fhandler_console *) me->fh;
-  fhandler_console::set_input_mode (tty::cygwin, &((tty *)fh->tc ())->ti,
-				    fh->get_handle_set ());
-
   select_console_info *ci = stuff->device_specific_console;
   if (ci->start)
     me->h = *(stuff->device_specific_console)->thread;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index a7e25cc20..9ecc2d29e 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -612,8 +612,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       fhandler_pty_slave *ptys_primary = NULL;
       fhandler_console *cons_native = NULL;
-      termios *cons_ti = NULL;
-      pid_t cons_owner = 0;
       for (int i = 0; i < 3; i ++)
 	{
 	  const int chk_order[] = {1, 0, 2};
@@ -629,25 +627,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    {
 	      if (!iscygwin () && cons_native == NULL)
 		{
-		  fhandler_console *cons = (fhandler_console *) fh;
-		  cons_native = cons;
-		  cons_ti = &((tty *)cons->tc ())->ti;
-		  cons_owner = cons->get_owner ();
-		  tty::cons_mode conmode =
-		    (ctty_pgid && ctty_pgid == myself->pgid) ?
-		    tty::native : tty::restore;
-		  fhandler_console::set_input_mode (conmode,
-					   cons_ti, cons->get_handle_set ());
-		  fhandler_console::set_output_mode (conmode,
-					   cons_ti, cons->get_handle_set ());
+		  cons_native = (fhandler_console *) fh;
+		  cons_native->setup_console_for_non_cygwin_app ();
 		}
 	    }
 	}
-      struct fhandler_console::handle_set_t cons_handle_set = { 0, };
-      if (cons_native)
-	/* Console handles will be closed by close_all_files(),
-	   therefore, duplicate them here */
-	cons_native->get_duplicated_handle_set (&cons_handle_set);
 
       if (!iscygwin ())
 	{
@@ -1023,15 +1007,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      CloseHandle (ptys_pcon_mutex);
 	    }
 	  if (cons_native)
-	    {
-	      tty::cons_mode conmode =
-		cons_owner == myself->pid ? tty::restore : tty::cygwin;
-	      fhandler_console::set_output_mode (conmode, cons_ti,
-						 &cons_handle_set);
-	      fhandler_console::set_input_mode (conmode, cons_ti,
-						&cons_handle_set);
-	      fhandler_console::close_handle_set (&cons_handle_set);
-	    }
+	    cons_native->cleanup_console_for_non_cygwin_app ();
 	  myself.exit (EXITCODE_NOSET);
 	  break;
 	case _P_WAIT:
@@ -1060,15 +1036,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      CloseHandle (ptys_pcon_mutex);
 	    }
 	  if (cons_native)
-	    {
-	      tty::cons_mode conmode =
-		cons_owner == myself->pid ? tty::restore : tty::cygwin;
-	      fhandler_console::set_output_mode (conmode, cons_ti,
-						 &cons_handle_set);
-	      fhandler_console::set_input_mode (conmode, cons_ti,
-						&cons_handle_set);
-	      fhandler_console::close_handle_set (&cons_handle_set);
-	    }
+	    cons_native->cleanup_console_for_non_cygwin_app ();
 	  break;
 	case _P_DETACH:
 	  res = 0;	/* Lost all memory of this child. */
-- 
2.35.1

