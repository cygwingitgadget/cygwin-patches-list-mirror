Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 7EED93972830
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 08:33:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7EED93972830
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10F8WSAZ017561;
 Fri, 15 Jan 2021 17:33:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10F8WSAZ017561
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/5] Cygwin: console: Revise the code to switch xterm mode.
Date: Fri, 15 Jan 2021 17:32:10 +0900
Message-Id: <20210115083213.676-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
References: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 15 Jan 2021 08:33:34 -0000

- If application changes the console mode, mode management introduced
  by commit 10d8c278 will be corrupted. For example, stdout of jansi
  v2.0.1 or later is piped to less, jansi resets the xterm mode flag
  ENABLE_VIRTUAL_TERMINA_PROCESSING when jansi is terminated. This
  causes garbled output in less because less needs this flag enabled.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler.h          |  18 ++++-
 winsup/cygwin/fhandler_console.cc | 121 +++++++++++++++++++-----------
 winsup/cygwin/select.cc           |  15 +---
 winsup/cygwin/spawn.cc            |  35 ++++++++-
 4 files changed, 127 insertions(+), 62 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index fe76c0781..45ac17af2 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2048,8 +2048,6 @@ class dev_console
   bool raw_win32_keyboard_mode;
   char cons_rabuf[40];  // cannot get longer than char buf[40] in char_command
   char *cons_rapoi;
-  LONG xterm_mode_input;
-  LONG xterm_mode_output;
   bool cursor_key_app_mode;
 
   inline UINT get_console_cp ();
@@ -2086,11 +2084,19 @@ public:
     input_signalled = 2,
     input_winch = 3
   };
+  struct handle_set_t
+  {
+    HANDLE input_handle;
+    HANDLE output_handle;
+    HANDLE input_mutex;
+    HANDLE output_mutex;
+  };
 private:
   static const unsigned MAX_WRITE_CHARS;
   static console_state *shared_console_info;
   static bool invisible_console;
   HANDLE input_mutex, output_mutex;
+  handle_set_t handle_set;
 
   /* Used when we encounter a truncated multi-byte sequence.  The
      lead bytes are stored here and revisited in the next write call. */
@@ -2212,8 +2218,12 @@ private:
   size_t &raixput ();
   size_t &rabuflen ();
 
-  void request_xterm_mode_input (bool);
-  void request_xterm_mode_output (bool);
+  const handle_set_t *get_handle_set (void) {return &handle_set;}
+  void get_duplicated_handle_set (handle_set_t *p);
+  static void close_handle_set (handle_set_t *p);
+
+  static void request_xterm_mode_input (bool, const handle_set_t *p);
+  static void request_xterm_mode_output (bool, const handle_set_t *p);
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 41cac37e6..a4c054e24 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -187,11 +187,7 @@ fhandler_console::set_unit ()
 	  tty_min_state.setntty (DEV_CONS_MAJOR, console_unit (me));
       devset = (fh_devices) shared_console_info->tty_min_state.getntty ();
       if (created)
-	{
-	  con.owner = myself->pid;
-	  con.xterm_mode_input = 0;
-	  con.xterm_mode_output = 0;
-	}
+	con.owner = myself->pid;
     }
   if (!created && shared_console_info)
     {
@@ -279,60 +275,65 @@ fhandler_console::rabuflen ()
   return con_ra.rabuflen;
 }
 
+/* The function request_xterm_mode_{in,out}put() should be static so that
+   they can be called even after the fhandler_console instance is deleted. */
 void
-fhandler_console::request_xterm_mode_input (bool req)
+fhandler_console::request_xterm_mode_input (bool req, const handle_set_t *p)
 {
   if (con_is_legacy)
     return;
+  WaitForSingleObject (p->input_mutex, INFINITE);
+  DWORD dwMode;
+  GetConsoleMode (p->input_handle, &dwMode);
   if (req)
     {
-      if (InterlockedExchange (&con.xterm_mode_input, 1) == 0)
+      if (!(dwMode & ENABLE_VIRTUAL_TERMINAL_INPUT))
 	{
-	  DWORD dwMode;
-	  GetConsoleMode (get_handle (), &dwMode);
 	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-	  SetConsoleMode (get_handle (), dwMode);
+	  SetConsoleMode (p->input_handle, dwMode);
 	  if (con.cursor_key_app_mode) /* Restore DECCKM */
-	    WriteConsoleW (get_output_handle (), L"\033[?1h", 5, NULL, 0);
+	    {
+	      request_xterm_mode_output (true, p);
+	      WriteConsoleW (p->output_handle, L"\033[?1h", 5, NULL, 0);
+	    }
 	}
     }
   else
     {
-      if (InterlockedExchange (&con.xterm_mode_input, 0) == 1)
+      if (dwMode & ENABLE_VIRTUAL_TERMINAL_INPUT)
 	{
-	  DWORD dwMode;
-	  GetConsoleMode (get_handle (), &dwMode);
 	  dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
-	  SetConsoleMode (get_handle (), dwMode);
+	  SetConsoleMode (p->input_handle, dwMode);
 	}
     }
+  ReleaseMutex (p->input_mutex);
 }
 
 void
