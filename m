Return-Path: <cygwin-patches-return-10068-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89774 invoked by alias); 16 Feb 2020 08:14:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89765 invoked by uid 89); 16 Feb 2020 08:13:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, HTo:U*cygwin-patches
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 16 Feb 2020 08:13:56 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 01G8DXe2015294;	Sun, 16 Feb 2020 17:13:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 01G8DXe2015294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581840819;	bh=FnnUNjsbXPOhdykegT7XuN5reei/Pij9SS+Q4YIKAvM=;	h=From:To:Cc:Subject:Date:From;	b=g8h3gYNTb5DLMGYAoF4QZ7ikWu+zWLMFIzevD/3BauwAGwJRezeppjsnQHq+RSJn3	 PzD7A0NER/yNqpAbGqP9BtREwVzQdOBjF15l5ie6dDNtJrumCNcfdpoMXboY4sohgK	 FVLLwmURsr3aIJ9+qPRVD5TviZ2rXr/X5lktLEe2mGdx5Kj2fJ5kML7M49n1BB/c2r	 od3pjyUknkMiynmjtPGr6cALU4spXKYko+hkqGrAJadx7fUXoJqURL/3rGyL5nwjxl	 Hqr6ILslDT9vmuGHH/mlyfKkxVfOV31xTdd3rit6IqrOSka2/+djvThG/P4LMBQ53a	 tABhRgn7ODK+g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Date: Sun, 16 Feb 2020 08:14:00 -0000
Message-Id: <20200216081322.1183-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00174.txt

- If two cygwin programs are executed simultaneousley with pipes
  in cmd.exe, xterm compatible mode is accidentally disabled by
  the process which ends first. After that, escape sequences are
  not handled correctly in the other app. This is the problem 2
  reported in https://cygwin.com/ml/cygwin/2020-02/msg00116.html.
  This patch fixes the issue. This patch also fixes the problem 3.
  For these issues, the timing of setting and unsetting xterm
  compatible mode is changed. For read, xterm compatible mode is
  enabled only within read() or select() functions. For write, it
  is enabled every time write() is called, and restored on close().
---
 winsup/cygwin/fhandler_console.cc | 101 +++++++++++++++---------------
 winsup/cygwin/select.cc           |  32 +++++++++-
 winsup/cygwin/spawn.cc            |  23 +++----
 3 files changed, 89 insertions(+), 67 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 38eed05f4..fabfcd926 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -53,7 +53,6 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
 
 bool NO_COPY fhandler_console::invisible_console;
 
-static DWORD orig_conin_mode = (DWORD) -1;
 static DWORD orig_conout_mode = (DWORD) -1;
 
 /* con_ra is shared in the same process.
@@ -361,6 +360,9 @@ fix_tab_position (HANDLE h, SHORT width)
     __small_sprintf (buf+strlen (buf), "\033[%d;%dH\033H", 1, col+1);
   /* Restore cursor position */
   __small_sprintf (buf+strlen (buf), "\0338");
+  DWORD dwMode;
+  GetConsoleMode (h, &dwMode);
+  SetConsoleMode (h, dwMode | ENABLE_VIRTUAL_TERMINAL_PROCESSING);
   DWORD dwLen;
   WriteConsole (h, buf, strlen (buf), &dwLen, 0);
 }
@@ -423,6 +425,12 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   DWORD timeout = is_nonblocking () ? 0 : INFINITE;
 
+  DWORD dwMode;
+  GetConsoleMode (get_handle (), &dwMode);
+  /* if system has 24 bit color capability, use xterm compatible mode. */
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
+    SetConsoleMode (get_handle (), dwMode | ENABLE_VIRTUAL_TERMINAL_INPUT);
+
   set_input_state ();
 
   while (!input_ready && !get_cons_readahead_valid ())
@@ -431,6 +439,7 @@ fhandler_console::read (void *pv, size_t& buflen)
       if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
 	{
 	  buflen = bgres;
+	  SetConsoleMode (get_handle (), dwMode); /* Restore */
 	  return;
 	}
 
@@ -448,6 +457,7 @@ fhandler_console::read (void *pv, size_t& buflen)
 	case WAIT_TIMEOUT:
 	  set_sig_errno (EAGAIN);
 	  buflen = (size_t) -1;
+	  SetConsoleMode (get_handle (), dwMode); /* Restore */
 	  return;
 	default:
 	  goto err;
