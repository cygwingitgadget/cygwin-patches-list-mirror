Return-Path: <cygwin-patches-return-9284-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64330 invoked by alias); 31 Mar 2019 13:48:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62175 invoked by uid 89); 31 Mar 2019 13:48:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=sigttou, SIGTTOU
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 13:48:29 +0000
Received: from localhost.localdomain (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x2VDlggx021625;	Sun, 31 Mar 2019 22:48:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x2VDlggx021625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1554040090;	bh=oL3pWSPJt3JdTpKRNZoo74WqQyyWxdrj0FdsKVXIxH4=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=QgaKxXCxEdH8YUc+nXcPPN8D8n+SF1kj/o2IhOS9jLudtIDUAG6spcRB4C+7sdz3S	 Y5p2txBI+1V/uM7Ugcbj5Th77/lhPaJUxzIgO3dWw+eGTwf/0Wyj7zp/hGMTw4lKxR	 RhV3jsZ/ymvBuloIEL4Q+yaxvD2N5OuDi6fRPgwKThM2COFolQwYadlBCSim91mes6	 ImLjsQiSC2JVlO6RbAHX4ab7j8Z6w3WRujgUfDxrdhJvWEqJKDAih2N3SMjx0SKawS	 1ho/EsCnZJkY8bcu6srkIQBoYoH+2pmkjPnX8YLE+mR4IEdlrsXnTSk7KCx+Q2orMY	 op2x2MqIvftiQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 3/3] Cygwin: console: Make I/O functions thread-safe
Date: Sun, 31 Mar 2019 13:48:00 -0000
Message-Id: <20190331134718.1407-4-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190331134718.1407-1-takashi.yano@nifty.ne.jp>
References: <20190331094731.GC3337@calimero.vinschen.de> <20190331134718.1407-1-takashi.yano@nifty.ne.jp>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00094.txt.bz2

- POSIX states I/O functions shall be thread-safe, however, cygwin
  console I/O functions were not. This patch makes console I/O
  functions thread-safe.
---
 winsup/cygwin/fhandler.h          |  18 +++-
 winsup/cygwin/fhandler_console.cc | 136 +++++++++++++++++++++++++++++-
 winsup/cygwin/select.cc           |  23 +++--
 3 files changed, 165 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e4a6de610..bc66377cd 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1698,6 +1698,12 @@ class fhandler_serial: public fhandler_base
   }
 };
 
+#define acquire_input_mutex(ms) \
+  __acquire_input_mutex (__PRETTY_FUNCTION__, __LINE__, ms)
+
+#define release_input_mutex() \
+  __release_input_mutex (__PRETTY_FUNCTION__, __LINE__)
+
 #define acquire_output_mutex(ms) \
   __acquire_output_mutex (__PRETTY_FUNCTION__, __LINE__, ms)
 
@@ -1897,6 +1903,7 @@ private:
   static const unsigned MAX_WRITE_CHARS;
   static console_state *shared_console_info;
   static bool invisible_console;
+  HANDLE input_mutex, output_mutex;
 
   /* Used when we encounter a truncated multi-byte sequence.  The
      lead bytes are stored here and revisited in the next write call. */
@@ -1966,8 +1973,11 @@ private:
   bool focus_aware () {return shared_console_info->con.use_focus;}
   bool get_cons_readahead_valid ()
   {
-    return shared_console_info->con.cons_rapoi != NULL &&
+    acquire_input_mutex (INFINITE);
+    bool ret = shared_console_info->con.cons_rapoi != NULL &&
       *shared_console_info->con.cons_rapoi;
+    release_input_mutex ();
+    return ret;
   }
 
   select_record *select_read (select_stuff *);
@@ -2002,6 +2012,12 @@ private:
     return fh;
   }
   input_states process_input_message ();
+  void setup_io_mutex (void);
+  DWORD __acquire_input_mutex (const char *fn, int ln, DWORD ms);
+  void __release_input_mutex (const char *fn, int ln);
+  DWORD __acquire_output_mutex (const char *fn, int ln, DWORD ms);
+  void __release_output_mutex (const char *fn, int ln);
+
   friend tty_min * tty_list::get_cttyp ();
 };
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 788bc5cf4..04e59a474 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -231,6 +231,45 @@ tty_list::get_cttyp ()
     return NULL;
 }
 
