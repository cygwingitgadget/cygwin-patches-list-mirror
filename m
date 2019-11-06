Return-Path: <cygwin-patches-return-9809-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90642 invoked by alias); 6 Nov 2019 16:30:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90144 invoked by uid 89); 6 Nov 2019 16:30:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 16:30:25 +0000
Received: from localhost.localdomain (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conuserg-06.nifty.com with ESMTP id xA6GTb7H003680;	Thu, 7 Nov 2019 01:29:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com xA6GTb7H003680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573057784;	bh=gE6/S+VAWvUJuG8CoZ+YMGfLM+Ir5723mQz4+Wb/V7Y=;	h=From:To:Cc:Subject:Date:From;	b=ZO4qMvt6yDn2quIZybp9G5j/QRTflU+p2bo7s3f/89SZNk49+7Mc2cFf8hyvNX5go	 cbllmggvag98K6trrI62UGzTB8/6QydZ0HAjIaxFPz8X5nkq2xUYF/M3md44XWnjU0	 nixONMY7KbuwDW/d7Ynz/W/k3udIr5A7gU6DnQ8krWt0Ob2dgCnKBoBL2vb+WazNZ7	 IZlQ3K2tSjhv3SZ2voJJE3FITz1SaOP5NEvjZz4N4Lx4YfUo7tNUiV6Ot7MfyBFiF3	 XVMv3hMZPvne6bVAujeMnsnYeOvjfvLzlyivM1Eg+3Vqp9qMxgqyaRfLVV5vx5F41T	 TOXnBHucbZJeA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3] Cygwin: console, pty: Prevent error in legacy console mode.
Date: Wed, 06 Nov 2019 16:30:00 -0000
Message-Id: <20191106162929.739-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00080.txt.bz2

---
 winsup/cygwin/environ.cc          |  2 +-
 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 46 ++++++++++++++++++++-----------
 winsup/cygwin/fhandler_tty.cc     | 14 ++++++++++
 4 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 8fa01b2d5..8c5ce64e1 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -859,6 +859,7 @@ environ_init (char **envp, int envc)
   __endtry
 }
 
+int sawTERM = 0;
 
 char ** __reg2
 win32env_to_cygenv (PWCHAR rawenv, bool posify)
@@ -868,7 +869,6 @@ win32env_to_cygenv (PWCHAR rawenv, bool posify)
   int envc;
   char *newp;
   int i;
-  int sawTERM = 0;
   const char cygterm[] = "TERM=cygwin";
   const char xterm[] = "TERM=xterm-256color";
   char *tmpbuf = tp.t_get ();
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
index 241759203..d875ad65c 100644
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
@@ -1023,17 +1024,28 @@ fhandler_console::open (int flags, mode_t)
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
+      extern int sawTERM;
+      if (con.is_legacy && !sawTERM)
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
@@ -1062,7 +1074,7 @@ fhandler_console::close ()
   output_mutex = NULL;
 
   if (shared_console_info && getpid () == con.owner &&
-      wincap.has_con_24bit_colors ())
+      wincap.has_con_24bit_colors () && !con.is_legacy)
     {
       DWORD dwMode;
       /* Disable xterm compatible mode in input */
@@ -1209,7 +1221,7 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   acquire_output_mutex (INFINITE);
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
   /* If system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors ())
+  if (wincap.has_con_24bit_colors () && !con.is_legacy)
     {
       flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
       if (!(t->c_oflag & OPOST) || !(t->c_oflag & ONLCR))
@@ -1274,9 +1286,10 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
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
@@ -1650,7 +1663,7 @@ bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
   bool need_fix_tab_position = false;
   /* Check if screen will be alternated. */
-  if (wincap.has_con_24bit_colors ()
+  if (wincap.has_con_24bit_colors () && !con.is_legacy
       && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR)))
     need_fix_tab_position = true;
 
@@ -2498,7 +2511,8 @@ fhandler_console::write_normal (const unsigned char *src,
   memset (&ps, 0, sizeof ps);
   while (found < end
 	 && found - src < CONVERT_LIMIT
-	 && (wincap.has_con_24bit_colors () || base_chars[*found] == NOR) )
+	 && ((wincap.has_con_24bit_colors () && !con.is_legacy)
+	     || base_chars[*found] == NOR) )
     {
       switch (ret = f_mbtowc (_REENT, NULL, (const char *) found,
 			       end - found, &ps))
@@ -2958,7 +2972,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
-  if (wincap.has_con_24bit_colors ())
+  if (wincap.has_con_24bit_colors () && !con.is_legacy)
     {
       DWORD dwMode;
       /* Disable xterm compatible mode in input */
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0109d452b..c71603068 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -26,6 +26,7 @@ details. */
 #include <asm/socket.h>
 #include "cygwait.h"
 #include "tls_pbuf.h"
+#include "registry.h"
 
 #define ALWAYS_USE_PCON false
 #define USE_API_HOOK true
@@ -3104,6 +3105,19 @@ is_running_as_service (void)
 bool
 fhandler_pty_master::setup_pseudoconsole ()
 {
+  /* If the legacy console mode is enabled, pseudo console seems
+     not to work as expected. To determine console mode, registry
+     key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
+  reg_key reg (HKEY_CURRENT_USER, KEY_READ, L"Console", NULL);
+  if (reg.error ())
+    return false;
+  if (reg.get_dword (L"ForceV2", 1) == 0)
+    {
+      termios_printf ("Pseudo console is disabled "
+		      "because the legacy console mode is enabled.");
+      return false;
+    }
+
   /* Pseudo console supprot is realized using a tricky technic.
      PTY need the pseudo console handles, however, they cannot
      be retrieved by normal procedure. Therefore, run a helper
-- 
2.21.0
