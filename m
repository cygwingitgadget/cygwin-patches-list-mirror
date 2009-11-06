Return-Path: <cygwin-patches-return-6813-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20642 invoked by alias); 6 Nov 2009 08:20:10 -0000
Received: (qmail 20629 invoked by uid 22791); 6 Nov 2009 08:20:08 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=BAYES_00,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.10)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Nov 2009 08:20:01 +0000
Received: from towo.net (dslb-088-073-010-191.pools.arcor-ip.net [88.73.10.191]) 	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis) 	id 0M7Ual-1MBB3j1CFD-00whzl; Fri, 06 Nov 2009 09:19:57 +0100
Received: by towo.net (sSMTP sendmail emulation); Fri, 6 Nov 2009 09:20:04 +0100
Date: Fri, 06 Nov 2009 08:20:00 -0000
To: cygwin-patches@cygwin.com
From: Thomas Wolff <towo@towo.net>
Subject: console enhancements: mouse events
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=%%message-boundary%%
Message-Id: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00144.txt.bz2


--%%message-boundary%%
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-length: 3307

Hi,
About enhancements of cygwin console features, I've now worked out a 
patch which does the following:

* Implement additional mouse reporting modes 1002 and 1003 as known 
  from xterm and mintty; they report mouse move events.
* Add detection and reporting of mouse scroll events to mouse reporting 
  mode 1000.
  Note: This works on my home PC (Windows XP Home) but it's not effective 
  on my work PC (Windows XP Professional) where the mouse wheel scrolls the 
  Windows console (which it doesn't on the other machine); I don't know 
  how to disable or configure this.
* Enforce consistence between select() and read() about whether mouse 
  reporting input is available by moving all checks into the common 
  function mouse_aware.
* Add mouse focus reporting mode 1004 as known from xterm and mintty.
* As a separate change, where I added the initialization of the additional 
  reporting modes, I also added and fixed some screen attribute modes as 
  known from the Linux console (and xterm):
  - ESC[22m disable bold, ESC[28m disable invisible, ESC[25m disable blinking
  - ESC[2m dim as usual on other terminals, instead of ESC[9m

Some other console issues (not covered by this patch) are probably better 
discussed on cygwin-developers but maybe I can mention them here already:
* Maybe the escape sequences of shifted function keys should be modified 
  to comply with those of the Linux console?
* I would like to fix some key assignments:
  - Control-(Shift-)6 inputs Control-^ which is not proper on international 
    keyboards if Shift-6 is not "^", Control-^ (the key) does not input 
    Control-^ (the character) on the other hand; the same glitch 
    occurs in the pure Windows console, however.
    Unfortunately, with the functions being used it is not possible to 
    detect that shifted key "^" was hit together with Control; only 
    keycodes/scancodes are available when Control/Shift/Alt are used. So 
    I don't know whether this can easily be fixed. It works in mintty but 
    I think mintty uses different Windows functions.
  - Pressing something like Alt-Ã¶ on a German keyboard leaves an illegal UTF-8 
    sequence (the second byte of the respective sequence) in input, apparently 
    because Alt-0xC3 is handled somehow. Don't know, though, whether this is 
    a cygwin console issue or maybe a readline issue.
* I intended to implement cursor position reports and noticed that their 
  request ESC[6n is already handled in the code; it does not work, however, 
  so I started to debug it:
  The readahead buffer is used (also used for UTF-8 bytes) but after the 
  buffer has been filled with the reporting sequence it appears to be empty 
  (logged ralen in put_readahead, get_readahead and elsewhere where it is 
  modified). First puzzled by the trace output, my assumption is that 
  the readahead buffer of stdout is being filled (while handling the 
  request) but the readahead buffer of stdin is checked and should have 
  been filled instead (so this can never have worked).
  I don't know, however, how to access the other buffer while handling 
  within stdout because I'm not familiar with the fhandler design. Could 
  someone please give a hint or fix this?
* VT100 graphics mode should be added as suggested by Andy.

Kind regards,
Thomas



--%%message-boundary%%
Content-Type: text/plain; charset=utf-8; name="cygwin-1.7.0-63-patch-mouse-events-etc.patch"
Content-Transfer-Encoding: 8bit
Content-length: 14495

diff -rup cygwin-1.7.0-63-orig/winsup/cygwin/ChangeLog cygwin-1.7.0-63/winsup/cygwin/ChangeLog
--- cygwin-1.7.0-63-orig/winsup/cygwin/ChangeLog	2009-11-03 14:58:50.000000000 +0100
+++ cygwin-1.7.0-63/winsup/cygwin/ChangeLog	2009-11-04 12:55:52.227074000 +0100
@@ -1,3 +1,27 @@
+2009-11-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler.h (use_mouse): Enable additional mouse modes (bool->int).
+	(mouse_aware): Move enhanced function into fhandler_console.cc.
+	* fhandler_console.cc (read): Detect and handle mouse wheel scrolling 
+	and mouse movement events. Use mouse_aware as a guard and only 
+	condition for mouse reporting in order to enforce consistence 
+	with select(). Add focus reports.
+	(mouse_aware) Enable detection of additional mouse events for select.
+	Tune function to precisely match actual reporting criteria.
+	Move adjustment of mouse position (by window scroll offset) 
+	here to avoid duplicate code.
+	(char_command): Initialization of enhanced mouse reporting modes.
+	Initialization of focus reports.
+	* select.cc (peek_console): Use modified mouse_aware() for more 
+	general detection of mouse events. Also check for focus reports.
+
+2009-11-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (char_command): Fix code to select dim mode 
+	to usual 2 (not leaving previous 9 for compatibility because it 
+	doesn't work anyway); also add entries for mode 22 (normal, not bold) 
+	28 (visible, not invisible), 25 (not blinking).
+
 2009-11-03  Corinna Vinschen  <corinna@vinschen.de>
 
 	* security.cc (alloc_sd): Re-introduce setting the SE_DACL_PROTECTED
diff -rup cygwin-1.7.0-63-orig/winsup/cygwin/fhandler.h cygwin-1.7.0-63/winsup/cygwin/fhandler.h
--- cygwin-1.7.0-63-orig/winsup/cygwin/fhandler.h	2009-10-20 10:16:40.000000000 +0200
+++ cygwin-1.7.0-63/winsup/cygwin/fhandler.h	2009-11-04 12:45:39.688539000 +0100
@@ -925,11 +925,15 @@ class dev_console
     } info;
 
   COORD dwLastCursorPosition;
-  DWORD dwLastButtonState;
+  COORD dwMousePosition;	/* scroll-adjusted coord of mouse event */
+  COORD dwLastMousePosition;	/* scroll-adjusted coord of previous mouse event */
+  DWORD dwLastButtonState;	/* (not noting mouse wheel events) */
+  int last_button_code;		/* transformed mouse report button code */
   int nModifiers;
 
   bool insert_mode;
-  bool use_mouse;
+  int use_mouse;
+  bool use_focus;
   bool raw_win32_keyboard_mode;
 
   inline UINT get_console_cp ();
@@ -1001,7 +1005,11 @@ class fhandler_console: public fhandler_
 
   int ioctl (unsigned int cmd, void *);
   int init (HANDLE, DWORD, mode_t);
-  bool mouse_aware () {return dev_state->use_mouse;}
+  bool mouse_aware (MOUSE_EVENT_RECORD& mouse_event);
+  bool focus_aware ()
+    {
+      return dev_state->use_focus;
+    }
 
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
diff -rup cygwin-1.7.0-63-orig/winsup/cygwin/fhandler_console.cc cygwin-1.7.0-63/winsup/cygwin/fhandler_console.cc
--- cygwin-1.7.0-63-orig/winsup/cygwin/fhandler_console.cc	2009-10-03 14:28:04.000000000 +0200
+++ cygwin-1.7.0-63/winsup/cygwin/fhandler_console.cc	2009-11-04 14:48:31.197074200 +0100
@@ -100,6 +100,10 @@ fhandler_console::get_tty_stuff (int fla
       dev_state->scroll_region.Bottom = -1;
       dev_state->dwLastCursorPosition.X = -1;
       dev_state->dwLastCursorPosition.Y = -1;
+      dev_state->dwLastMousePosition.X = -1;
+      dev_state->dwLastMousePosition.Y = -1;
+      dev_state->dwLastButtonState = 0;	/* none pressed */
+      dev_state->last_button_code = 3;	/* released */
       dev_state->underline_color = FOREGROUND_GREEN | FOREGROUND_BLUE;
       dev_state->dim_color = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE;
       dev_state->meta_mask = LEFT_ALT_PRESSED;
@@ -206,6 +210,45 @@ fhandler_console::send_winch_maybe ()
     }
 }
 
+/* Check whether a mouse event is to be reported as an escape sequence */
+bool
+fhandler_console::mouse_aware (MOUSE_EVENT_RECORD& mouse_event)
+{
+  if (! dev_state->use_mouse)
+    return 0;
+
+  /* Adjust mouse position by window scroll buffer offset
+     and remember adjusted position in state for use by read() */
+  CONSOLE_SCREEN_BUFFER_INFO now;
+  if (GetConsoleScreenBufferInfo (get_output_handle (), &now))
+    {
+      dev_state->dwMousePosition.X = mouse_event.dwMousePosition.X - now.srWindow.Left;
+      dev_state->dwMousePosition.Y = mouse_event.dwMousePosition.Y - now.srWindow.Top;
+    }
+  else
+    {
+      /* Cannot adjust position by window scroll buffer offset */
+      return 0;
+    }
+
+  /* Check whether adjusted mouse position can be reported */
+  if (dev_state->dwMousePosition.X > 0xFF - ' ' - 1
+      || dev_state->dwMousePosition.Y > 0xFF - ' ' - 1)
+    {
+      /* Mouse position out of reporting range */
+      return 0;
+    }
+
+  return ((mouse_event.dwEventFlags == 0 || mouse_event.dwEventFlags == DOUBLE_CLICK)
+	  && mouse_event.dwButtonState != dev_state->dwLastButtonState)
+	 || mouse_event.dwEventFlags == MOUSE_WHEELED
+	 || (mouse_event.dwEventFlags == MOUSE_MOVED
+	     && (dev_state->dwMousePosition.X != dev_state->dwLastMousePosition.X
+	         || dev_state->dwMousePosition.Y != dev_state->dwLastMousePosition.Y)
+	     && ((dev_state->use_mouse >= 2 && mouse_event.dwButtonState)
+	         || dev_state->use_mouse >= 3));
+}
+
 void __stdcall
 fhandler_console::read (void *pv, size_t& buflen)
 {
@@ -400,10 +443,18 @@ fhandler_console::read (void *pv, size_t
 	  break;
 
 	case MOUSE_EVENT:
-	  send_winch_maybe ();
-	  if (dev_state->use_mouse)
+	 send_winch_maybe ();
+	 {
+	  MOUSE_EVENT_RECORD& mouse_event = input_rec.Event.MouseEvent;
+	  /* As a unique guard for mouse report generation, 
+	     call mouse_aware() which is common with select(), so the result 
+	     of select() and the actual read() will be consistent on the 
+	     issue of whether input (i.e. a mouse escape sequence) will 
+	     be available or not */
+	  if (mouse_aware (mouse_event))
 	    {
-	      MOUSE_EVENT_RECORD& mouse_event = input_rec.Event.MouseEvent;
+	      /* Note: Reported mouse position was already retrieved by 
+	         mouse_aware() and adjusted by window scroll buffer offset */
 
 	      /* Treat the double-click event like a regular button press */
 	      if (mouse_event.dwEventFlags == DOUBLE_CLICK)
@@ -412,95 +463,106 @@ fhandler_console::read (void *pv, size_t
 		  mouse_event.dwEventFlags = 0;
 		}
 
-	      /* Did something other than a click occur? */
-	      if (mouse_event.dwEventFlags)
-		continue;
-
-	      /* Retrieve reported mouse position */
-	      int x = mouse_event.dwMousePosition.X;
-	      int y = mouse_event.dwMousePosition.Y;
-
-	      /* Adjust mouse position by scroll buffer offset */
-	      CONSOLE_SCREEN_BUFFER_INFO now;
-	      if (GetConsoleScreenBufferInfo (get_output_handle (), &now))
-		{
-		  y -= now.srWindow.Top;
-		  x -= now.srWindow.Left;
-		}
-	      else
-		{
-		  syscall_printf ("mouse: cannot adjust position by scroll buffer offset");
-		  continue;
-		}
-
-	      /* If the mouse event occurred out of the area we can handle,
-		 ignore it. */
-	      if ((x + ' ' + 1 > 0xFF) || (y + ' ' + 1 > 0xFF))
-		{
-		  syscall_printf ("mouse: position out of range");
-		  continue;
-		}
-
-	      /* Ignore unimportant mouse buttons */
-	      mouse_event.dwButtonState &= 0x7;
-
 	      /* This code assumes Windows never reports multiple button
 		 events at the same time. */
 	      int b = 0;
 	      char sz[32];
-	      if (mouse_event.dwButtonState == dev_state->dwLastButtonState)
-		{
-		  syscall_printf ("mouse: button state unchanged");
-		  continue;
-		}
-	      else if (mouse_event.dwButtonState < dev_state->dwLastButtonState)
-		{
-		  b = 3;
-		  strcpy (sz, "btn up");
-		}
-	      else if ((mouse_event.dwButtonState & 1) != (dev_state->dwLastButtonState & 1))
-		{
-		  b = 0;
-		  strcpy (sz, "btn1 down");
-		}
-	      else if ((mouse_event.dwButtonState & 2) != (dev_state->dwLastButtonState & 2))
+
+	      if (mouse_event.dwEventFlags == MOUSE_WHEELED)
 		{
-		  b = 2;
-		  strcpy (sz, "btn2 down");
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
-	      else if ((mouse_event.dwButtonState & 4) != (dev_state->dwLastButtonState & 4))
+	      else
 		{
-		  b = 1;
-		  strcpy (sz, "btn3 down");
-		}
+		  /* Ignore unimportant mouse buttons */
+		  mouse_event.dwButtonState &= 0x7;
 
-	      /* Remember the current button state */
-	      dev_state->dwLastButtonState = mouse_event.dwButtonState;
-
-	      /* If a button was pressed, remember the modifiers */
-	      if (b != 3)
-		{
-		  dev_state->nModifiers = 0;
-		  if (mouse_event.dwControlKeyState & SHIFT_PRESSED)
-		    dev_state->nModifiers |= 0x4;
-		  if (mouse_event.dwControlKeyState & (RIGHT_ALT_PRESSED|LEFT_ALT_PRESSED))
-		    dev_state->nModifiers |= 0x8;
-		  if (mouse_event.dwControlKeyState & (RIGHT_CTRL_PRESSED|LEFT_CTRL_PRESSED))
-		    dev_state->nModifiers |= 0x10;
-		}
+		  if (mouse_event.dwEventFlags == MOUSE_MOVED)
+		    {
+		      b = dev_state->last_button_code;
+		    }
+		  else if (mouse_event.dwButtonState < dev_state->dwLastButtonState)
+		    {
+		      b = 3;
+		      strcpy (sz, "btn up");
+		    }
+		  else if ((mouse_event.dwButtonState & 1) != (dev_state->dwLastButtonState & 1))
+		    {
+		      b = 0;
+		      strcpy (sz, "btn1 down");
+		    }
+		  else if ((mouse_event.dwButtonState & 2) != (dev_state->dwLastButtonState & 2))
+		    {
+		      b = 2;
+		      strcpy (sz, "btn2 down");
+		    }
+		  else if ((mouse_event.dwButtonState & 4) != (dev_state->dwLastButtonState & 4))
+		    {
+		      b = 1;
+		      strcpy (sz, "btn3 down");
+		    }
+
+		  dev_state->last_button_code = b;
+
+		  if (mouse_event.dwEventFlags == MOUSE_MOVED)
+		    {
+		      b += 32;
+		      strcpy (sz, "move");
+		    }
+		  else
+		    {
+		      /* Remember the modified button state */
+		      dev_state->dwLastButtonState = mouse_event.dwButtonState;
+		    }
+	        }
+
+	      /* Remember mouse position */
+	      dev_state->dwLastMousePosition.X = dev_state->dwMousePosition.X;
+	      dev_state->dwLastMousePosition.Y = dev_state->dwMousePosition.Y;
+
+	      /* Remember the modifiers */
+	      dev_state->nModifiers = 0;
+	      if (mouse_event.dwControlKeyState & SHIFT_PRESSED)
+		  dev_state->nModifiers |= 0x4;
+	      if (mouse_event.dwControlKeyState & (RIGHT_ALT_PRESSED|LEFT_ALT_PRESSED))
+		  dev_state->nModifiers |= 0x8;
+	      if (mouse_event.dwControlKeyState & (RIGHT_CTRL_PRESSED|LEFT_CTRL_PRESSED))
+		  dev_state->nModifiers |= 0x10;
 
+	      /* Indicate the modifiers */
 	      b |= dev_state->nModifiers;
 
 	      /* We can now create the code. */
-	      sprintf (tmp, "\033[M%c%c%c", b + ' ', x + ' ' + 1, y + ' ' + 1);
-	      syscall_printf ("mouse: %s at (%d,%d)", sz, x, y);
+	      sprintf (tmp, "\033[M%c%c%c", b + ' ', dev_state->dwMousePosition.X + ' ' + 1, dev_state->dwMousePosition.Y + ' ' + 1);
+	      syscall_printf ("mouse: %s at (%d,%d)", sz, dev_state->dwMousePosition.X, dev_state->dwMousePosition.Y);
 
 	      toadd = tmp;
 	      nread = 6;
 	    }
-	  break;
+	 }
+	 break;
 
 	case FOCUS_EVENT:
+	  if (dev_state->use_focus) {
+	    if (input_rec.Event.FocusEvent.bSetFocus)
+	      sprintf (tmp, "\033[I");
+	    else
+	      sprintf (tmp, "\033[O");
+
+	    toadd = tmp;
+	    nread = 3;
+	  }
+	  break;
+
 	case WINDOW_BUFFER_SIZE_EVENT:
 	  send_winch_maybe ();
 	  /* fall through */
@@ -1136,7 +1198,10 @@ fhandler_console::char_command (char c)
 	     case 1:    /* bold */
 	       dev_state->intensity = INTENSITY_BOLD;
 	       break;
-	     case 4:
+	     case 2:    /* dim */
+	       dev_state->intensity = INTENSITY_DIM;
+	       break;
+	     case 4:    /* underlined */
 	       dev_state->underline = 1;
 	       break;
 	     case 5:    /* blink mode */
@@ -1148,18 +1213,22 @@ fhandler_console::char_command (char c)
 	     case 8:    /* invisible */
 	       dev_state->intensity = INTENSITY_INVISIBLE;
 	       break;
-	     case 9:    /* dim */
-	       dev_state->intensity = INTENSITY_DIM;
-	       break;
 	     case 10:   /* end alternate charset */
 	       dev_state->alternate_charset_active = false;
 	       break;
 	     case 11:   /* start alternate charset */
 	       dev_state->alternate_charset_active = true;
 	       break;
+	     case 22:
+	     case 28:
+	       dev_state->intensity = INTENSITY_NORMAL;
+	       break;
 	     case 24:
 	       dev_state->underline = false;
 	       break;
+	     case 25:
+	       dev_state->blink = false;
+	       break;
 	     case 27:
 	       dev_state->reverse = false;
 	       break;
@@ -1275,9 +1344,24 @@ fhandler_console::char_command (char c)
 	    }
 	  break;
 
-	case 1000: /* Mouse support */
-	  dev_state->use_mouse = (c == 'h') ? true : false;
-	  syscall_printf ("mouse support %sabled", dev_state->use_mouse ? "en" : "dis");
+	case 1000: /* Mouse tracking */
+	  dev_state->use_mouse = (c == 'h') ? 1 : 0;
+	  syscall_printf ("mouse support set to mode %d", dev_state->use_mouse);
+	  break;
+
+	case 1002: /* Mouse button event tracking */
+	  dev_state->use_mouse = (c == 'h') ? 2 : 0;
+	  syscall_printf ("mouse support set to mode %d", dev_state->use_mouse);
+	  break;
+
+	case 1003: /* Mouse any event tracking */
+	  dev_state->use_mouse = (c == 'h') ? 3 : 0;
+	  syscall_printf ("mouse support set to mode %d", dev_state->use_mouse);
+	  break;
+
+	case 1004: /* Focus in/out event reporting */
+	  dev_state->use_focus = (c == 'h') ? true : false;
+	  syscall_printf ("focus reporting set to %d", dev_state->use_focus);
 	  break;
 
 	case 2000: /* Raw keyboard mode */
diff -rup cygwin-1.7.0-63-orig/winsup/cygwin/select.cc cygwin-1.7.0-63/winsup/cygwin/select.cc
--- cygwin-1.7.0-63-orig/winsup/cygwin/select.cc	2009-10-03 14:28:04.000000000 +0200
+++ cygwin-1.7.0-63/winsup/cygwin/select.cc	2009-10-24 02:30:14.000000000 +0200
@@ -823,9 +823,9 @@ peek_console (select_record *me, bool)
 	else
 	  {
 	    if (irec.EventType == MOUSE_EVENT
-		&& fh->mouse_aware ()
-		&& (irec.Event.MouseEvent.dwEventFlags == 0
-		    || irec.Event.MouseEvent.dwEventFlags == DOUBLE_CLICK))
+		&& fh->mouse_aware (irec.Event.MouseEvent))
+		return me->read_ready = true;
+	    if (irec.EventType == FOCUS_EVENT && fh->focus_aware ())
 		return me->read_ready = true;
 	  }
 

--%%message-boundary%%--