-fhandler_console::request_xterm_mode_output (bool req)
+fhandler_console::request_xterm_mode_output (bool req, const handle_set_t *p)
 {
   if (con_is_legacy)
     return;
+  WaitForSingleObject (p->output_mutex, INFINITE);
+  DWORD dwMode;
+  GetConsoleMode (p->output_handle, &dwMode);
   if (req)
     {
-      if (InterlockedExchange (&con.xterm_mode_output, 1) == 0)
+      if (!(dwMode & ENABLE_VIRTUAL_TERMINAL_PROCESSING))
 	{
-	  DWORD dwMode;
-	  GetConsoleMode (get_output_handle (), &dwMode);
 	  dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-	  SetConsoleMode (get_output_handle (), dwMode);
+	  SetConsoleMode (p->output_handle, dwMode);
 	}
     }
   else
     {
-      if (InterlockedExchange (&con.xterm_mode_output, 0) == 1)
+      if (dwMode & ENABLE_VIRTUAL_TERMINAL_PROCESSING)
 	{
-	  DWORD dwMode;
-	  GetConsoleMode (get_output_handle (), &dwMode);
 	  dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-	  SetConsoleMode (get_output_handle (), dwMode);
+	  SetConsoleMode (p->output_handle, dwMode);
 	}
     }
+  ReleaseMutex (p->output_mutex);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -440,8 +441,8 @@ fhandler_console::fix_tab_position (void)
 {
   /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
      fixes the tab position. */
-  request_xterm_mode_output (false);
-  request_xterm_mode_output (true);
+  request_xterm_mode_output (false, &handle_set);
+  request_xterm_mode_output (true, &handle_set);
 }
 
 bool
@@ -506,7 +507,7 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   /* if system has 24 bit color capability, use xterm compatible mode. */
   if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_input (true);
+    request_xterm_mode_input (true, &handle_set);
 
   while (!input_ready && !get_cons_readahead_valid ())
     {
@@ -514,8 +515,6 @@ fhandler_console::read (void *pv, size_t& buflen)
       if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
 	{
 	  buflen = bgres;
-	  if (wincap.has_con_24bit_colors ())
-	    request_xterm_mode_input (false);
 	  return;
 	}
 
@@ -533,8 +532,6 @@ fhandler_console::read (void *pv, size_t& buflen)
 	case WAIT_TIMEOUT:
 	  set_sig_errno (EAGAIN);
 	  buflen = (size_t) -1;
-	  if (wincap.has_con_24bit_colors ())
-	    request_xterm_mode_input (false);
 	  return;
 	default:
 	  goto err;
@@ -582,22 +579,16 @@ fhandler_console::read (void *pv, size_t& buflen)
 #undef buf
 
   buflen = copied_chars;
-  if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_input (false);
   return;
 
 err:
   __seterrno ();
   buflen = (size_t) -1;
-  if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_input (false);
   return;
 
 sig_exit:
   set_sig_errno (EINTR);
   buflen = (size_t) -1;
-  if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_input (false);
 }
 
 fhandler_console::input_states
@@ -1106,6 +1097,7 @@ fhandler_console::open (int flags, mode_t)
       return 0;
     }
   set_handle (h);
+  handle_set.input_handle = h;
 
   h = CreateFileW (L"CONOUT$", GENERIC_READ | GENERIC_WRITE,
 		  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
@@ -1117,8 +1109,11 @@ fhandler_console::open (int flags, mode_t)
       return 0;
     }
   set_output_handle (h);
+  handle_set.output_handle = h;
 
   setup_io_mutex ();
+  handle_set.input_mutex = input_mutex;
+  handle_set.output_mutex = output_mutex;
 
   if (con.fillin (get_output_handle ()))
     {
@@ -1191,8 +1186,10 @@ fhandler_console::close ()
 			      &obi, sizeof obi, NULL);
       if ((NT_SUCCESS (status) && obi.HandleCount == 1)
 	  || myself->pid == con.owner)
-	request_xterm_mode_output (false);
-      request_xterm_mode_input (false);
+	{
+	  request_xterm_mode_output (false, &handle_set);
+	  request_xterm_mode_input (false, &handle_set);
+	}
     }
 
   release_output_mutex ();
@@ -1354,10 +1351,14 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   /* All the output bits we can ignore */
 
   acquire_output_mutex (INFINITE);
-  if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_output (false);
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 
+  DWORD oflags;
+  GetConsoleMode (get_output_handle (), &oflags);
+  if (wincap.has_con_24bit_colors () && !con_is_legacy
+      && (oflags & ENABLE_VIRTUAL_TERMINAL_PROCESSING))
+    flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+
   int res = SetConsoleMode (get_output_handle (), flags) ? 0 : -1;
   if (res)
     __seterrno_from_win_error (GetLastError ());
@@ -1419,6 +1420,10 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
     ((wincap.has_con_24bit_colors () && !con_is_legacy) ?
      0 : ENABLE_MOUSE_INPUT);
 
+  if (wincap.has_con_24bit_colors () && !con_is_legacy
+      && (oflags & ENABLE_VIRTUAL_TERMINAL_INPUT))
+    flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
+
   int res;
   if (flags == oflags)
     res = 0;
