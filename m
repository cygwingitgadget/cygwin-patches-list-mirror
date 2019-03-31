Return-Path: <cygwin-patches-return-9290-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87232 invoked by alias); 31 Mar 2019 15:48:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86928 invoked by uid 89); 31 Mar 2019 15:48:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 15:48:29 +0000
Received: from localhost.localdomain (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x2VFm0UU009284;	Mon, 1 Apr 2019 00:48:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x2VFm0UU009284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1554047297;	bh=xSc7sHGWQjmgIAGK58PGafzljTmUPHvd3VLBJcHTTsg=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=cjOGiM+1D1lKzKhryf82pO9d5DcErju1EXShpc6x0CeigIVws7pS7TgWste0FeQcK	 j1wQNs7tAPZDPgocLGh1zur1k8EmkzkBdpjeRz7QkwjU0ncbftBQSBecjNmhITShal	 1Ix+9vob+Yv96I7FJTm8DxR3YCmr2xsQNmR3gi4gZRpQvMq+uS/IQPkBf57/Ky5dHf	 wBYctOcb+aQ7KvAH/fBrwFnl/bOB9B0H1Ykn5mkEPBY3QiG2hLzX7T0se4nIoxfpi3	 Q8sibHqGNKmb5ztFwV4QAGYeUKEwE6xTTwFDEADSfrZFm3m0WcLEdPhCiO8y8AXKIr	 wLkm0gWGuSw8Q==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 1/3] Cygwin: console: support 24 bit color
Date: Sun, 31 Mar 2019 15:49:00 -0000
Message-Id: <20190331154748.1957-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190331154748.1957-1-takashi.yano@nifty.ne.jp>
References: <20190331143651.GF3337@calimero.vinschen.de> <20190331154748.1957-1-takashi.yano@nifty.ne.jp>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00101.txt.bz2

- Add 24 bit color support using xterm compatibility mode in
  Windows 10 1703 or later.
- Add fake 24 bit color support for legacy console, which uses
  the nearest color from 16 system colors.
---
 winsup/cygwin/environ.cc          |   7 +-
 winsup/cygwin/fhandler.h          |   4 +
 winsup/cygwin/fhandler_console.cc | 230 +++++++++++++++++++++++++-----
 winsup/cygwin/select.cc           |   8 ++
 winsup/cygwin/wincap.cc           |  10 ++
 winsup/cygwin/wincap.h            |   2 +
 6 files changed, 227 insertions(+), 34 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 21f13734c..a47ed72e7 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -869,7 +869,8 @@ win32env_to_cygenv (PWCHAR rawenv, bool posify)
   char *newp;
   int i;
   int sawTERM = 0;
-  static char NO_COPY cygterm[] = "TERM=cygwin";
+  const char cygterm[] = "TERM=cygwin";
+  const char xterm[] = "TERM=xterm-256color";
   char *tmpbuf = tp.t_get ();
   PWCHAR w;
 
@@ -899,8 +900,10 @@ win32env_to_cygenv (PWCHAR rawenv, bool posify)
       debug_printf ("%p: %s", envp[i], envp[i]);
     }
 
+  /* If console has 24 bit color capability, TERM=xterm-256color,
+     otherwise, TERM=cygwin */
   if (!sawTERM)
-    envp[i++] = strdup (cygterm);
+    envp[i++] = strdup (wincap.has_con_24bit_colors () ? xterm : cygterm);
 
   envp[i] = NULL;
   return envp;
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index b336eb63a..66e724bcb 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1778,6 +1778,8 @@ enum ansi_intensity
 #define eattitle 7
 #define gotparen 8
 #define gotrparen 9
+#define eatpalette 10
+#define endpalette 11
 #define MAXARGS 10
 
 enum cltype
