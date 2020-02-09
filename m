Return-Path: <cygwin-patches-return-10050-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100318 invoked by alias); 9 Feb 2020 14:47:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100308 invoked by uid 89); 9 Feb 2020 14:47:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Inherit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 14:47:11 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-01.nifty.com with ESMTP id 019Ekxn0016887;	Sun, 9 Feb 2020 23:47:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com 019Ekxn0016887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581259624;	bh=6VqGOufzQ4/sECmwsFSo9UwnNOyUb0RebBO9+bQ7Z/s=;	h=From:To:Cc:Subject:Date:From;	b=g6U/Rrs2SEIih2s6zg5O92uBiPUSh5B/Q+IjQju6W5UGciyZUvWupaVCLa1YSk25Q	 tPz/3Yfv7JLbODN5PijUy4/PIR9qPniyZ6nti1xi9LSbCTqoO1hxd377TVh+BFFm9T	 1LPP38pmZBvpZcLsEyALXDdAgPY+/B0i8Km/cE7GQSPUYMz1clQD5pf7aqA0IszJUI	 w0l8axUXmJr/HiQP7LNDeILPK23VvC0c/KcLa5rdzHXYO/AsZON28zvzuiPG+NlJ0v	 JPWRYwdiq5guATz0oW76/vVy71GFrtaF6Zvkl5rwcm8PfkpJ6lf92zuAUeXOM4sPc4	 SGnj9wne8JFwA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Inherit typeahead data between two input pipes.
Date: Sun, 09 Feb 2020 14:47:00 -0000
Message-Id: <20200209144659.441-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00156.txt

- PTY has a problem that the key input, which is typed during
  windows native app is running, disappear when it returns to shell.
  (Problem 3 in https://cygwin.com/ml/cygwin/2020-02/msg00007.html)
  This is beacuse pty has two input pipes, one is for cygwin apps
  and the other one is for native windows apps. The key input during
  windows native program is running is sent to the second input pipe
  while cygwin shell reads input from the first input pipe.
  This patch realize transfering input data between these two pipes.
---
 winsup/cygwin/fhandler.h      |  12 +-
 winsup/cygwin/fhandler_tty.cc | 400 ++++++++++++++++++++++++++--------
 winsup/cygwin/select.cc       |   2 +
 winsup/cygwin/tty.cc          |   3 +
 winsup/cygwin/tty.h           |   3 +
 5 files changed, 329 insertions(+), 91 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index a22f3a136..993d7355a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -326,7 +326,7 @@ class fhandler_base
   virtual size_t &raixput () { return ra.raixput; };
   virtual size_t &rabuflen () { return ra.rabuflen; };
 
-  bool get_readahead_valid () { return raixget () < ralen (); }
+  virtual bool get_readahead_valid () { return raixget () < ralen (); }
   int puts_readahead (const char *s, size_t len = (size_t) -1);
   int put_readahead (char value);
 
@@ -335,7 +335,7 @@ class fhandler_base
 
   void set_readahead_valid (int val, int ch = -1);
 
-  int get_readahead_into_buffer (char *buf, size_t buflen);
+  virtual int get_readahead_into_buffer (char *buf, size_t buflen);
 
   bool has_acls () const { return pc.has_acls (); }
 
@@ -1768,7 +1768,7 @@ class fhandler_termios: public fhandler_base
   int ioctl (int, void *);
   tty_min *_tc;
   tty *get_ttyp () {return (tty *) tc ();}
-  int eat_readahead (int n);
+  virtual int eat_readahead (int n);
 
  public:
   tty_min*& tc () {return _tc;}
@@ -2168,6 +2168,9 @@ class fhandler_pty_slave: public fhandler_pty_common
   ssize_t __stdcall write (const void *ptr, size_t len);
   void __reg3 read (void *ptr, size_t& len);
   int init (HANDLE, DWORD, mode_t);
+  int eat_readahead (int n);
+  int get_readahead_into_buffer (char *buf, size_t buflen);
+  bool get_readahead_valid (void);
 
   int tcsetattr (int a, const struct termios *t);
   int tcgetattr (struct termios *t);
@@ -2217,6 +2220,8 @@ class fhandler_pty_slave: public fhandler_pty_common
   void set_freeconsole_on_close (bool val);
   void trigger_redraw_screen (void);
   void wait_pcon_fwd (void);
+  void pull_pcon_input (void);
+  void update_pcon_input_state (bool need_lock);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
@@ -2281,6 +2286,7 @@ public:
   }
 
   bool setup_pseudoconsole (void);
