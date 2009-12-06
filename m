Return-Path: <cygwin-patches-return-6859-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10567 invoked by alias); 6 Dec 2009 19:24:56 -0000
Received: (qmail 10433 invoked by uid 22791); 6 Dec 2009 19:24:51 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0 	tests=AWL,BAYES_50,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.10)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 06 Dec 2009 19:24:42 +0000
Received: from [127.0.0.1] (dslb-088-073-042-133.pools.arcor-ip.net [88.73.42.133]) 	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis) 	id 0MaV5d-1NX7LW1LjN-00Kemp; Sun, 06 Dec 2009 20:24:39 +0100
Message-ID: <4B1C04D1.8010707@towo.net>
Date: Sun, 06 Dec 2009 19:24:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx> <20091119160948.GA1883@calimero.vinschen.de>
In-Reply-To: <20091119160948.GA1883@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------070608070605060207040605"
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
X-SW-Source: 2009-q4/txt/msg00190.txt.bz2

This is a multi-part message in MIME format.
--------------070608070605060207040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 3013

Corinna Vinschen wrote:
> Could you please resend the latest version of your patch so we
> can have another look into it?
This is my updated and extended patch for a number of console enhancements.
> Christopher Faylor wrote:
>   
>> Can we hold of on applying this until after 1.7 is released?
>>     
Sure, feel free to apply when suitable. I just happened to work on it 
around this time...
> Yeah, maybe we really should do that for now.  Except for the
> ESC9m -> ESC2m change, maybe...
>   
If you want a subset of the features sooner than others, I may split the 
patch.


------------------------------------------------------------------------

The patch contains the following enhancements, all intended to increase 
compatibility with xterm and mintty (or rxvt in the case of modified 
function keys as it was desired to stay compatible with the linux console):

* Additional event reporting as described before:
  - Report mouse wheel scrolling in mode 1000.
  - Report mouse movement in new modes 1002 and 1003.
  - Report focus events in new mode 1004.
* Add and fix a few rarely used screen attributes as described before.
* Enable ESC prefixing for Alt-AltGr keys, so that e.g. Alt-@ works on 
keyboards where @ is AltGr-q.
* Extend escape sequences for modified function keys to indicate all 
combinations of Ctrl, Shift, Alt, using the rxvt codes.
* Extend escape sequences for modified keypad keys to indicate all 
combinations of Ctrl, Shift, Alt, following the xterm/mintty convention 
for Ctrl and Shift, and the rxvt/linux convention for Alt, to reach 
maximum compatibility.
  Note that Alt handling interfers with the Windows-style Alt-numeric 
