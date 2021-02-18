Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id DA49D386F00E
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 09:02:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DA49D386F00E
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 11I91bHJ015892;
 Thu, 18 Feb 2021 18:02:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 11I91bHJ015892
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: console: Fix handling of Ctrl-S in Win7.
Date: Thu, 18 Feb 2021 18:01:28 +0900
Message-Id: <20210218090128.1459-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218090128.1459-1-takashi.yano@nifty.ne.jp>
References: <20210218090128.1459-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 18 Feb 2021 09:02:21 -0000

- If ENABLE_LINE_INPUT is set, Ctrl-S is handled by Windows if the
  OS is Windows 7. This conflicts with Ctrl-S handling in cygwin
  console code. This patch unsets ENABLE_LINE_INPUT flag in cygwin
  and set it when native app is executed.
---
 winsup/cygwin/fhandler.h          |   9 +-
 winsup/cygwin/fhandler_console.cc | 291 +++++++-----------------------
 winsup/cygwin/select.cc           |   4 +-
 winsup/cygwin/spawn.cc            |  32 ++--
 winsup/cygwin/tty.h               |   8 +-
 5 files changed, 98 insertions(+), 246 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e457e2785..faa910692 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2135,11 +2135,9 @@ private:
   const unsigned char *write_normal (unsigned const char*, unsigned const char *);
   void char_command (char);
   bool set_raw_win32_keyboard_mode (bool);
-  int output_tcsetattr (int a, const struct termios *t);
 
 /* Input calls */
   int igncr_enabled ();
-  int input_tcsetattr (int a, const struct termios *t);
   void set_cursor_maybe ();
   static bool create_invisible_console (HWINSTA);
   static bool create_invisible_console_workaround (bool force);
@@ -2196,7 +2194,6 @@ private:
   void fixup_after_exec () {fixup_after_fork_exec (true);}
   void fixup_after_fork (HANDLE) {fixup_after_fork_exec (false);}
   void set_close_on_exec (bool val);
-  void set_input_state ();
   bool send_winch_maybe ();
   void setup ();
   bool set_unit ();
@@ -2245,8 +2242,10 @@ private:
   void get_duplicated_handle_set (handle_set_t *p);
   static void close_handle_set (handle_set_t *p);
 
-  static void request_xterm_mode_input (bool, const handle_set_t *p);
-  static void request_xterm_mode_output (bool, const handle_set_t *p);
+  static void set_input_mode (tty::cons_mode m, const termios *t,
+			      const handle_set_t *p);
+  static void set_output_mode (tty::cons_mode m, const termios *t,
+			       const handle_set_t *p);
 
   static void cons_master_thread (handle_set_t *p, tty *ttyp);
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 4dee506dd..ca8eb6400 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -299,8 +299,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		    { /* Fix tab position */
 		      /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
 			 fixes the tab position. */
-		      request_xterm_mode_output (false, p);
-		      request_xterm_mode_output (true, p);
+		      set_output_mode (tty::restore, &ti, p);
+		      set_input_mode (tty::cygwin, &ti, p);
 		    }
 		  ttyp->kill_pgrp (SIGWINCH);
 		}
@@ -446,64 +446,72 @@ fhandler_console::rabuflen ()
   return con_ra.rabuflen;
 }
 
-/* The function request_xterm_mode_{in,out}put() should be static so that
-   they can be called even after the fhandler_console instance is deleted. */
+/* The function set_{in,out}put_mode() should be static so that they
+   can be called even after the fhandler_console instance is deleted. */
 void
