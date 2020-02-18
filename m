Return-Path: <cygwin-patches-return-10082-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125192 invoked by alias); 18 Feb 2020 09:13:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125161 invoked by uid 89); 18 Feb 2020 09:13:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 09:13:27 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 01I9DBA4024428;	Tue, 18 Feb 2020 18:13:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 01I9DBA4024428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582017196;	bh=DzhaiUXMTjxG5qkqoJtIVbTE/3yR0gaQmnPc3zTUSlo=;	h=From:To:Cc:Subject:Date:From;	b=wXtV/WxOxb/K7ggWGcP97ZSb2ywYqIwTMMVnE/ToM3nklltYmt4r75LQRbFyFuNCc	 7aoBNfOyejwBDKbcMGMSSAiWtFv8Sl10WO2VVTiDyEgiDNhoBw5uojQm3kdUh3FFn/	 f99tX7q2BvUqeJcYRcABj6Yg6o3chtkExXBnDuIWgIv7oR4/LVCSJlWun8kDfv8el+	 FEIrc2zy2RMl3FnlTrhzFke7E/Jq6kL4bxiFrNDRq2suKkYhjVCnFXfGLyQywU9Q7v	 a+4EaWvjQ38KKXsC/d7PtFu6GUltemfY8xEmpVKK2Z1uzjYgaGAU6t24++JE6SAjD8	 ydu2YgdfxJx8A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: console: Add guard for set/unset xterm compatible mode.
Date: Tue, 18 Feb 2020 09:13:00 -0000
Message-Id: <20200218091254.415-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00188.txt

- Setting / unsetting xterm compatible mode may cause race issue
  between multiple processes. This patch adds guard for that.
---
 winsup/cygwin/fhandler.h          |   6 ++
 winsup/cygwin/fhandler_console.cc | 125 +++++++++++++++++++++---------
 winsup/cygwin/select.cc           |  22 ++----
 winsup/cygwin/spawn.cc            |   8 +-
 4 files changed, 103 insertions(+), 58 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 993d7355a..55f18aebd 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1911,6 +1911,8 @@ class dev_console
   bool raw_win32_keyboard_mode;
   char cons_rabuf[40];  // cannot get longer than char buf[40] in char_command
   char *cons_rapoi;
+  LONG xterm_mode_input;
+  LONG xterm_mode_output;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
@@ -1983,6 +1985,7 @@ private:
   static bool create_invisible_console (HWINSTA);
   static bool create_invisible_console_workaround ();
   static console_state *open_shared_console (HWND, HANDLE&, bool&);
+  void fix_tab_position (void);
 
  public:
   static pid_t tc_getpgid ()
@@ -2072,6 +2075,9 @@ private:
   size_t &raixput ();
   size_t &rabuflen ();
 
+  void request_xterm_mode_input (bool);
+  void request_xterm_mode_output (bool);
+
   friend tty_min * tty_list::get_cttyp ();
 };
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 9bfee64d3..152149a0d 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -53,8 +53,6 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
 
 bool NO_COPY fhandler_console::invisible_console;
 
-static DWORD orig_conout_mode = (DWORD) -1;
-
 /* con_ra is shared in the same process.
    Only one console can exist in a process, therefore, static is suitable. */
 static struct fhandler_base::rabuf_t con_ra;
@@ -162,13 +160,17 @@ fhandler_console::set_unit ()
 	  tty_min_state.setntty (DEV_CONS_MAJOR, console_unit (me));
       devset = (fh_devices) shared_console_info->tty_min_state.getntty ();
       if (created)
-	con.owner = getpid ();
+	{
+	  con.owner = myself->pid;
+	  con.xterm_mode_input = 0;
+	  con.xterm_mode_output = 0;
+	}
     }
   if (!created && shared_console_info)
     {
       pinfo p (con.owner);
       if (!p)
-	con.owner = getpid ();
+	con.owner = myself->pid;
     }
 
   dev ().parse (devset);
@@ -247,6 +249,60 @@ fhandler_console::rabuflen ()
   return con_ra.rabuflen;
 }
 
+void
+fhandler_console::request_xterm_mode_input (bool req)
+{
+  if (con_is_legacy)
+    return;
+  if (req)
+    {
+      if (InterlockedIncrement (&con.xterm_mode_input) == 1)
+	{
+	  DWORD dwMode;
+	  GetConsoleMode (get_handle (), &dwMode);
+	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
+	  SetConsoleMode (get_handle (), dwMode);
+	}
+    }
+  else
+    {
+      if (InterlockedDecrement (&con.xterm_mode_input) == 0)
+	{
+	  DWORD dwMode;
+	  GetConsoleMode (get_handle (), &dwMode);
+	  dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
+	  SetConsoleMode (get_handle (), dwMode);
+	}
+    }
+}
+
+void
+fhandler_console::request_xterm_mode_output (bool req)
+{
+  if (con_is_legacy)
+    return;
+  if (req)
+    {
+      if (InterlockedExchange (&con.xterm_mode_output, 1) == 0)
+	{
+	  DWORD dwMode;
+	  GetConsoleMode (get_output_handle (), &dwMode);
+	  dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+	  SetConsoleMode (get_output_handle (), dwMode);
+	}
+    }
+  else
+    {
+      if (InterlockedExchange (&con.xterm_mode_output, 0) == 1)
+	{
+	  DWORD dwMode;
+	  GetConsoleMode (get_output_handle (), &dwMode);
+	  dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+	  SetConsoleMode (get_output_handle (), dwMode);
+	}
+    }
+}
+
 /* Return the tty structure associated with a given tty number.  If the
    tty number is < 0, just return a dummy record. */
 tty_min *
