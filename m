Return-Path: <cygwin-patches-return-6874-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16106 invoked by alias); 17 Dec 2009 02:12:12 -0000
Received: (qmail 16096 invoked by uid 22791); 17 Dec 2009 02:12:10 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.186)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 17 Dec 2009 02:12:06 +0000
Received: from [127.0.0.1] (dslb-088-073-057-210.pools.arcor-ip.net [88.73.57.210]) 	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis) 	id 0LsMjU-1O0rhQ2qk4-0124Mp; Thu, 17 Dec 2009 03:12:03 +0100
Message-ID: <4B29934A.80902@towo.net>
Date: Thu, 17 Dec 2009 02:12:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net> <20091216145627.GM8059@calimero.vinschen.de>
In-Reply-To: <20091216145627.GM8059@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------080101030601090000070402"
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
X-SW-Source: 2009-q4/txt/msg00205.txt.bz2

This is a multi-part message in MIME format.
--------------080101030601090000070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 136

Hi,
here is my VT100 graphics mode patch, plus the one-liner I forgot to 
mention in the change log last time, I hope that's OK.
Thomas

--------------080101030601090000070402
Content-Type: text/plain;
 name="ChangeLog.add"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.add"
Content-length: 1227

2009-12-17  Thomas Wolff  <towo@towo.net>

	* fhandler_console.cc (write_console): Check for VT100 
	graphics mode and transform wide characters in ASCII small 
	letter range to corresponding graphics.
	(__vt100_conv): Table to transform small ASCII letters to line 
	drawing graphics for use in VT100 graphics mode.
	(write_normal): Check for SO/SI control characters to 
	enable/disable VT100 graphics mode.
	(base_chars): Enable SO/SI control characters for detection.
	(write): Check for ESC ( 0 / ESC ( B escape sequences to 
	enable/disable VT100 graphics mode. Also detect ">" while 
	parsing ESC [ sequences to distinguish specific requests.
	(char_command): Distinguish Secondary from Primary Device Attribute 
	request to report more details about cygwin console terminal version.
	* fhandler.h (vt100_graphics_mode_active): New flag to indicate mode.
	(saw_greater_than_sign): New parse flag for ESC [ > sequences.
	(gotparen, gotrparen): New state values to parse ESC ( / ) sequences.

2009-12-16  Thomas Wolff  <towo@towo.net>

	* fhandler_console.cc (read): Allow combined Alt-AltGr modifiers 
	to also produce an ESC prefix like a plain Alt modifier, e.g. to make 
	Alt-@ work on a keyboard where @ is AltGr-q.


--------------080101030601090000070402
Content-Type: text/plain;
 name="cygwin-console-vt100-graphics-altaltgr.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="cygwin-console-vt100-graphics-altaltgr.patch"
Content-length: 8273

? src/config.log
? src/i686-pc-cygwin
? src/serdep.tmp
? src/etc/Makefile
? src/etc/config.cache
? src/etc/config.log
? src/etc/config.status
? src/etc/configure.info
? src/etc/standards.info
? src/winsup/cygwin/@mined.mar
? src/winsup/cygwin/cygwin-console-mouse-enhancements.patch
? src/winsup/cygwin/orig
? src/winsup/cygwin/patched
Index: src/winsup/cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.385
diff -u -p -r1.385 fhandler.h
--- src/winsup/cygwin/fhandler.h	16 Dec 2009 14:56:10 -0000	1.385
+++ src/winsup/cygwin/fhandler.h	17 Dec 2009 01:47:10 -0000
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
 
Index: src/winsup/cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.209
diff -u -p -r1.209 fhandler_console.cc
--- src/winsup/cygwin/fhandler_console.cc	16 Dec 2009 14:56:10 -0000	1.209
+++ src/winsup/cygwin/fhandler_console.cc	17 Dec 2009 01:47:21 -0000
@@ -405,9 +405,12 @@ fhandler_console::read (void *pv, size_t
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
@@ -1113,9 +1116,53 @@ fhandler_console::cursor_get (int *x, in
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
@@ -1144,11 +1191,13 @@ bool fhandler_console::write_console (PW
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
@@ -1497,7 +1546,16 @@ fhandler_console::char_command (char c)
 	WriteFile (get_output_handle (), &dev_state->args_[0], 1, (DWORD *) &x, 0);
       break;
     case 'c':				/* u9 - Terminal enquire string */
-      strcpy (buf, "\033[?6c");
+      if (dev_state->saw_greater_than_sign)
+	/* Generate Secondary Device Attribute report, using 67 = ASCII 'C' 
+	   to indicate Cygwin (convention used by Rxvt, Urxvt, Screen, Mintty), 
+	   and cygwin version for terminal version. */
+	__small_sprintf (buf, "\033[>67;%d%02d;0c", CYGWIN_VERSION_DLL_MAJOR, CYGWIN_VERSION_DLL_MINOR);
+      else
+	strcpy (buf, "\033[?6c");
+      /* The generated report needs to be injected for read-ahead into the 
+         fhandler_console object associated with standard input.
+         The current call does not work. */
       puts_readahead (buf);
       break;
     case 'n':
@@ -1673,6 +1731,12 @@ fhandler_console::write_normal (const un
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
@@ -1763,45 +1827,54 @@ fhandler_console::write (const void *vsr
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
@@ -1875,12 +1948,31 @@ fhandler_console::write (const void *vsr
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
 

--------------080101030601090000070402--