-fhandler_console::request_xterm_mode_input (bool req, const handle_set_t *p)
+fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
+				  const handle_set_t *p)
 {
-  if (con_is_legacy)
-    return;
+  DWORD flags = 0, oflags;
   WaitForSingleObject (p->input_mutex, INFINITE);
-  DWORD dwMode;
-  GetConsoleMode (p->input_handle, &dwMode);
-  if (req)
+  GetConsoleMode (p->input_handle, &oflags);
+  switch (m)
     {
-      if (!(dwMode & ENABLE_VIRTUAL_TERMINAL_INPUT))
-	{
-	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-	  SetConsoleMode (p->input_handle, dwMode);
-	  if (con.cursor_key_app_mode) /* Restore DECCKM */
-	    {
-	      request_xterm_mode_output (true, p);
-	      WriteConsoleW (p->output_handle, L"\033[?1h", 5, NULL, 0);
-	    }
-	}
+    case tty::restore:
+      flags = ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
+      break;
+    case tty::cygwin:
+      flags = ENABLE_WINDOW_INPUT;
+      if (wincap.has_con_24bit_colors () && !con_is_legacy)
+	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
+      else
+	flags |= ENABLE_MOUSE_INPUT;
+      break;
+    case tty::native:
+      if (t->c_lflag & ECHO)
+	flags |= ENABLE_ECHO_INPUT;
+      if (t->c_lflag & ICANON)
+	flags |= ENABLE_LINE_INPUT;
+      if (flags & ENABLE_ECHO_INPUT && !(flags & ENABLE_LINE_INPUT))
+	/* This is illegal, so turn off the echo here, and fake it
+	   when we read the characters */
+	flags &= ~ENABLE_ECHO_INPUT;
+      if ((t->c_lflag & ISIG) && !(t->c_iflag & IGNBRK))
+	flags |= ENABLE_PROCESSED_INPUT;
+      break;
     }
-  else
-    {
-      if (dwMode & ENABLE_VIRTUAL_TERMINAL_INPUT)
-	{
-	  dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
-	  SetConsoleMode (p->input_handle, dwMode);
-	}
+  SetConsoleMode (p->input_handle, flags);
+  if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
+      && (flags & ENABLE_VIRTUAL_TERMINAL_INPUT)
+      && con.cursor_key_app_mode)
+    { /* Restore DECCKM */
+      set_output_mode (tty::cygwin, t, p);
+      WriteConsoleW (p->output_handle, L"\033[?1h", 5, NULL, 0);
     }
   ReleaseMutex (p->input_mutex);
 }
 
 void
-fhandler_console::request_xterm_mode_output (bool req, const handle_set_t *p)
+fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
+				   const handle_set_t *p)
 {
-  if (con_is_legacy)
-    return;
+  DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
   WaitForSingleObject (p->output_mutex, INFINITE);
-  DWORD dwMode;
-  GetConsoleMode (p->output_handle, &dwMode);
-  if (req)
-    {
-      if (!(dwMode & ENABLE_VIRTUAL_TERMINAL_PROCESSING))
-	{
-	  dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-	  SetConsoleMode (p->output_handle, dwMode);
-	}
-    }
-  else
+  switch (m)
     {
-      if (dwMode & ENABLE_VIRTUAL_TERMINAL_PROCESSING)
-	{
-	  dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-	  SetConsoleMode (p->output_handle, dwMode);
-	}
+    case tty::restore:
+      break;
+    case tty::cygwin:
+      if (wincap.has_con_24bit_colors () && !con_is_legacy)
+	flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+      fallthrough;
+    case tty::native:
+      if (wincap.has_con_24bit_colors () && !con_is_legacy
+	  && (!(t->c_oflag & OPOST) || !(t->c_oflag & ONLCR)))
+	flags |= DISABLE_NEWLINE_AUTO_RETURN;
+      break;
     }
+  SetConsoleMode (p->output_handle, flags);
   ReleaseMutex (p->output_mutex);
 }
 
@@ -616,8 +624,8 @@ fhandler_console::fix_tab_position (void)
 {
   /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
      fixes the tab position. */
-  request_xterm_mode_output (false, &handle_set);
-  request_xterm_mode_output (true, &handle_set);
+  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
+  set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
 }
 
 bool
@@ -678,11 +686,7 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   DWORD timeout = is_nonblocking () ? 0 : INFINITE;
 