@@ -347,8 +403,8 @@ fhandler_console::set_cursor_maybe ()
 
 /* Workaround for a bug of windows xterm compatible mode. */
 /* The horizontal tab positions are broken after resize. */
-static void
-fix_tab_position (HANDLE h, SHORT width)
+void
+fhandler_console::fix_tab_position (void)
 {
   char buf[2048] = {0,};
   /* Save cursor position */
@@ -356,15 +412,13 @@ fix_tab_position (HANDLE h, SHORT width)
   /* Clear all horizontal tabs */
   __small_sprintf (buf+strlen (buf), "\033[3g");
   /* Set horizontal tabs */
-  for (int col=8; col<width; col+=8)
+  for (int col=8; col<con.dwWinSize.X; col+=8)
     __small_sprintf (buf+strlen (buf), "\033[%d;%dH\033H", 1, col+1);
   /* Restore cursor position */
   __small_sprintf (buf+strlen (buf), "\0338");
-  DWORD dwMode;
-  GetConsoleMode (h, &dwMode);
-  SetConsoleMode (h, dwMode | ENABLE_VIRTUAL_TERMINAL_PROCESSING);
+  request_xterm_mode_output (true);
   DWORD dwLen;
-  WriteConsole (h, buf, strlen (buf), &dwLen, 0);
+  WriteConsole (get_output_handle (), buf, strlen (buf), &dwLen, 0);
 }
 
 bool
@@ -379,7 +433,7 @@ fhandler_console::send_winch_maybe ()
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
-	fix_tab_position (get_output_handle (), con.dwWinSize.X);
+	fix_tab_position ();
       get_ttyp ()->kill_pgrp (SIGWINCH);
       return true;
     }
@@ -427,11 +481,9 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   set_input_state ();
 
-  DWORD dwMode;
-  GetConsoleMode (get_handle (), &dwMode);
   /* if system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con_is_legacy)
-    SetConsoleMode (get_handle (), dwMode | ENABLE_VIRTUAL_TERMINAL_INPUT);
+  if (wincap.has_con_24bit_colors ())
+    request_xterm_mode_input (true);
 
   while (!input_ready && !get_cons_readahead_valid ())
     {
@@ -439,7 +491,8 @@ fhandler_console::read (void *pv, size_t& buflen)
       if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
 	{
 	  buflen = bgres;
-	  SetConsoleMode (get_handle (), dwMode); /* Restore */
+	  if (wincap.has_con_24bit_colors ())
+	    request_xterm_mode_input (false);
 	  return;
 	}
 
@@ -457,7 +510,8 @@ fhandler_console::read (void *pv, size_t& buflen)
 	case WAIT_TIMEOUT:
 	  set_sig_errno (EAGAIN);
 	  buflen = (size_t) -1;
-	  SetConsoleMode (get_handle (), dwMode); /* Restore */
+	  if (wincap.has_con_24bit_colors ())
+	    request_xterm_mode_input (false);
 	  return;
 	default:
 	  goto err;
@@ -505,19 +559,22 @@ fhandler_console::read (void *pv, size_t& buflen)
 #undef buf
 
   buflen = copied_chars;
-  SetConsoleMode (get_handle (), dwMode); /* Restore */
+  if (wincap.has_con_24bit_colors ())
+    request_xterm_mode_input (false);
   return;
 
 err:
   __seterrno ();
   buflen = (size_t) -1;
-  SetConsoleMode (get_handle (), dwMode); /* Restore */
+  if (wincap.has_con_24bit_colors ())
+    request_xterm_mode_input (false);
   return;
 
 sig_exit:
   set_sig_errno (EINTR);
   buflen = (size_t) -1;
-  SetConsoleMode (get_handle (), dwMode); /* Restore */
+  if (wincap.has_con_24bit_colors ())
+    request_xterm_mode_input (false);
 }
 
 fhandler_console::input_states
@@ -1051,10 +1108,7 @@ fhandler_console::open (int flags, mode_t)
   get_ttyp ()->rstcons (false);
   set_open_status ();
 
