Return-Path: <cygwin-patches-return-9291-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88523 invoked by alias); 31 Mar 2019 15:49:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88435 invoked by uid 89); 31 Mar 2019 15:49:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=mouse
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 15:48:50 +0000
Received: from localhost.localdomain (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x2VFm0UW009284;	Mon, 1 Apr 2019 00:48:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x2VFm0UW009284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1554047299;	bh=HzyhaIjmSI5zBRQWdfKFtDnwOB/rd0Rcz9zwsuT547g=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=aY03B0OSZhs1JNhrC3gSr5Fik7QVxlzeH5c8Gvtk8J0ENaeu1aJoZALzpAcOFcvm+	 kSFQeqVuiOXS0Hu7+B0f3QChEEebG2fKvFf7wB4DFV6t9xKMxvIp+dThQe7OLBK0PT	 hYWzr0DQ3tYUn+cfY4uEcknOkbLxfP36TaGedC3BnTFgCcBy6ZsNha3ZHbY3xJ7ZZr	 XrNc/WycW2DnldQvLyAMC+COPRT2iD6v2vLwp8tI4xqxcVQ8Y2unlf0IERh17zq4pN	 DSxKkkBCyST14GQEx1WcxWiz+Ca1E7C2DlAwGadCQ5WlRdfgQV43tXhENWpvh+sooY	 CJgeinYIzrIUQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 2/3] Cygwin: console: fix select() behaviour
Date: Sun, 31 Mar 2019 15:49:00 -0000
Message-Id: <20190331154748.1957-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190331154748.1957-1-takashi.yano@nifty.ne.jp>
References: <20190331143651.GF3337@calimero.vinschen.de> <20190331154748.1957-1-takashi.yano@nifty.ne.jp>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00100.txt.bz2

- Previously, select() would return when only one key is typed even
  in canonical mode. With this patch, it returns after one line is
  completed.
---
 winsup/cygwin/fhandler.h          |  12 +-
 winsup/cygwin/fhandler_console.cc | 794 ++++++++++++++++--------------
 winsup/cygwin/select.cc           |  81 +--
 3 files changed, 462 insertions(+), 425 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 66e724bcb..e4a6de610 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1884,6 +1884,15 @@ public:
     tty_min tty_min_state;
     dev_console con;
   };
+  bool input_ready;
+  enum input_states
+  {
+    input_error = -1,
+    input_processing = 0,
+    input_ok = 1,
+    input_signalled = 2,
+    input_winch = 3
+  };
 private:
   static const unsigned MAX_WRITE_CHARS;
   static console_state *shared_console_info;
@@ -1969,7 +1978,7 @@ private:
   void fixup_after_fork (HANDLE) {fixup_after_fork_exec (false);}
   void set_close_on_exec (bool val);
   void set_input_state ();
-  void send_winch_maybe ();
+  bool send_winch_maybe ();
   void setup ();
   bool set_unit ();
   static bool need_invisible ();
@@ -1992,6 +2001,7 @@ private:
     copyto (fh);
     return fh;
   }
+  input_states process_input_message ();
   friend tty_min * tty_list::get_cttyp ();
 };
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 6b14d4a25..160ae284a 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -53,7 +53,9 @@ details. */
 
 #define con (shared_console_info->con)
 #define srTop (con.b.srWindow.Top + con.scroll_region.Top)
-#define srBottom ((con.scroll_region.Bottom < 0) ? con.b.srWindow.Bottom : con.b.srWindow.Top + con.scroll_region.Bottom)
+#define srBottom ((con.scroll_region.Bottom < 0) ? \
+		  con.b.srWindow.Bottom : \
+		  con.b.srWindow.Top + con.scroll_region.Bottom)
 
 const unsigned fhandler_console::MAX_WRITE_CHARS = 16384;
 
@@ -149,16 +151,19 @@ fhandler_console::set_unit ()
 		shared_unit : FH_ERROR;
       created = false;
     }
-  else if ((!generic_console && (myself->ctty != -1 && !iscons_dev (myself->ctty)))
+  else if ((!generic_console &&
+	    (myself->ctty != -1 && !iscons_dev (myself->ctty)))
 	   || !(me = GetConsoleWindow ()))
     devset = FH_ERROR;
   else
     {
       created = true;
-      shared_console_info = open_shared_console (me, cygheap->console_h, created);
+      shared_console_info =
+	open_shared_console (me, cygheap->console_h, created);
       ProtectHandleINH (cygheap->console_h);
       if (created)
-	shared_console_info->tty_min_state.setntty (DEV_CONS_MAJOR, console_unit (me));
+	shared_console_info->
+	  tty_min_state.setntty (DEV_CONS_MAJOR, console_unit (me));
       devset = (fh_devices) shared_console_info->tty_min_state.getntty ();
       if (created)
 	con.owner = getpid ();
@@ -251,7 +256,8 @@ fhandler_console::set_raw_win32_keyboard_mode (bool new_mode)
 {
   bool old_mode = con.raw_win32_keyboard_mode;
   con.raw_win32_keyboard_mode = new_mode;
-  syscall_printf ("raw keyboard mode %sabled", con.raw_win32_keyboard_mode ? "en" : "dis");
+  syscall_printf ("raw keyboard mode %sabled",
+		  con.raw_win32_keyboard_mode ? "en" : "dis");
   return old_mode;
 };
 
@@ -267,7 +273,7 @@ fhandler_console::set_cursor_maybe ()
     }
 }
 
-void
+bool
 fhandler_console::send_winch_maybe ()
 {
   SHORT y = con.dwWinSize.Y;
@@ -279,7 +285,9 @@ fhandler_console::send_winch_maybe ()
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
       get_ttyp ()->kill_pgrp (SIGWINCH);
+      return true;
     }
+  return false;
 }
 
 /* Check whether a mouse event is to be reported as an escape sequence */
@@ -299,7 +307,8 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECORD& mouse_event)
   con.dwMousePosition.X = mouse_event.dwMousePosition.X - now.srWindow.Left;
   con.dwMousePosition.Y = mouse_event.dwMousePosition.Y - now.srWindow.Top;
 
