Return-Path: <cygwin-patches-return-7643-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3203 invoked by alias); 22 Apr 2012 19:08:20 -0000
Received: (qmail 3184 invoked by uid 22791); 22 Apr 2012 19:08:18 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS,TW_CP,TW_RX
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.186)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 22 Apr 2012 19:07:57 +0000
Received: from [127.0.0.1] (dslb-088-073-036-239.pools.arcor-ip.net [88.73.36.239])	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)	id 0M1dC2-1S7GD149Fa-00tkzj; Sun, 22 Apr 2012 21:07:56 +0200
Message-ID: <4F945706.3050808@towo.net>
Date: Sun, 22 Apr 2012 19:08:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Extended mouse coordinates
Content-Type: multipart/mixed; boundary="------------070005070407050407070008"
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
X-SW-Source: 2012-q2/txt/msg00012.txt.bz2

This is a multi-part message in MIME format.
--------------070005070407050407070008
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 482

This patch replaces my previous proposal 
(http://cygwin.com/ml/cygwin-patches/2012-q2/msg00005.html) with two 
modifications:

  * Fixed a bug that suppressed mouse reporting at large coordinates (in
    all modes actually:-\ )
  * Added mouse mode 1005 (total of 3 three new modes, so all reporting
    modes run by current terminal emulators would be implemented)

I would appreciate the patch to be applied this time, planned to be my 
last mouse patch :)

Kind regards,
Thomas

--------------070005070407050407070008
Content-Type: text/plain; charset=windows-1252;
 name="mouse-modes-6-16.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mouse-modes-6-16.changelog"
Content-length: 498