+  void transfer_input_to_pcon (void);
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1c23c93e3..f2fd680ea 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -440,6 +440,10 @@ fhandler_pty_master::flush_to_slave ()
 {
   if (get_readahead_valid () && !(get_ttyp ()->ti.c_lflag & ICANON))
     accept_input ();
+  WaitForSingleObject (input_mutex, INFINITE);
+  if (!get_ttyp ()->pcon_in_empty && !(get_ttyp ()->ti.c_lflag & ICANON))
+    SetEvent (input_available_event);
+  ReleaseMutex (input_mutex);
 }
 
 DWORD
@@ -519,7 +523,7 @@ fhandler_pty_master::accept_input ()
       termios_printf ("sending EOF to slave");
       get_ttyp ()->read_retval = 0;
     }
-  else
+  else if (!to_be_read_from_pcon ())
     {
       char *p = rabuf ();
       DWORD rc;
@@ -986,7 +990,6 @@ fhandler_pty_slave::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (pcon_attached_to == get_minor ())
     get_ttyp ()->num_pcon_attached_slaves --;
-  get_ttyp ()->mask_switch_to_pcon_in = false;
   return 0;
 }
 
@@ -1076,6 +1079,157 @@ fhandler_pty_slave::restore_reattach_pcon (void)
   pid_restore = 0;
 }
 