@@ -1791,6 +1793,8 @@ enum cltype
 
 class dev_console
 {
+  pid_t owner;
+
   WORD default_color, underline_color, dim_color;
 
   /* Used to determine if an input keystroke should be modified with META. */
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 281c2005c..6b14d4a25 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -15,6 +15,7 @@ details. */
 #include <sys/param.h>
 #include <sys/cygwin.h>
 #include <cygwin/kd.h>
+#include <unistd.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
@@ -32,6 +33,17 @@ details. */
 #include "child_info.h"
 #include "cygwait.h"
 
+/* Not yet defined in Mingw-w64 */
+#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
+#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
+#endif /* ENABLE_VIRTUAL_TERMINAL_PROCESSING */
+#ifndef DISABLE_NEWLINE_AUTO_RETURN
+#define DISABLE_NEWLINE_AUTO_RETURN 0x0008
+#endif /* DISABLE_NEWLINE_AUTO_RETURN */
+#ifndef ENABLE_VIRTUAL_TERMINAL_INPUT
+#define ENABLE_VIRTUAL_TERMINAL_INPUT 0x0200
+#endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
+
 /* Don't make this bigger than NT_MAX_PATH as long as the temporary buffer
    is allocated using tmp_pathbuf!!! */
 #define CONVERT_LIMIT NT_MAX_PATH
@@ -148,7 +160,11 @@ fhandler_console::set_unit ()
       if (created)
 	shared_console_info->tty_min_state.setntty (DEV_CONS_MAJOR, console_unit (me));
       devset = (fh_devices) shared_console_info->tty_min_state.getntty ();
+      if (created)
+	con.owner = getpid ();
     }
+  if (!created && shared_console_info && kill (con.owner, 0) == -1)
+    con.owner = getpid ();
 
   dev ().parse (devset);
   if (devset != FH_ERROR)
@@ -167,33 +183,33 @@ void
 fhandler_console::setup ()
 {
   if (set_unit ())
-      {
-	con.scroll_region.Bottom = -1;
-	con.dwLastCursorPosition.X = -1;
-	con.dwLastCursorPosition.Y = -1;
-	con.dwLastMousePosition.X = -1;
-	con.dwLastMousePosition.Y = -1;
-	con.dwLastButtonState = 0;	/* none pressed */
-	con.last_button_code = 3;	/* released */
-	con.underline_color = FOREGROUND_GREEN | FOREGROUND_BLUE;
-	con.dim_color = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE;
-	con.meta_mask = LEFT_ALT_PRESSED;
-	/* Set the mask that determines if an input keystroke is modified by
-	   META.  We set this based on the keyboard layout language loaded
-	   for the current thread.  The left <ALT> key always generates
-	   META, but the right <ALT> key only generates META if we are using
-	   an English keyboard because many "international" keyboards
-	   replace common shell symbols ('[', '{', etc.) with accented
-	   language-specific characters (umlaut, accent grave, etc.).  On
-	   these keyboards right <ALT> (called AltGr) is used to produce the
-	   shell symbols and should not be interpreted as META. */
-	if (PRIMARYLANGID (LOWORD (GetKeyboardLayout (0))) == LANG_ENGLISH)
-	  con.meta_mask |= RIGHT_ALT_PRESSED;
-	con.set_default_attr ();
-	con.backspace_keycode = CERASE;
-	con.cons_rapoi = NULL;
-	shared_console_info->tty_min_state.is_console = true;
-      }
+    {
+      con.scroll_region.Bottom = -1;
+      con.dwLastCursorPosition.X = -1;
+      con.dwLastCursorPosition.Y = -1;
+      con.dwLastMousePosition.X = -1;
+      con.dwLastMousePosition.Y = -1;
+      con.dwLastButtonState = 0;	/* none pressed */
+      con.last_button_code = 3;	/* released */
+      con.underline_color = FOREGROUND_GREEN | FOREGROUND_BLUE;
+      con.dim_color = FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE;
+      con.meta_mask = LEFT_ALT_PRESSED;
+      /* Set the mask that determines if an input keystroke is modified by
+	 META.  We set this based on the keyboard layout language loaded
+	 for the current thread.  The left <ALT> key always generates
+	 META, but the right <ALT> key only generates META if we are using
+	 an English keyboard because many "international" keyboards
+	 replace common shell symbols ('[', '{', etc.) with accented
+	 language-specific characters (umlaut, accent grave, etc.).  On
+	 these keyboards right <ALT> (called AltGr) is used to produce the
+	 shell symbols and should not be interpreted as META. */
+      if (PRIMARYLANGID (LOWORD (GetKeyboardLayout (0))) == LANG_ENGLISH)
+	con.meta_mask |= RIGHT_ALT_PRESSED;
+      con.set_default_attr ();
+      con.backspace_keycode = CERASE;
+      con.cons_rapoi = NULL;
+      shared_console_info->tty_min_state.is_console = true;
+    }
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -435,7 +451,8 @@ fhandler_console::read (void *pv, size_t& buflen)
 	      toadd = tmp;
 	    }
 	  /* Allow Ctrl-Space to emit ^@ */