2012-04-03  Thomas Wolff  <towo@towo.net>

	* fhandler.h (class dev_console): Two flags for extended mouse modes.
	* fhandler_console.cc (fhandler_console::read): Implemented 
	extended mouse modes 1015 (urxvt, mintty, xterm) and 1006 (xterm).
	Not implemented extended mouse mode 1005 (xterm, mintty).
	Supporting mouse coordinates greater than 222 (each axis).
	Also: two { wrap formatting consistency fixes.
	(fhandler_console::char_command) Initialization of enhanced 
	mouse reporting modes.


--------------070005070407050407070008
Content-Type: text/plain; charset=windows-1252;
 name="mouse-modes-6-16.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mouse-modes-6-16.patch"
Content-length: 4760

diff -rup sav/fhandler.h ./fhandler.h
--- sav/fhandler.h	2012-04-01 19:46:04.000000000 +0200
+++ ./fhandler.h	2012-04-03 15:52:07.893561600 +0200
@@ -1282,6 +1282,8 @@ class dev_console
 
   bool insert_mode;
   int use_mouse;
+  bool ext_mouse_mode6;
+  bool ext_mouse_mode15;
   bool use_focus;
   bool raw_win32_keyboard_mode;
 
diff -rup sav/fhandler_console.cc ./fhandler_console.cc
--- sav/fhandler_console.cc	2012-04-02 00:28:55.000000000 +0200
+++ ./fhandler_console.cc	2012-04-03 15:56:13.993152400 +0200
@@ -452,12 +452,13 @@ fhandler_console::read (void *pv, size_t
 	    {
 	      char c = dev_state.backspace_keycode;
 	      nread = 0;
-	      if (control_key_state & ALT_PRESSED) {
-		if (dev_state.metabit)
-		  c |= 0x80;
-		else
-		  tmp[nread++] = '\e';
-	      }
+	      if (control_key_state & ALT_PRESSED)
+		{
+		  if (dev_state.metabit)
+		    c |= 0x80;
+		  else
+		    tmp[nread++] = '\e';
+		}
 	      tmp[nread++] = c;
 	      tmp[nread] = 0;
 	      toadd = tmp;
@@ -550,6 +551,7 @@ fhandler_console::read (void *pv, size_t
 		   events at the same time. */
 		int b = 0;
 		char sz[32];
+		char mode6_term = 'M';
 
 		if (mouse_event.dwEventFlags == MOUSE_WHEELED)
 		  {
@@ -573,7 +575,7 @@ fhandler_console::read (void *pv, size_t
 		      {
 			b = dev_state.last_button_code;
 		      }
-		    else if (mouse_event.dwButtonState < dev_state.dwLastButtonState)
+		    else if (mouse_event.dwButtonState < dev_state.dwLastButtonState && !dev_state.ext_mouse_mode6)
 		      {
 			b = 3;
 			strcpy (sz, "btn up");
@@ -594,6 +596,10 @@ fhandler_console::read (void *pv, size_t
 			strcpy (sz, "btn3 down");
 		      }
 
+		    if (dev_state.ext_mouse_mode6)	/* distinguish release */
+		      if (mouse_event.dwButtonState < dev_state.dwLastButtonState)
+		        mode6_term = 'm';
+
 		    dev_state.last_button_code = b;
 
 		    if (mouse_event.dwEventFlags == MOUSE_MOVED)
@@ -625,25 +631,46 @@ fhandler_console::read (void *pv, size_t
 		b |= dev_state.nModifiers;
 
 		/* We can now create the code. */
-		sprintf (tmp, "\033[M%c%c%c", b + ' ', dev_state.dwMousePosition.X + ' ' + 1, dev_state.dwMousePosition.Y + ' ' + 1);
+		if (dev_state.ext_mouse_mode6)
+		  {
+		    sprintf (tmp, "\033[<%d;%d;%d%c", b, dev_state.dwMousePosition.X + 1, dev_state.dwMousePosition.Y + 1, mode6_term);
+		    nread = strlen (tmp);
+		  }
+		else if (dev_state.ext_mouse_mode15)
+		  {
+		    sprintf (tmp, "\033[%d;%d;%dM", b + 32, dev_state.dwMousePosition.X + 1, dev_state.dwMousePosition.Y + 1);
+		    nread = strlen (tmp);
+		  }
+		/* else if (dev_state.ext_mouse_mode5) not implemented */
+		else
+		  {
+		    unsigned int xcode = dev_state.dwMousePosition.X + ' ' + 1;
+		    unsigned int ycode = dev_state.dwMousePosition.Y + ' ' + 1;
+		    if (xcode >= 256)
+		      xcode = 0;
+		    if (ycode >= 256)
+		      ycode = 0;
+		    sprintf (tmp, "\033[M%c%c%c", b + ' ', xcode, ycode);
+		    nread = 6;	/* tmp may contain NUL bytes */
+		  }
 		syscall_printf ("mouse: %s at (%d,%d)", sz, dev_state.dwMousePosition.X, dev_state.dwMousePosition.Y);
 
 		toadd = tmp;
-		nread = 6;
 	      }
 	  }
 	  break;
 
 	case FOCUS_EVENT:
-	  if (dev_state.use_focus) {
-	    if (input_rec.Event.FocusEvent.bSetFocus)
-	      sprintf (tmp, "\033[I");
-	    else
-	      sprintf (tmp, "\033[O");
+	  if (dev_state.use_focus)
+	    {
+	      if (input_rec.Event.FocusEvent.bSetFocus)
+	        sprintf (tmp, "\033[I");
+	      else
+	        sprintf (tmp, "\033[O");
 
-	    toadd = tmp;
-	    nread = 3;
-	  }
+	      toadd = tmp;
+	      nread = 3;
+	    }
 	  break;
 
 	case WINDOW_BUFFER_SIZE_EVENT:
@@ -1516,22 +1543,30 @@ fhandler_console::char_command (char c)
 
 	case 1000: /* Mouse tracking */
 	  dev_state.use_mouse = (c == 'h') ? 1 : 0;
-	  syscall_printf ("mouse support set to mode %d", dev_state.use_mouse);
 	  break;
 
 	case 1002: /* Mouse button event tracking */
 	  dev_state.use_mouse = (c == 'h') ? 2 : 0;
-	  syscall_printf ("mouse support set to mode %d", dev_state.use_mouse);
 	  break;
 
 	case 1003: /* Mouse any event tracking */
 	  dev_state.use_mouse = (c == 'h') ? 3 : 0;
-	  syscall_printf ("mouse support set to mode %d", dev_state.use_mouse);
 	  break;
 
 	case 1004: /* Focus in/out event reporting */
 	  dev_state.use_focus = (c == 'h') ? true : false;
-	  syscall_printf ("focus reporting set to %d", dev_state.use_focus);
+	  break;
+
+	case 1005: /* Extended mouse mode */
+	  syscall_printf ("ignored h/l command for extended mouse mode");
+	  break;
+
+	case 1006: /* SGR extended mouse mode */
+	  dev_state.ext_mouse_mode6 = c == 'h';
+	  break;
+
+	case 1015: /* Urxvt extended mouse mode */
+	  dev_state.ext_mouse_mode15 = c == 'h';
 	  break;
 
 	case 2000: /* Raw keyboard mode */

--------------070005070407050407070008--