+/* This function requests transfering the input data from the input
+   pipe for cygwin apps to the other input pipe for native apps. */
+void
+fhandler_pty_slave::pull_pcon_input (void)
+{
+  get_ttyp ()->req_transfer_input_to_pcon = true;
+  while (get_ttyp ()->req_transfer_input_to_pcon)
+    Sleep (1);
+}
+
+void
+fhandler_pty_slave::update_pcon_input_state (bool need_lock)
+{
+  if (need_lock)
+    WaitForSingleObject (input_mutex, INFINITE);
+  /* Flush input buffer if it is requested by master.
+     This happens if ^C is pressed in pseudo console side. */
+  if (get_ttyp ()->req_flush_pcon_input)
+    {
+      FlushConsoleInputBuffer (get_handle ());
+      get_ttyp ()->req_flush_pcon_input = false;
+    }
+  /* Peek console input buffer and update state. */
+  INPUT_RECORD inp[INREC_SIZE];
+  DWORD n;
+  BOOL (WINAPI *PeekFunc)
+    (HANDLE, PINPUT_RECORD, DWORD, LPDWORD);
+  PeekFunc =
+    PeekConsoleInputA_Orig ? : PeekConsoleInput;
+  PeekFunc (get_handle (), inp, INREC_SIZE, &n);
+  bool saw_accept = false;
+  bool pipe_empty = true;
+  while (n-- > 0)
+    if (inp[n].EventType == KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown &&
+	inp[n].Event.KeyEvent.uChar.AsciiChar)
+      {
+	pipe_empty = false;
+	char c = inp[n].Event.KeyEvent.uChar.AsciiChar;
+	const char sigs[] = {
+	  (char) get_ttyp ()->ti.c_cc[VINTR],
+	  (char) get_ttyp ()->ti.c_cc[VQUIT],
+	  (char) get_ttyp ()->ti.c_cc[VSUSP],
+	};
+	const char eols[] = {
+	  (char) get_ttyp ()->ti.c_cc[VEOF],
+	  (char) get_ttyp ()->ti.c_cc[VEOL],
+	  (char) get_ttyp ()->ti.c_cc[VEOL2],
+	  '\n',
+	  '\r'
+	};
+	if (is_line_input () && memchr (eols, c, sizeof (eols)))
+	  saw_accept = true;
+	if ((get_ttyp ()->ti.c_lflag & ISIG) &&
+	    memchr (sigs, c, sizeof (sigs)))
+	  saw_accept = true;
+      }
+  get_ttyp ()->pcon_in_empty = pipe_empty && !(ralen () > raixget ());
+  if (!get_readahead_valid () &&
+      (pipe_empty || (is_line_input () && !saw_accept)) &&
+      get_ttyp ()->read_retval == 1 && bytes_available (n) && n == 0)
+    ResetEvent (input_available_event);
+  if (need_lock)
+    ReleaseMutex (input_mutex);
+}
+
+int
+fhandler_pty_slave::eat_readahead (int n)
+{
+  int oralen = ralen () - raixget ();
+  if (n < 0)
+    n = ralen () - raixget ();
+  if (n > 0 && ralen () > raixget ())
+    {
+      const char eols[] = {
+	(char) get_ttyp ()->ti.c_cc[VEOF],
+	(char) get_ttyp ()->ti.c_cc[VEOL],
+	(char) get_ttyp ()->ti.c_cc[VEOL2],
+	'\n'
+      };
+      while (n > 0 && ralen () > raixget ())
+	{
+	  if (memchr (eols, rabuf ()[ralen ()-1], sizeof (eols)))
+	    break;
+	  -- n;
+	  -- ralen ();
+	}
+
+      /* If IUTF8 is set, the terminal is in UTF-8 mode.  If so, we erase
+	 a complete UTF-8 multibyte sequence on VERASE/VWERASE.  Otherwise,
+	 if we only erase a single byte, invalid unicode chars are left in
+	 the input. */
+      if (get_ttyp ()->ti.c_iflag & IUTF8)
+	while (ralen () > 0 &&
+	       ((unsigned char) rabuf ()[ralen ()] & 0xc0) == 0x80)
+	  --ralen ();
+
+      if (raixget () >= ralen ())
+	raixget () = raixput () = ralen () = 0;
+      else if (raixput () > ralen ())
+	raixput () = ralen ();
+    }
+
+  return oralen;
+}
+
+int
+fhandler_pty_slave::get_readahead_into_buffer (char *buf, size_t buflen)
+{
+  int ch;
+  int copied_chars = 0;
+
+  while (buflen)
+    if ((ch = get_readahead ()) < 0)
+      break;
+    else
+      {
+	const char eols[] = {
+	  (char) get_ttyp ()->ti.c_cc[VEOF],
+	  (char) get_ttyp ()->ti.c_cc[VEOL],
+	  (char) get_ttyp ()->ti.c_cc[VEOL2],
+	  '\n'
+	};
+	buf[copied_chars++] = (unsigned char)(ch & 0xff);
+	buflen--;
+	if (is_line_input () && memchr (eols, ch & 0xff, sizeof (eols)))
+	  break;
+      }
+
+  return copied_chars;
+}
+
+bool
+fhandler_pty_slave::get_readahead_valid (void)
+{
+  if (is_line_input ())
+    {
+      const char eols[] = {
+	(char) get_ttyp ()->ti.c_cc[VEOF],
+	(char) get_ttyp ()->ti.c_cc[VEOL],
+	(char) get_ttyp ()->ti.c_cc[VEOL2],
+	'\n'
+      };
+      for (size_t i=raixget (); i<ralen (); i++)
+	if (memchr (eols, rabuf ()[i], sizeof (eols)))
+	  return true;
+      return false;
+    }
+  else
+    return ralen () > raixget ();
+}
+
 void
 fhandler_pty_slave::set_switch_to_pcon (int fd_set)
 {
@@ -1083,13 +1237,7 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
     fd = fd_set;
   if (fd == 0 && !get_ttyp ()->switch_to_pcon_in)
     {
-      pid_restore = 0;
-      if (pcon_attached_to != get_minor ())
-	if (!try_reattach_pcon ())
-	  goto skip_console_setting;
-      FlushConsoleInputBuffer (get_handle ());
-skip_console_setting:
-      restore_reattach_pcon ();
+      pull_pcon_input ();
       if (get_ttyp ()->pcon_pid == 0 ||
 	  !pinfo (get_ttyp ()->pcon_pid))
 	get_ttyp ()->pcon_pid = myself->pid;
@@ -1121,16 +1269,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     /* There is a process which is grabbing pseudo console. */
     return;
   if (isHybrid)
-    {
-      DWORD bytes_in_pipe;
-      WaitForSingleObject (input_mutex, INFINITE);
-      if (bytes_available (bytes_in_pipe) && !bytes_in_pipe)
-	ResetEvent (input_available_event);
-      FlushConsoleInputBuffer (get_handle ());
-      ReleaseMutex (input_mutex);
-      init_console_handler (true);
-      return;
-    }
+    return;
   if (do_not_reset_switch_to_pcon)
     return;
   if (get_ttyp ()->switch_to_pcon_out)
@@ -1333,6 +1472,14 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
     if (!try_reattach_pcon ())
       fallback = true;
 
+  if (get_ttyp ()->switch_to_pcon_out && !fallback &&
+      (memmem (buf, nlen, "\033[6n", 4) || memmem (buf, nlen, "\033[0c", 4)))
+    {
+      get_ttyp ()->pcon_in_empty = false;
+      if (!is_line_input ())
+	SetEvent (input_available_event);
+    }
+
   DWORD dwMode, flags;
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
@@ -1382,18 +1529,14 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 void
 fhandler_pty_slave::mask_switch_to_pcon_in (bool mask)
 {
-  if (!mask && get_ttyp ()->pcon_pid &&
-      get_ttyp ()->pcon_pid != myself->pid &&
-      !!pinfo (get_ttyp ()->pcon_pid))
-    return;
   get_ttyp ()->mask_switch_to_pcon_in = mask;
 }
 
 bool
 fhandler_pty_common::to_be_read_from_pcon (void)
 {
-  return get_ttyp ()->switch_to_pcon_in &&
-    !get_ttyp ()->mask_switch_to_pcon_in;
+  return !get_ttyp ()->pcon_in_empty ||
+    (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->mask_switch_to_pcon_in);
 }
 
 void __reg3
@@ -1424,6 +1567,8 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
       mask_switch_to_pcon_in (true);
       reset_switch_to_pcon ();
     }
+  if (to_be_read_from_pcon ())
+    update_pcon_input_state (true);
 
   if (is_nonblocking () || !ptr) /* Indicating tcflush(). */
     time_to_wait = 0;
@@ -1523,60 +1668,81 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    }
 	  goto out;
 	}
