Return-Path: <cygwin-patches-return-7698-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17199 invoked by alias); 16 Aug 2012 06:33:45 -0000
Received: (qmail 17174 invoked by uid 22791); 16 Aug 2012 06:33:44 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SARE_SUB_NEED_REPLY,SPF_HELO_PASS,TW_CP
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.186)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 16 Aug 2012 06:33:30 +0000
Received: from [127.0.0.1] (dslb-088-073-028-074.pools.arcor-ip.net [88.73.28.74])	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)	id 0LmjjU-1Tc2o009xk-00h2A1; Thu, 16 Aug 2012 08:33:28 +0200
Message-ID: <502C942E.8080309@towo.net>
Date: Thu, 16 Aug 2012 06:33:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: console: terminal request/response
Content-Type: multipart/mixed; boundary="------------080609050909010706090307"
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
X-SW-Source: 2012-q3/txt/msg00019.txt.bz2

This is a multi-part message in MIME format.
--------------080609050909010706090307
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 570

This is another patch to enable terminal responses in the cygwin console.
Typically, terminals respond to requests to report Primary/Secondary 
Device Attributes
and to send a Cursor Position Report (see 
http://invisible-island.net/xterm/ctlseqs/ctlseqs.txt).
(This hasn't ever worked in the cygwin console except with obsolete 
setting CYGWIN=tty.)

My attached patch should now fix this. I know it's not really 
significant anymore
(http://cygwin.com/ml/cygwin-patches/2012-q2/msg00002.html) but I 
couldn't resist
to rework and fix my previous fix attempts.

Thomas

--------------080609050909010706090307
Content-Type: text/plain; charset=windows-1252;
 name="terminal-requests.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="terminal-requests.patch"
Content-length: 3943

diff -rup sav/fhandler.h ./fhandler.h
--- sav/fhandler.h	2012-08-03 17:39:21.000000000 +0200
+++ ./fhandler.h	2012-08-15 16:57:09.152522000 +0200
@@ -1294,6 +1294,8 @@ class dev_console
   bool ext_mouse_mode15;
   bool use_focus;
   bool raw_win32_keyboard_mode;
+  char cons_rabuf[40];
+  char * cons_rapoi;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
@@ -1384,6 +1386,7 @@ private:
   int init (HANDLE, DWORD, mode_t);
   bool mouse_aware (MOUSE_EVENT_RECORD& mouse_event);
   bool focus_aware () {return shared_console_info->dev_state.use_focus;}
+  bool get_cons_readahead_valid () { return shared_console_info->dev_state.cons_rapoi != 0; }
 
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
diff -rup sav/fhandler_console.cc ./fhandler_console.cc
--- sav/fhandler_console.cc	2012-07-30 05:44:59.000000000 +0200
+++ ./fhandler_console.cc	2012-08-15 18:44:27.603635900 +0200
@@ -95,6 +95,7 @@ fhandler_console::open_shared_console (H
   create = m != SH_JUSTOPEN;
   return res;
 }
+
 class console_unit
 {
   int n;
@@ -142,6 +143,7 @@ fhandler_console::set_unit ()
   HWND me;
   fh_devices this_unit = dev ();
   bool generic_console = this_unit == FH_CONIN || this_unit == FH_CONOUT;
+
   if (shared_console_info)
     {
       fh_devices shared_unit =
@@ -183,7 +185,6 @@ fhandler_console::setup ()
 {
   if (set_unit ())
       {
-
 	dev_state.scroll_region.Bottom = -1;
 	dev_state.dwLastCursorPosition.X = -1;
 	dev_state.dwLastCursorPosition.Y = -1;
@@ -207,6 +208,7 @@ fhandler_console::setup ()
 	  dev_state.meta_mask |= RIGHT_ALT_PRESSED;
 	dev_state.set_default_attr ();
 	dev_state.backspace_keycode = CERASE;
+	dev_state.cons_rapoi = 0;
 	shared_console_info->tty_min_state.is_console = true;
       }
 }
@@ -330,6 +332,14 @@ fhandler_console::read (void *pv, size_t
   int ch;
   set_input_state ();
 
+  /* Check console read-ahead buffer filled from terminal requests */
+  if (dev_state.cons_rapoi && * dev_state.cons_rapoi)
+    {
+      * buf = * dev_state.cons_rapoi ++;
+      buflen = 1;
+      return;
+    }
+
   int copied_chars = get_readahead_into_buffer (buf, buflen);
 
   if (copied_chars)
@@ -726,6 +736,7 @@ fhandler_console::read (void *pv, size_t
 	buf[copied_chars++] = (unsigned char)(ch & 0xff);
 	buflen--;
       }
+
 #undef buf
 
   buflen = copied_chars;
@@ -1739,8 +1750,12 @@ fhandler_console::char_command (char c)
 	strcpy (buf, "\033[?6c");
       /* The generated report needs to be injected for read-ahead into the
 	 fhandler_console object associated with standard input.
-	 The current call does not work. */
-      puts_readahead (buf);
+	 So puts_readahead does not work. */
+      /*puts_readahead (buf);*/
+      /* Use a common console read-ahead buffer instead. */
+      dev_state.cons_rapoi = 0;
+      strcpy (dev_state.cons_rabuf, buf);
+      dev_state.cons_rapoi = dev_state.cons_rabuf;
       break;
     case 'n':
       switch (dev_state.args_[0])
@@ -1750,9 +1765,12 @@ fhandler_console::char_command (char c)
 	  y -= dev_state.info.winTop;
 	  /* x -= dev_state.info.winLeft;		// not available yet */
 	  __small_sprintf (buf, "\033[%d;%dR", y + 1, x + 1);
-	  puts_readahead (buf);
+	  /*puts_readahead (buf);*/
+	  dev_state.cons_rapoi = 0;
+	  strcpy (dev_state.cons_rabuf, buf);
+	  dev_state.cons_rapoi = dev_state.cons_rabuf;
 	  break;
-    default:
+	default:
 	  goto bad_escape;
 	}
       break;
diff -rup sav/select.cc ./select.cc
--- sav/select.cc	2012-07-24 16:03:54.000000000 +0200
+++ ./select.cc	2012-08-15 18:38:32.119260900 +0200
@@ -818,6 +818,11 @@ peek_console (select_record *me, bool)
   if (!me->read_selected)
     return me->write_ready;
 
+  if (fh->get_cons_readahead_valid ())
+    {
+      select_printf ("cons_readahead");
+      return me->read_ready = true;
+    }
   if (fh->get_readahead_valid ())
     {
       select_printf ("readahead");

--------------080609050909010706090307
Content-Type: text/plain; charset=windows-1252;
 name="terminal-requests.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="terminal-requests.changelog"
Content-length: 580

2012-08-15  Thomas Wolff  <towo@towo.net>

	* fhandler.h (class dev_console): Add console read-ahead buffer.
	(class fhandler_console): Add peek function for it (for select).
	* fhandler_console.cc (fhandler_console::setup): Init buffer.
	(fhandler_console::read): Check console read-aheader buffer.
	(fhandler_console::char_command): Put responses to terminal 
	requests (device status and cursor position reports) into 
	common console buffer (shared between CONOUT/CONIN) 
	instead of fhandler buffer (separated).
	* select.cc (peek_console): Check console read-ahead buffer.


--------------080609050909010706090307--