@@ -2973,7 +2978,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 
   /* If system has 24 bit color capability, use xterm compatible mode. */
   if (wincap.has_con_24bit_colors ())
-    request_xterm_mode_output (true);
+    request_xterm_mode_output (true, &handle_set);
   if (wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       DWORD dwMode;
@@ -3657,3 +3662,35 @@ fhandler_console::__release_output_mutex (const char *fn, int ln)
   strace.prntf (_STRACE_TERMIOS, fn, "(%d): release output_mutex", ln);
 #endif
 }
+
+void
+fhandler_console::get_duplicated_handle_set (handle_set_t *p)
+{
+  DuplicateHandle (GetCurrentProcess (), get_handle (),
+		   GetCurrentProcess (), &p->input_handle,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), get_output_handle (),
+		   GetCurrentProcess (), &p->output_handle,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), input_mutex,
+		   GetCurrentProcess (), &p->input_mutex,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), output_mutex,
+		   GetCurrentProcess (), &p->output_mutex,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
+}
+
+/* The function close_handle_set() should be static so that they can
+   be called even after the fhandler_console instance is deleted. */
+void
+fhandler_console::close_handle_set (handle_set_t *p)
+{
+  CloseHandle (p->input_handle);
+  p->input_handle = NULL;
+  CloseHandle (p->output_handle);
+  p->output_handle = NULL;
+  CloseHandle (p->input_mutex);
+  p->input_mutex = NULL;
+  CloseHandle (p->output_mutex);
+  p->output_mutex = NULL;
+}
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 501714fa7..dcb9b2d6e 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1087,28 +1087,15 @@ verify_console (select_record *me, fd_set *rfds, fd_set *wfds,
   return peek_console (me, true);
 }
 
-static void console_cleanup (select_record *, select_stuff *);
-
 static int
 console_startup (select_record *me, select_stuff *stuff)
 {
   fhandler_console *fh = (fhandler_console *) me->fh;
   if (wincap.has_con_24bit_colors ())
-    {
-      fh->request_xterm_mode_input (true);
-      me->cleanup = console_cleanup;
-    }
+    fhandler_console::request_xterm_mode_input (true, fh->get_handle_set ());
   return 1;
 }
 
-static void
-console_cleanup (select_record *me, select_stuff *stuff)
-{
-  fhandler_console *fh = (fhandler_console *) me->fh;
-  if (wincap.has_con_24bit_colors ())
-    fh->request_xterm_mode_input (false);
-}
-
 select_record *
 fhandler_console::select_read (select_stuff *ss)
 {
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 5057af932..94909df4c 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -606,6 +606,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	sa = &sec_none_nih;
 
       fhandler_pty_slave *ptys_primary = NULL;
+      fhandler_console *cons_native = NULL;
       for (int i = 0; i < 3; i ++)
 	{
 	  const int chk_order[] = {1, 0, 2};
@@ -621,10 +622,23 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    {
 	      fhandler_console *cons = (fhandler_console *) fh;
 	      if (wincap.has_con_24bit_colors () && !iscygwin ())
-		if (fd == 1 || fd == 2)
-		  cons->request_xterm_mode_output (false);
+		{
+		  if (cons_native == NULL)
+		    cons_native = cons;
+		  if (fd == 0)
+		    fhandler_console::request_xterm_mode_input (false,
+						cons->get_handle_set ());
+		  else if (fd == 1 || fd == 2)
+		    fhandler_console::request_xterm_mode_output (false,
+						 cons->get_handle_set ());
+		}
 	    }
 	}
+      struct fhandler_console::handle_set_t cons_handle_set = { 0, };
+      if (cons_native)
+	/* Console handles will be closed by close_all_handle(),
+	   therefore, duplicate them here */
+	cons_native->get_duplicated_handle_set (&cons_handle_set);
 
       if (!iscygwin ())
 	{
@@ -942,6 +956,15 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      WaitForSingleObject (pi.hProcess, INFINITE);
 	      ptys_primary->close_pseudoconsole ();
 	    }
+	  else if (cons_native)
+	    {
+	      WaitForSingleObject (pi.hProcess, INFINITE);
+	      fhandler_console::request_xterm_mode_output (true,
+							   &cons_handle_set);
+	      fhandler_console::request_xterm_mode_input (true,
+							  &cons_handle_set);
+	      fhandler_console::close_handle_set (&cons_handle_set);
+	    }
 	  myself.exit (EXITCODE_NOSET);
 	  break;
 	case _P_WAIT:
@@ -951,6 +974,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    res = -1;
 	  if (enable_pcon)
 	    ptys_primary->close_pseudoconsole ();
+	  else if (cons_native)
+	    {
+	      fhandler_console::request_xterm_mode_output (true,
+							   &cons_handle_set);
+	      fhandler_console::request_xterm_mode_input (true,
+							  &cons_handle_set);
+	      fhandler_console::close_handle_set (&cons_handle_set);
+	    }
 	  break;
 	case _P_DETACH:
 	  res = 0;	/* Lost all memory of this child. */
-- 
2.30.0