-      if (to_be_read_from_pcon ())
+      if (ptr && to_be_read_from_pcon ())
 	{
-	  if (!try_reattach_pcon ())
+	  if (get_readahead_valid ())
 	    {
-	      restore_reattach_pcon ();
-	      goto do_read_cyg;
+	      ReleaseMutex (input_mutex);
+	      totalread = get_readahead_into_buffer ((char *) ptr, len);
 	    }
-
-	  DWORD dwMode;
-	  GetConsoleMode (get_handle (), &dwMode);
-	  DWORD flags = ENABLE_VIRTUAL_TERMINAL_INPUT;
-	  if (get_ttyp ()->ti.c_lflag & ECHO)
-	    flags |= ENABLE_ECHO_INPUT;
-	  if (get_ttyp ()->ti.c_lflag & ICANON)
-	    flags |= ENABLE_LINE_INPUT;
-	  if (flags & ENABLE_ECHO_INPUT && !(flags & ENABLE_LINE_INPUT))
-	    flags &= ~ENABLE_ECHO_INPUT;
-	  if ((get_ttyp ()->ti.c_lflag & ISIG) &&
-	      !(get_ttyp ()->ti.c_iflag & IGNBRK))
-	    flags |= ENABLE_PROCESSED_INPUT;
-	  if (dwMode != flags)
-	    SetConsoleMode (get_handle (), flags);
-	  /* Read get_handle() instad of get_handle_cyg() */
-	  BOOL (WINAPI *ReadFunc)
-	    (HANDLE, LPVOID, DWORD, LPDWORD, LPOVERLAPPED);
-	  ReadFunc = ReadFile_Orig ? ReadFile_Orig : ReadFile;
-	  DWORD rlen;
-	  if (!ReadFunc (get_handle (), ptr, len, &rlen, NULL))
+	  else
 	    {
-	      termios_printf ("read failed, %E");
+	      if (!try_reattach_pcon ())
+		{
+		  restore_reattach_pcon ();
+		  goto do_read_cyg;
+		}
+
+	      DWORD dwMode;
+	      GetConsoleMode (get_handle (), &dwMode);
+	      DWORD flags = ENABLE_VIRTUAL_TERMINAL_INPUT;
+	      if (dwMode != flags)
+		SetConsoleMode (get_handle (), flags);
+	      /* Read get_handle() instad of get_handle_cyg() */
+	      BOOL (WINAPI *ReadFunc)
+		(HANDLE, LPVOID, DWORD, LPDWORD, LPVOID);
+	      ReadFunc = ReadConsoleA_Orig ? ReadConsoleA_Orig : ReadConsoleA;
+	      DWORD rlen;
+	      readlen = MIN (len, sizeof (buf));
+	      if (!ReadFunc (get_handle (), buf, readlen, &rlen, NULL))
+		{
+		  termios_printf ("read failed, %E");
+		  SetConsoleMode (get_handle (), dwMode);
+		  restore_reattach_pcon ();
+		  ReleaseMutex (input_mutex);
+		  set_errno (EIO);
+		  totalread = -1;
+		  goto out;
+		}
+	      SetConsoleMode (get_handle (), dwMode);
+	      restore_reattach_pcon ();
 	      ReleaseMutex (input_mutex);
-	      set_errno (EIO);
-	      totalread = -1;
-	      goto out;
+
+	      ssize_t nlen;
+	      char *nbuf = convert_mb_str (get_ttyp ()->term_code_page,
+			     (size_t *) &nlen, GetConsoleCP (), buf, rlen);
+
+	      ssize_t ret;
+	      line_edit_status res =
+		line_edit (nbuf, nlen, get_ttyp ()->ti, &ret);
+
+	      mb_str_free (nbuf);
+
+	      if (res == line_edit_input_done || res == line_edit_ok)
+		totalread = get_readahead_into_buffer ((char *) ptr, len);
+	      else if (res > line_edit_signalled)
+		{
+		  set_sig_errno (EINTR);
+		  totalread = -1;
+		}
+	      else
+		{
+		  update_pcon_input_state (true);
+		  continue;
+		}
 	    }
-	  INPUT_RECORD inp[128];
-	  DWORD n;
-	  BOOL (WINAPI *PeekFunc)
-	    (HANDLE, PINPUT_RECORD, DWORD, LPDWORD);
-	  PeekFunc =
-	    PeekConsoleInputA_Orig ? PeekConsoleInputA_Orig : PeekConsoleInput;
-	  PeekFunc (get_handle (), inp, 128, &n);
-	  bool pipe_empty = true;
-	  while (n-- > 0)
-	    if (inp[n].EventType == KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown)
-	      pipe_empty = false;
-	  if (pipe_empty)
-	    ResetEvent (input_available_event);
-	  ReleaseMutex (input_mutex);
-	  len = rlen;
 
-	  restore_reattach_pcon ();
+	  update_pcon_input_state (true);
 	  mask_switch_to_pcon_in (false);
-	  return;
+	  goto out;
+	}
+      if (!ptr && len == UINT_MAX && !get_ttyp ()->pcon_in_empty)
+	{
+	  FlushConsoleInputBuffer (get_handle ());
+	  get_ttyp ()->pcon_in_empty = true;
+	  DWORD n;
+	  if (bytes_available (n) && n == 0)
+	    ResetEvent (input_available_event);
 	}
 
 do_read_cyg:
