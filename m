Return-Path: <cygwin-patches-return-6869-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12443 invoked by alias); 16 Dec 2009 09:48:39 -0000
Received: (qmail 12425 invoked by uid 22791); 16 Dec 2009 09:48:36 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.8)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 16 Dec 2009 09:48:31 +0000
Received: from [127.0.0.1] (dslb-088-073-057-210.pools.arcor-ip.net [88.73.57.210]) 	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis) 	id 0MbK2G-1Ndbna2LKe-00Iqha; Wed, 16 Dec 2009 10:48:27 +0100
Message-ID: <4B28ACE8.1050305@towo.net>
Date: Wed, 16 Dec 2009 09:48:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de> <20091215130036.GA19394@calimero.vinschen.de>
In-Reply-To: <20091215130036.GA19394@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------060707050306040906080104"
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
X-SW-Source: 2009-q4/txt/msg00200.txt.bz2

This is a multi-part message in MIME format.
--------------060707050306040906080104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 499

Corinna Vinschen schrieb:
> I've applied the first part of the patch:
> 	* fhandler_console.cc (char_command): Fix code to select dim mode
> 	to 2 rather than 9.  Add entries for mode 22 (normal, not bold)
> 	28 (visible, not invisible), 25 (not blinking).
>   
Thanks. So here is the next chunk, the event reporting enhancements 
(additional mouse events, additional mouse reporting modes, focus event 
reporting). I am attaching the change log as a text file to preserve its 
formatting.

Thomas


--------------060707050306040906080104
Content-Type: text/plain;
 name="ChangeLog.add"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.add"
Content-length: 1102

2009-12-16  Thomas Wolff  <towo@towo.net>

	* fhandler_console.cc (read): Detect and handle mouse wheel scrolling 
	events (for completion of mouse reporting mode 1000) and mouse 
	movement events (for additional mouse reporting modes 1002 and 1003).
	Use mouse_aware() as a guard and only condition for mouse 
	reporting in order to enforce consistence of read() and select().
	Add focus reports (for additional focus reporting mode 1004).
	(mouse_aware): Enable detection of additional mouse events for select().
	Tune function to precisely match actual reporting criteria.
	Move adjustment of mouse position (by window scroll offset) 
	here to avoid duplicate code.
	(char_command): Initialization of enhanced mouse reporting modes.
	Initialization of focus reporting mode.
	* fhandler.h (use_mouse): Change flag (bool->int) to indicate 
	additional mouse modes. Add flag to indicate focus reporting.
	(mouse_aware): Move enhanced function into fhandler_console.cc.
	* select.cc (peek_console): Use modified mouse_aware() for more 
	general detection of mouse events. Also check for focus reports.


--------------060707050306040906080104
Content-Type: text/plain;
 name="cygwin-console-mouse-enhancements.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-console-mouse-enhancements.patch"
Content-length: 12566

Index: src/winsup/cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.384
diff -u -p -r1.384 fhandler.h
--- src/winsup/cygwin/fhandler.h	17 Nov 2009 10:43:00 -0000	1.384
+++ src/winsup/cygwin/fhandler.h	16 Dec 2009 09:39:23 -0000
@@ -936,11 +936,15 @@ class dev_console
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
@@ -1012,7 +1016,8 @@ class fhandler_console: public fhandler_
 
   int ioctl (unsigned int cmd, void *);
   int init (HANDLE, DWORD, mode_t);
-  bool mouse_aware () {return dev_state->use_mouse;}
+  bool mouse_aware (MOUSE_EVENT_RECORD& mouse_event);
+  bool focus_aware () {return dev_state->use_focus;}
 
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
Index: src/winsup/cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.208
diff -u -p -r1.208 fhandler_console.cc
--- src/winsup/cygwin/fhandler_console.cc	15 Dec 2009 12:46:40 -0000	1.208
+++ src/winsup/cygwin/fhandler_console.cc	16 Dec 2009 09:39:30 -0000
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
@@ -362,9 +405,12 @@ fhandler_console::read (void *pv, size_t
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
@@ -400,10 +446,18 @@ fhandler_console::read (void *pv, size_t
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
@@ -412,95 +466,106 @@ fhandler_console::read (void *pv, size_t
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
@@ -1282,9 +1347,24 @@ fhandler_console::char_command (char c)
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
Index: src/winsup/cygwin/select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.154
diff -u -p -r1.154 select.cc
--- src/winsup/cygwin/select.cc	1 Sep 2009 14:25:10 -0000	1.154
+++ src/winsup/cygwin/select.cc	16 Dec 2009 09:40:04 -0000
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
 

--------------060707050306040906080104--
