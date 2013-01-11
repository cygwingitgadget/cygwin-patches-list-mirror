Return-Path: <cygwin-patches-return-7789-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9391 invoked by alias); 11 Jan 2013 08:33:19 -0000
Received: (qmail 9378 invoked by uid 22791); 11 Jan 2013 08:33:16 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,RDNS_NONE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from Unknown (HELO moutng.kundenserver.de) (212.227.17.8)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 11 Jan 2013 08:33:10 +0000
Received: from [127.0.0.1] (dslb-088-073-034-096.pools.arcor-ip.net [88.73.34.96])	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)	id 0LobIQ-1TLtyu0bjW-00fqbw; Fri, 11 Jan 2013 09:33:02 +0100
Message-ID: <50EFCE3C.8030607@towo.net>
Date: Fri, 11 Jan 2013 08:33:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Console modes: cursor style
Content-Type: multipart/mixed; boundary="------------090004010903070005040003"
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
X-SW-Source: 2013-q1/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------090004010903070005040003
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 236

The attached patch adds two escape control sequences to the Cygwin Console:

  * Show/Hide Cursor (DECTCEM)
  * Set cursor style (DECSCUSR): block vs. underline cursor, or
    arbitrary size (as an extension, using values > 4)

Thomas


--------------090004010903070005040003
Content-Type: text/plain; charset=windows-1252;
 name="cursor.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cursor.changelog"
Content-length: 185

2013-01-13  Thomas Wolff  <towo@towo.net>

	* fhandler.h (class dev_console): Flag for expanded control sequence.
	* fhandler_console.cc (char_command): Supporting cursor style modes.


--------------090004010903070005040003
Content-Type: text/plain; charset=windows-1252;
 name="cursor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cursor.patch"
Content-length: 3167

diff -rup sav/fhandler.h ./fhandler.h
--- sav/fhandler.h	2012-10-13 14:34:17.000000000 +0200
+++ ./fhandler.h	2013-01-08 16:02:54.601269200 +0100
@@ -1246,6 +1246,7 @@ class dev_console
   unsigned rarg;
   bool saw_question_mark;
   bool saw_greater_than_sign;
+  bool saw_space;
   bool vt100_graphics_mode_G0;
   bool vt100_graphics_mode_G1;
   bool iso_2022_G1;
diff -rup sav/fhandler_console.cc ./fhandler_console.cc
--- sav/fhandler_console.cc	2012-08-17 17:57:30.000000000 +0200
+++ ./fhandler_console.cc	2013-01-08 16:50:05.467534000 +0100
@@ -1510,6 +1510,31 @@ fhandler_console::char_command (char c)
 	   }
        dev_state.set_color (get_output_handle ());
       break;
+    case 'q': /* Set cursor style (DECSCUSR) */
+      if (dev_state.saw_space)
+	{
+	    CONSOLE_CURSOR_INFO console_cursor_info;
+	    GetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+	    switch (dev_state.args_[0])
+	      {
+		case 0: /* blinking block */
+		case 1: /* blinking block (default) */
+		case 2: /* steady block */
+		  console_cursor_info.dwSize = 100;
+		  SetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+		  break;
+		case 3: /* blinking underline */
+		case 4: /* steady underline */
+		  console_cursor_info.dwSize = 10;	/* or Windows default 25? */
+		  SetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+		  break;
+		default: /* use value as percentage */
+		  console_cursor_info.dwSize = dev_state.args_[0];
+		  SetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+		  break;
+	      }
+	}
+      break;
     case 'h':
     case 'l':
       if (!dev_state.saw_question_mark)
@@ -1525,6 +1550,17 @@ fhandler_console::char_command (char c)
 	}
       switch (dev_state.args_[0])
 	{
+	case 25: /* Show/Hide Cursor (DECTCEM) */
+	  {
+	    CONSOLE_CURSOR_INFO console_cursor_info;
+	    GetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+	    if (c == 'h')
+	      console_cursor_info.bVisible = TRUE;
+	    else
+	      console_cursor_info.bVisible = FALSE;
+	    SetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+	    break;
+	  }
 	case 47:   /* Save/Restore screen */
 	  if (c == 'h') /* save */
 	    {
@@ -1752,7 +1788,7 @@ fhandler_console::char_command (char c)
 	  __small_sprintf (buf, "\033[%d;%dR", y + 1, x + 1);
 	  puts_readahead (buf);
 	  break;
-    default:
+      default:
 	  goto bad_escape;
 	}
       break;
@@ -2026,6 +2062,7 @@ fhandler_console::write (const void *vsr
 	      dev_state.state_ = gotsquare;
 	      dev_state.saw_question_mark = false;
 	      dev_state.saw_greater_than_sign = false;
+	      dev_state.saw_space = false;
 	      for (dev_state.nargs_ = 0; dev_state.nargs_ < MAXARGS; dev_state.nargs_++)
 		dev_state.args_[dev_state.nargs_] = 0;
 	      dev_state.nargs_ = 0;
@@ -2092,6 +2129,12 @@ fhandler_console::write (const void *vsr
 	      if (dev_state.nargs_ >= MAXARGS)
 		dev_state.nargs_--;
 	    }
+	  else if (*src == ' ')
+	    {
+	      src++;
+	      dev_state.saw_space = true;
+	      dev_state.state_ = gotcommand;
+	    }
 	  else
 	    {
 	      dev_state.state_ = gotcommand;

--------------090004010903070005040003--