character input method but it did so before already, so I didn't break 
anything. However, if that method is desired to work, I would modify my 
patch accordingly.
* Add VT100 graphics mode. It remaps small ASCII letters to line drawing 
graphics and is enabled / disabled in either of two ways:
        \033(0 jklmntuvwx \033(B
        \016 jklmntuvwx \017
  where the latter mode would normally be enabled with \033)0 but this 
is not required by my implementation (nor by mlterm); if guarding it by 
the enabling sequence is desired, I can easily add that.
* Fix cursor position reports and terminal status reports to work. Add 
"Secondary Device Attribute" report option to the latter.
  I implemented this with an additional static readahead buffer local to 
fhandler_console because the fhandler_base object buffer did not work as 
I described before.
  Side remark: While implementing this, I noticed that cygwin creates 37 
fhandler_console objects which I think is quite weird and probably not 
intended. Stdin is associated with object # 7 and stdout is always 
associated with the last one. Whenever bash redirects output to stderr, 
3 new objects are created.

There is only one feature missing now which I may try to implement later:
* Fix control-character mappings (for non-letter controls) on 
international keyboards.

Thomas

--------------070608070605060207040605
Content-Type: text/plain;
 name="cygwin-1.7.0-68-console-enhancements.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="cygwin-1.7.0-68-console-enhancements.patch"
Content-length: 30403

diff -rup cygwin-1.7.0-68.orig/winsup/cygwin/ChangeLog cygwin-1.7.0-68/winsup/cygwin/ChangeLog
--- cygwin-1.7.0-68.orig/winsup/cygwin/ChangeLog	2009-12-04 16:53:56.000000000 +0100
+++ cygwin-1.7.0-68/winsup/cygwin/ChangeLog	2009-12-05 14:02:42.000000000 +0100
@@ -1,3 +1,76 @@
+2009-12-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (write): Detect ">" while parsing ESC [ 
+	sequences to distinguish specific requests.
+	(char_command): Distinguish Secondary from Primary Device Attribute 
+	request to report more details about cygwin console terminal version.
+	* fhandler.h: Flag to note ">" in ESC [ sequences.
+
+2009-12-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (c_rabuf, c_puts_readahead, c_peek_readahead, 
+	c_get_readahead_into_buffer): Static readahead buffer specific 
+	for fhandler_console (independent from fhandler_base buffer) 
+	to fix terminal status requests / escape sequence reporting.
+	(read): Check c_rabuf to deliver status report strings.
+	* select.cc (peek_console): Check peek_c_readahead() to detect 
+	console terminal reports.
+
+2009-12-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (read): Allow combined Alt-AltGr modifiers 
+	to also produce an ESC prefix like a plain Alt modifier, e.g. to make 
+	Alt-@ work on a keyboard where @ is AltGr-q.
+
+2009-12-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (get_nonascii_key): Generate ESC prefix 
+	for Alt modifier generically for function keys and keypad keys.
+	(keytable): Add escape sequences for remaining modified function keys as 
+	a compatible extension using rxvt escape codes.
+	Also distinguish keypad keys modified with Ctrl, Shift, Ctrl-Shift using 
+	xterm-style modifier coding.
+
+2009-12-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (__vt100_conv): Table to transform small ASCII 
+	letters to line drawing graphics for use in VT100 graphics mode.
+	(write_console): Check for VT100 graphics mode and transform wide 
+	characters in ASCII small letter range to corresponding graphics.
+	(write_normal): Check for SO/SI control characters to 
+	enable/disable VT100 graphics mode.
+	(base_chars): Enable SO/SI control characters for detection.
+	(write): Check for ESC ( 0 / ESC ( B escape sequences to 
+	enable/disable VT100 graphics mode.
+	* fhandler.h: New flag vt100_graphics_mode_active, state value 
+	gotparen to parse ESC ( escape sequences.
+
+2009-12-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (read): Detect and handle mouse wheel scrolling 
+	events (for completion of mouse reporting mode 1000) and mouse 
+	movement events (for additional mouse reporting modes 1002 and 1003).
+	Use mouse_aware() as a guard and only condition for mouse 
+	reporting in order to enforce consistence of read() and select().
+	Add focus reports (for additional focus reporting mode 1004).
+	(mouse_aware): Enable detection of additional mouse events for select.
+	Tune function to precisely match actual reporting criteria.
+	Move adjustment of mouse position (by window scroll offset) 
+	here to avoid duplicate code.
+	(char_command): Initialization of enhanced mouse reporting modes.
+	Initialization of focus reports.
+	* fhandler.h (use_mouse): Flag for additional mouse modes (bool->int).
+	(mouse_aware): Move enhanced function into fhandler_console.cc.
+	* select.cc (peek_console): Use modified mouse_aware() for more 
+	general detection of mouse events. Also check for focus reports.
+
+2009-12-04  Thomas Wolff  <towo@towo.net>
+
+	* fhandler_console.cc (char_command): Fix code to select dim mode 
+	to usual 2 (not leaving previous 9 for compatibility because it 
+	doesn't work anyway); also add entries for mode 22 (normal, not bold) 
+	28 (visible, not invisible), 25 (not blinking).
+
 2009-12-02  Corinna Vinschen  <corinna@vinschen.de>
 
 	* fhandler_socket.cc (send_internal): Don't split datagram messages
diff -rup cygwin-1.7.0-68.orig/winsup/cygwin/fhandler.h cygwin-1.7.0-68/winsup/cygwin/fhandler.h
--- cygwin-1.7.0-68.orig/winsup/cygwin/fhandler.h	2009-11-19 09:55:58.000000000 +0100
+++ cygwin-1.7.0-68/winsup/cygwin/fhandler.h	2009-12-04 17:45:02.000000000 +0100
@@ -889,6 +889,8 @@ enum ansi_intensity
 #define gotcommand 5
 #define gettitle 6
 #define eattitle 7
+#define gotparen 8
+#define gotrparen 9
 #define MAXARGS 10
 
 class dev_console
@@ -904,6 +906,8 @@ class dev_console
   int nargs_;
   unsigned rarg;
   bool saw_question_mark;
+  bool saw_greater_than_sign;
+  bool vt100_graphics_mode_active;
   bool alternate_charset_active;
   bool metabit;
 
@@ -936,11 +940,15 @@ class dev_console
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
@@ -1012,7 +1020,8 @@ class fhandler_console: public fhandler_
 
   int ioctl (unsigned int cmd, void *);
   int init (HANDLE, DWORD, mode_t);
-  bool mouse_aware () {return dev_state->use_mouse;}
+  bool mouse_aware (MOUSE_EVENT_RECORD& mouse_event);
+  bool focus_aware () {return dev_state->use_focus;}
 
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
diff -rup cygwin-1.7.0-68.orig/winsup/cygwin/fhandler_console.cc cygwin-1.7.0-68/winsup/cygwin/fhandler_console.cc
--- cygwin-1.7.0-68.orig/winsup/cygwin/fhandler_console.cc	2009-11-19 09:55:58.000000000 +0100
+++ cygwin-1.7.0-68/winsup/cygwin/fhandler_console.cc	2009-12-04 18:03:56.000000000 +0100
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
@@ -206,6 +210,78 @@ fhandler_console::send_winch_maybe ()
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
+static char c_rabuf[40];
+static char * c_rabufpoi = 0;
+
+static void
+c_puts_readahead (char *buf)
+{
+  strcpy (c_rabuf, buf);
+  c_rabufpoi = c_rabuf;
+}
+
+static int
+c_get_readahead_into_buffer (char *buf, size_t buflen)
+{
+  int copied_chars = 0;
+
+  while (buflen && c_rabufpoi && *c_rabufpoi)
+    {
+	buf[copied_chars++] = (unsigned char) (*c_rabufpoi++ & 0xff);
+	buflen--;
+    }
+
+  return copied_chars;
+}
+
+int
+c_peek_readahead ()
+{
+  if (c_rabufpoi)
+    return (unsigned char) *c_rabufpoi;
+  else
+    return -1;
+}
+
 void __stdcall
 fhandler_console::read (void *pv, size_t& buflen)
 {
@@ -216,7 +292,11 @@ fhandler_console::read (void *pv, size_t
   int ch;
   set_input_state ();
 
-  int copied_chars = get_readahead_into_buffer (buf, buflen);
+  int copied_chars = c_get_readahead_into_buffer (buf, buflen);
+  if (!copied_chars)
+    {
+      copied_chars = get_readahead_into_buffer (buf, buflen);
+    }
 
   if (copied_chars)
     {
@@ -362,9 +442,12 @@ fhandler_console::read (void *pv, size_t
 	      /* Determine if the keystroke is modified by META.  The tricky
 		 part is to distinguish whether the right Alt key should be
 		 recognized as Alt, or as AltGr. */
-	      bool meta;
-	      meta = (control_key_state & ALT_PRESSED) != 0
+	      bool meta =
+		     /* Alt but not AltGr (= left ctrl + right alt)? */
+		     (control_key_state & ALT_PRESSED) != 0
 		     && ((control_key_state & CTRL_PRESSED) == 0
+			    /* but also allow Alt-AltGr: */
+			 || (control_key_state & ALT_PRESSED) == ALT_PRESSED
 			 || (wch <= 0x1f || wch == 0x7f));
 	      if (!meta)
 		{
@@ -400,10 +483,18 @@ fhandler_console::read (void *pv, size_t
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
@@ -412,95 +503,106 @@ fhandler_console::read (void *pv, size_t
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
-
-	      /* Remember the current button state */
-	      dev_state->dwLastButtonState = mouse_event.dwButtonState;
+		  /* Ignore unimportant mouse buttons */
+		  mouse_event.dwButtonState &= 0x7;
 
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
@@ -1051,9 +1153,53 @@ fhandler_console::cursor_get (int *x, in
   *x = dev_state->info.dwCursorPosition.X;
 }
 
+static wchar_t __vt100_conv [31] = {
+/* VT100 line drawing graphics mode maps
+	`abcdefghijklmnopqrstuvwxyz{|}~
+   to
+	ââââââÂ°Â±â¤ââââââ¼âºâ»ââ¼â½ââ¤â´â¬ââ¤â¥Ïâ Â£Â·
+*/
+	0x25C6 /* â */,
+	0x2592 /* â */,
+	0x2409 /* â */,
+	0x240C /* â */,
+	0x240D /* â */,
+	0x240A /* â */,
+	0x00B0 /* Â° */,
+	0x00B1 /* Â± */,
+	0x2424 /* â¤ */,
+	0x240B /* â */,
+	0x2518 /* â */,
+	0x2510 /* â */,
+	0x250C /* â */,
+	0x2514 /* â */,
+	0x253C /* â¼ */,
+	0x23BA /* âº */,
+	0x23BB /* â» */,
+	0x2500 /* â */,
+	0x23BC /* â¼ */,
+	0x23BD /* â½ */,
+	0x251C /* â */,
+	0x2524 /* â¤ */,
+	0x2534 /* â´ */,
+	0x252C /* â¬ */,
+	0x2502 /* â */,
+	0x2264 /* â¤ */,
+	0x2265 /* â¥ */,
+	0x03C0 /* Ï */,
+	0x2260 /* â  */,
+	0x00A3 /* Â£ */,
+	0x00B7 /* Â· */,
+};
+
 inline
 bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
+  if (dev_state->vt100_graphics_mode_active)
+    for (DWORD i = 0; i < len; i ++)
+      if (buf[i] >= (unsigned char) '`' && buf[i] <= (unsigned char) '~')
+        buf[i] = __vt100_conv[buf[i] - (unsigned char) '`'];
+
   while (len > 0)
     {
       DWORD nbytes = len > MAX_WRITE_CHARS ? MAX_WRITE_CHARS : len;
@@ -1082,11 +1228,13 @@ bool fhandler_console::write_console (PW
 #define TAB 8 /* We should't let the console deal with these */
 #define CR 13
 #define LF 10
+#define SO 14
+#define SI 15
 
 static const char base_chars[256] =
 {
 /*00 01 02 03 04 05 06 07 */ IGN, ERR, ERR, NOR, NOR, NOR, NOR, BEL,
-/*08 09 0A 0B 0C 0D 0E 0F */ BAK, TAB, DWN, ERR, ERR, CR,  ERR, IGN,
+/*08 09 0A 0B 0C 0D 0E 0F */ BAK, TAB, DWN, ERR, ERR, CR,  SO,  SI,
 /*10 11 12 13 14 15 16 17 */ NOR, NOR, ERR, ERR, ERR, ERR, ERR, ERR,
 /*18 19 1A 1B 1C 1D 1E 1F */ NOR, NOR, ERR, ESC, ERR, ERR, ERR, ERR,
 /*   !  "  #  $  %  &  '  */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,
@@ -1136,7 +1284,10 @@ fhandler_console::char_command (char c)
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
@@ -1148,18 +1299,22 @@ fhandler_console::char_command (char c)
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
@@ -1275,9 +1430,24 @@ fhandler_console::char_command (char c)
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
@@ -1413,8 +1583,11 @@ fhandler_console::char_command (char c)
 	WriteFile (get_output_handle (), &dev_state->args_[0], 1, (DWORD *) &x, 0);
       break;
     case 'c':				/* u9 - Terminal enquire string */
-      strcpy (buf, "\033[?6c");
-      puts_readahead (buf);
+      if (dev_state->saw_greater_than_sign)
+	__small_sprintf (buf, "\033[>67;%d%02d;0c", CYGWIN_VERSION_DLL_MAJOR, CYGWIN_VERSION_DLL_MINOR);
+      else
+	strcpy (buf, "\033[?6c");
+      c_puts_readahead (buf);
       break;
     case 'n':
       switch (dev_state->args_[0])
@@ -1424,7 +1597,7 @@ fhandler_console::char_command (char c)
 	  y -= dev_state->info.winTop;
 	  /* x -= dev_state->info.winLeft;		// not available yet */
 	  __small_sprintf (buf, "\033[%d;%dR", y + 1, x + 1);
-	  puts_readahead (buf);
+	  c_puts_readahead (buf);
 	  break;
     default:
 	  goto bad_escape;
@@ -1589,6 +1762,12 @@ fhandler_console::write_normal (const un
       int x, y;
       switch (base_chars[*found])
 	{
+	case SO:
+	  dev_state->vt100_graphics_mode_active = true;
+	  break;
+	case SI:
+	  dev_state->vt100_graphics_mode_active = false;
+	  break;
 	case BEL:
 	  beep ();
 	  break;
@@ -1679,45 +1858,54 @@ fhandler_console::write (const void *vsr
 	    return -1;
 	  break;
 	case gotesc:
-	  if (*src == '[')
+	  if (*src == '[')		/* CSI Control Sequence Introducer */
 	    {
 	      dev_state->state_ = gotsquare;
 	      dev_state->saw_question_mark = false;
+	      dev_state->saw_greater_than_sign = false;
 	      for (dev_state->nargs_ = 0; dev_state->nargs_ < MAXARGS; dev_state->nargs_++)
 		dev_state->args_[dev_state->nargs_] = 0;
 	      dev_state->nargs_ = 0;
 	    }
-	  else if (*src == ']')
+	  else if (*src == ']')		/* OSC Operating System Command */
 	    {
 	      dev_state->rarg = 0;
 	      dev_state->my_title_buf[0] = '\0';
 	      dev_state->state_ = gotrsquare;
 	    }
-	  else if (*src == 'M')		/* Reverse Index */
+	  else if (*src == '(')		/* Designate G0 character set */
+	    {
+	      dev_state->state_ = gotparen;
+	    }
+	  else if (*src == ')')		/* Designate G1 character set */
+	    {
+	      dev_state->state_ = gotrparen;
+	    }
+	  else if (*src == 'M')		/* Reverse Index (scroll down) */
 	    {
 	      dev_state->fillin_info (get_output_handle ());
 	      scroll_screen (0, 0, -1, -1, 0, dev_state->info.winTop + 1);
 	      dev_state->state_ = normal;
 	    }
-	  else if (*src == 'c')		/* Reset Linux terminal */
+	  else if (*src == 'c')		/* RIS Full Reset */
 	    {
 	      dev_state->set_default_attr ();
 	      clear_screen (0, 0, -1, -1);
 	      cursor_set (true, 0, 0);
 	      dev_state->state_ = normal;
 	    }
-	  else if (*src == '8')		/* Restore cursor position */
+	  else if (*src == '8')		/* DECRC Restore cursor position */
 	    {
 	      cursor_set (true, dev_state->savex, dev_state->savey);
 	      dev_state->state_ = normal;
 	    }
-	  else if (*src == '7')		/* Save cursor position */
+	  else if (*src == '7')		/* DECSC Save cursor position */
 	    {
 	      cursor_get (&dev_state->savex, &dev_state->savey);
 	      dev_state->savey -= dev_state->info.winTop;
 	      dev_state->state_ = normal;
 	    }
-	  else if (*src == 'R')
+	  else if (*src == 'R')		/* ? */
 	      dev_state->state_ = normal;
 	  else
 	    {
@@ -1791,12 +1979,31 @@ fhandler_console::write (const void *vsr
 	    {
 	      if (*src == '?')
 		dev_state->saw_question_mark = true;
+	      else if (*src == '>')
+		dev_state->saw_greater_than_sign = true;
 	      /* ignore any extra chars between [ and first arg or command */
 	      src++;
 	    }
 	  else
 	    dev_state->state_ = gotarg1;
 	  break;
+	case gotparen:
+	  if (*src == '0')
+	    dev_state->vt100_graphics_mode_active = true;
+	  else
+	    dev_state->vt100_graphics_mode_active = false;
+	  dev_state->state_ = normal;
+	  src++;
+	  break;
+	case gotrparen:
+	  /* This is not strictly needed, ^N/^O can just always be enabled */
+	  if (*src == '0')
+	    /*dev_state->vt100_graphics_mode_SOSI_enabled = true*/;
+	  else
+	    /*dev_state->vt100_graphics_mode_SOSI_enabled = false*/;
+	  dev_state->state_ = normal;
+	  src++;
+	  break;
 	}
     }
 
@@ -1809,33 +2016,39 @@ static struct {
   int vk;
   const char *val[4];
 } keytable[] NO_COPY = {
-	       /* NORMAL */    /* SHIFT */     /* CTRL */     /* ALT */
-  {VK_LEFT,	{"\033[D",	"\033[D",	"\033[D",	"\033\033[D"}},
-  {VK_RIGHT,	{"\033[C",	"\033[C",	"\033[C",	"\033\033[C"}},
-  {VK_UP,	{"\033[A",	"\033[A",	"\033[A",	"\033\033[A"}},
-  {VK_DOWN,	{"\033[B",	"\033[B",	"\033[B",	"\033\033[B"}},
-  {VK_PRIOR,	{"\033[5~",	"\033[5~",	"\033[5~",	"\033\033[5~"}},
-  {VK_NEXT,	{"\033[6~",	"\033[6~",	"\033[6~",	"\033\033[6~"}},
-  {VK_HOME,	{"\033[1~",	"\033[1~",	"\033[1~",	"\033\033[1~"}},
-  {VK_END,	{"\033[4~",	"\033[4~",	"\033[4~",	"\033\033[4~"}},
-  {VK_INSERT,	{"\033[2~",	"\033[2~",	"\033[2~",	"\033\033[2~"}},
-  {VK_DELETE,	{"\033[3~",	"\033[3~",	"\033[3~",	"\033\033[3~"}},
-  {VK_F1,	{"\033[[A",	"\033[23~",	NULL,		NULL}},
-  {VK_F2,	{"\033[[B",	"\033[24~",	NULL,		NULL}},
-  {VK_F3,	{"\033[[C",	"\033[25~",	NULL,		NULL}},
-  {VK_F4,	{"\033[[D",	"\033[26~",	NULL,		NULL}},
-  {VK_F5,	{"\033[[E",	"\033[28~",	NULL,		NULL}},
-  {VK_F6,	{"\033[17~",	"\033[29~",	"\036",		NULL}},
-  {VK_F7,	{"\033[18~",	"\033[31~",	NULL,		NULL}},
-  {VK_F8,	{"\033[19~",	"\033[32~",	NULL,		NULL}},
-  {VK_F9,	{"\033[20~",	"\033[33~",	NULL,		NULL}},
-  {VK_F10,	{"\033[21~",	"\033[34~",	NULL,		NULL}},
-  {VK_F11,	{"\033[23~",	NULL,		NULL,		NULL}},
-  {VK_F12,	{"\033[24~",	NULL,		NULL,		NULL}},
-  {VK_NUMPAD5,	{"\033[G",	NULL,		NULL,		NULL}},
-  {VK_CLEAR,	{"\033[G",	NULL,		NULL,		NULL}},
+	       /* NORMAL */    /* SHIFT */     /* CTRL */     /* CTRL-SHIFT */
+  /* Unmodified and Alt-modified keypad keys comply with linux console
+     SHIFT, CTRL, CTRL-SHIFT modifiers comply with xterm modifier usage */
+  {VK_NUMPAD5,	{"\033[G",	"\033[1;2G",	"\033[1;5G",	"\033[1;6G"}},
+  {VK_CLEAR,	{"\033[G",	"\033[1;2G",	"\033[1;5G",	"\033[1;6G"}},
+  {VK_LEFT,	{"\033[D",	"\033[1;2D",	"\033[1;5D",	"\033[1;6D"}},
+  {VK_RIGHT,	{"\033[C",	"\033[1;2C",	"\033[1;5C",	"\033[1;6C"}},
+  {VK_UP,	{"\033[A",	"\033[1;2A",	"\033[1;5A",	"\033[1;6A"}},
+  {VK_DOWN,	{"\033[B",	"\033[1;2B",	"\033[1;5B",	"\033[1;6B"}},
+  {VK_PRIOR,	{"\033[5~",	"\033[5;2~",	"\033[5;5~",	"\033[5;6~"}},
+  {VK_NEXT,	{"\033[6~",	"\033[6;2~",	"\033[6;5~",	"\033[6;6~"}},
+  {VK_HOME,	{"\033[1~",	"\033[1;2~",	"\033[1;5~",	"\033[1;6~"}},
+  {VK_END,	{"\033[4~",	"\033[4;2~",	"\033[4;5~",	"\033[4;6~"}},
+  {VK_INSERT,	{"\033[2~",	"\033[2;2~",	"\033[2;5~",	"\033[2;6~"}},
+  {VK_DELETE,	{"\033[3~",	"\033[3;2~",	"\033[3;5~",	"\033[3;6~"}},
+  /* F1...F12, SHIFT-F1...SHIFT-F10 comply with linux console
+     F6...F12, and all modified F-keys comply with rxvt (compatible extension) */
+  {VK_F1,	{"\033[[A",	"\033[23~",	"\033[11^",	"\033[23^"}},
+  {VK_F2,	{"\033[[B",	"\033[24~",	"\033[12^",	"\033[24^"}},
+  {VK_F3,	{"\033[[C",	"\033[25~",	"\033[13^",	"\033[25^"}},
+  {VK_F4,	{"\033[[D",	"\033[26~",	"\033[14^",	"\033[26^"}},
+  {VK_F5,	{"\033[[E",	"\033[28~",	"\033[15^",	"\033[28^"}},
+  {VK_F6,	{"\033[17~",	"\033[29~",	"\033[17^",	"\033[29^"}},
+  {VK_F7,	{"\033[18~",	"\033[31~",	"\033[18^",	"\033[31^"}},
+  {VK_F8,	{"\033[19~",	"\033[32~",	"\033[19^",	"\033[32^"}},
+  {VK_F9,	{"\033[20~",	"\033[33~",	"\033[20^",	"\033[33^"}},
+  {VK_F10,	{"\033[21~",	"\033[34~",	"\033[21^",	"\033[34^"}},
+  {VK_F11,	{"\033[23~",	"\033[23$",	"\033[23^",	"\033[23@"}},
+  {VK_F12,	{"\033[24~",	"\033[24$",	"\033[24^",	"\033[24@"}},
+  /* CTRL-6 complies with Windows cmd console but should be fixed */
   {'6',		{NULL,		NULL,		"\036",		NULL}},
-  {0,		{"",		NULL,		NULL,		NULL}}
+  /* Table end marker */
+  {0}
 };
 
 const char *
@@ -1844,21 +2057,29 @@ get_nonascii_key (INPUT_RECORD& input_re
 #define NORMAL  0
 #define SHIFT	1
 #define CONTROL	2
-#define ALT	3
-  int modifier_index = NORMAL;
+/*#define CONTROLSHIFT	3*/
 
+  int modifier_index = NORMAL;
   if (input_rec.Event.KeyEvent.dwControlKeyState & SHIFT_PRESSED)
     modifier_index = SHIFT;
-  else if (input_rec.Event.KeyEvent.dwControlKeyState &
+  if (input_rec.Event.KeyEvent.dwControlKeyState &
 		(LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED))
-    modifier_index = CONTROL;
-  else if (input_rec.Event.KeyEvent.dwControlKeyState &
-		(LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED))
-    modifier_index = ALT;
+    modifier_index += CONTROL;
 
   for (int i = 0; keytable[i].vk; i++)
     if (input_rec.Event.KeyEvent.wVirtualKeyCode == keytable[i].vk)
-      return keytable[i].val[modifier_index];
+      {
+        if ((input_rec.Event.KeyEvent.dwControlKeyState &
+		(LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED))
+	    && keytable[i].val[modifier_index] != NULL)
+          { /* Generic ESC prefixing if Alt is pressed */
+	    tmp[0] = '\033';
+	    strcpy (tmp + 1, keytable[i].val[modifier_index]);
+	    return tmp;
+          }
+        else
+          return keytable[i].val[modifier_index];
+      }
 
   if (input_rec.Event.KeyEvent.uChar.AsciiChar)
     {
diff -rup cygwin-1.7.0-68.orig/winsup/cygwin/select.cc cygwin-1.7.0-68/winsup/cygwin/select.cc
--- cygwin-1.7.0-68.orig/winsup/cygwin/select.cc	2009-10-03 14:28:06.000000000 +0200
+++ cygwin-1.7.0-68/winsup/cygwin/select.cc	2009-12-04 18:36:06.000000000 +0100
@@ -781,6 +781,7 @@ fhandler_fifo::select_except (select_stu
 static int
 peek_console (select_record *me, bool)
 {
+  extern int c_peek_readahead ();
   extern const char * get_nonascii_key (INPUT_RECORD& input_rec, char *);
   fhandler_console *fh = (fhandler_console *) me->fh;
 
@@ -815,6 +816,8 @@ peek_console (select_record *me, bool)
 	fh->send_winch_maybe ();
 	if (irec.EventType == KEY_EVENT)
 	  {
+	    if (c_peek_readahead () >= 0)
+	      return me->read_ready = true;
 	    if (irec.Event.KeyEvent.bKeyDown
 		&& (irec.Event.KeyEvent.uChar.AsciiChar
 		    || get_nonascii_key (irec, tmpbuf)))
@@ -823,9 +826,9 @@ peek_console (select_record *me, bool)
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
 

--------------070608070605060207040605--
