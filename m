Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 79EEF3948819
 for <cygwin-patches@cygwin.com>; Thu, 13 Jan 2022 12:29:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 79EEF3948819
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 20DCSLD4010973;
 Thu, 13 Jan 2022 21:28:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 20DCSLD4010973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1642076914;
 bh=2XemtcLkJ4jScscvNaNrLkv+by2GD7xm4HvySKgsbFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J5tKnjH2TasD0BYJekHVJf6vFJm+mw/6jIhBkKwqXLSqLi3SzCaCUY/Ra2Vd36mjj
 HmWQnBuLGOTzcGXWaVdaOoKnyE5hCsik10z52KcITq05w6nag4SPY1uWYOsnM4mz/i
 kjdDt1LvA7pUF7yaI2Q40S+EmhX/JyYr9PmdgcW0AHdSj7HTdtBXMSor+IVJp47Gd/
 MC+ehAtwnm2P9ZUv9g5Oy6UR4sQoojQhNr9SVEd5N4qUDgRsjRZrZi/k2meX6ZowhW
 NB+OmH4F2uxpi/9Vw2FIHY9EYsKc/No+rTbHtl9XOi5pmxFfREwZUnjO+8+yaXUh54
 pXnQKGbVU+pAQ==
X-Nifty-SrcIP: [14.3.233.132]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/4] Cygwin: pty, console: Fix deadlock in GDB regarding mutex.
Date: Thu, 13 Jan 2022 21:28:08 +0900
Message-Id: <20220113122811.241-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
References: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 13 Jan 2022 12:29:08 -0000

- GDB inferior may be suspended while the inferior grabs mutex.
  This causes deadlock in terminal I/O. With this patch, timeout
  for waiting mutex is set to 0 for the debugger process when the
  process calls CreateProcess() with DEBUG_PROCESS flag to avoid
  deadlock. This may cause the race issue in GDB, however, there
  is no other way than that.

Addresses:
 https://cygwin.com/pipermail/cygwin-developers/2021-December/012542.html
---
 winsup/cygwin/fhandler_console.cc | 77 ++++++++++++++++++++++++-------
 winsup/cygwin/fhandler_termios.cc |  8 +++-
 winsup/cygwin/fhandler_tty.cc     | 63 ++++++++++++++-----------
 winsup/cygwin/select.cc           |  6 ++-
 winsup/cygwin/spawn.cc            |  8 ++--
 winsup/cygwin/tty.cc              |  6 ++-
 6 files changed, 115 insertions(+), 53 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 4c98b5355..024be522b 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -59,6 +59,8 @@ bool NO_COPY fhandler_console::invisible_console;
 /* Mutex for AttachConsole()/FreeConsole() in fhandler_tty.cc */
 HANDLE attach_mutex;
 
+extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
+
 static inline void
 acquire_attach_mutex (DWORD t)
 {
@@ -214,7 +216,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  continue;
 	}
 