+void
+fhandler_console::setup_io_mutex (void)
+{
+  char buf[MAX_PATH];
+  DWORD res;
+
+  res = WAIT_FAILED;
+  if (!input_mutex || WAIT_FAILED == (res = acquire_input_mutex (0)))
+    {
+      shared_name (buf, "cygcons.input.mutex", get_minor ());
+      input_mutex = OpenMutex (MAXIMUM_ALLOWED, TRUE, buf);
+      if (!input_mutex)
+	input_mutex = CreateMutex (&sec_none, FALSE, buf);
+      if (!input_mutex)
+	{
+	  __seterrno ();
+	  return;
+	}
+    }
+  if (res == WAIT_OBJECT_0)
+    release_input_mutex ();
+
+  res = WAIT_FAILED;
+  if (!output_mutex || WAIT_FAILED == (res = acquire_output_mutex (0)))
+    {
+      shared_name (buf, "cygcons.output.mutex", get_minor ());
+      output_mutex = OpenMutex (MAXIMUM_ALLOWED, TRUE, buf);
+      if (!output_mutex)
+	output_mutex = CreateMutex (&sec_none, FALSE, buf);
+      if (!output_mutex)
+	{
+	  __seterrno ();
+	  return;
+	}
+    }
+  if (res == WAIT_OBJECT_0)
+    release_output_mutex ();
+}
+
 inline DWORD
 dev_console::con_to_str (char *d, int dlen, WCHAR w)
 {
@@ -361,7 +400,9 @@ fhandler_console::read (void *pv, size_t& buflen)
 #define buf ((char *) pv)
 
       int ret;
+      acquire_input_mutex (INFINITE);
       ret = process_input_message ();
+      release_input_mutex ();
       switch (ret)
 	{
 	case input_error:
@@ -381,6 +422,7 @@ fhandler_console::read (void *pv, size_t& buflen)
     }
 
   /* Check console read-ahead buffer filled from terminal requests */
+  acquire_input_mutex (INFINITE);
   while (con.cons_rapoi && *con.cons_rapoi && buflen)
     {
       buf[copied_chars++] = *con.cons_rapoi++;
@@ -392,6 +434,7 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   if (!ralen)
     input_ready = false;
+  release_input_mutex ();
 
 #undef buf
 
@@ -902,6 +945,8 @@ fhandler_console::open (int flags, mode_t)
     }
   set_output_handle (h);
 
+  setup_io_mutex ();
+
   if (con.fillin (get_output_handle ()))
     {
       con.current_win32_attr = con.b.wAttributes;
@@ -952,6 +997,11 @@ fhandler_console::close ()
 {
   debug_printf ("closing: %p, %p", get_handle (), get_output_handle ());
 
+  CloseHandle (input_mutex);
+  input_mutex = NULL;
+  CloseHandle (output_mutex);
+  output_mutex = NULL;
+
   if (shared_console_info && getpid () == con.owner &&
       wincap.has_con_24bit_colors ())
     {
@@ -979,6 +1029,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
   int res = fhandler_termios::ioctl (cmd, arg);
   if (res <= 0)
     return res;
+  acquire_output_mutex (INFINITE);
   switch (cmd)
     {
       case TIOCGWINSZ:
@@ -994,20 +1045,25 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	    syscall_printf ("WINSZ: (row=%d,col=%d)",
 			   ((struct winsize *) arg)->ws_row,
 			   ((struct winsize *) arg)->ws_col);
+	    release_output_mutex ();
 	    return 0;
 	  }
 	else
 	  {
 	    syscall_printf ("WINSZ failed");
 	    __seterrno ();
+	    release_output_mutex ();
 	    return -1;
 	  }
+	release_output_mutex ();
 	return 0;
       case TIOCSWINSZ:
 	bg_check (SIGTTOU);
+	release_output_mutex ();
 	return 0;
       case KDGKBMETA:
 	*(int *) arg = (con.metabit) ? K_METABIT : K_ESCPREFIX;
+	release_output_mutex ();
 	return 0;
       case KDSKBMETA:
 	if ((intptr_t) arg == K_METABIT)
@@ -1017,16 +1073,20 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	else
 	  {
 	    set_errno (EINVAL);
+	    release_output_mutex ();
 	    return -1;
 	  }
+	release_output_mutex ();
 	return 0;
       case TIOCLINUX:
 	if (*(unsigned char *) arg == 6)
 	  {
 	    *(unsigned char *) arg = (unsigned char) con.nModifiers;
+	    release_output_mutex ();
 	    return 0;
 	  }
 	set_errno (EINVAL);
+	release_output_mutex ();
 	return -1;
       case FIONREAD:
 	{
@@ -1039,17 +1099,20 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  if (!PeekConsoleInputW (get_handle (), inp, INREC_SIZE, &n))
 	    {
 	      set_errno (EINVAL);
+	      release_output_mutex ();
 	      return -1;
 	    }
 	  while (n-- > 0)
 	    if (inp[n].EventType == KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown)
 	      ++ret;
 	  *(int *) arg = ret;
+	  release_output_mutex ();
 	  return 0;
 	}
 	break;
     }
 
+  release_output_mutex ();
   return fhandler_base::ioctl (cmd, arg);
 }
 
@@ -1074,6 +1137,7 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
 {
   /* All the output bits we can ignore */
 
+  acquire_output_mutex (INFINITE);
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
   /* If system has 24 bit color capability, use xterm compatible mode. */
   if (wincap.has_con_24bit_colors ())
@@ -1086,6 +1150,7 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   int res = SetConsoleMode (get_output_handle (), flags) ? 0 : -1;
   if (res)
     __seterrno_from_win_error (GetLastError ());
+  release_output_mutex ();
   syscall_printf ("%d = tcsetattr(,%p) (ENABLE FLAGS %y) (lflag %y oflag %y)",
 		  res, t, flags, t->c_lflag, t->c_oflag);
   return res;
@@ -1096,6 +1161,7 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
 {
   /* Ignore the optional_actions stuff, since all output is emitted
      instantly */
+  acquire_input_mutex (INFINITE);
 
   DWORD oflags;
 
@@ -1157,6 +1223,7 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
     }
 
   get_ttyp ()->rstcons (false);
+  release_input_mutex ();
   return res;
 }
 
@@ -1209,7 +1276,8 @@ fhandler_console::tcgetattr (struct termios *t)
 }
 
 fhandler_console::fhandler_console (fh_devices unit) :
-  fhandler_termios (), input_ready (false)
+  fhandler_termios (), input_ready (false),
+  input_mutex (NULL), output_mutex (NULL)
 {
   if (unit > 0)
     dev ().parse (unit);
@@ -2131,9 +2199,11 @@ fhandler_console::char_command (char c)
 	 fhandler_console object associated with standard input.
 	 So puts_readahead does not work.
 	 Use a common console read-ahead buffer instead. */
+      acquire_input_mutex (INFINITE);
       con.cons_rapoi = NULL;
       strcpy (con.cons_rabuf, buf);
       con.cons_rapoi = con.cons_rabuf;
+      release_input_mutex ();
       /* Wake up read() or select() by sending a message
 	 which has no effect */
       PostMessageW (GetConsoleWindow (), WM_SETFOCUS, 0, 0);
@@ -2146,9 +2216,11 @@ fhandler_console::char_command (char c)
 	  y -= con.b.srWindow.Top;
 	  /* x -= con.b.srWindow.Left;		// not available yet */
 	  __small_sprintf (buf, "\033[%d;%dR", y + 1, x + 1);
+	  acquire_input_mutex (INFINITE);
 	  con.cons_rapoi = NULL;
 	  strcpy (con.cons_rabuf, buf);
 	  con.cons_rapoi = con.cons_rabuf;
+	  release_input_mutex ();
 	  /* Wake up read() or select() by sending a message
 	     which has no effect */
 	  PostMessageW (GetConsoleWindow (), WM_SETFOCUS, 0, 0);
@@ -2486,6 +2558,7 @@ fhandler_console::write (const void *vsrc, size_t len)
     return (ssize_t) bg;
 
   push_process_state process_state (PID_TTYOU);
+  acquire_output_mutex (INFINITE);
 
   /* Run and check for ansi sequences */
   unsigned const char *src = (unsigned char *) vsrc;
@@ -2506,7 +2579,10 @@ fhandler_console::write (const void *vsrc, size_t len)
 	case normal:
 	  src = write_normal (src, end);
 	  if (!src) /* write_normal failed */
-	    return -1;
+	    {
+	      release_output_mutex ();
+	      return -1;
+	    }
 	  break;
 	case gotesc:
 	  if (*src == '[')		/* CSI Control Sequence Introducer */
@@ -2675,6 +2751,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	  break;
 	}
     }