-  return ((mouse_event.dwEventFlags == 0 || mouse_event.dwEventFlags == DOUBLE_CLICK)
+  return ((mouse_event.dwEventFlags == 0
+	   || mouse_event.dwEventFlags == DOUBLE_CLICK)
 	  && mouse_event.dwButtonState != con.dwLastButtonState)
 	 || mouse_event.dwEventFlags == MOUSE_WHEELED
 	 || (mouse_event.dwEventFlags == MOUSE_MOVED
@@ -312,36 +321,17 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECORD& mouse_event)
 void __reg3
 fhandler_console::read (void *pv, size_t& buflen)
 {
+  termios_printf ("read(%p,%d)", pv, buflen);
+
   push_process_state process_state (PID_TTYIN);
 
-  HANDLE h = get_handle ();
+  int copied_chars = 0;
 
-#define buf ((char *) pv)
+  DWORD timeout = is_nonblocking () ? 0 : INFINITE;
 
-  int ch;
   set_input_state ();
 
-  /* Check console read-ahead buffer filled from terminal requests */
-  if (con.cons_rapoi && *con.cons_rapoi)
-    {
-      *buf = *con.cons_rapoi++;
-      buflen = 1;
-      return;
-    }
-
-  int copied_chars = get_readahead_into_buffer (buf, buflen);
-
-  if (copied_chars)
-    {
-      buflen = copied_chars;
-      return;
-    }
-
-  DWORD timeout = is_nonblocking () ? 0 : INFINITE;
-  char tmp[60];
-
-  termios ti = get_ttyp ()->ti;
-  for (;;)
+  while (!input_ready && !get_cons_readahead_valid ())
     {
       int bgres;
       if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
@@ -350,8 +340,8 @@ fhandler_console::read (void *pv, size_t& buflen)
 	  return;
 	}
 
-      set_cursor_maybe ();	/* to make cursor appear on the screen immediately */
-      switch (cygwait (h, timeout))
+      set_cursor_maybe (); /* to make cursor appear on the screen immediately */
+      switch (cygwait (get_handle (), timeout))
 	{
 	case WAIT_OBJECT_0:
 	  break;
@@ -369,367 +359,414 @@ fhandler_console::read (void *pv, size_t& buflen)
 	  goto err;
 	}
 
-      DWORD nread;
-      INPUT_RECORD input_rec;
-      const char *toadd = NULL;
+#define buf ((char *) pv)
 
-      if (!ReadConsoleInputW (h, &input_rec, 1, &nread))
+      int ret;
+      ret = process_input_message ();
+      switch (ret)
 	{
-	  syscall_printf ("ReadConsoleInput failed, %E");
-	  goto err;		/* seems to be failure */
+	case input_error:
+	  goto err;
+	case input_processing:
+	  continue;
+	case input_ok: /* input ready */
+	  break;
+	case input_signalled: /* signalled */
+	  goto sig_exit;
+	case input_winch:
+	  continue;
+	default:
+	  /* Should not come here */
+	  goto err;
 	}
+    }
 
-      const WCHAR &unicode_char = input_rec.Event.KeyEvent.uChar.UnicodeChar;
-      const DWORD &ctrl_key_state = input_rec.Event.KeyEvent.dwControlKeyState;
+  /* Check console read-ahead buffer filled from terminal requests */
+  while (con.cons_rapoi && *con.cons_rapoi && buflen)
+    {
+      buf[copied_chars++] = *con.cons_rapoi++;
+      buflen --;
+    }
 
-      /* check the event that occurred */
-      switch (input_rec.EventType)
-	{
-	case KEY_EVENT:
+  copied_chars +=
+    get_readahead_into_buffer (buf + copied_chars, buflen);
 
-	  con.nModifiers = 0;
+  if (!ralen)
+    input_ready = false;
+
+#undef buf
+
+  buflen = copied_chars;
+  return;
+
+err:
+  __seterrno ();
+  buflen = (size_t) -1;
+  return;
+
+sig_exit:
+  set_sig_errno (EINTR);
+  buflen = (size_t) -1;
+}
+
+fhandler_console::input_states
+fhandler_console::process_input_message (void)
+{
+  char tmp[60];
+
+  if (!shared_console_info)
+    return input_error;
+
+  termios *ti = &(get_ttyp ()->ti);
+
+  DWORD nread;
+  INPUT_RECORD input_rec;
+  const char *toadd = NULL;
+
+  if (!ReadConsoleInputW (get_handle (), &input_rec, 1, &nread))
+    {
+      termios_printf ("ReadConsoleInput failed, %E");
+      return input_error;
+    }
+
+  const WCHAR &unicode_char = input_rec.Event.KeyEvent.uChar.UnicodeChar;
+  const DWORD &ctrl_key_state = input_rec.Event.KeyEvent.dwControlKeyState;
+
+  /* check the event that occurred */
+  switch (input_rec.EventType)
+    {
+    case KEY_EVENT:
+
+      con.nModifiers = 0;
 
 #ifdef DEBUGGING
-	  /* allow manual switching to/from raw mode via ctrl-alt-scrolllock */
-	  if (input_rec.Event.KeyEvent.bKeyDown
-	      && input_rec.Event.KeyEvent.wVirtualKeyCode == VK_SCROLL
-	      && (ctrl_key_state & (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
-		  == (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
-	    {
-	      set_raw_win32_keyboard_mode (!con.raw_win32_keyboard_mode);
-	      continue;
-	    }
+      /* allow manual switching to/from raw mode via ctrl-alt-scrolllock */
+      if (input_rec.Event.KeyEvent.bKeyDown
+	  && input_rec.Event.KeyEvent.wVirtualKeyCode == VK_SCROLL
+	  && (ctrl_key_state & (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
+	  == (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
+	{
+	  set_raw_win32_keyboard_mode (!con.raw_win32_keyboard_mode);
+	  return input_processing;
+	}
 #endif
 
-	  if (con.raw_win32_keyboard_mode)
+      if (con.raw_win32_keyboard_mode)
+	{
+	  __small_sprintf (tmp, "\033{%u;%u;%u;%u;%u;%luK",
+			   input_rec.Event.KeyEvent.bKeyDown,
+			   input_rec.Event.KeyEvent.wRepeatCount,
+			   input_rec.Event.KeyEvent.wVirtualKeyCode,
+			   input_rec.Event.KeyEvent.wVirtualScanCode,
+			   input_rec.Event.KeyEvent.uChar.UnicodeChar,
+			   input_rec.Event.KeyEvent.dwControlKeyState);
+	  toadd = tmp;
+	  nread = strlen (toadd);
+	  break;
+	}
+
+      /* Ignore key up events, except for Alt+Numpad events. */
+      if (!input_rec.Event.KeyEvent.bKeyDown &&
+	  !is_alt_numpad_event (&input_rec))
+	return input_processing;
+      /* Ignore Alt+Numpad keys.  They are eventually handled below after
+	 releasing the Alt key. */
+      if (input_rec.Event.KeyEvent.bKeyDown
+	  && is_alt_numpad_key (&input_rec))
+	return input_processing;
+
+      if (ctrl_key_state & SHIFT_PRESSED)
+	con.nModifiers |= 1;
+      if (ctrl_key_state & RIGHT_ALT_PRESSED)
+	con.nModifiers |= 2;
+      if (ctrl_key_state & CTRL_PRESSED)
+	con.nModifiers |= 4;
+      if (ctrl_key_state & LEFT_ALT_PRESSED)
+	con.nModifiers |= 8;
+
+      /* Allow Backspace to emit ^? and escape sequences. */
+      if (input_rec.Event.KeyEvent.wVirtualKeyCode == VK_BACK)
+	{
+	  char c = con.backspace_keycode;
+	  nread = 0;
+	  if (ctrl_key_state & ALT_PRESSED)
 	    {
-	      __small_sprintf (tmp, "\033{%u;%u;%u;%u;%u;%luK",
-				    input_rec.Event.KeyEvent.bKeyDown,
-				    input_rec.Event.KeyEvent.wRepeatCount,
-				    input_rec.Event.KeyEvent.wVirtualKeyCode,
-				    input_rec.Event.KeyEvent.wVirtualScanCode,
-				    input_rec.Event.KeyEvent.uChar.UnicodeChar,
-				    input_rec.Event.KeyEvent.dwControlKeyState);
-	      toadd = tmp;
-	      nread = strlen (toadd);
-	      break;
+	      if (con.metabit)
+		c |= 0x80;
+	      else
+		tmp[nread++] = '\e';
 	    }
-
-	  /* Ignore key up events, except for Alt+Numpad events. */
-	  if (!input_rec.Event.KeyEvent.bKeyDown &&
-	      !is_alt_numpad_event (&input_rec))
-	    continue;
-	  /* Ignore Alt+Numpad keys.  They are eventually handled below after
-	     releasing the Alt key. */
-	  if (input_rec.Event.KeyEvent.bKeyDown
-	      && is_alt_numpad_key (&input_rec))
-	    continue;
-
-	  if (ctrl_key_state & SHIFT_PRESSED)
-	    con.nModifiers |= 1;
-	  if (ctrl_key_state & RIGHT_ALT_PRESSED)
-	    con.nModifiers |= 2;
-	  if (ctrl_key_state & CTRL_PRESSED)
-	    con.nModifiers |= 4;
-	  if (ctrl_key_state & LEFT_ALT_PRESSED)
-	    con.nModifiers |= 8;
-
-	  /* Allow Backspace to emit ^? and escape sequences. */
-	  if (input_rec.Event.KeyEvent.wVirtualKeyCode == VK_BACK)
+	  tmp[nread++] = c;
+	  tmp[nread] = 0;
+	  toadd = tmp;
+	}
+      /* Allow Ctrl-Space to emit ^@ */
+      else if (input_rec.Event.KeyEvent.wVirtualKeyCode
+	       == (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
+	       && (ctrl_key_state & CTRL_PRESSED)
+	       && !(ctrl_key_state & ALT_PRESSED))
+	toadd = "";
+      else if (unicode_char == 0
+	       /* arrow/function keys */
+	       || (input_rec.Event.KeyEvent.dwControlKeyState & ENHANCED_KEY))
+	{
+	  toadd = get_nonascii_key (input_rec, tmp);
+	  if (!toadd)
 	    {
-	      char c = con.backspace_keycode;
-	      nread = 0;
-	      if (ctrl_key_state & ALT_PRESSED)
-		{
-		  if (con.metabit)
-		    c |= 0x80;
-		  else
-		    tmp[nread++] = '\e';
-		}
-	      tmp[nread++] = c;
-	      tmp[nread] = 0;
-	      toadd = tmp;
+	      con.nModifiers = 0;
+	      return input_processing;
 	    }
-	  /* Allow Ctrl-Space to emit ^@ */
-	  else if (input_rec.Event.KeyEvent.wVirtualKeyCode
-		   == (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
-		   && (ctrl_key_state & CTRL_PRESSED)
-		   && !(ctrl_key_state & ALT_PRESSED))
-	    toadd = "";
-	  else if (unicode_char == 0
-	      /* arrow/function keys */
-	      || (input_rec.Event.KeyEvent.dwControlKeyState & ENHANCED_KEY))
+	  nread = strlen (toadd);
+	}
+      else
+	{
+	  nread = con.con_to_str (tmp + 1, 59, unicode_char);
+	  /* Determine if the keystroke is modified by META.  The tricky
+	     part is to distinguish whether the right Alt key should be
+	     recognized as Alt, or as AltGr. */
+	  bool meta =
+	    /* Alt but not AltGr (= left ctrl + right alt)? */
+	    (ctrl_key_state & ALT_PRESSED) != 0
+	    && ((ctrl_key_state & CTRL_PRESSED) == 0
+		/* but also allow Alt-AltGr: */
+		|| (ctrl_key_state & ALT_PRESSED) == ALT_PRESSED
+		|| (unicode_char <= 0x1f || unicode_char == 0x7f));
+	  if (!meta)
 	    {
-	      toadd = get_nonascii_key (input_rec, tmp);
-	      if (!toadd)
-		{
-		  con.nModifiers = 0;
-		  continue;
-		}
-	      nread = strlen (toadd);
+	      /* Determine if the character is in the current multibyte
+		 charset.  The test is easy.  If the multibyte sequence
+		 is > 1 and the first byte is ASCII CAN, the character
+		 has been translated into the ASCII CAN + UTF-8 replacement
+		 sequence.  If so, just ignore the keypress.
+		 FIXME: Is there a better solution? */
+	      if (nread > 1 && tmp[1] == 0x18)
+		beep ();
+	      else
+		toadd = tmp + 1;
+	    }
+	  else if (con.metabit)
+	    {
+	      tmp[1] |= 0x80;
+	      toadd = tmp + 1;
 	    }
 	  else
 	    {
-	      nread = con.con_to_str (tmp + 1, 59, unicode_char);
-	      /* Determine if the keystroke is modified by META.  The tricky
-		 part is to distinguish whether the right Alt key should be
-		 recognized as Alt, or as AltGr. */
-	      bool meta =
-		     /* Alt but not AltGr (= left ctrl + right alt)? */
-		     (ctrl_key_state & ALT_PRESSED) != 0
-		     && ((ctrl_key_state & CTRL_PRESSED) == 0
-			    /* but also allow Alt-AltGr: */
-			 || (ctrl_key_state & ALT_PRESSED) == ALT_PRESSED
-			 || (unicode_char <= 0x1f || unicode_char == 0x7f));
-	      if (!meta)
+	      tmp[0] = '\033';
+	      tmp[1] = cyg_tolower (tmp[1]);
+	      toadd = tmp;
+	      nread++;
+	      con.nModifiers &= ~4;
+	    }
+	}
+      break;
+
+    case MOUSE_EVENT:
+      send_winch_maybe ();
+	{
+	  MOUSE_EVENT_RECORD& mouse_event = input_rec.Event.MouseEvent;
+	  /* As a unique guard for mouse report generation,
+	     call mouse_aware() which is common with select(), so the result
+	     of select() and the actual read() will be consistent on the
+	     issue of whether input (i.e. a mouse escape sequence) will
+	     be available or not */
+	  if (mouse_aware (mouse_event))
+	    {
+	      /* Note: Reported mouse position was already retrieved by
+		 mouse_aware() and adjusted by window scroll buffer offset */
+
+	      /* Treat the double-click event like a regular button press */
+	      if (mouse_event.dwEventFlags == DOUBLE_CLICK)
 		{
-		  /* Determine if the character is in the current multibyte
-		     charset.  The test is easy.  If the multibyte sequence
-		     is > 1 and the first byte is ASCII CAN, the character
-		     has been translated into the ASCII CAN + UTF-8 replacement
-		     sequence.  If so, just ignore the keypress.
-		     FIXME: Is there a better solution? */
-		  if (nread > 1 && tmp[1] == 0x18)
-		    beep ();
-		  else
-		    toadd = tmp + 1;
+		  syscall_printf ("mouse: double-click -> click");
+		  mouse_event.dwEventFlags = 0;
 		}
-	      else if (con.metabit)
+
+	      /* This code assumes Windows never reports multiple button
+		 events at the same time. */
+	      int b = 0;
+	      char sz[32];
+	      char mode6_term = 'M';
+
+	      if (mouse_event.dwEventFlags == MOUSE_WHEELED)
 		{
-		  tmp[1] |= 0x80;
-		  toadd = tmp + 1;
+		  if (mouse_event.dwButtonState & 0xFF800000)
+		    {
+		      b = 0x41;
+		      strcpy (sz, "wheel down");
+		    }
+		  else
+		    {
+		      b = 0x40;
+		      strcpy (sz, "wheel up");
+		    }
 		}
 	      else
 		{
-		  tmp[0] = '\033';
-		  tmp[1] = cyg_tolower (tmp[1]);
-		  toadd = tmp;
-		  nread++;
-		  con.nModifiers &= ~4;
+		  /* Ignore unimportant mouse buttons */
+		  mouse_event.dwButtonState &= 0x7;
+
+		  if (mouse_event.dwEventFlags == MOUSE_MOVED)
+		    {
+		      b = con.last_button_code;
+		    }
+		  else if (mouse_event.dwButtonState < con.dwLastButtonState
+			   && !con.ext_mouse_mode6)
+		    {
+		      b = 3;
+		      strcpy (sz, "btn up");
+		    }
+		  else if ((mouse_event.dwButtonState & 1)
+			   != (con.dwLastButtonState & 1))
+		    {
+		      b = 0;
+		      strcpy (sz, "btn1 down");
+		    }
+		  else if ((mouse_event.dwButtonState & 2)
+			   != (con.dwLastButtonState & 2))
+		    {
+		      b = 2;
+		      strcpy (sz, "btn2 down");
+		    }
+		  else if ((mouse_event.dwButtonState & 4)
+			   != (con.dwLastButtonState & 4))
+		    {
+		      b = 1;
+		      strcpy (sz, "btn3 down");
+		    }
+
+		  if (con.ext_mouse_mode6 /* distinguish release */
+		      && mouse_event.dwButtonState < con.dwLastButtonState)
+		    mode6_term = 'm';
+
+		  con.last_button_code = b;
+
+		  if (mouse_event.dwEventFlags == MOUSE_MOVED)
+		    {
+		      b += 32;
+		      strcpy (sz, "move");
+		    }
+		  else
+		    {
+		      /* Remember the modified button state */
+		      con.dwLastButtonState = mouse_event.dwButtonState;
+		    }
 		}
-	    }
-	  break;
 
-	case MOUSE_EVENT:
-	  send_winch_maybe ();
-	  {
-	    MOUSE_EVENT_RECORD& mouse_event = input_rec.Event.MouseEvent;
-	    /* As a unique guard for mouse report generation,
-	       call mouse_aware() which is common with select(), so the result
-	       of select() and the actual read() will be consistent on the
-	       issue of whether input (i.e. a mouse escape sequence) will
-	       be available or not */
-	    if (mouse_aware (mouse_event))
-	      {
-		/* Note: Reported mouse position was already retrieved by
-		   mouse_aware() and adjusted by window scroll buffer offset */
-
-		/* Treat the double-click event like a regular button press */
-		if (mouse_event.dwEventFlags == DOUBLE_CLICK)
-		  {
-		    syscall_printf ("mouse: double-click -> click");
-		    mouse_event.dwEventFlags = 0;
-		  }
-
-		/* This code assumes Windows never reports multiple button
-		   events at the same time. */
-		int b = 0;
-		char sz[32];
-		char mode6_term = 'M';
-
-		if (mouse_event.dwEventFlags == MOUSE_WHEELED)
-		  {
-		    if (mouse_event.dwButtonState & 0xFF800000)
-		      {
-			b = 0x41;
-			strcpy (sz, "wheel down");
-		      }
-		    else
-		      {
-			b = 0x40;
-			strcpy (sz, "wheel up");
-		      }
-		  }
-		else
-		  {
-		    /* Ignore unimportant mouse buttons */
-		    mouse_event.dwButtonState &= 0x7;
+	      /* Remember mouse position */
+	      con.dwLastMousePosition.X = con.dwMousePosition.X;
+	      con.dwLastMousePosition.Y = con.dwMousePosition.Y;
 
-		    if (mouse_event.dwEventFlags == MOUSE_MOVED)
-		      {
-			b = con.last_button_code;
-		      }
-		    else if (mouse_event.dwButtonState < con.dwLastButtonState && !con.ext_mouse_mode6)
-		      {
-			b = 3;
-			strcpy (sz, "btn up");
-		      }
-		    else if ((mouse_event.dwButtonState & 1) != (con.dwLastButtonState & 1))
-		      {
-			b = 0;
-			strcpy (sz, "btn1 down");
-		      }
-		    else if ((mouse_event.dwButtonState & 2) != (con.dwLastButtonState & 2))
-		      {
-			b = 2;
-			strcpy (sz, "btn2 down");
-		      }
-		    else if ((mouse_event.dwButtonState & 4) != (con.dwLastButtonState & 4))
-		      {
-			b = 1;
-			strcpy (sz, "btn3 down");
-		      }
-
-		    if (con.ext_mouse_mode6 /* distinguish release */
-			&& mouse_event.dwButtonState < con.dwLastButtonState)
-			mode6_term = 'm';
+	      /* Remember the modifiers */
+	      con.nModifiers = 0;
+	      if (mouse_event.dwControlKeyState & SHIFT_PRESSED)
+		con.nModifiers |= 0x4;
+	      if (mouse_event.dwControlKeyState & ALT_PRESSED)
+		con.nModifiers |= 0x8;
+	      if (mouse_event.dwControlKeyState & CTRL_PRESSED)
+		con.nModifiers |= 0x10;
 
-		    con.last_button_code = b;
+	      /* Indicate the modifiers */
+	      b |= con.nModifiers;
 
-		    if (mouse_event.dwEventFlags == MOUSE_MOVED)
-		      {
-			b += 32;
-			strcpy (sz, "move");
-		      }
-		    else
-		      {
-			/* Remember the modified button state */
-			con.dwLastButtonState = mouse_event.dwButtonState;
-		      }
-		  }
-
-		/* Remember mouse position */
-		con.dwLastMousePosition.X = con.dwMousePosition.X;
-		con.dwLastMousePosition.Y = con.dwMousePosition.Y;
-
-		/* Remember the modifiers */
-		con.nModifiers = 0;
-		if (mouse_event.dwControlKeyState & SHIFT_PRESSED)
-		    con.nModifiers |= 0x4;
-		if (mouse_event.dwControlKeyState & ALT_PRESSED)
-		    con.nModifiers |= 0x8;
-		if (mouse_event.dwControlKeyState & CTRL_PRESSED)
-		    con.nModifiers |= 0x10;
-
-		/* Indicate the modifiers */
-		b |= con.nModifiers;
-
-		/* We can now create the code. */
-		if (con.ext_mouse_mode6)
-		  {
-		    __small_sprintf (tmp, "\033[<%d;%d;%d%c", b,
-				     con.dwMousePosition.X + 1,
-				     con.dwMousePosition.Y + 1,
-				     mode6_term);
-		    nread = strlen (tmp);
-		  }
-		else if (con.ext_mouse_mode15)
-		  {
-		    __small_sprintf (tmp, "\033[%d;%d;%dM", b + 32,
-				     con.dwMousePosition.X + 1,
-				     con.dwMousePosition.Y + 1);
-		    nread = strlen (tmp);
-		  }
-		else if (con.ext_mouse_mode5)
-		  {
-		    unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
-		    unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
-
-		    __small_sprintf (tmp, "\033[M%c", b + ' ');
-		    nread = 4;
-		    /* the neat nested encoding function of mintty
-		       does not compile in g++, so let's unfold it: */
-		    if (xcode < 0x80)
-		      tmp [nread++] = xcode;
-		    else if (xcode < 0x800)
-		      {
-			tmp [nread++] = 0xC0 + (xcode >> 6);
-			tmp [nread++] = 0x80 + (xcode & 0x3F);
-		      }
-		    else
-		      tmp [nread++] = 0;
-		    if (ycode < 0x80)
-		      tmp [nread++] = ycode;
-		    else if (ycode < 0x800)
-		      {
-			tmp [nread++] = 0xC0 + (ycode >> 6);
-			tmp [nread++] = 0x80 + (ycode & 0x3F);
-		      }
-		    else
-		      tmp [nread++] = 0;
-		  }
-		else
-		  {
-		    unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
-		    unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
-		    if (xcode >= 256)
-		      xcode = 0;
-		    if (ycode >= 256)
-		      ycode = 0;
-		    __small_sprintf (tmp, "\033[M%c%c%c", b + ' ',
-				     xcode, ycode);
-		    nread = 6;	/* tmp may contain NUL bytes */
-		  }
-		syscall_printf ("mouse: %s at (%d,%d)", sz,
-				con.dwMousePosition.X,
-				con.dwMousePosition.Y);
-
-		toadd = tmp;
-	      }
-	  }
-	  break;
-
-	case FOCUS_EVENT:
-	  if (con.use_focus)
-	    {
-	      if (input_rec.Event.FocusEvent.bSetFocus)
-		__small_sprintf (tmp, "\033[I");
+	      /* We can now create the code. */
+	      if (con.ext_mouse_mode6)
+		{
+		  __small_sprintf (tmp, "\033[<%d;%d;%d%c", b,
+				   con.dwMousePosition.X + 1,
+				   con.dwMousePosition.Y + 1,
+				   mode6_term);
+		  nread = strlen (tmp);
+		}
+	      else if (con.ext_mouse_mode15)
+		{
+		  __small_sprintf (tmp, "\033[%d;%d;%dM", b + 32,
+				   con.dwMousePosition.X + 1,
+				   con.dwMousePosition.Y + 1);
+		  nread = strlen (tmp);
+		}
+	      else if (con.ext_mouse_mode5)
+		{
+		  unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
+		  unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
+
+		  __small_sprintf (tmp, "\033[M%c", b + ' ');
+		  nread = 4;
+		  /* the neat nested encoding function of mintty
+		     does not compile in g++, so let's unfold it: */
+		  if (xcode < 0x80)
+		    tmp [nread++] = xcode;
+		  else if (xcode < 0x800)
+		    {
+		      tmp [nread++] = 0xC0 + (xcode >> 6);
+		      tmp [nread++] = 0x80 + (xcode & 0x3F);
+		    }
+		  else
+		    tmp [nread++] = 0;
+		  if (ycode < 0x80)
+		    tmp [nread++] = ycode;
+		  else if (ycode < 0x800)
+		    {
+		      tmp [nread++] = 0xC0 + (ycode >> 6);
+		      tmp [nread++] = 0x80 + (ycode & 0x3F);
+		    }
+		  else
+		    tmp [nread++] = 0;
+		}
 	      else
-		__small_sprintf (tmp, "\033[O");
+		{
+		  unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
+		  unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
+		  if (xcode >= 256)
+		    xcode = 0;
+		  if (ycode >= 256)
+		    ycode = 0;
+		  __small_sprintf (tmp, "\033[M%c%c%c", b + ' ',
+				   xcode, ycode);
+		  nread = 6;	/* tmp may contain NUL bytes */
+		}
+	      syscall_printf ("mouse: %s at (%d,%d)", sz,
+			      con.dwMousePosition.X,
+			      con.dwMousePosition.Y);
 
 	      toadd = tmp;
-	      nread = 3;
 	    }
-	  break;
-
-	case WINDOW_BUFFER_SIZE_EVENT:
-	  send_winch_maybe ();
-	  /* fall through */
-	default:
-	  continue;
 	}
+      break;
 
-      if (toadd)
+    case FOCUS_EVENT:
+      if (con.use_focus)
 	{
-	  line_edit_status res = line_edit (toadd, nread, ti);
-	  if (res == line_edit_signalled)
-	    goto sig_exit;
-	  else if (res == line_edit_input_done)
-	    break;
-	}
-    }
+	  if (input_rec.Event.FocusEvent.bSetFocus)
+	    __small_sprintf (tmp, "\033[I");
+	  else
+	    __small_sprintf (tmp, "\033[O");
 
-  while (buflen)
-    if ((ch = get_readahead ()) < 0)
+	  toadd = tmp;
+	  nread = 3;
+	}
       break;
-    else
-      {
-	buf[copied_chars++] = (unsigned char)(ch & 0xff);
-	buflen--;
-      }
-#undef buf
 
-  buflen = copied_chars;
-  return;
-
-err:
-  __seterrno ();
-  buflen = (size_t) -1;
-  return;
+    case WINDOW_BUFFER_SIZE_EVENT:
+      if (send_winch_maybe ())
+	return input_winch;
+      /* fall through */
+    default:
+      return input_processing;
+    }
 
-sig_exit:
-  set_sig_errno (EINTR);
-  buflen = (size_t) -1;
+  if (toadd)
+    {
+      ssize_t ret;
+      line_edit_status res = line_edit (toadd, nread, *ti, &ret);
+      if (res == line_edit_signalled)
+	return input_signalled;
+      else if (res == line_edit_input_done)
+	{
+	  input_ready = true;
+	  return input_ok;
+	}
+    }
+  return input_processing;
 }
 
 void
@@ -749,7 +786,8 @@ dev_console::fillin (HANDLE h)
       dwWinSize.Y = 1 + b.srWindow.Bottom - b.srWindow.Top;
       dwWinSize.X = 1 + b.srWindow.Right - b.srWindow.Left;
       if (b.dwCursorPosition.Y > dwEnd.Y
-	  || (b.dwCursorPosition.Y >= dwEnd.Y && b.dwCursorPosition.X > dwEnd.X))
+	  || (b.dwCursorPosition.Y >= dwEnd.Y
+	      && b.dwCursorPosition.X > dwEnd.X))
 	dwEnd = b.dwCursorPosition;
     }
   else
@@ -765,7 +803,8 @@ dev_console::fillin (HANDLE h)
 }
 
 void __reg3
-dev_console::scroll_buffer (HANDLE h, int x1, int y1, int x2, int y2, int xn, int yn)
+dev_console::scroll_buffer (HANDLE h, int x1, int y1, int x2, int y2,
+			    int xn, int yn)
 {
 /* Scroll the screen context.
    x1, y1 - ul corner
@@ -786,7 +825,8 @@ dev_console::scroll_buffer (HANDLE h, int x1, int y1, int x2, int y2, int xn, in
   sr1.Bottom = y2 >= 0 ? y2 : b.srWindow.Bottom;
   sr2.Top = b.srWindow.Top + scroll_region.Top;
   sr2.Left = 0;
-  sr2.Bottom = (scroll_region.Bottom < 0) ? b.srWindow.Bottom : b.srWindow.Top + scroll_region.Bottom;
+  sr2.Bottom = (scroll_region.Bottom < 0) ?
+    b.srWindow.Bottom : b.srWindow.Top + scroll_region.Bottom;
   sr2.Right = dwWinSize.X - 1;
   if (sr1.Bottom > sr2.Bottom && sr1.Top <= sr2.Bottom)
     sr1.Bottom = sr2.Bottom;
@@ -796,13 +836,15 @@ dev_console::scroll_buffer (HANDLE h, int x1, int y1, int x2, int y2, int xn, in
 }
 
 inline void
-fhandler_console::scroll_buffer (int x1, int y1, int x2, int y2, int xn, int yn)
+fhandler_console::scroll_buffer (int x1, int y1, int x2, int y2,
+				 int xn, int yn)
 {
   con.scroll_buffer (get_output_handle (), x1, y1, x2, y2, xn, yn);
 }
 
 inline void
-fhandler_console::scroll_buffer_screen (int x1, int y1, int x2, int y2, int xn, int yn)
+fhandler_console::scroll_buffer_screen (int x1, int y1, int x2, int y2,
+					int xn, int yn)
 {
   if (y1 >= 0)
     y1 += con.b.srWindow.Top;
@@ -1168,7 +1210,7 @@ fhandler_console::tcgetattr (struct termios *t)
 }
 
 fhandler_console::fhandler_console (fh_devices unit) :
-  fhandler_termios ()
+  fhandler_termios (), input_ready (false)
 {
   if (unit > 0)
     dev ().parse (unit);
@@ -1869,16 +1911,19 @@ fhandler_console::char_command (char c)
 		case 1: /* blinking block (default) */
 		case 2: /* steady block */
 		  console_cursor_info.dwSize = 100;
-		  SetConsoleCursorInfo (get_output_handle (), &console_cursor_info);
+		  SetConsoleCursorInfo (get_output_handle (),
+					&console_cursor_info);
 		  break;
 		case 3: /* blinking underline */
 		case 4: /* steady underline */
-		  console_cursor_info.dwSize = 10;	/* or Windows default 25? */
-		  SetConsoleCursorInfo (get_output_handle (), &console_cursor_info);
+		  console_cursor_info.dwSize = 10; /* or Windows default 25? */
+		  SetConsoleCursorInfo (get_output_handle (),
+					&console_cursor_info);
 		  break;
 		default: /* use value as percentage */
 		  console_cursor_info.dwSize = con.args[0];
-		  SetConsoleCursorInfo (get_output_handle (), &console_cursor_info);
+		  SetConsoleCursorInfo (get_output_handle (),
+					&console_cursor_info);
 		  break;
 	      }
 	}
@@ -1891,7 +1936,8 @@ fhandler_console::char_command (char c)
 	    {
 	    case 4:    /* Insert mode */
 	      con.insert_mode = (c == 'h') ? true : false;
-	      syscall_printf ("insert mode %sabled", con.insert_mode ? "en" : "dis");
+	      syscall_printf ("insert mode %sabled",
+			      con.insert_mode ? "en" : "dis");
 	      break;
 	    }
 	  break;
@@ -2078,7 +2124,8 @@ fhandler_console::char_command (char c)
 	/* Generate Secondary Device Attribute report, using 67 = ASCII 'C'
 	   to indicate Cygwin (convention used by Rxvt, Urxvt, Screen, Mintty),
 	   and cygwin version for terminal version. */
-	__small_sprintf (buf, "\033[>67;%d%02d;0c", CYGWIN_VERSION_DLL_MAJOR, CYGWIN_VERSION_DLL_MINOR);
+	__small_sprintf (buf, "\033[>67;%d%02d;0c",
+			 CYGWIN_VERSION_DLL_MAJOR, CYGWIN_VERSION_DLL_MINOR);
       else
 	strcpy (buf, "\033[?6c");
       /* The generated report needs to be injected for read-ahead into the
@@ -2088,6 +2135,9 @@ fhandler_console::char_command (char c)
       con.cons_rapoi = NULL;
       strcpy (con.cons_rabuf, buf);
       con.cons_rapoi = con.cons_rabuf;
+      /* Wake up read() or select() by sending a message
+	 which has no effect */
+      PostMessageW (GetConsoleWindow (), WM_SETFOCUS, 0, 0);
       break;
     case 'n':
       switch (con.args[0])
@@ -2100,6 +2150,9 @@ fhandler_console::char_command (char c)
 	  con.cons_rapoi = NULL;
 	  strcpy (con.cons_rabuf, buf);
 	  con.cons_rapoi = con.cons_rabuf;
+	  /* Wake up read() or select() by sending a message
+	     which has no effect */
+	  PostMessageW (GetConsoleWindow (), WM_SETFOCUS, 0, 0);
 	  break;
 	default:
 	  goto bad_escape;
@@ -2278,7 +2331,8 @@ fhandler_console::write_normal (const unsigned char *src,
 				    nfound - trunc_buf.buf);
 	  if (!write_console (write_buf, buf_len, done))
 	    {
-	      debug_printf ("multibyte sequence write failed, handle %p", get_output_handle ());
+	      debug_printf ("multibyte sequence write failed, handle %p",
+			    get_output_handle ());
 	      return 0;
 	    }
 	  found = src + (nfound - trunc_buf.buf - trunc_buf.len);
@@ -2378,7 +2432,8 @@ do_print:
 		  y--;
 		}
 	    }
-	  cursor_set (false, ((get_ttyp ()->ti.c_oflag & ONLCR) ? 0 : x), y + 1);
+	  cursor_set (false,
+		      ((get_ttyp ()->ti.c_oflag & ONLCR) ? 0 : x), y + 1);
 	  break;
 	case BAK:
 	  cursor_rel (-1, 0);
@@ -2837,7 +2892,8 @@ fhandler_console::create_invisible_console_workaround ()
 
 	  /* Create a new hidden process.  Use the two event handles as
 	     argv[1] and argv[2]. */
-	  BOOL x = CreateProcessW (NULL, cmd, &sec_none_nih, &sec_none_nih, true,
+	  BOOL x = CreateProcessW (NULL, cmd,
+				   &sec_none_nih, &sec_none_nih, true,
 				   CREATE_NEW_CONSOLE, NULL, NULL, &si, &pi);
 	  if (x)
 	    {
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 28adcf3e7..790f15791 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -202,7 +202,9 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
 	     right value >= 0, matching the number of bits set in the
 	     fds records.  if ret is 0, continue to loop. */
 	  ret = sel.poll (readfds, writefds, exceptfds);
-	  if (!ret)
+	  if (ret < 0)
+	    wait_state = select_stuff::select_signalled;
+	  else if (!ret)
 	    wait_state = select_stuff::select_set_zero;
 	}
       /* Always clean up everything here.  If we're looping then build it
@@ -479,6 +481,7 @@ was_timeout:
 	 events like mouse movements.  The verify function will detect these
 	 situations.  If it returns false, then this wakeup was a false alarm
 	 and we should go back to waiting. */
+      int ret = 0;
       while ((s = s->next))
 	if (s->saw_error ())
 	  {
@@ -488,8 +491,13 @@ was_timeout:
 	  }
 	else if ((((wait_ret >= m && s->windows_handle)
 	           || s->h == w4[wait_ret]))
-		 && s->verify (s, readfds, writefds, exceptfds))
+		 && (ret = s->verify (s, readfds, writefds, exceptfds)) > 0)
 	  res = select_ok;
+	else if (ret < 0)
+	  {
+	    res = select_signalled;
+	    goto out;
+	  }
 
       select_printf ("res after verify %d", res);
       break;
@@ -539,8 +547,12 @@ select_stuff::poll (fd_set *readfds, fd_set *writefds, fd_set *exceptfds)
   int n = 0;
   select_record *s = &start;
   while ((s = s->next))
-    n += (!s->peek || s->peek (s, true)) ?
-	 set_bits (s, readfds, writefds, exceptfds) : 0;
+    {
+      int ret = s->peek ? s->peek (s, true) : 1;
+      if (ret < 0)
+	return -1;
+      n += (ret > 0) ?  set_bits (s, readfds, writefds, exceptfds) : 0;
+    }
   return n;
 }
 
@@ -1010,16 +1022,10 @@ peek_console (select_record *me, bool)
     return me->write_ready;
 
   if (fh->get_cons_readahead_valid ())
-    {
-      select_printf ("cons_readahead");
-      return me->read_ready = true;
-    }
+    return me->read_ready = true;
 
-  if (fh->get_readahead_valid ())
-    {
-      select_printf ("readahead");
-      return me->read_ready = true;
-    }
+  if (fh->input_ready)
+    return me->read_ready = true;
 
   if (me->read_ready)
     {
@@ -1030,54 +1036,20 @@ peek_console (select_record *me, bool)
   INPUT_RECORD irec;
   DWORD events_read;
   HANDLE h;
-  char tmpbuf[17];
   set_handle_or_return_if_not_open (h, me);
 
-  for (;;)
+  while (!fh->input_ready && !fh->get_cons_readahead_valid ())
     if (fh->bg_check (SIGTTIN, true) <= bg_eof)
       return me->read_ready = true;
     else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
       break;
-    else
+    else if (fhandler_console::input_winch == fh->process_input_message ())
       {
-	fh->send_winch_maybe ();
-	if (irec.EventType == KEY_EVENT)
-	  {
-	    if (irec.Event.KeyEvent.bKeyDown)
-	      {
-		/* Ignore Alt+Numpad keys. They are eventually handled in the
-		   key-up case below. */
-		if (is_alt_numpad_key (&irec))
-		   ;
-		/* Handle normal input. */
-		else if (irec.Event.KeyEvent.uChar.UnicodeChar
-			 || fhandler_console::get_nonascii_key (irec, tmpbuf))
-		  return me->read_ready = true;
-		/* Allow Ctrl-Space for ^@ */
-		else if ( (irec.Event.KeyEvent.wVirtualKeyCode == VK_SPACE
-			   || irec.Event.KeyEvent.wVirtualKeyCode == '2')
-			 && (irec.Event.KeyEvent.dwControlKeyState &
-			     (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED))
-			 && !(irec.Event.KeyEvent.dwControlKeyState
-			      & (LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED)) )
-		  return me->read_ready = true;
-	      }
-	    /* Ignore key up events, except for Alt+Numpad events. */
-	    else if (is_alt_numpad_event (&irec))
-	      return me->read_ready = true;
-	  }
-	else
-	  {
-	    if (irec.EventType == MOUSE_EVENT
-		&& fh->mouse_aware (irec.Event.MouseEvent))
-		return me->read_ready = true;
-	    if (irec.EventType == FOCUS_EVENT && fh->focus_aware ())
-		return me->read_ready = true;
-	  }
-
-	/* Read and discard the event */
-	ReadConsoleInputW (h, &irec, 1, &events_read);
+	set_sig_errno (EINTR);
+	return -1;
       }
+  if (fh->input_ready || fh->get_cons_readahead_valid ())
+    return me->read_ready = true;
 
   return me->write_ready;
 }
@@ -1089,7 +1061,6 @@ verify_console (select_record *me, fd_set *rfds, fd_set *wfds,
   return peek_console (me, true);
 }
 
-
 select_record *
 fhandler_console::select_read (select_stuff *ss)
 {
@@ -1104,7 +1075,7 @@ fhandler_console::select_read (select_stuff *ss)
   s->peek = peek_console;
   s->h = get_handle ();
   s->read_selected = true;
-  s->read_ready = get_readahead_valid ();
+  s->read_ready = input_ready || get_cons_readahead_valid ();
   return s;
 }
 
-- 
2.17.0