@@ -495,30 +505,24 @@ fhandler_console::read (void *pv, size_t& buflen)
 #undef buf
 
   buflen = copied_chars;
+  SetConsoleMode (get_handle (), dwMode); /* Restore */
   return;
 
 err:
   __seterrno ();
   buflen = (size_t) -1;
+  SetConsoleMode (get_handle (), dwMode); /* Restore */
   return;
 
 sig_exit:
   set_sig_errno (EINTR);
   buflen = (size_t) -1;
+  SetConsoleMode (get_handle (), dwMode); /* Restore */
 }
 
 fhandler_console::input_states
 fhandler_console::process_input_message (void)
 {
-  if (wincap.has_con_24bit_colors () && !con_is_legacy)
-    {
-      DWORD dwMode;
-      /* Enable xterm compatible mode in input */
-      GetConsoleMode (get_handle (), &dwMode);
-      dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-      SetConsoleMode (get_handle (), dwMode);
-    }
-
   char tmp[60];
 
   if (!shared_console_info)
@@ -1047,29 +1051,26 @@ fhandler_console::open (int flags, mode_t)
   get_ttyp ()->rstcons (false);
   set_open_status ();
 
-  if (orig_conin_mode == (DWORD) -1)
-    GetConsoleMode (get_handle (), &orig_conin_mode);
   if (orig_conout_mode == (DWORD) -1)
     GetConsoleMode (get_output_handle (), &orig_conout_mode);
 
   if (getpid () == con.owner && wincap.has_con_24bit_colors ())
     {
+      bool is_legacy = false;
       DWORD dwMode;
-      /* Enable xterm compatible mode in output */
+      /* Check xterm compatible mode in output */
       GetConsoleMode (get_output_handle (), &dwMode);
-      dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-      if (!SetConsoleMode (get_output_handle (), dwMode))
-	con.is_legacy = true;
-      else
-	con.is_legacy = false;
-      /* Enable xterm compatible mode in input */
-      if (!con_is_legacy)
-	{
-	  GetConsoleMode (get_handle (), &dwMode);
-	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-	  if (!SetConsoleMode (get_handle (), dwMode))
-	    con.is_legacy = true;
-	}
+      if (!SetConsoleMode (get_output_handle (),
+			   dwMode | ENABLE_VIRTUAL_TERMINAL_PROCESSING))
+	is_legacy = true;
+      SetConsoleMode (get_output_handle (), dwMode);
+      /* Check xterm compatible mode in input */
+      GetConsoleMode (get_handle (), &dwMode);
+      if (!SetConsoleMode (get_handle (),
+			   dwMode | ENABLE_VIRTUAL_TERMINAL_INPUT))
+	is_legacy = true;
+      SetConsoleMode (get_handle (), dwMode);
+      con.is_legacy = is_legacy;
       extern int sawTERM;
       if (con_is_legacy && !sawTERM)
 	setenv ("TERM", "cygwin", 1);
@@ -1102,19 +1103,12 @@ fhandler_console::close ()
 {
   debug_printf ("closing: %p, %p", get_handle (), get_output_handle ());
 
-  CloseHandle (input_mutex);
-  input_mutex = NULL;
-  CloseHandle (output_mutex);
-  output_mutex = NULL;
+  acquire_output_mutex (INFINITE);
 
   if (shared_console_info && getpid () == con.owner &&
       wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       DWORD dwMode;
-      /* Disable xterm compatible mode in input */
-      GetConsoleMode (get_handle (), &dwMode);
-      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
-      SetConsoleMode (get_handle (), dwMode);
       /* Disable xterm compatible mode in output */
       GetConsoleMode (get_output_handle (), &dwMode);
       dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
@@ -1127,12 +1121,15 @@ fhandler_console::close ()
   status = NtQueryObject (get_handle (), ObjectBasicInformation,
 			  &obi, sizeof obi, NULL);
   if (NT_SUCCESS (status) && obi.HandleCount == 1)
-    {
-      if (orig_conin_mode != (DWORD) -1)
-	SetConsoleMode (get_handle (), orig_conin_mode);
-      if (orig_conout_mode != (DWORD) -1)
-	SetConsoleMode (get_handle (), orig_conout_mode);
-    }
+    if (orig_conout_mode != (DWORD) -1)
+      SetConsoleMode (get_handle (), orig_conout_mode);
+
+  release_output_mutex ();
+
+  CloseHandle (input_mutex);
+  input_mutex = NULL;
+  CloseHandle (output_mutex);
+  output_mutex = NULL;
 
   CloseHandle (get_handle ());
   CloseHandle (get_output_handle ());
@@ -1270,13 +1267,6 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
 
   acquire_output_mutex (INFINITE);
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
-  /* If system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con_is_legacy)
-    {
-      flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-      if (!(t->c_oflag & OPOST) || !(t->c_oflag & ONLCR))
-	flags |= DISABLE_NEWLINE_AUTO_RETURN;
-    }
 
   int res = SetConsoleMode (get_output_handle (), flags) ? 0 : -1;
   if (res)
@@ -1338,9 +1328,6 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
   flags |= ENABLE_WINDOW_INPUT |
     ((wincap.has_con_24bit_colors () && !con_is_legacy) ?
      0 : ENABLE_MOUSE_INPUT);
-  /* if system has 24 bit color capability, use xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con_is_legacy)
-    flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
 
   int res;
   if (flags == oflags)
@@ -2716,6 +2703,20 @@ fhandler_console::write (const void *vsrc, size_t len)
   push_process_state process_state (PID_TTYOU);
   acquire_output_mutex (INFINITE);
 
+  /* If system has 24 bit color capability, use xterm compatible mode. */
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
+    {
+      DWORD dwMode;
+      GetConsoleMode (get_output_handle (), &dwMode);
+      dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+      if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
+	  !(get_ttyp ()->ti.c_oflag & ONLCR))
+	dwMode |= DISABLE_NEWLINE_AUTO_RETURN;
+      else
+	dwMode &= ~DISABLE_NEWLINE_AUTO_RETURN;
+      SetConsoleMode (get_output_handle (), dwMode);
+    }
+
   /* Run and check for ansi sequences */
   unsigned const char *src = (unsigned char *) vsrc;
   unsigned const char *end = src + len;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index b06441c77..f3e3e4482 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1075,19 +1075,49 @@ verify_console (select_record *me, fd_set *rfds, fd_set *wfds,
   return peek_console (me, true);
 }
 
+static int
+console_startup (select_record *me, select_stuff *stuff)
+{
+  select_record *s = stuff->start.next;
+  if (wincap.has_con_24bit_colors ())
+    {
+      DWORD dwMode;
+      GetConsoleMode (s->h, &dwMode);
+      /* Enable xterm compatible mode in input */
+      dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
+      SetConsoleMode (s->h, dwMode);
+    }
+  return 1;
+}
+
+static void
+console_cleanup (select_record *me, select_stuff *stuff)
+{
+  select_record *s = stuff->start.next;
+  if (wincap.has_con_24bit_colors ())
+    {
+      DWORD dwMode;
+      GetConsoleMode (s->h, &dwMode);
+      /* Disable xterm compatible mode in input */
+      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
+      SetConsoleMode (s->h, dwMode);
+    }
+}
+
 select_record *
 fhandler_console::select_read (select_stuff *ss)
 {
   select_record *s = ss->start.next;
   if (!s->startup)
     {
-      s->startup = no_startup;
+      s->startup = console_startup;
       s->verify = verify_console;
       set_cursor_maybe ();
     }
 
   s->peek = peek_console;
   s->h = get_handle ();
+  s->cleanup = console_cleanup;
   s->read_selected = true;
   s->read_ready = input_ready || get_cons_readahead_valid ();
   return s;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index f7c6dd590..772fe6dd6 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -615,22 +615,13 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    {
 	      attach_to_console = true;
 	      if (wincap.has_con_24bit_colors () && !iscygwin ())
-		{
-		  DWORD dwMode;
-		  if (fd == 0)
-		    {
-		      /* Disable xterm compatible mode in input */
-		      GetConsoleMode (fh->get_handle (), &dwMode);
-		      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
-		      SetConsoleMode (fh->get_handle (), dwMode);
-		    }
-		  else
-		    {
-		      GetConsoleMode (fh->get_output_handle (), &dwMode);
-		      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-		      SetConsoleMode (fh->get_output_handle (), dwMode);
-		    }
-		}
+		if (fd == 1 || fd == 2)
+		  {
+		    DWORD dwMode;
+		    GetConsoleMode (fh->get_output_handle (), &dwMode);
+		    dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+		    SetConsoleMode (fh->get_output_handle (), dwMode);
+		  }
 	    }
 	}
 
-- 
2.21.0