-	  else if (input_rec.Event.KeyEvent.wVirtualKeyCode == VK_SPACE
+	  else if (input_rec.Event.KeyEvent.wVirtualKeyCode
+		   == (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
 		   && (ctrl_key_state & CTRL_PRESSED)
 		   && !(ctrl_key_state & ALT_PRESSED))
 	    toadd = "";
@@ -855,10 +872,24 @@ fhandler_console::open (int flags, mode_t)
   get_ttyp ()->rstcons (false);
   set_open_status ();
 
+  if (getpid () == con.owner && wincap.has_con_24bit_colors ())
+    {
+      DWORD dwMode;
+      /* Enable xterm compatible mode in output */
+      GetConsoleMode (get_output_handle (), &dwMode);
+      dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+      SetConsoleMode (get_output_handle (), dwMode);
+      /* Enable xterm compatible mode in input */
+      GetConsoleMode (get_handle (), &dwMode);
+      dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
+      SetConsoleMode (get_handle (), dwMode);
+    }
+
   DWORD cflags;
   if (GetConsoleMode (get_handle (), &cflags))
-    SetConsoleMode (get_handle (),
-		    ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT | cflags);
+    SetConsoleMode (get_handle (), ENABLE_WINDOW_INPUT
+		    | (wincap.has_con_24bit_colors () ? 0 : ENABLE_MOUSE_INPUT)
+		    | cflags);
 
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
@@ -878,6 +909,22 @@ fhandler_console::open_setup (int flags)
 int
 fhandler_console::close ()
 {
+  debug_printf ("closing: %p, %p", get_handle (), get_output_handle ());
+
+  if (shared_console_info && getpid () == con.owner &&
+      wincap.has_con_24bit_colors ())
+    {
+      DWORD dwMode;
+      /* Disable xterm compatible mode in input */
+      GetConsoleMode (get_handle (), &dwMode);
+      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
+      SetConsoleMode (get_handle (), dwMode);
+      /* Disable xterm compatible mode in output */
+      GetConsoleMode (get_output_handle (), &dwMode);
+      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+      SetConsoleMode (get_output_handle (), dwMode);
+    }
+
   CloseHandle (get_handle ());
   CloseHandle (get_output_handle ());
   if (!have_execed)
@@ -987,6 +1034,13 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   /* All the output bits we can ignore */
 
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
+  /* If system has 24 bit color capability, use xterm compatible mode. */
+  if (wincap.has_con_24bit_colors ())
+    {
+      flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+      if (!(t->c_oflag & OPOST) || !(t->c_oflag & ONLCR))
+	flags |= DISABLE_NEWLINE_AUTO_RETURN;
+    }
 
   int res = SetConsoleMode (get_output_handle (), flags) ? 0 : -1;
   if (res)
@@ -1043,7 +1097,11 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
       flags |= ENABLE_PROCESSED_INPUT;
     }
 
-  flags |= ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT;
+  flags |= ENABLE_WINDOW_INPUT |
+    (wincap.has_con_24bit_colors () ? 0 : ENABLE_MOUSE_INPUT);
+  /* if system has 24 bit color capability, use xterm compatible mode. */
+  if (wincap.has_con_24bit_colors ())
+    flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
 
   int res;
   if (flags == oflags)
@@ -1602,11 +1660,32 @@ static const char base_chars[256] =
 /*F0 F1 F2 F3 F4 F5 F6 F7 */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,
 /*F8 F9 FA FB FC FD FE FF */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR };
 
+static const char table256[256] =
+{
+   0, 4, 2, 6, 1, 5, 3, 7, 8,12,10,14, 9,13,11,15,
+   0, 1, 1, 1, 9, 9, 2, 3, 3, 3, 3, 9, 2, 3, 3, 3,
+   3,11, 2, 3, 3, 3,11,11,10, 3, 3,11,11,11,10,10,
+  11,11,11,11, 4, 5, 5, 5, 5, 9, 6, 8, 8, 8, 8, 9,
+   6, 8, 8, 8, 8, 7, 6, 8, 8, 8, 7, 7, 6, 8, 8, 7,
+   7,11,10,10, 7, 7,11,11, 4, 5, 5, 5, 5,13, 6, 8,
+   8, 8, 8, 7, 6, 8, 8, 8, 7, 7, 6, 8, 8, 7, 7, 7,
+   6, 8, 7, 7, 7, 7,14, 7, 7, 7, 7, 7, 4, 5, 5, 5,
+  13,13, 6, 8, 8, 8, 7, 7, 6, 8, 8, 7, 7, 7, 6, 8,
+   7, 7, 7, 7,14, 7, 7, 7, 7, 7,14, 7, 7, 7, 7,15,
+  12, 5, 5,13,13,13, 6, 8, 8, 7, 7,13, 6, 8, 7, 7,
+   7, 7,14, 7, 7, 7, 7, 7,14, 7, 7, 7, 7,15,14,14,
+   7, 7,15,15,12,12,13,13,13,13,12,12, 7, 7,13,13,
+  14, 7, 7, 7, 7, 7,14, 7, 7, 7, 7,15,14,14, 7, 7,
+  15,15,14,14, 7,15,15,15, 0, 0, 0, 0, 0, 0, 8, 8,
+   8, 8, 8, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 7,15,15
+};
+
 void
 fhandler_console::char_command (char c)
 {
   int x, y, n;
   char buf[40];
+  int r, g, b;
 
   switch (c)
     {
@@ -1678,6 +1757,40 @@ fhandler_console::char_command (char c)
 	     case 37:		/* WHITE foreg */
 	       con.fg = FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED;
 	       break;
+	     case 38:
+	       if (con.nargs < 1)
+		 /* Sequence error (abort) */
+		 break;
+	       switch (con.args[1])
+		 {
+		 case 2:
+		   if (con.nargs != 4)
+		     /* Sequence error (abort) */
+		     break;
+		   r = con.args[2];
+		   g = con.args[3];
+		   b = con.args[4];
+		   r = r < (95 + 1) / 2 ? 0 : r > 255 ? 5 : (r - 55 + 20) / 40;
+		   g = g < (95 + 1) / 2 ? 0 : g > 255 ? 5 : (g - 55 + 20) / 40;
+		   b = b < (95 + 1) / 2 ? 0 : b > 255 ? 5 : (b - 55 + 20) / 40;
+		   con.fg = table256[16 + r*36 + g*6 + b];
+		   break;
+		 case 5:
+		   if (con.nargs != 2)
+		     /* Sequence error (abort) */
+		     break;
+		   {
+		     int idx = con.args[2];
+		     if (idx < 0)
+		       idx = 0;
+		     if (idx > 255)
+		       idx = 255;
+		     con.fg = table256[idx];
+		   }
+		   break;
+		 }
+	       i += con.nargs;
+	       break;
 	     case 39:
 	       con.fg = con.default_color & FOREGROUND_ATTR_MASK;
 	       break;
@@ -1705,6 +1818,40 @@ fhandler_console::char_command (char c)
 	     case 47:    /* WHITE background */
 	       con.bg = BACKGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_RED;
 	       break;
+	     case 48:
+	       if (con.nargs < 1)
+		 /* Sequence error (abort) */
+		 break;
+	       switch (con.args[1])
+		 {
+		 case 2:
+		   if (con.nargs != 4)
+		     /* Sequence error (abort) */
+		     break;
+		   r = con.args[2];
+		   g = con.args[3];
+		   b = con.args[4];
+		   r = r < (95 + 1) / 2 ? 0 : r > 255 ? 5 : (r - 55 + 20) / 40;
+		   g = g < (95 + 1) / 2 ? 0 : g > 255 ? 5 : (g - 55 + 20) / 40;
+		   b = b < (95 + 1) / 2 ? 0 : b > 255 ? 5 : (b - 55 + 20) / 40;
+		   con.bg = table256[16 + r*36 + g*6 + b] << 4;
+		   break;
+		 case 5:
+		   if (con.nargs != 2)
+		     /* Sequence error (abort) */
+		     break;
+		   {
+		     int idx = con.args[2];
+		     if (idx < 0)
+		       idx = 0;
+		     if (idx > 255)
+		       idx = 255;
+		     con.bg = table256[idx] << 4;
+		   }
+		   break;
+		 }
+	       i += con.nargs;
+	       break;
 	     case 49:
 	       con.bg = con.default_color & BACKGROUND_ATTR_MASK;
 	       break;
@@ -2143,10 +2290,12 @@ fhandler_console::write_normal (const unsigned char *src,
   /* Loop over src buffer as long as we have just simple characters.  Stop
      as soon as we reach the conversion limit, or if we encounter a control
      character or a truncated or invalid mutibyte sequence. */
+  /* If system has 24 bit color capability, just write all control
+     sequences to console since xterm compatible mode is enabled. */
   memset (&ps, 0, sizeof ps);
   while (found < end
 	 && found - src < CONVERT_LIMIT
-	 && base_chars[*found] == NOR)
+	 && (wincap.has_con_24bit_colors () || base_chars[*found] == NOR) )
     {
       switch (ret = f_mbtowc (_REENT, NULL, (const char *) found,
 			       end - found, &ps))
@@ -2394,6 +2543,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    con.rarg = con.rarg * 10 + (*src - '0');
 	  else if (*src == ';' && (con.rarg == 2 || con.rarg == 0))
 	    con.state = gettitle;
+	  else if (*src == ';' && (con.rarg == 4 || con.rarg == 104))
+	    con.state = eatpalette;
 	  else
 	    con.state = eattitle;
 	  src++;
@@ -2416,6 +2567,21 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    src++;
 	    break;
 	  }
+	case eatpalette:
+	  if (*src == '\033')
+	    con.state = endpalette;
+	  else if (*src == '\a')
+	    con.state = normal;
+	  src++;
+	  break;
+	case endpalette:
+	  if (*src == '\\')
+	    con.state = normal;
+	  else
+	    /* Sequence error (abort) */
+	    con.state = normal;
+	  src++;
+	  break;
 	case gotsquare:
 	  if (*src == ';')
 	    {
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 9b18e8f80..28adcf3e7 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1053,6 +1053,14 @@ peek_console (select_record *me, bool)
 		else if (irec.Event.KeyEvent.uChar.UnicodeChar
 			 || fhandler_console::get_nonascii_key (irec, tmpbuf))
 		  return me->read_ready = true;
+		/* Allow Ctrl-Space for ^@ */
+		else if ( (irec.Event.KeyEvent.wVirtualKeyCode == VK_SPACE
+			   || irec.Event.KeyEvent.wVirtualKeyCode == '2')
+			 && (irec.Event.KeyEvent.dwControlKeyState &
+			     (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED))
+			 && !(irec.Event.KeyEvent.dwControlKeyState
+			      & (LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED)) )
+		  return me->read_ready = true;
 	      }
 	    /* Ignore key up events, except for Alt+Numpad events. */
 	    else if (is_alt_numpad_event (&irec))
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 5bc9c3778..86dc631ec 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -40,6 +40,7 @@ wincaps wincap_vista __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:true,
+    has_con_24bit_colors:false,
   },
 };
 
@@ -65,6 +66,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:true,
+    has_con_24bit_colors:false,
   },
 };
 