@@ -1697,7 +1863,8 @@ out:
   termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
   /* Push slave read as echo to pseudo console screen buffer. */
-  if (get_pseudo_console () && ptr0 && (get_ttyp ()->ti.c_lflag & ECHO))
+  if (get_pseudo_console () && ptr0 && totalread > 0 &&
+      (get_ttyp ()->ti.c_lflag & ECHO))
     {
       acquire_output_mutex (INFINITE);
       push_to_pcon_screenbuffer (ptr0, len, true);
@@ -2307,19 +2474,41 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
       WaitForSingleObject (input_mutex, INFINITE);
 
+      if (memchr (buf, '\003', nlen)) /* ^C intr key in pcon */
+	get_ttyp ()->req_flush_pcon_input = true;
+
       DWORD wLen;
       WriteFile (to_slave, buf, nlen, &wLen, NULL);
-
-      if (ti.c_lflag & ICANON)
-	{
-	  if (memchr (buf, '\r', nlen))
-	    SetEvent (input_available_event);
-	}
-      else
-	SetEvent (input_available_event);
+      get_ttyp ()->pcon_in_empty = false;
 
       ReleaseMutex (input_mutex);
 
+      /* Use line_edit () in order to set input_available_event. */
+      bool is_echo = tc ()->ti.c_lflag & ECHO;
+      if (!get_ttyp ()->mask_switch_to_pcon_in)
+	{
+	  tc ()->ti.c_lflag &= ~ECHO;
+	  ti.c_lflag &= ~ECHO;
+	}
+      ti.c_lflag &= ~ISIG;
+      line_edit (buf, nlen, ti, &ret);
+      if (is_echo)
+	tc ()->ti.c_lflag |= ECHO;
+      get_ttyp ()->read_retval = 1;
+
+      const char sigs[] = {
+	(char) ti.c_cc[VINTR],
+	(char) ti.c_cc[VQUIT],
+	(char) ti.c_cc[VSUSP],
+      };
+      if (tc ()->ti.c_lflag & ISIG)
+	for (size_t i=0; i<sizeof (sigs); i++)
+	  if (memchr (buf, sigs[i], nlen))
+	    {
+	      eat_readahead (-1);
+	      SetEvent (input_available_event);
+	    }
+
       mb_str_free (buf);
       return len;
     }
