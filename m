Return-Path: <cygwin-patches-return-9801-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110518 invoked by alias); 6 Nov 2019 11:59:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110507 invoked by uid 89); 6 Nov 2019 11:59:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, 5898, UD:X, pty
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 11:59:17 +0000
Received: from localhost.localdomain (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conuserg-05.nifty.com with ESMTP id xA6Bx6GZ016087;	Wed, 6 Nov 2019 20:59:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com xA6Bx6GZ016087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573041551;	bh=8t2tydRd3Go+BL0ByzAsGykFP7tU+kUINgeTy5uJ2hs=;	h=From:To:Cc:Subject:Date:From;	b=tYflkreQl2kYeL3Jh5Hu6bs0OqQFqcb2FiaMtcoHbiyHxiAFSWayai95wVhEw96Ah	 asUJNc5Er9HV7Ey6XclXDKs0KtlUnKSzMPMiHZULrSo7AV5orpuLfOVcDxp0ENv726	 ffrbyH3xDVsJrwu89U4E2mqCWDGA67ay1KLbbnoODHri4uNNohG9JXLXsUXYB0msgR	 lUeoID3K/58+xAX4fCeffbSkgsUbeYoLIORiEdOM3rnCPe1N3TTscg/eIS+vxTlYDh	 aHLwvITUHQVVnG0E0+3O9GG6UzgoBHLAlp9AwGDPoSygTQt2qMsJApGDqUgKBKG10q	 7N7f/oVawbBlA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console, pty: Prevent error in legacy console mode.
Date: Wed, 06 Nov 2019 11:59:00 -0000
Message-Id: <20191106115909.429-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00072.txt.bz2

---
 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 45 ++++++++++++++++++++-----------
 winsup/cygwin/fhandler_tty.cc     | 13 +++++++++
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index d5aa57300..313172ec5 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1831,6 +1831,7 @@ enum cltype
 class dev_console
 {
   pid_t owner;
+  bool is_legacy;
 
   WORD default_color, underline_color, dim_color;
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 241759203..79fa00bdb 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -309,7 +309,7 @@ fhandler_console::set_cursor_maybe ()
 {
   con.fillin (get_output_handle ());
   /* Nothing to do for xterm compatible mode. */
-  if (wincap.has_con_24bit_colors ())
+  if (wincap.has_con_24bit_colors () && !con.is_legacy)
     return;
   if (con.dwLastCursorPosition.X != con.b.dwCursorPosition.X ||
       con.dwLastCursorPosition.Y != con.b.dwCursorPosition.Y)
@@ -349,7 +349,7 @@ fhandler_console::send_winch_maybe ()
     {
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
-      if (wincap.has_con_24bit_colors ())
+      if (wincap.has_con_24bit_colors () && !con.is_legacy)
 	fix_tab_position (get_output_handle (), con.dwWinSize.X);
       get_ttyp ()->kill_pgrp (SIGWINCH);
       return true;
@@ -483,7 +483,7 @@ sig_exit:
 fhandler_console::input_states
 fhandler_console::process_input_message (void)
 {
-  if (wincap.has_con_24bit_colors ())
+  if (wincap.has_con_24bit_colors () && !con.is_legacy)
     {
       DWORD dwMode;
       /* Enable xterm compatible mode in input */
@@ -589,7 +589,8 @@ fhandler_console::process_input_message (void)
 	    }
 	  /* Allow Ctrl-Space to emit ^@ */
 	  else if (input_rec[i].Event.KeyEvent.wVirtualKeyCode
-		   == (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
+		   == ((wincap.has_con_24bit_colors () && !con.is_legacy) ?
+		       '2' : VK_SPACE)
 		   && (ctrl_key_state & CTRL_PRESSED)
 		   && !(ctrl_key_state & ALT_PRESSED))
 	    toadd = "";
@@ -1023,17 +1024,27 @@ fhandler_console::open (int flags, mode_t)
       /* Enable xterm compatible mode in output */
       GetConsoleMode (get_output_handle (), &dwMode);
       dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-      SetConsoleMode (get_output_handle (), dwMode);
+      if (!SetConsoleMode (get_output_handle (), dwMode))
+	con.is_legacy = true;
+      else
+	con.is_legacy = false;
       /* Enable xterm compatible mode in input */
-      GetConsoleMode (get_handle (), &dwMode);
-      dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-      SetConsoleMode (get_handle (), dwMode);
+      if (!con.is_legacy)
+	{
+	  GetConsoleMode (get_handle (), &dwMode);
+	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
+	  if (!SetConsoleMode (get_handle (), dwMode))
+	    con.is_legacy = true;
+	}
+      if (con.is_legacy)
+	setenv ("TERM", "cygwin", 1);
     }
 
   DWORD cflags;
   if (GetConsoleMode (get_handle (), &cflags))
     SetConsoleMode (get_handle (), ENABLE_WINDOW_INPUT
-		    | (wincap.has_con_24bit_colors () ? 0 : ENABLE_MOUSE_INPUT)
+		    | ((wincap.has_con_24bit_colors () && !con.is_legacy) ?
+		       0 : ENABLE_MOUSE_INPUT)
 		    | cflags);
 
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
@@ -1062,7 +1073,7 @@ fhandler_console::close ()
   output_mutex = NULL;
 
   if (shared_console_info && getpid () == con.owner &&
-      wincap.has_con_24bit_colors ())
+      wincap.has_con_24bit_colors () && !con.is_legacy)
     {
       DWORD dwMode;
       /* Disable xterm compatible mode in input */
@@ -1209,7 +1220,7 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   acquire_output_mutex (INFINITE);
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
   /* If system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors ())
+  if (wincap.has_con_24bit_colors () && !con.is_legacy)
     {
       flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
       if (!(t->c_oflag & OPOST) || !(t->c_oflag & ONLCR))
@@ -1274,9 +1285,10 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
     }
 
   flags |= ENABLE_WINDOW_INPUT |
-    (wincap.has_con_24bit_colors () ? 0 : ENABLE_MOUSE_INPUT);
+    ((wincap.has_con_24bit_colors () && !con.is_legacy) ?
+     0 : ENABLE_MOUSE_INPUT);
   /* if system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors ())
+  if (wincap.has_con_24bit_colors () && !con.is_legacy)
     flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
 
   int res;
@@ -1650,7 +1662,7 @@ bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
   bool need_fix_tab_position = false;
   /* Check if screen will be alternated. */
-  if (wincap.has_con_24bit_colors ()
+  if (wincap.has_con_24bit_colors () && !con.is_legacy
       && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR)))
     need_fix_tab_position = true;
 
@@ -2498,7 +2510,8 @@ fhandler_console::write_normal (const unsigned char *src,
   memset (&ps, 0, sizeof ps);
   while (found < end
 	 && found - src < CONVERT_LIMIT
-	 && (wincap.has_con_24bit_colors () || base_chars[*found] == NOR) )
+	 && ((wincap.has_con_24bit_colors () && !con.is_legacy)
+	     || base_chars[*found] == NOR) )
     {
       switch (ret = f_mbtowc (_REENT, NULL, (const char *) found,
 			       end - found, &ps))
@@ -2958,7 +2971,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
-  if (wincap.has_con_24bit_colors ())
+  if (wincap.has_con_24bit_colors () && !con.is_legacy)
     {
       DWORD dwMode;
       /* Disable xterm compatible mode in input */
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index da6119dfb..f87ac73f2 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -26,6 +26,7 @@ details. */
 #include <asm/socket.h>
 #include "cygwait.h"
 #include "tls_pbuf.h"
+#include "registry.h"
 
 #define ALWAYS_USE_PCON false
 #define USE_API_HOOK true
@@ -3121,6 +3122,8 @@ fhandler_pty_master::setup_pseudoconsole ()
      process in a pseudo console and get them from the helper.
      Slave process will attach to the pseudo console in the
      helper process using AttachConsole(). */
+  bool error = false;
+
   COORD size = {80, 25};
   CreatePipe (&from_master, &to_slave, &sec_none, 0);
   SetLastError (ERROR_SUCCESS);
@@ -3131,6 +3134,16 @@ fhandler_pty_master::setup_pseudoconsole ()
       if (res != S_OK)
 	system_printf ("CreatePseudoConsole() failed. %08x\n",
 		       GetLastError ());
+      error = true;
+    }
+
+  reg_key reg (HKEY_CURRENT_USER, KEY_READ, L"Console", NULL);
+  if (reg.error ())
+    error = true;
+  if (reg.get_dword (L"ForceV2", 1) == 0)
+    error = true;
+  if (error)
+    {
       CloseHandle (from_master);
       CloseHandle (to_slave);
       from_master = from_master_cyg;
-- 
2.21.0