-  if (orig_conout_mode == (DWORD) -1)
-    GetConsoleMode (get_output_handle (), &orig_conout_mode);
-
-  if (getpid () == con.owner && wincap.has_con_24bit_colors ())
+  if (myself->pid == con.owner && wincap.has_con_24bit_colors ())
     {
       bool is_legacy = false;
       DWORD dwMode;
@@ -1105,15 +1159,9 @@ fhandler_console::close ()
 
   acquire_output_mutex (INFINITE);
 
-  if (shared_console_info && getpid () == con.owner &&
+  if (shared_console_info && myself->pid == con.owner &&
       wincap.has_con_24bit_colors () && !con_is_legacy)
-    {
-      DWORD dwMode;
-      /* Disable xterm compatible mode in output */
-      GetConsoleMode (get_output_handle (), &dwMode);
-      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-      SetConsoleMode (get_output_handle (), dwMode);
-    }
+    request_xterm_mode_output (false);
 
   /* Restore console mode if this is the last closure. */
   OBJECT_BASIC_INFORMATION obi;
@@ -1121,8 +1169,8 @@ fhandler_console::close ()
   status = NtQueryObject (get_handle (), ObjectBasicInformation,
 			  &obi, sizeof obi, NULL);
   if (NT_SUCCESS (status) && obi.HandleCount == 1)
-    if (orig_conout_mode != (DWORD) -1)
-      SetConsoleMode (get_output_handle (), orig_conout_mode);
+    if (wincap.has_con_24bit_colors ())
+      request_xterm_mode_output (false);
 
   release_output_mutex ();
 
@@ -1266,6 +1314,8 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   /* All the output bits we can ignore */
 
   acquire_output_mutex (INFINITE);
+  if (wincap.has_con_24bit_colors ())
+    request_xterm_mode_output (false);
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 
   int res = SetConsoleMode (get_output_handle (), flags) ? 0 : -1;
@@ -1736,7 +1786,7 @@ bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
     }
   /* Call fix_tab_position() if screen has been alternated. */
   if (need_fix_tab_position)
-    fix_tab_position (get_output_handle (), con.dwWinSize.X);
+    fix_tab_position ();
   return true;
 }
 
@@ -2704,11 +2754,12 @@ fhandler_console::write (const void *vsrc, size_t len)
   acquire_output_mutex (INFINITE);
 
   /* If system has 24 bit color capability, use xterm compatible mode. */
+  if (wincap.has_con_24bit_colors ())
+    request_xterm_mode_output (true);
   if (wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       DWORD dwMode;
       GetConsoleMode (get_output_handle (), &dwMode);
-      dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
       if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
 	  !(get_ttyp ()->ti.c_oflag & ONLCR))
 	dwMode |= DISABLE_NEWLINE_AUTO_RETURN;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index f3e3e4482..48a700132 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1075,17 +1075,16 @@ verify_console (select_record *me, fd_set *rfds, fd_set *wfds,
   return peek_console (me, true);
 }
 
+static void console_cleanup (select_record *, select_stuff *);
+
 static int
 console_startup (select_record *me, select_stuff *stuff)
 {
-  select_record *s = stuff->start.next;
+  fhandler_console *fh = (fhandler_console *) me->fh;
   if (wincap.has_con_24bit_colors ())
     {
-      DWORD dwMode;
-      GetConsoleMode (s->h, &dwMode);
-      /* Enable xterm compatible mode in input */
-      dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-      SetConsoleMode (s->h, dwMode);
+      fh->request_xterm_mode_input (true);
+      me->cleanup = console_cleanup;
     }
   return 1;
 }
@@ -1093,15 +1092,9 @@ console_startup (select_record *me, select_stuff *stuff)
 static void
 console_cleanup (select_record *me, select_stuff *stuff)
 {
-  select_record *s = stuff->start.next;
+  fhandler_console *fh = (fhandler_console *) me->fh;
   if (wincap.has_con_24bit_colors ())
-    {
-      DWORD dwMode;
-      GetConsoleMode (s->h, &dwMode);
-      /* Disable xterm compatible mode in input */
-      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
-      SetConsoleMode (s->h, dwMode);
-    }
+    fh->request_xterm_mode_input (false);
 }
 
 select_record *
@@ -1117,7 +1110,6 @@ fhandler_console::select_read (select_stuff *ss)
 
   s->peek = peek_console;
   s->h = get_handle ();
-  s->cleanup = console_cleanup;
   s->read_selected = true;
   s->read_ready = input_ready || get_cons_readahead_valid ();
   return s;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 772fe6dd6..3e8c8367a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -614,14 +614,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  else if (fh && fh->get_major () == DEV_CONS_MAJOR)
 	    {
 	      attach_to_console = true;
+	      fhandler_console *cons = (fhandler_console *) fh;
 	      if (wincap.has_con_24bit_colors () && !iscygwin ())
 		if (fd == 1 || fd == 2)
-		  {
-		    DWORD dwMode;
-		    GetConsoleMode (fh->get_output_handle (), &dwMode);
-		    dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-		    SetConsoleMode (fh->get_output_handle (), dwMode);
-		  }
+		  cons->request_xterm_mode_output (false);
 	    }
 	}
 
-- 
2.21.0