@@ -2716,11 +2905,17 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	  get_ttyp ()->num_pcon_attached_slaves ++;
 	}
 
+#if 0 /* This is for debug only. */
+      isHybrid = true;
+      get_ttyp ()->switch_to_pcon_in = true;
+      get_ttyp ()->switch_to_pcon_out = true;
+#endif
+
       if (pcon_attached_to == get_minor () && native_maybe)
 	{
 	  if (fd == 0)
 	    {
-	      FlushConsoleInputBuffer (get_handle ());
+	      pull_pcon_input ();
 	      DWORD mode =
 		ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
 	      SetConsoleMode (get_handle (), mode);
@@ -2764,13 +2959,6 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 void
 fhandler_pty_slave::fixup_after_exec ()
 {
-  /* Native windows program does not reset event on read.
-     Therefore, reset here if no input is available. */
-  DWORD bytes_in_pipe;
-  if (!to_be_read_from_pcon () &&
-      bytes_available (bytes_in_pipe) && !bytes_in_pipe)
-    ResetEvent (input_available_event);
-
   reset_switch_to_pcon ();
 
   if (!close_on_exec ())
@@ -2988,6 +3176,33 @@ reply:
   return 0;
 }
 
+void
+fhandler_pty_master::transfer_input_to_pcon (void)
+{
+  WaitForSingleObject (input_mutex, INFINITE);
+  DWORD n;
+  size_t transfered = 0;
+  while (::bytes_available (n, from_master_cyg) && n)
+    {
+      char buf[1024];
+      ReadFile (from_master_cyg, buf, sizeof (buf), &n, 0);
+      char *p = buf;
+      while ((p = (char *) memchr (p, '\n', n - (p - buf))))
+	*p = '\r';
+      if (WriteFile (to_slave, buf, n, &n, 0))
+	transfered += n;
+    }
+  DWORD bytes_left = eat_readahead (-1);
+  if (bytes_left)
+    {
+      if (WriteFile (to_slave, rabuf (), bytes_left, &n, NULL))
+	transfered += n;
+    }
+  if (transfered)
+    get_ttyp ()->pcon_in_empty = false;
+  ReleaseMutex (input_mutex);
+}
+
 static DWORD WINAPI
 pty_master_thread (VOID *arg)
 {
@@ -3018,6 +3233,15 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      if (GetTickCount () - get_ttyp ()->pcon_last_time > time_to_wait)
 		SetEvent (get_ttyp ()->fwd_done);
 	      release_output_mutex ();
+	      /* Forcibly transfer input if it is requested by slave.
+		 This happens when input data should be transfered
+		 from the input pipe for cygwin apps to the input pipe
+		 for native apps. */
+	      if (get_ttyp ()->req_transfer_input_to_pcon)
+		{
+		  transfer_input_to_pcon ();
+		  get_ttyp ()->req_transfer_input_to_pcon = false;
+		}
 	      Sleep (1);
 	    }
 	}
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 5048e549f..b06441c77 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1195,6 +1195,8 @@ peek_pty_slave (select_record *s, bool from_select)
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 
   ptys->reset_switch_to_pcon ();
+  if (ptys->to_be_read_from_pcon ())
+    ptys->update_pcon_input_state (true);
 
   if (s->read_selected)
     {
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index a3d4a0fc8..0663dc5ee 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -247,6 +247,9 @@ tty::init ()
   need_redraw_screen = false;
   fwd_done = NULL;
   pcon_last_time = 0;
+  pcon_in_empty = true;
+  req_transfer_input_to_pcon = false;
+  req_flush_pcon_input = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 755897d7d..a24afad06 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -108,6 +108,9 @@ private:
   bool need_redraw_screen;
   HANDLE fwd_done;
   DWORD pcon_last_time;
+  bool pcon_in_empty;
+  bool req_transfer_input_to_pcon;
+  bool req_flush_pcon_input;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
