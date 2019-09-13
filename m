Return-Path: <cygwin-patches-return-9670-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82191 invoked by alias); 13 Sep 2019 19:35:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82175 invoked by uid 89); 13 Sep 2019 19:35:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Per, press, META, sk:get_non
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Sep 2019 19:34:58 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x8DJYjl3018527;	Sat, 14 Sep 2019 04:34:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x8DJYjl3018527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568403292;	bh=4XGTb5g1hwRpgHaIDtEgCWKI6REba37/SiEqoxgc6XY=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=hh6lPEie9MJh0GT3QI8SoYVc9j0r7eppNHtvmOli8zTD6Ge7vT0sIguyEhNkzl2vb	 AcbaWlhkwnx1PJ63SpqNktel5Ve50uOcVPkO07MebQEh7q7Ws+HS9VRP000y2/4slU	 8Sh4Ge7Ci4tQVHwavx1xbW9h/V7fuCMs7WVMdzm9C6HzLXGOQv/tnCHtP7i13J1BW4	 Js4wgnRT32glGtp4dbl+BQwv4f2zzdlTrc6t+YOnj90yXeSUW/kYtI+BoClS4YB61Z	 SitdXKNlczPk6pzKoIXud9aeyi74jYIJkcynojv00Wyx8BU76BeGqPAUX49BBj+4ga	 EKCPqGcF0wOlQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: console: Fix read() in non-canonical mode.
Date: Fri, 13 Sep 2019 19:35:00 -0000
Message-Id: <20190913193439.1566-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190913193439.1566-1-takashi.yano@nifty.ne.jp>
References: <20190913193439.1566-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00190.txt.bz2

- In non-canonical mode, cygwin console returned only one character
  even if several keys are typed before read() called. This patch
  fixes this behaviour.
---
 winsup/cygwin/fhandler_console.cc | 606 ++++++++++++++++--------------
 1 file changed, 315 insertions(+), 291 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 778279f99..709b8255d 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -499,354 +499,378 @@ fhandler_console::process_input_message (void)
 
   termios *ti = &(get_ttyp ()->ti);
 
-  DWORD nread;
-  INPUT_RECORD input_rec;
-  const char *toadd = NULL;
+	  /* Per MSDN, max size of buffer required is below 64K. */
+#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
 
-  if (!ReadConsoleInputW (get_handle (), &input_rec, 1, &nread))
+  fhandler_console::input_states stat = input_processing;
+  DWORD total_read, i;
+  INPUT_RECORD input_rec[INREC_SIZE];
+
+  if (!PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read))
     {
-      termios_printf ("ReadConsoleInput failed, %E");
+      termios_printf ("PeekConsoleInput failed, %E");
       return input_error;
     }
 