@@ -90,6 +92,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:false,
   },
 };
 
@@ -115,6 +118,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:false,
   },
 };
 
@@ -140,6 +144,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:false,
   },
 };
 
@@ -165,6 +170,7 @@ wincaps wincap_10_1511 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:false,
   },
 };
 
@@ -190,6 +196,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:true,
   },
 };
 
@@ -215,6 +222,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:true,
   },
 };
 
@@ -240,6 +248,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_case_sensitive_dirs:true,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:true,
   },
 };
 
@@ -265,6 +274,7 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_case_sensitive_dirs:true,
     has_posix_rename_semantics:true,
     no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:true,
   },
 };
 
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index 0e83f6794..73b6f5ffc 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -34,6 +34,7 @@ struct wincaps
     unsigned has_case_sensitive_dirs		: 1;
     unsigned has_posix_rename_semantics		: 1;
     unsigned no_msv1_0_s4u_logon_in_wow64	: 1;
+    unsigned has_con_24bit_colors		: 1;
   };
 };
 
@@ -89,6 +90,7 @@ public:
   bool	IMPLEMENT (has_case_sensitive_dirs)
   bool	IMPLEMENT (has_posix_rename_semantics)
   bool	IMPLEMENT (no_msv1_0_s4u_logon_in_wow64)
+  bool	IMPLEMENT (has_con_24bit_colors)
 
   void disable_case_sensitive_dirs ()
   {
-- 
2.17.0
