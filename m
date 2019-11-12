Return-Path: <cygwin-patches-return-9835-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91747 invoked by alias); 12 Nov 2019 18:05:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91738 invoked by uid 89); 12 Nov 2019 18:05:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Revise, cygwin-patches, cygwinpatches, revise
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 18:05:21 +0000
Received: from localhost.localdomain (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conuserg-01.nifty.com with ESMTP id xACI500f020420;	Wed, 13 Nov 2019 03:05:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com xACI500f020420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573581906;	bh=FZKQwHBbc1oaOQNOOVS+puPTt5I4uKc3zO7lpy5lL9g=;	h=From:To:Cc:Subject:Date:From;	b=g4j7hzpWcE1izocrfiE/EylAGQIn5qTPFiVX8psNSx4+rdLto2HK6LuDLMtKA+bVY	 +n82VZeOTQj9fDIYZ5EK7Q3S+4KTYh6MhOP44jmMHbTSUBq35d/nfUGlxkhjwzexgU	 Da1ZM0gGyqc8gk/G47FvgU56C5lILvpP7iI5MyCoJUo658Q1FATlKPS7E6FjGL7Z1d	 U6KYu9Lhs4A13l6/mu1ZdPvOnLR2qMT5w5+A4auiBepLRAggk7BtBTMt2b5HGvYAVh	 cz7GiV/QkFSMqwhI7c8An33BVeR+9NH0FAb3evxDxMUNMZWEcEXrLLlPRm4aH9DJel	 tHjpMgD0Fq2nw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Revise the code checking if the console is legacy.
Date: Tue, 12 Nov 2019 18:05:00 -0000
Message-Id: <20191112180459.1786-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00106.txt.bz2

- Accessing shared_console_info before initializing causes access
  violation in checking if the console is legacy mode. This patch
  fixes this issue. This solves the problem reported in:
  https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00099.html
---
 winsup/cygwin/fhandler_console.cc | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index d875ad65c..0b1c82fb9 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -56,6 +56,7 @@ details. */
 #define srBottom ((con.scroll_region.Bottom < 0) ? \
 		  con.b.srWindow.Bottom : \
 		  con.b.srWindow.Top + con.scroll_region.Bottom)
+#define con_is_legacy (shared_console_info && con.is_legacy)
 
 const unsigned fhandler_console::MAX_WRITE_CHARS = 16384;
 
@@ -309,7 +310,7 @@ fhandler_console::set_cursor_maybe ()
 {
   con.fillin (get_output_handle ());
   /* Nothing to do for xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con.is_legacy)
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
     return;
   if (con.dwLastCursorPosition.X != con.b.dwCursorPosition.X ||
       con.dwLastCursorPosition.Y != con.b.dwCursorPosition.Y)
@@ -349,7 +350,7 @@ fhandler_console::send_winch_maybe ()
     {
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
-      if (wincap.has_con_24bit_colors () && !con.is_legacy)
+      if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	fix_tab_position (get_output_handle (), con.dwWinSize.X);
       get_ttyp ()->kill_pgrp (SIGWINCH);
       return true;
@@ -483,7 +484,7 @@ sig_exit:
 fhandler_console::input_states
 fhandler_console::process_input_message (void)
 {
-  if (wincap.has_con_24bit_colors () && !con.is_legacy)
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       DWORD dwMode;
       /* Enable xterm compatible mode in input */
@@ -589,7 +590,7 @@ fhandler_console::process_input_message (void)
 	    }
 	  /* Allow Ctrl-Space to emit ^@ */
 	  else if (input_rec[i].Event.KeyEvent.wVirtualKeyCode
-		   == ((wincap.has_con_24bit_colors () && !con.is_legacy) ?
+		   == ((wincap.has_con_24bit_colors () && !con_is_legacy) ?
 		       '2' : VK_SPACE)
 		   && (ctrl_key_state & CTRL_PRESSED)
 		   && !(ctrl_key_state & ALT_PRESSED))
@@ -1029,7 +1030,7 @@ fhandler_console::open (int flags, mode_t)
       else
 	con.is_legacy = false;
       /* Enable xterm compatible mode in input */
-      if (!con.is_legacy)
+      if (!con_is_legacy)
 	{
 	  GetConsoleMode (get_handle (), &dwMode);
 	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
@@ -1037,14 +1038,14 @@ fhandler_console::open (int flags, mode_t)
 	    con.is_legacy = true;
 	}
       extern int sawTERM;
-      if (con.is_legacy && !sawTERM)
+      if (con_is_legacy && !sawTERM)
 	setenv ("TERM", "cygwin", 1);
     }
 
   DWORD cflags;
   if (GetConsoleMode (get_handle (), &cflags))
     SetConsoleMode (get_handle (), ENABLE_WINDOW_INPUT
-		    | ((wincap.has_con_24bit_colors () && !con.is_legacy) ?
+		    | ((wincap.has_con_24bit_colors () && !con_is_legacy) ?
 		       0 : ENABLE_MOUSE_INPUT)
 		    | cflags);
 
@@ -1074,7 +1075,7 @@ fhandler_console::close ()
   output_mutex = NULL;
 
   if (shared_console_info && getpid () == con.owner &&
-      wincap.has_con_24bit_colors () && !con.is_legacy)
+      wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       DWORD dwMode;
       /* Disable xterm compatible mode in input */
@@ -1221,7 +1222,7 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   acquire_output_mutex (INFINITE);
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
   /* If system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con.is_legacy)
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
       if (!(t->c_oflag & OPOST) || !(t->c_oflag & ONLCR))
@@ -1286,10 +1287,10 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
     }
 
   flags |= ENABLE_WINDOW_INPUT |
-    ((wincap.has_con_24bit_colors () && !con.is_legacy) ?
+    ((wincap.has_con_24bit_colors () && !con_is_legacy) ?
      0 : ENABLE_MOUSE_INPUT);
   /* if system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con.is_legacy)
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
     flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
 
   int res;
@@ -1663,7 +1664,7 @@ bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
   bool need_fix_tab_position = false;
   /* Check if screen will be alternated. */
-  if (wincap.has_con_24bit_colors () && !con.is_legacy
+  if (wincap.has_con_24bit_colors () && !con_is_legacy
       && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR)))
     need_fix_tab_position = true;
 
@@ -2511,7 +2512,7 @@ fhandler_console::write_normal (const unsigned char *src,
   memset (&ps, 0, sizeof ps);
   while (found < end
 	 && found - src < CONVERT_LIMIT
-	 && ((wincap.has_con_24bit_colors () && !con.is_legacy)
+	 && ((wincap.has_con_24bit_colors () && !con_is_legacy)
 	     || base_chars[*found] == NOR) )
     {
       switch (ret = f_mbtowc (_REENT, NULL, (const char *) found,
@@ -2972,7 +2973,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
-  if (wincap.has_con_24bit_colors () && !con.is_legacy)
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       DWORD dwMode;
       /* Disable xterm compatible mode in input */
-- 
2.21.0