-  const WCHAR &unicode_char = input_rec.Event.KeyEvent.uChar.UnicodeChar;
-  const DWORD &ctrl_key_state = input_rec.Event.KeyEvent.dwControlKeyState;
-
-  /* check the event that occurred */
-  switch (input_rec.EventType)
+  for (i = 0; i < total_read; i ++)
     {
-    case KEY_EVENT:
+      DWORD nread = 1;
+      const char *toadd = NULL;
 
-      con.nModifiers = 0;
+      const WCHAR &unicode_char =
+	input_rec[i].Event.KeyEvent.uChar.UnicodeChar;
+      const DWORD &ctrl_key_state =
+	input_rec[i].Event.KeyEvent.dwControlKeyState;
 
-#ifdef DEBUGGING
-      /* allow manual switching to/from raw mode via ctrl-alt-scrolllock */
-      if (input_rec.Event.KeyEvent.bKeyDown
-	  && input_rec.Event.KeyEvent.wVirtualKeyCode == VK_SCROLL
-	  && (ctrl_key_state & (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
-	  == (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
+      /* check the event that occurred */
+      switch (input_rec[i].EventType)
 	{
-	  set_raw_win32_keyboard_mode (!con.raw_win32_keyboard_mode);
-	  return input_processing;
-	}
-#endif
+	case KEY_EVENT:
 
-      if (con.raw_win32_keyboard_mode)
-	{
-	  __small_sprintf (tmp, "\033{%u;%u;%u;%u;%u;%luK",
-			   input_rec.Event.KeyEvent.bKeyDown,
-			   input_rec.Event.KeyEvent.wRepeatCount,
-			   input_rec.Event.KeyEvent.wVirtualKeyCode,
-			   input_rec.Event.KeyEvent.wVirtualScanCode,
-			   input_rec.Event.KeyEvent.uChar.UnicodeChar,
-			   input_rec.Event.KeyEvent.dwControlKeyState);
-	  toadd = tmp;
-	  nread = strlen (toadd);
-	  break;
-	}
+	  con.nModifiers = 0;
 
-      /* Ignore key up events, except for Alt+Numpad events. */
-      if (!input_rec.Event.KeyEvent.bKeyDown &&
-	  !is_alt_numpad_event (&input_rec))
-	return input_processing;
-      /* Ignore Alt+Numpad keys.  They are eventually handled below after
-	 releasing the Alt key. */
-      if (input_rec.Event.KeyEvent.bKeyDown
-	  && is_alt_numpad_key (&input_rec))
-	return input_processing;
-
-      if (ctrl_key_state & SHIFT_PRESSED)
-	con.nModifiers |= 1;
-      if (ctrl_key_state & RIGHT_ALT_PRESSED)
-	con.nModifiers |= 2;
-      if (ctrl_key_state & CTRL_PRESSED)
-	con.nModifiers |= 4;
-      if (ctrl_key_state & LEFT_ALT_PRESSED)
-	con.nModifiers |= 8;
-
-      /* Allow Backspace to emit ^? and escape sequences. */
-      if (input_rec.Event.KeyEvent.wVirtualKeyCode == VK_BACK)
-	{
-	  char c = con.backspace_keycode;
-	  nread = 0;
-	  if (ctrl_key_state & ALT_PRESSED)
+#ifdef DEBUGGING
+	  /* allow manual switching to/from raw mode via ctrl-alt-scrolllock */
+	  if (input_rec[i].Event.KeyEvent.bKeyDown
+	      && input_rec[i].Event.KeyEvent.wVirtualKeyCode == VK_SCROLL
+	      && (ctrl_key_state & (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
+	      == (LEFT_ALT_PRESSED | LEFT_CTRL_PRESSED))
 	    {
-	      if (con.metabit)
-		c |= 0x80;
-	      else
-		tmp[nread++] = '\e';
+	      set_raw_win32_keyboard_mode (!con.raw_win32_keyboard_mode);
+	      continue;
 	    }
-	  tmp[nread++] = c;
-	  tmp[nread] = 0;
-	  toadd = tmp;
-	}
-      /* Allow Ctrl-Space to emit ^@ */
-      else if (input_rec.Event.KeyEvent.wVirtualKeyCode
-	       == (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
-	       && (ctrl_key_state & CTRL_PRESSED)
-	       && !(ctrl_key_state & ALT_PRESSED))
-	toadd = "";
-      else if (unicode_char == 0
-	       /* arrow/function keys */
-	       || (input_rec.Event.KeyEvent.dwControlKeyState & ENHANCED_KEY))
-	{
-	  toadd = get_nonascii_key (input_rec, tmp);
-	  if (!toadd)
+#endif
+
+	  if (con.raw_win32_keyboard_mode)
 	    {
-	      con.nModifiers = 0;
-	      return input_processing;
+	      __small_sprintf (tmp, "\033{%u;%u;%u;%u;%u;%luK",
+			       input_rec[i].Event.KeyEvent.bKeyDown,
+			       input_rec[i].Event.KeyEvent.wRepeatCount,
+			       input_rec[i].Event.KeyEvent.wVirtualKeyCode,
+			       input_rec[i].Event.KeyEvent.wVirtualScanCode,
+			       input_rec[i].Event.KeyEvent.uChar.UnicodeChar,
+			       input_rec[i].Event.KeyEvent.dwControlKeyState);
+	      toadd = tmp;
+	      nread = strlen (toadd);
+	      break;
 	    }
-	  nread = strlen (toadd);
-	}
-      else
-	{
-	  nread = con.con_to_str (tmp + 1, 59, unicode_char);
-	  /* Determine if the keystroke is modified by META.  The tricky
-	     part is to distinguish whether the right Alt key should be
-	     recognized as Alt, or as AltGr. */
-	  bool meta =
-	    /* Alt but not AltGr (= left ctrl + right alt)? */
-	    (ctrl_key_state & ALT_PRESSED) != 0
-	    && ((ctrl_key_state & CTRL_PRESSED) == 0
-		/* but also allow Alt-AltGr: */
-		|| (ctrl_key_state & ALT_PRESSED) == ALT_PRESSED
-		|| (unicode_char <= 0x1f || unicode_char == 0x7f));
-	  if (!meta)
+
+	  /* Ignore key up events, except for Alt+Numpad events. */
+	  if (!input_rec[i].Event.KeyEvent.bKeyDown &&
+	      !is_alt_numpad_event (&input_rec[i]))
+	    continue;
+	  /* Ignore Alt+Numpad keys.  They are eventually handled below after
+	     releasing the Alt key. */
+	  if (input_rec[i].Event.KeyEvent.bKeyDown
+	      && is_alt_numpad_key (&input_rec[i]))
+	    continue;
+
+	  if (ctrl_key_state & SHIFT_PRESSED)
+	    con.nModifiers |= 1;
+	  if (ctrl_key_state & RIGHT_ALT_PRESSED)
+	    con.nModifiers |= 2;
+	  if (ctrl_key_state & CTRL_PRESSED)
+	    con.nModifiers |= 4;
+	  if (ctrl_key_state & LEFT_ALT_PRESSED)
+	    con.nModifiers |= 8;
+
+	  /* Allow Backspace to emit ^? and escape sequences. */
+	  if (input_rec[i].Event.KeyEvent.wVirtualKeyCode == VK_BACK)
 	    {
-	      /* Determine if the character is in the current multibyte
-		 charset.  The test is easy.  If the multibyte sequence
-		 is > 1 and the first byte is ASCII CAN, the character
-		 has been translated into the ASCII CAN + UTF-8 replacement
-		 sequence.  If so, just ignore the keypress.
-		 FIXME: Is there a better solution? */
-	      if (nread > 1 && tmp[1] == 0x18)
-		beep ();
-	      else
-		toadd = tmp + 1;
+	      char c = con.backspace_keycode;
+	      nread = 0;
+	      if (ctrl_key_state & ALT_PRESSED)
+		{
+		  if (con.metabit)
+		    c |= 0x80;
+		  else
+		    tmp[nread++] = '\e';
+		}
+	      tmp[nread++] = c;
+	      tmp[nread] = 0;
+	      toadd = tmp;
 	    }
-	  else if (con.metabit)
+	  /* Allow Ctrl-Space to emit ^@ */
+	  else if (input_rec[i].Event.KeyEvent.wVirtualKeyCode
+		   == (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
+		   && (ctrl_key_state & CTRL_PRESSED)
+		   && !(ctrl_key_state & ALT_PRESSED))
+	    toadd = "";
+	  else if (unicode_char == 0
+		   /* arrow/function keys */
+		   || (input_rec[i].Event.KeyEvent.dwControlKeyState
+		       & ENHANCED_KEY))
 	    {
-	      tmp[1] |= 0x80;
-	      toadd = tmp + 1;
+	      toadd = get_nonascii_key (input_rec[i], tmp);
+	      if (!toadd)
+		{
+		  con.nModifiers = 0;
+		  continue;
+		}
+	      nread = strlen (toadd);
 	    }
 	  else
 	    {
-	      tmp[0] = '\033';
-	      tmp[1] = cyg_tolower (tmp[1]);
-	      toadd = tmp;
-	      nread++;
-	      con.nModifiers &= ~4;
-	    }
-	}
-      break;
-
-    case MOUSE_EVENT:
-      send_winch_maybe ();
-	{
-	  MOUSE_EVENT_RECORD& mouse_event = input_rec.Event.MouseEvent;
-	  /* As a unique guard for mouse report generation,
-	     call mouse_aware() which is common with select(), so the result
-	     of select() and the actual read() will be consistent on the
-	     issue of whether input (i.e. a mouse escape sequence) will
-	     be available or not */
-	  if (mouse_aware (mouse_event))
-	    {
-	      /* Note: Reported mouse position was already retrieved by
-		 mouse_aware() and adjusted by window scroll buffer offset */
-
-	      /* Treat the double-click event like a regular button press */
-	      if (mouse_event.dwEventFlags == DOUBLE_CLICK)
+	      nread = con.con_to_str (tmp + 1, 59, unicode_char);
+	      /* Determine if the keystroke is modified by META.  The tricky
+		 part is to distinguish whether the right Alt key should be
+		 recognized as Alt, or as AltGr. */
+	      bool meta =
+		/* Alt but not AltGr (= left ctrl + right alt)? */
+		(ctrl_key_state & ALT_PRESSED) != 0
+		&& ((ctrl_key_state & CTRL_PRESSED) == 0
+		    /* but also allow Alt-AltGr: */
+		    || (ctrl_key_state & ALT_PRESSED) == ALT_PRESSED
+		    || (unicode_char <= 0x1f || unicode_char == 0x7f));
+	      if (!meta)
 		{
-		  syscall_printf ("mouse: double-click -> click");
-		  mouse_event.dwEventFlags = 0;
+		  /* Determine if the character is in the current multibyte
+		     charset.  The test is easy.  If the multibyte sequence
+		     is > 1 and the first byte is ASCII CAN, the character
+		     has been translated into the ASCII CAN + UTF-8 replacement
+		     sequence.  If so, just ignore the keypress.
+		     FIXME: Is there a better solution? */
+		  if (nread > 1 && tmp[1] == 0x18)
+		    beep ();
+		  else
+		    toadd = tmp + 1;
 		}
-
-	      /* This code assumes Windows never reports multiple button
-		 events at the same time. */
-	      int b = 0;
-	      char sz[32];
-	      char mode6_term = 'M';
-
-	      if (mouse_event.dwEventFlags == MOUSE_WHEELED)
+	      else if (con.metabit)
 		{
-		  if (mouse_event.dwButtonState & 0xFF800000)
-		    {
-		      b = 0x41;
-		      strcpy (sz, "wheel down");
-		    }
-		  else
-		    {
-		      b = 0x40;
-		      strcpy (sz, "wheel up");
-		    }
+		  tmp[1] |= 0x80;
+		  toadd = tmp + 1;
 		}
 	      else
 		{
-		  /* Ignore unimportant mouse buttons */
-		  mouse_event.dwButtonState &= 0x7;
+		  tmp[0] = '\033';
+		  tmp[1] = cyg_tolower (tmp[1]);
+		  toadd = tmp;
+		  nread++;
+		  con.nModifiers &= ~4;
+		}
+	    }
+	  break;
+
+	case MOUSE_EVENT:
+	  send_winch_maybe ();
+	    {
+	      MOUSE_EVENT_RECORD& mouse_event = input_rec[i].Event.MouseEvent;
+	      /* As a unique guard for mouse report generation,
+		 call mouse_aware() which is common with select(), so the result
+		 of select() and the actual read() will be consistent on the
+		 issue of whether input (i.e. a mouse escape sequence) will
+		 be available or not */
+	      if (mouse_aware (mouse_event))
+		{
+		  /* Note: Reported mouse position was already retrieved by
+		     mouse_aware() and adjusted by window scroll buffer offset */
 
-		  if (mouse_event.dwEventFlags == MOUSE_MOVED)
-		    {
-		      b = con.last_button_code;
-		    }
-		  else if (mouse_event.dwButtonState < con.dwLastButtonState
-			   && !con.ext_mouse_mode6)
-		    {
-		      b = 3;
-		      strcpy (sz, "btn up");
-		    }
-		  else if ((mouse_event.dwButtonState & 1)
-			   != (con.dwLastButtonState & 1))
+		  /* Treat the double-click event like a regular button press */
+		  if (mouse_event.dwEventFlags == DOUBLE_CLICK)
 		    {
-		      b = 0;
-		      strcpy (sz, "btn1 down");
+		      syscall_printf ("mouse: double-click -> click");
+		      mouse_event.dwEventFlags = 0;
 		    }
-		  else if ((mouse_event.dwButtonState & 2)
-			   != (con.dwLastButtonState & 2))
-		    {
-		      b = 2;
-		      strcpy (sz, "btn2 down");
-		    }
-		  else if ((mouse_event.dwButtonState & 4)
-			   != (con.dwLastButtonState & 4))
-		    {
-		      b = 1;
-		      strcpy (sz, "btn3 down");
-		    }
-
-		  if (con.ext_mouse_mode6 /* distinguish release */
-		      && mouse_event.dwButtonState < con.dwLastButtonState)
-		    mode6_term = 'm';
 
-		  con.last_button_code = b;
+		  /* This code assumes Windows never reports multiple button
+		     events at the same time. */
+		  int b = 0;
+		  char sz[32];
+		  char mode6_term = 'M';
 
-		  if (mouse_event.dwEventFlags == MOUSE_MOVED)
+		  if (mouse_event.dwEventFlags == MOUSE_WHEELED)
 		    {
-		      b += 32;
-		      strcpy (sz, "move");
+		      if (mouse_event.dwButtonState & 0xFF800000)
+			{
+			  b = 0x41;
+			  strcpy (sz, "wheel down");
+			}
+		      else
+			{
+			  b = 0x40;
+			  strcpy (sz, "wheel up");
+			}
 		    }
 		  else
 		    {
-		      /* Remember the modified button state */
-		      con.dwLastButtonState = mouse_event.dwButtonState;
+		      /* Ignore unimportant mouse buttons */
+		      mouse_event.dwButtonState &= 0x7;
+
+		      if (mouse_event.dwEventFlags == MOUSE_MOVED)
+			{
+			  b = con.last_button_code;
+			}
+		      else if (mouse_event.dwButtonState < con.dwLastButtonState
+			       && !con.ext_mouse_mode6)
+			{
+			  b = 3;
+			  strcpy (sz, "btn up");
+			}
+		      else if ((mouse_event.dwButtonState & 1)
+			       != (con.dwLastButtonState & 1))
+			{
+			  b = 0;
+			  strcpy (sz, "btn1 down");
+			}
+		      else if ((mouse_event.dwButtonState & 2)
+			       != (con.dwLastButtonState & 2))
+			{
+			  b = 2;
+			  strcpy (sz, "btn2 down");
+			}
+		      else if ((mouse_event.dwButtonState & 4)
+			       != (con.dwLastButtonState & 4))
+			{
+			  b = 1;
+			  strcpy (sz, "btn3 down");
+			}
+
+		      if (con.ext_mouse_mode6 /* distinguish release */
+			  && mouse_event.dwButtonState < con.dwLastButtonState)
+			mode6_term = 'm';
+
+		      con.last_button_code = b;
+
+		      if (mouse_event.dwEventFlags == MOUSE_MOVED)
+			{
+			  b += 32;
+			  strcpy (sz, "move");
+			}
+		      else
+			{
+			  /* Remember the modified button state */
+			  con.dwLastButtonState = mouse_event.dwButtonState;
+			}
 		    }
-		}
 
-	      /* Remember mouse position */
-	      con.dwLastMousePosition.X = con.dwMousePosition.X;
-	      con.dwLastMousePosition.Y = con.dwMousePosition.Y;
+		  /* Remember mouse position */
+		  con.dwLastMousePosition.X = con.dwMousePosition.X;
+		  con.dwLastMousePosition.Y = con.dwMousePosition.Y;
 
-	      /* Remember the modifiers */
-	      con.nModifiers = 0;
-	      if (mouse_event.dwControlKeyState & SHIFT_PRESSED)
-		con.nModifiers |= 0x4;
-	      if (mouse_event.dwControlKeyState & ALT_PRESSED)
-		con.nModifiers |= 0x8;
-	      if (mouse_event.dwControlKeyState & CTRL_PRESSED)
-		con.nModifiers |= 0x10;
+		  /* Remember the modifiers */
+		  con.nModifiers = 0;
+		  if (mouse_event.dwControlKeyState & SHIFT_PRESSED)
+		    con.nModifiers |= 0x4;
+		  if (mouse_event.dwControlKeyState & ALT_PRESSED)
+		    con.nModifiers |= 0x8;
+		  if (mouse_event.dwControlKeyState & CTRL_PRESSED)
+		    con.nModifiers |= 0x10;
 
-	      /* Indicate the modifiers */
-	      b |= con.nModifiers;
+		  /* Indicate the modifiers */
+		  b |= con.nModifiers;
 
-	      /* We can now create the code. */
-	      if (con.ext_mouse_mode6)
-		{
-		  __small_sprintf (tmp, "\033[<%d;%d;%d%c", b,
-				   con.dwMousePosition.X + 1,
-				   con.dwMousePosition.Y + 1,
-				   mode6_term);
-		  nread = strlen (tmp);
-		}
-	      else if (con.ext_mouse_mode15)
-		{
-		  __small_sprintf (tmp, "\033[%d;%d;%dM", b + 32,
-				   con.dwMousePosition.X + 1,
-				   con.dwMousePosition.Y + 1);
-		  nread = strlen (tmp);
-		}
-	      else if (con.ext_mouse_mode5)
-		{
-		  unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
-		  unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
-
-		  __small_sprintf (tmp, "\033[M%c", b + ' ');
-		  nread = 4;
-		  /* the neat nested encoding function of mintty
-		     does not compile in g++, so let's unfold it: */
-		  if (xcode < 0x80)
-		    tmp [nread++] = xcode;
-		  else if (xcode < 0x800)
+		  /* We can now create the code. */
+		  if (con.ext_mouse_mode6)
 		    {
-		      tmp [nread++] = 0xC0 + (xcode >> 6);
-		      tmp [nread++] = 0x80 + (xcode & 0x3F);
+		      __small_sprintf (tmp, "\033[<%d;%d;%d%c", b,
+				       con.dwMousePosition.X + 1,
+				       con.dwMousePosition.Y + 1,
+				       mode6_term);
+		      nread = strlen (tmp);
 		    }
-		  else
-		    tmp [nread++] = 0;
-		  if (ycode < 0x80)
-		    tmp [nread++] = ycode;
-		  else if (ycode < 0x800)
+		  else if (con.ext_mouse_mode15)
 		    {
-		      tmp [nread++] = 0xC0 + (ycode >> 6);
-		      tmp [nread++] = 0x80 + (ycode & 0x3F);
+		      __small_sprintf (tmp, "\033[%d;%d;%dM", b + 32,
+				       con.dwMousePosition.X + 1,
+				       con.dwMousePosition.Y + 1);
+		      nread = strlen (tmp);
+		    }
+		  else if (con.ext_mouse_mode5)
+		    {
+		      unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
+		      unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
+
+		      __small_sprintf (tmp, "\033[M%c", b + ' ');
+		      nread = 4;
+		      /* the neat nested encoding function of mintty
+			 does not compile in g++, so let's unfold it: */
+		      if (xcode < 0x80)
+			tmp [nread++] = xcode;
+		      else if (xcode < 0x800)
+			{
+			  tmp [nread++] = 0xC0 + (xcode >> 6);
+			  tmp [nread++] = 0x80 + (xcode & 0x3F);
+			}
+		      else
+			tmp [nread++] = 0;
+		      if (ycode < 0x80)
+			tmp [nread++] = ycode;
+		      else if (ycode < 0x800)
+			{
+			  tmp [nread++] = 0xC0 + (ycode >> 6);
+			  tmp [nread++] = 0x80 + (ycode & 0x3F);
+			}
+		      else
+			tmp [nread++] = 0;
 		    }
 		  else
-		    tmp [nread++] = 0;
+		    {
+		      unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
+		      unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
+		      if (xcode >= 256)
+			xcode = 0;
+		      if (ycode >= 256)
+			ycode = 0;
+		      __small_sprintf (tmp, "\033[M%c%c%c", b + ' ',
+				       xcode, ycode);
+		      nread = 6;	/* tmp may contain NUL bytes */
+		    }
+		  syscall_printf ("mouse: %s at (%d,%d)", sz,
+				  con.dwMousePosition.X,
+				  con.dwMousePosition.Y);
+
+		  toadd = tmp;
 		}
+	    }
+	  break;
+
+	case FOCUS_EVENT:
+	  if (con.use_focus)
+	    {
+	      if (input_rec[i].Event.FocusEvent.bSetFocus)
+		__small_sprintf (tmp, "\033[I");
 	      else
-		{
-		  unsigned int xcode = con.dwMousePosition.X + ' ' + 1;
-		  unsigned int ycode = con.dwMousePosition.Y + ' ' + 1;
-		  if (xcode >= 256)
-		    xcode = 0;
-		  if (ycode >= 256)
-		    ycode = 0;
-		  __small_sprintf (tmp, "\033[M%c%c%c", b + ' ',
-				   xcode, ycode);
-		  nread = 6;	/* tmp may contain NUL bytes */
-		}
-	      syscall_printf ("mouse: %s at (%d,%d)", sz,
-			      con.dwMousePosition.X,
-			      con.dwMousePosition.Y);
+		__small_sprintf (tmp, "\033[O");
 
 	      toadd = tmp;
+	      nread = 3;
 	    }
-	}
-      break;
-
-    case FOCUS_EVENT:
-      if (con.use_focus)
-	{
-	  if (input_rec.Event.FocusEvent.bSetFocus)
-	    __small_sprintf (tmp, "\033[I");
-	  else
-	    __small_sprintf (tmp, "\033[O");
+	  break;
 
-	  toadd = tmp;
-	  nread = 3;
+	case WINDOW_BUFFER_SIZE_EVENT:
+	  if (send_winch_maybe ())
+	    {
+	      stat = input_winch;
+	      goto out;
+	    }
+	  /* fall through */
+	default:
+	  continue;
 	}
-      break;
-
-    case WINDOW_BUFFER_SIZE_EVENT:
-      if (send_winch_maybe ())
-	return input_winch;
-      /* fall through */
-    default:
-      return input_processing;
-    }
 
-  if (toadd)
-    {
-      ssize_t ret;
-      line_edit_status res = line_edit (toadd, nread, *ti, &ret);
-      if (res == line_edit_signalled)
-	return input_signalled;
-      else if (res == line_edit_input_done)
+      if (toadd)
 	{
-	  input_ready = true;
-	  return input_ok;
+	  ssize_t ret;
+	  line_edit_status res = line_edit (toadd, nread, *ti, &ret);
+	  if (res == line_edit_signalled)
+	    {
+	      stat = input_signalled;
+	      goto out;
+	    }
+	  else if (res == line_edit_input_done)
+	    {
+	      input_ready = true;
+	      stat = input_ok;
+	      if (ti->c_lflag & ICANON)
+		goto out;
+	    }
 	}
     }
-  return input_processing;
+out:
+  /* Discard processed recored. */
+  DWORD dummy;
+  ReadConsoleInputW (get_handle (), input_rec, min (total_read, i+1), &dummy);
+  return stat;
 }
 
 void
-- 
2.21.0