-  set_input_state ();
-
-  /* if system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_input (true, &handle_set);
+  set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
 
   while (!input_ready && !get_cons_readahead_valid ())
     {
@@ -1165,13 +1169,6 @@ out:
   return stat;
 }
 
-void
-fhandler_console::set_input_state ()
-{
-  if (get_ttyp ()->rstcons ())
-    input_tcsetattr (0, &get_ttyp ()->ti);
-}
-
 bool
 dev_console::fillin (HANDLE h)
 {
@@ -1313,7 +1310,6 @@ fhandler_console::open (int flags, mode_t)
       con.set_default_attr ();
     }
 
-  get_ttyp ()->rstcons (false);
   set_open_status ();
 
   if (myself->pid == con.owner && wincap.has_con_24bit_colors ())
@@ -1338,12 +1334,8 @@ fhandler_console::open (int flags, mode_t)
 	setenv ("TERM", "cygwin", 1);
     }
 
-  DWORD cflags;
-  if (GetConsoleMode (get_handle (), &cflags))
-    SetConsoleMode (get_handle (), ENABLE_WINDOW_INPUT
-		    | ((wincap.has_con_24bit_colors () && !con_is_legacy) ?
-		       0 : ENABLE_MOUSE_INPUT)
-		    | cflags);
+  set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+  set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
 
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
@@ -1376,7 +1368,7 @@ fhandler_console::close ()
 
   acquire_output_mutex (INFINITE);
 
-  if (shared_console_info && wincap.has_con_24bit_colors ())
+  if (shared_console_info)
     {
       /* Restore console mode if this is the last closure. */
       OBJECT_BASIC_INFORMATION obi;
@@ -1386,8 +1378,8 @@ fhandler_console::close ()
       if ((NT_SUCCESS (status) && obi.HandleCount == 1)
 	  || myself->pid == con.owner)
 	{
-	  request_xterm_mode_output (false, &handle_set);
-	  request_xterm_mode_input (false, &handle_set);
+	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
+	  set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
 	}
     }
 
@@ -1561,154 +1553,19 @@ fhandler_console::tcflush (int queue)
   return res;
 }
 