+  release_output_mutex ();
 
   syscall_printf ("%ld = fhandler_console::write(...)", len);
 
@@ -2802,6 +2879,7 @@ void
 fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
+  setup_io_mutex ();
 }
 
 // #define WINSTA_ACCESS (WINSTA_READATTRIBUTES | STANDARD_RIGHTS_READ | STANDARD_RIGHTS_WRITE | WINSTA_CREATEDESKTOP | WINSTA_EXITWINDOWS)
@@ -2985,3 +3063,57 @@ fhandler_console::need_invisible ()
   debug_printf ("invisible_console %d", invisible_console);
   return b;
 }
+
+DWORD
+fhandler_console::__acquire_input_mutex (const char *fn, int ln, DWORD ms)
+{
+#ifdef DEBUGGING
+  strace.prntf (_STRACE_TERMIOS, fn, "(%d): trying to get input_mutex", ln);
+#endif
+  DWORD res = WaitForSingleObject (input_mutex, ms);
+  if (res != WAIT_OBJECT_0)
+    strace.prntf (_STRACE_TERMIOS, fn,
+		  "(%d): Failed to acquire input_mutex %08x",
+		  ln, GetLastError ());
+#ifdef DEBUGGING
+  else
+    strace.prntf (_STRACE_TERMIOS, fn, "(%d): got input_mutex", ln);
+#endif
+  return res;
+}
+
+void
+fhandler_console::__release_input_mutex (const char *fn, int ln)
+{
+  ReleaseMutex (input_mutex);
+#ifdef DEBUGGING
+  strace.prntf (_STRACE_TERMIOS, fn, "(%d): release input_mutex", ln);
+#endif
+}
+
+DWORD
+fhandler_console::__acquire_output_mutex (const char *fn, int ln, DWORD ms)
+{
+#ifdef DEBUGGING
+  strace.prntf (_STRACE_TERMIOS, fn, "(%d): trying to get output_mutex", ln);
+#endif
+  DWORD res = WaitForSingleObject (output_mutex, ms);
+  if (res != WAIT_OBJECT_0)
+    strace.prntf (_STRACE_TERMIOS, fn,
+		  "(%d): Failed to acquire output_mutex %08x",
+		  ln, GetLastError ());
+#ifdef DEBUGGING
+  else
+    strace.prntf (_STRACE_TERMIOS, fn, "(%d): got output_mutex", ln);
+#endif
+  return res;
+}
+
+void
+fhandler_console::__release_output_mutex (const char *fn, int ln)
+{
+  ReleaseMutex (output_mutex);
+#ifdef DEBUGGING
+  strace.prntf (_STRACE_TERMIOS, fn, "(%d): release output_mutex", ln);
+#endif
+}
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 790f15791..85242ec06 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1039,15 +1039,20 @@ peek_console (select_record *me, bool)
   set_handle_or_return_if_not_open (h, me);
 
   while (!fh->input_ready && !fh->get_cons_readahead_valid ())
-    if (fh->bg_check (SIGTTIN, true) <= bg_eof)
-      return me->read_ready = true;
-    else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
-      break;
-    else if (fhandler_console::input_winch == fh->process_input_message ())
-      {
-	set_sig_errno (EINTR);
-	return -1;
-      }
+    {
+      if (fh->bg_check (SIGTTIN, true) <= bg_eof)
+	return me->read_ready = true;
+      else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
+	break;
+      fh->acquire_input_mutex (INFINITE);
+      if (fhandler_console::input_winch == fh->process_input_message ())
+	{
+	  set_sig_errno (EINTR);
+	  fh->release_input_mutex ();
+	  return -1;
+	}
+      fh->release_input_mutex ();
+    }
   if (fh->input_ready || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
-- 
2.17.0