-      WaitForSingleObject (p->input_mutex, INFINITE);
+      WaitForSingleObject (p->input_mutex, mutex_timeout);
       total_read = 0;
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
@@ -474,7 +476,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 				  const handle_set_t *p)
 {
   DWORD flags = 0, oflags;
-  WaitForSingleObject (p->input_mutex, INFINITE);
+  WaitForSingleObject (p->input_mutex, mutex_timeout);
   GetConsoleMode (p->input_handle, &oflags);
   switch (m)
     {
@@ -521,7 +523,7 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
 				   const handle_set_t *p)
 {
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
-  WaitForSingleObject (p->output_mutex, INFINITE);
+  WaitForSingleObject (p->output_mutex, mutex_timeout);
   switch (m)
     {
     case tty::restore:
@@ -626,7 +628,7 @@ fhandler_console::set_raw_win32_keyboard_mode (bool new_mode)
 void
 fhandler_console::set_cursor_maybe ()
 {
-  acquire_attach_mutex (INFINITE);
+  acquire_attach_mutex (mutex_timeout);
   con.fillin (get_output_handle ());
   release_attach_mutex ();
   /* Nothing to do for xterm compatible mode. */
@@ -635,7 +637,7 @@ fhandler_console::set_cursor_maybe ()
   if (con.dwLastCursorPosition.X != con.b.dwCursorPosition.X ||
       con.dwLastCursorPosition.Y != con.b.dwCursorPosition.Y)
     {
-      acquire_attach_mutex (INFINITE);
+      acquire_attach_mutex (mutex_timeout);
       SetConsoleCursorPosition (get_output_handle (), con.b.dwCursorPosition);
       release_attach_mutex ();
       con.dwLastCursorPosition = con.b.dwCursorPosition;
@@ -742,7 +744,7 @@ wait_retry:
 	  if (GetLastError () == ERROR_INVALID_HANDLE)
 	    { /* Confirm the handle is still valid */
 	      DWORD mode;
-	      acquire_attach_mutex (INFINITE);
+	      acquire_attach_mutex (mutex_timeout);
 	      BOOL res = GetConsoleMode (get_handle (), &mode);
 	      release_attach_mutex ();
 	      if (res)
@@ -754,8 +756,8 @@ wait_retry:
 #define buf ((char *) pv)
 
       int ret;
-      acquire_input_mutex (INFINITE);
-      acquire_attach_mutex (INFINITE);
+      acquire_input_mutex (mutex_timeout);
+      acquire_attach_mutex (mutex_timeout);
       ret = process_input_message ();
       release_attach_mutex ();
       switch (ret)
@@ -1410,7 +1412,7 @@ fhandler_console::close ()
 {
   debug_printf ("closing: %p, %p", get_handle (), get_output_handle ());
 
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
 
   if (shared_console_info)
     {
@@ -1463,13 +1465,13 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
   int res = fhandler_termios::ioctl (cmd, arg);
   if (res <= 0)
     return res;
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
   switch (cmd)
     {
       case TIOCGWINSZ:
 	int st;
 
-	acquire_attach_mutex (INFINITE);
+	acquire_attach_mutex (mutex_timeout);
 	st = con.fillin (get_output_handle ());
 	release_attach_mutex ();
 	if (st)
@@ -1529,7 +1531,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  DWORD n;
 	  int ret = 0;
 	  INPUT_RECORD inp[INREC_SIZE];
-	  acquire_attach_mutex (INFINITE);
+	  acquire_attach_mutex (mutex_timeout);
 	  if (!PeekConsoleInputW (get_handle (), inp, INREC_SIZE, &n))
 	    {
 	      set_errno (EINVAL);
@@ -1588,7 +1590,7 @@ fhandler_console::tcflush (int queue)
   if (queue == TCIFLUSH
       || queue == TCIOFLUSH)
     {
-      acquire_attach_mutex (INFINITE);
+      acquire_attach_mutex (mutex_timeout);
       if (!FlushConsoleInputBuffer (get_handle ()))
 	{
 	  __seterrno ();
@@ -2734,7 +2736,7 @@ fhandler_console::char_command (char c)
 	 fhandler_console object associated with standard input.
 	 So puts_readahead does not work.
 	 Use a common console read-ahead buffer instead. */
-      acquire_input_mutex (INFINITE);
+      acquire_input_mutex (mutex_timeout);
       con.cons_rapoi = NULL;
       strcpy (con.cons_rabuf, buf);
       con.cons_rapoi = con.cons_rabuf;
@@ -2751,7 +2753,7 @@ fhandler_console::char_command (char c)
 	  y -= con.b.srWindow.Top;
 	  /* x -= con.b.srWindow.Left;		// not available yet */
 	  __small_sprintf (buf, "\033[%d;%dR", y + 1, x + 1);
-	  acquire_input_mutex (INFINITE);
+	  acquire_input_mutex (mutex_timeout);
 	  con.cons_rapoi = NULL;
 	  strcpy (con.cons_rabuf, buf);
 	  con.cons_rapoi = con.cons_rabuf;
@@ -3109,12 +3111,12 @@ fhandler_console::write (const void *vsrc, size_t len)
   while (get_ttyp ()->output_stopped)
     cygwait (10);
 
-  acquire_attach_mutex (INFINITE);
+  acquire_attach_mutex (mutex_timeout);
   push_process_state process_state (PID_TTYOU);
 
   set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
 
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
 
   /* Run and check for ansi sequences */
   unsigned const char *src = (unsigned char *) vsrc;
@@ -3570,11 +3572,52 @@ set_console_title (char *title)
   debug_printf ("title '%W'", buf);
 }
 
+#define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
+/* CreateProcess() is hooked for GDB etc. */
+DEF_HOOK (CreateProcessA);
+DEF_HOOK (CreateProcessW);
+
+static BOOL WINAPI
+CreateProcessA_Hooked
+     (LPCSTR n, LPSTR c, LPSECURITY_ATTRIBUTES pa, LPSECURITY_ATTRIBUTES ta,
+      BOOL inh, DWORD f, LPVOID e, LPCSTR d,
+      LPSTARTUPINFOA si, LPPROCESS_INFORMATION pi)
+{
+  if (f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS))
+    mutex_timeout = 0; /* to avoid deadlock in GDB */
+  return CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+}
+
+static BOOL WINAPI
+CreateProcessW_Hooked
+     (LPCWSTR n, LPWSTR c, LPSECURITY_ATTRIBUTES pa, LPSECURITY_ATTRIBUTES ta,
+      BOOL inh, DWORD f, LPVOID e, LPCWSTR d,
+      LPSTARTUPINFOW si, LPPROCESS_INFORMATION pi)
+{
+  if (f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS))
+    mutex_timeout = 0; /* to avoid deadlock in GDB */
+  return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+}
+
 void
 fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
+
+  if (!execing)
+    return;
+
+#define DO_HOOK(module, name) \
+  if (!name##_Orig) \
+    { \
+      void *api = hook_api (module, #name, (void *) name##_Hooked); \
+      name##_Orig = (__typeof__ (name) *) api; \
+      /*if (api) system_printf (#name " hooked.");*/ \
+    }
+  /* CreateProcess() is hooked for GDB etc. */
+  DO_HOOK (NULL, CreateProcessA);
+  DO_HOOK (NULL, CreateProcessW);
 }
 
 /* Ugly workaround to create invisible console required since Windows 7.
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index b72f01f22..3461d1785 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -21,6 +21,12 @@ details. */
 #include "child_info.h"
 #include "ntdll.h"
 
+/* Wait time for some treminal mutexes. This is set to 0 when the
+   process calls CreateProcess() with DEBUG_PROCESS flag, because
+   the debuggie may be suspended while it grabs the mutex. Without
+   this, GDB may cause deadlock in console or pty I/O. */
+DWORD NO_COPY mutex_timeout = INFINITE;
+
 /* Common functions shared by tty/console */
 
 void
@@ -340,7 +346,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	    }
 	  release_input_mutex_if_necessary ();
 	  tc ()->kill_pgrp (sig);
-	  acquire_input_mutex_if_necessary (INFINITE);
+	  acquire_input_mutex_if_necessary (mutex_timeout);
 	  ti.c_lflag &= ~FLUSHO;
 	  sawsig = true;
 	  goto restart_output;
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c8ad53cb7..16dbc5c0a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -33,6 +33,8 @@ details. */
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
 #endif /* PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE */
 
+extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
+
 extern "C" int sscanf (const char *, const char *, ...);
 
 #define close_maybe(h) \
@@ -167,7 +169,7 @@ atexit_func (void)
 		&& GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ()
 		&& ttyp->pcon_input_state_eq (tty::to_nat) && !force_switch_to)
 	      {
-		WaitForSingleObject (ptys->input_mutex, INFINITE);
+		WaitForSingleObject (ptys->input_mutex, mutex_timeout);
 		fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
 						    input_available_event);
 		ReleaseMutex (ptys->input_mutex);
@@ -242,6 +244,8 @@ CreateProcessA_Hooked
 		   GetCurrentProcess (), &h_gdb_process,
 		   0, 0, DUPLICATE_SAME_ACCESS);
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
+  if (debug_process)
+    mutex_timeout = 0; /* to avoid deadlock in GDB */
   if (!atexit_func_registered && !path.iscygexec ())
     {
       atexit (atexit_func);
@@ -306,6 +310,8 @@ CreateProcessW_Hooked
 		   GetCurrentProcess (), &h_gdb_process,
 		   0, 0, DUPLICATE_SAME_ACCESS);
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
+  if (debug_process)
+    mutex_timeout = 0; /* to avoid deadlock in GDB */
   if (!atexit_func_registered && !path.iscygexec ())
     {
       atexit (atexit_func);
@@ -415,7 +421,7 @@ fhandler_pty_master::discard_input ()
   char buf[1024];
   DWORD n;
 
-  WaitForSingleObject (input_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
   while (::bytes_available (bytes_in_pipe, from_master) && bytes_in_pipe)
     ReadFile (from_master, buf, sizeof(buf), &n, NULL);
   ResetEvent (input_available_event);
@@ -429,8 +435,6 @@ fhandler_pty_common::__acquire_output_mutex (const char *fn, int ln,
 {
   if (strace.active ())
     strace.prntf (_STRACE_TERMIOS, fn, "(%d): pty output_mutex (%p): waiting %d ms", ln, output_mutex, ms);
-  if (ms == INFINITE)
-    ms = 100;
   DWORD res = WaitForSingleObject (output_mutex, ms);
   if (res == WAIT_OBJECT_0)
     {
@@ -479,7 +483,7 @@ void
 fhandler_pty_master::doecho (const void *str, DWORD len)
 {
   ssize_t towrite = len;
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
   if (!process_opost_output (echo_w, str, towrite, true,
 			     get_ttyp (), is_nonblocking ()))
     termios_printf ("Write to echo pipe failed, %E");
@@ -492,7 +496,7 @@ fhandler_pty_master::accept_input ()
   DWORD bytes_left;
   int ret = 1;
 
-  WaitForSingleObject (input_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
 
   char *p = rabuf () + raixget ();
   bytes_left = eat_readahead (-1);
@@ -519,7 +523,7 @@ fhandler_pty_master::accept_input ()
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  WaitForSingleObject (attach_mutex, INFINITE);
+	  WaitForSingleObject (attach_mutex, mutex_timeout);
 	  FreeConsole ();
 	  AttachConsole (target_pid);
 	  cp_to = GetConsoleCP ();
@@ -804,7 +808,7 @@ fhandler_pty_slave::open (int flags, mode_t)
 					  S_IFCHR | S_IRUSR | S_IWUSR | S_IWGRP,
 					  sd))
       sa.lpSecurityDescriptor = (PSECURITY_DESCRIPTOR) sd;
-    acquire_output_mutex (INFINITE);
+    acquire_output_mutex (mutex_timeout);
     inuse = get_ttyp ()->create_inuse (&sa);
     get_ttyp ()->was_opened = true;
     release_output_mutex ();
@@ -1065,7 +1069,7 @@ fhandler_pty_slave::set_switch_to_pcon (void)
 	  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
 	  && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
 	{
-	  WaitForSingleObject (input_mutex, INFINITE);
+	  WaitForSingleObject (input_mutex, mutex_timeout);
 	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 			  input_available_event);
 	  ReleaseMutex (input_mutex);
@@ -1109,13 +1113,14 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	{
 	  CloseHandle (h_gdb_process);
 	  h_gdb_process = NULL;
+	  mutex_timeout = INFINITE;
 	  if (isHybrid)
 	    {
 	      if (get_ttyp ()->getpgid () == myself->pgid
 		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
 		  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 		{
-		  WaitForSingleObject (input_mutex, INFINITE);
+		  WaitForSingleObject (input_mutex, mutex_timeout);
 		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 				  input_available_event);
 		  ReleaseMutex (input_mutex);
@@ -1178,7 +1183,9 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     return;
   if (get_ttyp ()->pcon_start)
     return;
-  WaitForSingleObject (pcon_mutex, INFINITE);
+  DWORD wait_ret = WaitForSingleObject (pcon_mutex, mutex_timeout);
+  if (wait_ret == WAIT_TIMEOUT)
+    return;
   if (!pcon_pid_self (get_ttyp ()->pcon_pid)
       && pcon_pid_alive (get_ttyp ()->pcon_pid))
     {
@@ -1207,7 +1214,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
 		      FreeConsole ();
 		      AttachConsole (get_ttyp ()->pcon_pid);
-		      WaitForSingleObject (input_mutex, INFINITE);
+		      WaitForSingleObject (input_mutex, mutex_timeout);
 		      transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
 				      input_available_event);
 		      ReleaseMutex (input_mutex);
@@ -1221,7 +1228,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	  else if (!get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ())
 		   && get_ttyp ()->switch_to_pcon_in)
 	    {
-	      WaitForSingleObject (input_mutex, INFINITE);
+	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 			      input_available_event);
 	      ReleaseMutex (input_mutex);
@@ -1232,7 +1239,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   /* This input transfer is needed if non-cygwin app is terminated
      by Ctrl-C or killed. */
-  WaitForSingleObject (input_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
   if (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated
       && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
     transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
@@ -1260,7 +1267,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   reset_switch_to_pcon ();
 
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
   if (!process_opost_output (get_output_handle (), ptr, towrite, false,
 			     get_ttyp (), is_nonblocking ()))
     {
@@ -1289,7 +1296,7 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
   HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
   CloseHandle (masked);
 
-  WaitForSingleObject (input_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
   if (mask)
     {
       if (InterlockedIncrement (&num_reader) == 1)
@@ -1647,7 +1654,7 @@ int
 fhandler_pty_slave::tcsetattr (int, const struct termios *t)
 {
   reset_switch_to_pcon ();
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
   get_ttyp ()->ti = *t;
   release_output_mutex ();
   return 0;
@@ -1736,7 +1743,7 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
       return fhandler_base::ioctl (cmd, arg);
     }
 
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
 
   get_ttyp ()->cmd = cmd;
   get_ttyp ()->ioctl_retval = 0;
@@ -2088,7 +2095,7 @@ fhandler_pty_master::close ()
 
 	  __small_sprintf (buf, "\\\\.\\pipe\\cygwin-%S-pty%d-master-ctl",
 			   &cygheap->installation_key, get_minor ());
-	  acquire_output_mutex (INFINITE);
+	  acquire_output_mutex (mutex_timeout);
 	  if (master_ctl)
 	    {
 	      CallNamedPipe (buf, &req, sizeof req, &repl, sizeof repl, &len,
@@ -2107,7 +2114,7 @@ fhandler_pty_master::close ()
 
   /* Check if the last master handle has been closed.  If so, set
      input_available_event to wake up potentially waiting slaves. */
-  acquire_output_mutex (INFINITE);
+  acquire_output_mutex (mutex_timeout);
   status = NtQueryObject (get_output_handle (), ObjectBasicInformation,
 			  &obi, sizeof obi, NULL);
   fhandler_pty_common::close ();
@@ -2179,7 +2186,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       static int state = 0;
 
       DWORD n;
-      WaitForSingleObject (input_mutex, INFINITE);
+      WaitForSingleObject (input_mutex, mutex_timeout);
       for (size_t i = 0; i < len; i++)
 	{
 	  if (p[i] == '\033')
@@ -2231,7 +2238,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 		 which is not accepted yet to non-cygwin pipe. */
 	      if (get_readahead_valid ())
 		accept_input ();
-	      WaitForSingleObject (input_mutex, INFINITE);
+	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
 						  get_ttyp (),
 						  input_available_event);
@@ -2245,7 +2252,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   /* Write terminal input to to_slave_nat pipe instead of output_handle
      if current application is native console application. */
-  WaitForSingleObject (input_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
   if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated
       && get_ttyp ()->pcon_input_state == tty::to_nat)
     {
@@ -2827,7 +2834,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  WaitForSingleObject (attach_mutex, INFINITE);
+	  WaitForSingleObject (attach_mutex, mutex_timeout);
 	  FreeConsole ();
 	  AttachConsole (target_pid);
 	  cp_from = GetConsoleOutputCP ();
@@ -2848,7 +2855,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	  wlen = rlen = nlen;
 	}
 
-      WaitForSingleObject (p->output_mutex, INFINITE);
+      WaitForSingleObject (p->output_mutex, mutex_timeout);
       while (rlen>0)
 	{
 	  if (!process_opost_output (p->to_master, ptr, wlen, false,
@@ -3230,7 +3237,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       if (GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
 	{ /* Send CSI6n just for requesting transfer input. */
 	  DWORD n;
-	  WaitForSingleObject (input_mutex, INFINITE);
+	  WaitForSingleObject (input_mutex, mutex_timeout);
 	  get_ttyp ()->req_xfer_input = true;
 	  get_ttyp ()->pcon_start = true;
 	  get_ttyp ()->pcon_start_pid = myself->pid;
@@ -3706,7 +3713,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 
   /* Check if terminal has CSI6n */
   WaitForSingleObject (pcon_mutex, INFINITE);
-  WaitForSingleObject (input_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
   /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle_nat rather than io_handle. */
   get_ttyp ()->pcon_activated = true;
@@ -3751,7 +3758,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   return true;
 
 not_has_csi6n:
-  WaitForSingleObject (input_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
   /* If CSI6n is not responded, pcon_start is not cleared
      in master write(). Therefore, clear it here manually. */
   get_ttyp ()->pcon_start = false;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index a2868abd0..0cd62d932 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1111,6 +1111,8 @@ release_attach_mutex ()
     ReleaseMutex (attach_mutex);
 }
 
+extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
+
 static int
 peek_console (select_record *me, bool)
 {
@@ -1136,7 +1138,7 @@ peek_console (select_record *me, bool)
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
-  acquire_attach_mutex (INFINITE);
+  acquire_attach_mutex (mutex_timeout);
   while (!fh->input_ready && !fh->get_cons_readahead_valid ())
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
@@ -1146,7 +1148,7 @@ peek_console (select_record *me, bool)
 	}
       else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
 	break;
-      fh->acquire_input_mutex (INFINITE);
+      fh->acquire_input_mutex (mutex_timeout);
       if (fhandler_console::input_winch == fh->process_input_message ()
 	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
 	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index b93063d9b..81dba5a94 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -272,6 +272,8 @@ child_info_spawn NO_COPY ch_spawn;
 
 extern "C" void __posix_spawn_sem_release (void *sem, int error);
 
+extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
+
 int
 child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			  const char *const envp[], int mode,
@@ -718,7 +720,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      && stdin_is_ptys
 	      && ptys_ttyp->pcon_input_state_eq (tty::to_cyg))
 	    {
-	      WaitForSingleObject (ptys_input_mutex, INFINITE);
+	      WaitForSingleObject (ptys_input_mutex, mutex_timeout);
 	      fhandler_pty_slave::transfer_input (tty::to_nat,
 				    ptys_primary->get_handle (),
 				    ptys_ttyp, ptys_input_available_event);
@@ -1011,7 +1013,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      if (ptys_ttyp->getpgid () == myself->pgid && stdin_is_ptys
 		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
 		{
-		  WaitForSingleObject (ptys_input_mutex, INFINITE);
+		  WaitForSingleObject (ptys_input_mutex, mutex_timeout);
 		  fhandler_pty_slave::transfer_input (tty::to_cyg,
 					    ptys_from_master_nat, ptys_ttyp,
 					    ptys_input_available_event);
@@ -1048,7 +1050,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      if (ptys_ttyp->getpgid () == myself->pgid && stdin_is_ptys
 		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
 		{
-		  WaitForSingleObject (ptys_input_mutex, INFINITE);
+		  WaitForSingleObject (ptys_input_mutex, mutex_timeout);
 		  fhandler_pty_slave::transfer_input (tty::to_cyg,
 					    ptys_from_master_nat, ptys_ttyp,
 					    ptys_input_available_event);
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 11ad3ec51..e29d73dcb 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -299,6 +299,8 @@ tty_min::ttyname ()
   return d.name ();
 }
 
+extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
+
 void
 tty_min::setpgid (int pid)
 {
@@ -317,7 +319,7 @@ tty_min::setpgid (int pid)
       if (!was_pcon_fg && pcon_fg && ttyp->switch_to_pcon_in
 	  && ttyp->pcon_input_state_eq (tty::to_cyg))
 	{
-	WaitForSingleObject (ptys->input_mutex, INFINITE);
+	WaitForSingleObject (ptys->input_mutex, mutex_timeout);
 	fhandler_pty_slave::transfer_input (tty::to_nat,
 					    ptys->get_handle (), ttyp,
 					    ptys->get_input_available_event ());
@@ -341,7 +343,7 @@ tty_min::setpgid (int pid)
 	      AttachConsole (ttyp->pcon_pid);
 	      attach_restore = true;
 	    }
-	  WaitForSingleObject (ptys->input_mutex, INFINITE);
+	  WaitForSingleObject (ptys->input_mutex, mutex_timeout);
 	  fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
 				  ptys->get_input_available_event ());
 	  ReleaseMutex (ptys->input_mutex);
-- 
2.34.1