-int
-fhandler_console::output_tcsetattr (int, struct termios const *t)
-{
-  /* All the output bits we can ignore */
-
-  acquire_output_mutex (INFINITE);
-  DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
-
-  DWORD oflags;
-  acquire_attach_mutex (INFINITE);
-  GetConsoleMode (get_output_handle (), &oflags);
-  if (wincap.has_con_24bit_colors () && !con_is_legacy
-      && (oflags & ENABLE_VIRTUAL_TERMINAL_PROCESSING))
-    flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-
-  int res = SetConsoleMode (get_output_handle (), flags) ? 0 : -1;
-  release_attach_mutex ();
-  if (res)
-    __seterrno_from_win_error (GetLastError ());
-  release_output_mutex ();
-  syscall_printf ("%d = tcsetattr(,%p) (ENABLE FLAGS %y) (lflag %y oflag %y)",
-		  res, t, flags, t->c_lflag, t->c_oflag);
-  return res;
-}
-
-int
-fhandler_console::input_tcsetattr (int, struct termios const *t)
-{
-  /* Ignore the optional_actions stuff, since all output is emitted
-     instantly */
-  acquire_input_mutex (INFINITE);
-
-  DWORD oflags;
-
-  acquire_attach_mutex (INFINITE);
-  if (!GetConsoleMode (get_handle (), &oflags))
-    oflags = 0;
-  DWORD flags = 0;
-
-#if 0
-  /* Enable/disable LF -> CRLF conversions */
-  rbinary ((t->c_iflag & INLCR) ? false : true);
-#endif
-
-  /* There's some disparity between what we need and what's
-     available.  We've got ECHO and ICANON, they've
-     got ENABLE_ECHO_INPUT and ENABLE_LINE_INPUT. */
-
-  termios_printf ("this %p, get_ttyp () %p, t %p", this, get_ttyp (), t);
-  get_ttyp ()->ti = *t;
-
-  if (t->c_lflag & ECHO)
-    {
-      flags |= ENABLE_ECHO_INPUT;
-    }
-  if (t->c_lflag & ICANON)
-    {
-      flags |= ENABLE_LINE_INPUT;
-    }
-
-  if (flags & ENABLE_ECHO_INPUT
-      && !(flags & ENABLE_LINE_INPUT))
-    {
-      /* This is illegal, so turn off the echo here, and fake it
-	 when we read the characters */
-
-      flags &= ~ENABLE_ECHO_INPUT;
-    }
-
-  if ((t->c_lflag & ISIG) && !(t->c_iflag & IGNBRK))
-    {
-      flags |= ENABLE_PROCESSED_INPUT;
-    }
-
-  flags |= ENABLE_WINDOW_INPUT |
-    ((wincap.has_con_24bit_colors () && !con_is_legacy) ?
-     0 : ENABLE_MOUSE_INPUT);
-
-  if (wincap.has_con_24bit_colors () && !con_is_legacy
-      && (oflags & ENABLE_VIRTUAL_TERMINAL_INPUT))
-    flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-
-  int res;
-  if (flags == oflags)
-    res = 0;
-  else
-    {
-      res = SetConsoleMode (get_handle (), flags) ? 0 : -1;
-      if (res < 0)
-	__seterrno ();
-      syscall_printf ("%d = tcsetattr(,%p) enable flags %y, c_lflag %y iflag %y",
-		      res, t, flags, t->c_lflag, t->c_iflag);
-    }
-  release_attach_mutex ();
-
-  get_ttyp ()->rstcons (false);
-  release_input_mutex ();
-  return res;
-}
-
 int
 fhandler_console::tcsetattr (int a, struct termios const *t)
 {
-  int res = output_tcsetattr (a, t);
-  if (res != 0)
-    return res;
-  return input_tcsetattr (a, t);
+  get_ttyp ()->ti = *t;
+  return 0;
 }
 
 int
 fhandler_console::tcgetattr (struct termios *t)
 {
-  int res;
   *t = get_ttyp ()->ti;
-
   t->c_cflag |= CS8;
-
-  DWORD flags;
-
-  acquire_attach_mutex (INFINITE);
-  if (!GetConsoleMode (get_handle (), &flags))
-    {
-      __seterrno ();
-      res = -1;
-    }
-  else
-    {
-      if (flags & ENABLE_ECHO_INPUT)
-	t->c_lflag |= ECHO;
-
-      if (flags & ENABLE_LINE_INPUT)
-	t->c_lflag |= ICANON;
-
-      if (flags & ENABLE_PROCESSED_INPUT)
-	t->c_lflag |= ISIG;
-      else
-	t->c_iflag |= IGNBRK;
-
-      /* What about ENABLE_WINDOW_INPUT
-	 and ENABLE_MOUSE_INPUT   ? */
-
-      /* All the output bits we can ignore */
-      res = 0;
-    }
-  release_attach_mutex ();
-  syscall_printf ("%d = tcgetattr(%p) enable flags %y, t->lflag %y, t->iflag %y",
-		 res, t, flags, t->c_lflag, t->c_iflag);
-  return res;
+  return 0;
 }
 
 fhandler_console::fhandler_console (fh_devices unit) :
@@ -3205,22 +3062,10 @@ fhandler_console::write (const void *vsrc, size_t len)
 
   acquire_attach_mutex (INFINITE);
   push_process_state process_state (PID_TTYOU);
-  acquire_output_mutex (INFINITE);
 
