Return-Path: <cygwin-patches-return-7632-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26587 invoked by alias); 2 Apr 2012 18:46:52 -0000
Received: (qmail 26574 invoked by uid 22791); 2 Apr 2012 18:46:50 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SARE_SUB_NEED_REPLY,SPF_HELO_PASS,TW_CP,TW_RX
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.8)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Apr 2012 18:46:37 +0000
Received: from [127.0.0.1] (dslb-088-073-037-163.pools.arcor-ip.net [88.73.37.163])	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)	id 0MRRcG-1Rm5Lf22Yq-00T7sn; Mon, 02 Apr 2012 20:46:36 +0200
Message-ID: <4F79F407.9000700@towo.net>
Date: Mon, 02 Apr 2012 18:46:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: console: new mouse modes, request/response attempt
Content-Type: multipart/mixed; boundary="------------010303060507050900050705"
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
X-SW-Source: 2012-q2/txt/msg00001.txt.bz2

This is a multi-part message in MIME format.
--------------010303060507050900050705
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 816

This patch includes 2 things (to be fixed and separated anyway; change 
log still missing) for discussion:
* mouse modes 6 and 15 (numeric mouse coordinates)
* semi-fix for missing terminal status responses
The fix tries to detect the proper fhandler for CONIO, which is then 
used to queue the response.
Problem 1: I am not sure whether this detection is proper in all cases, 
what e.g. if /dev/tty is reopened etc. I don't know where else a 
relation between the handles for CONIN and CONOUT might be established.
Problem 2: While the response reaches the application with this patch, 
only the first byte is read right-away. Further bytes are delayed until 
other input is becoming present (typing a key). This may (or may not) be 
related to other issues with select(), so maybe it's worth analyzing it.

Thomas

--------------010303060507050900050705
Content-Type: text/plain; charset=windows-1252;
 name="cygwin-console-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-console-patch"
Content-length: 5922

diff -rup sav/fhandler.h ./fhandler.h
--- sav/fhandler.h	2012-04-01 19:46:04.000000000 +0200
+++ ./fhandler.h	2012-04-02 15:47:22.385727000 +0200
@@ -1282,8 +1282,11 @@ class dev_console
 
   bool insert_mode;
   int use_mouse;
+  bool ext_mouse_mode6;
+  bool ext_mouse_mode15;
   bool use_focus;
   bool raw_win32_keyboard_mode;
+  fhandler_console * fh_tty;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
diff -rup sav/fhandler_console.cc ./fhandler_console.cc
--- sav/fhandler_console.cc	2012-04-02 00:28:55.000000000 +0200
+++ ./fhandler_console.cc	2012-04-02 18:02:26.004016200 +0200
@@ -139,6 +139,8 @@ fhandler_console::set_unit ()
   if (shared_console_info)
     {
       fh_devices this_unit = dev ();
+      if (this_unit == FH_TTY)
+	dev_state.fh_tty = this;
       fh_devices shared_unit =
 	(fh_devices) shared_console_info->tty_min_state.getntty ();
       devset = (shared_unit == this_unit || this_unit == FH_CONSOLE
@@ -452,12 +454,13 @@ fhandler_console::read (void *pv, size_t
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
@@ -550,6 +553,7 @@ fhandler_console::read (void *pv, size_t
 		   events at the same time. */
 		int b = 0;
 		char sz[32];
+		char mode6_term = 'M';
 
 		if (mouse_event.dwEventFlags == MOUSE_WHEELED)
 		  {
@@ -573,7 +577,7 @@ fhandler_console::read (void *pv, size_t
 		      {
 			b = dev_state.last_button_code;
 		      }
-		    else if (mouse_event.dwButtonState < dev_state.dwLastButtonState)
+		    else if (mouse_event.dwButtonState < dev_state.dwLastButtonState && !dev_state.ext_mouse_mode6)
 		      {
 			b = 3;
 			strcpy (sz, "btn up");
@@ -594,6 +598,10 @@ fhandler_console::read (void *pv, size_t
 			strcpy (sz, "btn3 down");
 		      }
 
+		    if (dev_state.ext_mouse_mode6)	/* distinguish release */
+		      if (mouse_event.dwButtonState < dev_state.dwLastButtonState)
+		        mode6_term = 'm';
+
 		    dev_state.last_button_code = b;
 
 		    if (mouse_event.dwEventFlags == MOUSE_MOVED)
@@ -625,25 +633,46 @@ fhandler_console::read (void *pv, size_t
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
@@ -1516,22 +1545,30 @@ fhandler_console::char_command (char c)
 
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
@@ -1677,7 +1714,7 @@ fhandler_console::char_command (char c)
       /* The generated report needs to be injected for read-ahead into the
 	 fhandler_console object associated with standard input.
 	 The current call does not work. */
-      puts_readahead (buf);
+      dev_state.fh_tty->puts_readahead (buf);
       break;
     case 'n':
       switch (dev_state.args_[0])
@@ -1687,7 +1724,7 @@ fhandler_console::char_command (char c)
 	  y -= dev_state.info.winTop;
 	  /* x -= dev_state.info.winLeft;		// not available yet */
 	  __small_sprintf (buf, "\033[%d;%dR", y + 1, x + 1);
-	  puts_readahead (buf);
+	  dev_state.fh_tty->puts_readahead (buf);
 	  break;
     default:
 	  goto bad_escape;

--------------010303060507050900050705--