-  /* If system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_output (true, &handle_set);
-  if (wincap.has_con_24bit_colors () && !con_is_legacy)
-    {
-      DWORD dwMode;
-      GetConsoleMode (get_output_handle (), &dwMode);
-      if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
-	  !(get_ttyp ()->ti.c_oflag & ONLCR))
-	dwMode |= DISABLE_NEWLINE_AUTO_RETURN;
-      else
-	dwMode &= ~DISABLE_NEWLINE_AUTO_RETURN;
-      SetConsoleMode (get_output_handle (), dwMode);
-    }
+  set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+
+  acquire_output_mutex (INFINITE);
 
   /* Run and check for ansi sequences */
   unsigned const char *src = (unsigned char *) vsrc;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index dc75a2dbf..085de6deb 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1147,8 +1147,8 @@ static int
 console_startup (select_record *me, select_stuff *stuff)
 {
   fhandler_console *fh = (fhandler_console *) me->fh;
-  if (wincap.has_con_24bit_colors ())
-    fhandler_console::request_xterm_mode_input (true, fh->get_handle_set ());
+  fhandler_console::set_input_mode (tty::cygwin, &((tty *)fh->tc ())->ti,
+				    fh->get_handle_set ());
 
   select_console_info *ci = stuff->device_specific_console;
   if (ci->start)
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4d4d599ca..323630fcb 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -607,6 +607,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       fhandler_pty_slave *ptys_primary = NULL;
       fhandler_console *cons_native = NULL;
+      termios *cons_ti = NULL;
       for (int i = 0; i < 3; i ++)
 	{
 	  const int chk_order[] = {1, 0, 2};
@@ -621,16 +622,19 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  else if (fh && fh->get_major () == DEV_CONS_MAJOR)
 	    {
 	      fhandler_console *cons = (fhandler_console *) fh;
-	      if (wincap.has_con_24bit_colors () && !iscygwin ())
+	      if (!iscygwin ())
 		{
 		  if (cons_native == NULL)
-		    cons_native = cons;
+		    {
+		      cons_native = cons;
+		      cons_ti = &((tty *)cons->tc ())->ti;
+		    }
 		  if (fd == 0)
-		    fhandler_console::request_xterm_mode_input (false,
-						cons->get_handle_set ());
+		    fhandler_console::set_input_mode (tty::native,
+					   cons_ti, cons->get_handle_set ());
 		  else if (fd == 1 || fd == 2)
-		    fhandler_console::request_xterm_mode_output (false,
-						 cons->get_handle_set ());
+		    fhandler_console::set_output_mode (tty::native,
+					   cons_ti, cons->get_handle_set ());
 		}
 	    }
 	}
@@ -996,10 +1000,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  if (cons_native)
 	    {
-	      fhandler_console::request_xterm_mode_output (true,
-							   &cons_handle_set);
-	      fhandler_console::request_xterm_mode_input (true,
-							  &cons_handle_set);
+	      fhandler_console::set_output_mode (tty::cygwin, cons_ti,
+						 &cons_handle_set);
+	      fhandler_console::set_input_mode (tty::cygwin, cons_ti,
+						&cons_handle_set);
 	      fhandler_console::close_handle_set (&cons_handle_set);
 	    }
 	  myself.exit (EXITCODE_NOSET);
@@ -1031,10 +1035,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  if (cons_native)
 	    {
-	      fhandler_console::request_xterm_mode_output (true,
-							   &cons_handle_set);
-	      fhandler_console::request_xterm_mode_input (true,
-							  &cons_handle_set);
+	      fhandler_console::set_output_mode (tty::cygwin, cons_ti,
+						 &cons_handle_set);
+	      fhandler_console::set_input_mode (tty::cygwin, cons_ti,
+						&cons_handle_set);
 	      fhandler_console::close_handle_set (&cons_handle_set);
 	    }
 	  break;
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index a8ddd68d6..4ef1e04c9 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -39,7 +39,6 @@ class tty_min
   struct status_flags
   {
     unsigned initialized : 1;	/* Set if tty is initialized */
-    unsigned rstcons     : 1;	/* Set if console needs to be set to "non-cooked" */
   } status;
 
 public:
@@ -51,7 +50,6 @@ public:
   int last_sig;
 
   IMPLEMENT_STATUS_FLAG (bool, initialized)
-  IMPLEMENT_STATUS_FLAG (bool, rstcons)
 
   struct termios ti;
   struct winsize winsize;
@@ -97,6 +95,12 @@ public:
     to_cyg,
     to_nat
   };
+  enum cons_mode
+  {
+    restore, /* For restoring when exit from cygwin. */
+    cygwin,  /* For cygwin apps */
+    native   /* For native apps executed from cygwin. */
+  };
 
 private:
   HANDLE _from_master;
-- 
2.30.0

