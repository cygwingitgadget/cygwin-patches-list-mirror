Return-Path: <cygwin-patches-return-10046-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98376 invoked by alias); 9 Feb 2020 14:46:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98342 invoked by uid 89); 9 Feb 2020 14:46:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, organized, Hook, screen
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 14:46:28 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 019Ek4Rb005877;	Sun, 9 Feb 2020 23:46:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 019Ek4Rb005877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581259575;	bh=aG6lX/h43XY37nxTaB+Xz/s1FTsWZ9+qw68mtH0LvCg=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=kTlxJcqRXaruqV4RVMxR291cCL7VckbsZcQOUPOr0ZD9dxQQxadnSzNhAJDnR7eN3	 hbUfcuK6Ij0MfJ3ZsRfyCr70fKL4omzAts61FGjydbS3mdkiIz9dpq393uyp3Sga4k	 +B9AmXGtTJ/+dCyrQtTe+GCQqRKywLPDeKzHbnYiZ5dc81f3tjFEzxjXTfOQ0ktqyO	 5DLQCKGhk/Ef9CXqUfQgKLbjbeT2oRXzdhhGih4x9rz8SB4TNEEd544meR9/C5eCB7	 cTW0Xe6yIGPqSqs11GppAQLyvywzEX9g4HJNtlv8LljP4jIyuuxkiN2EBV3sGn1gr7	 4gUjZbQD1/F1Q==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/4] Cygwin: pty: Remove debug codes and organize related codes.
Date: Sun, 09 Feb 2020 14:46:00 -0000
Message-Id: <20200209144603.389-4-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
References: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00152.txt

- Debug codes used in the early stage of pseudo console support are
  removed. (Regarding ALWAYS_USE_PCON and USE_API_HOOK) Along with
  this, the codes related to this change are organized.
---
 winsup/cygwin/fhandler_tty.cc | 81 ++++++++++-------------------------
 winsup/cygwin/select.cc       | 23 ----------
 2 files changed, 23 insertions(+), 81 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f88382752..36b3341b1 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -28,9 +28,6 @@ details. */
 #include "tls_pbuf.h"
 #include "registry.h"
 
-#define ALWAYS_USE_PCON false
-#define USE_API_HOOK true
-
 #ifndef PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
 #endif /* PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE */
@@ -68,7 +65,6 @@ static bool isHybrid;
 static bool do_not_reset_switch_to_pcon;
 static bool freeconsole_on_close = true;
 
-#if USE_API_HOOK
 static void
 set_switch_to_pcon (void)
 {
@@ -364,12 +360,6 @@ CreateProcessW_Hooked
   set_ishybrid_and_switch_to_pcon (h);
   return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
-#else /* USE_API_HOOK */
-#define WriteFile_Orig 0
-#define ReadFile_Orig 0
-#define PeekConsoleInputA_Orig 0
-void set_ishybrid_and_switch_to_pcon (HANDLE) {}
-#endif /* USE_API_HOOK */
 
 static char *
 convert_mb_str (UINT cp_to, size_t *len_to,
@@ -1091,11 +1081,6 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
 {
   if (fd < 0)
     fd = fd_set;
-  if (!isHybrid)
-    {
-      reset_switch_to_pcon ();
-      return;
-    }
   if (fd == 0 && !get_ttyp ()->switch_to_pcon_in)
     {
       pid_restore = 0;
@@ -1109,6 +1094,11 @@ skip_console_setting:
 	  !pinfo (get_ttyp ()->pcon_pid))
 	get_ttyp ()->pcon_pid = myself->pid;
       get_ttyp ()->switch_to_pcon_in = true;
+      if (isHybrid && !get_ttyp ()->switch_to_pcon_out)
+	{
+	  wait_pcon_fwd ();
+	  get_ttyp ()->switch_to_pcon_out = true;
+	}
     }
   else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
     {
@@ -1117,14 +1107,14 @@ skip_console_setting:
 	  !pinfo (get_ttyp ()->pcon_pid))
 	get_ttyp ()->pcon_pid = myself->pid;
       get_ttyp ()->switch_to_pcon_out = true;
+      if (isHybrid)
+	get_ttyp ()->switch_to_pcon_in = true;
     }
 }
 
 void
 fhandler_pty_slave::reset_switch_to_pcon (void)
 {
-  if (isHybrid)
-    this->set_switch_to_pcon (fd);
   if (get_ttyp ()->pcon_pid &&
       get_ttyp ()->pcon_pid != myself->pid &&
       !!pinfo (get_ttyp ()->pcon_pid))
@@ -1132,27 +1122,17 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     return;
   if (isHybrid)
     {
-      if (ALWAYS_USE_PCON)
-	{
-	  DWORD mode;
-	  GetConsoleMode (get_handle (), &mode);
-	  mode |= ENABLE_ECHO_INPUT;
-	  mode |= ENABLE_LINE_INPUT;
-	  mode &= ~ENABLE_PROCESSED_INPUT;
-	  SetConsoleMode (get_handle (), mode);
-	}
-      get_ttyp ()->pcon_pid = 0;
+      DWORD bytes_in_pipe;
+      WaitForSingleObject (input_mutex, INFINITE);
+      if (bytes_available (bytes_in_pipe) && !bytes_in_pipe)
+	ResetEvent (input_available_event);
+      FlushConsoleInputBuffer (get_handle ());
+      ReleaseMutex (input_mutex);
       init_console_handler (true);
       return;
     }
   if (do_not_reset_switch_to_pcon)
     return;
-  if (get_ttyp ()->switch_to_pcon_in)
-    {
-      DWORD mode;
-      GetConsoleMode (get_handle (), &mode);
-      SetConsoleMode (get_handle (), mode & ~ENABLE_ECHO_INPUT);
-    }
   if (get_ttyp ()->switch_to_pcon_out)
     /* Wait for pty_master_fwd_thread() */
     wait_pcon_fwd ();
@@ -1413,7 +1393,7 @@ bool
 fhandler_pty_common::to_be_read_from_pcon (void)
 {
   return get_ttyp ()->switch_to_pcon_in &&
-    (!get_ttyp ()->mask_switch_to_pcon_in || ALWAYS_USE_PCON);
+    !get_ttyp ()->mask_switch_to_pcon_in;
 }
 
 void __reg3
@@ -1441,8 +1421,8 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 
   if (ptr) /* Indicating not tcflush(). */
     {
-      reset_switch_to_pcon ();
       mask_switch_to_pcon_in (true);
+      reset_switch_to_pcon ();
     }
 
   if (is_nonblocking () || !ptr) /* Indicating tcflush(). */
@@ -1562,7 +1542,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    flags &= ~ENABLE_ECHO_INPUT;
 	  if ((get_ttyp ()->ti.c_lflag & ISIG) &&
 	      !(get_ttyp ()->ti.c_iflag & IGNBRK))
-	    flags |= ALWAYS_USE_PCON ? 0 : ENABLE_PROCESSED_INPUT;
+	    flags |= ENABLE_PROCESSED_INPUT;
 	  if (dwMode != flags)
 	    SetConsoleMode (get_handle (), flags);
 	  /* Read get_handle() instad of get_handle_cyg() */
@@ -2325,13 +2305,11 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       char *buf = convert_mb_str
 	(CP_UTF8, &nlen, get_ttyp ()->term_code_page, (const char *) ptr, len);
 
+      WaitForSingleObject (input_mutex, INFINITE);
+
       DWORD wLen;
       WriteFile (to_slave, buf, nlen, &wLen, NULL);
 
-      if (ALWAYS_USE_PCON &&
-	  (ti.c_lflag & ISIG) && memchr (p, ti.c_cc[VINTR], len))
-	get_ttyp ()->kill_pgrp (SIGINT);
-
       if (ti.c_lflag & ICANON)
 	{
 	  if (memchr (buf, '\r', nlen))
@@ -2340,20 +2318,12 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       else
 	SetEvent (input_available_event);
 
+      ReleaseMutex (input_mutex);
+
       mb_str_free (buf);
       return len;
     }
 
-  if (get_ttyp ()->switch_to_pcon_in &&
-      (ti.c_lflag & ISIG) &&
-      memchr (p, ti.c_cc[VINTR], len) &&
-      get_ttyp ()->getpgid () == get_ttyp ()->pcon_pid)
-    {
-      DWORD n;
-      /* Send ^C to pseudo console as well */
-      WriteFile (to_slave, "\003", 1, &n, 0);
-    }
-
   line_edit_status status = line_edit (p, len, ti, &ret);
   if (status > line_edit_signalled && status != line_edit_pipe_full)
     ret = -1;
@@ -2739,17 +2709,13 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	  /* Clear screen to synchronize pseudo console screen buffer
 	     with real terminal. This is necessary because pseudo
 	     console screen buffer is empty at start. */
-	  if (get_ttyp ()->num_pcon_attached_slaves == 0
-	      && !ALWAYS_USE_PCON)
+	  if (get_ttyp ()->num_pcon_attached_slaves == 0)
 	    /* Assume this is the first process using this pty slave. */
 	    get_ttyp ()->need_redraw_screen = true;
 
 	  get_ttyp ()->num_pcon_attached_slaves ++;
 	}
 
-      if (ALWAYS_USE_PCON && !isHybrid && pcon_attached_to == get_minor ())
-	set_ishybrid_and_switch_to_pcon (get_output_handle ());
-
       if (pcon_attached_to == get_minor () && native_maybe)
 	{
 	  if (fd == 0)
@@ -2801,7 +2767,8 @@ fhandler_pty_slave::fixup_after_exec ()
   /* Native windows program does not reset event on read.
      Therefore, reset here if no input is available. */
   DWORD bytes_in_pipe;
-  if (bytes_available (bytes_in_pipe) && !bytes_in_pipe)
+  if (!to_be_read_from_pcon () &&
+      bytes_available (bytes_in_pipe) && !bytes_in_pipe)
     ResetEvent (input_available_event);
 
   reset_switch_to_pcon ();
@@ -2841,7 +2808,6 @@ fhandler_pty_slave::fixup_after_exec ()
   if (get_ttyp ()->term_code_page == 0)
     setup_locale ();
 
-#if USE_API_HOOK
   /* Hook Console API */
   if (get_pseudo_console ())
     {
@@ -2875,7 +2841,6 @@ fhandler_pty_slave::fixup_after_exec ()
       DO_HOOK (NULL, CreateProcessA);
       DO_HOOK (NULL, CreateProcessW);
     }
-#endif /* USE_API_HOOK */
 }
 
 /* This thread function handles the master control pipe.  It waits for a
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index b3aedf20f..5048e549f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1211,29 +1211,6 @@ peek_pty_slave (select_record *s, bool from_select)
 	  goto out;
 	}
 
-      if (ptys->to_be_read_from_pcon ())
-	{
-	  if (ptys->is_line_input ())
-	    {
-	      INPUT_RECORD inp[INREC_SIZE];
-	      DWORD n;
-	      PeekConsoleInput (ptys->get_handle (), inp, INREC_SIZE, &n);
-	      bool end_of_line = false;
-	      while (n-- > 0)
-		if (inp[n].EventType == KEY_EVENT &&
-		    inp[n].Event.KeyEvent.bKeyDown &&
-		    inp[n].Event.KeyEvent.uChar.AsciiChar == '\r')
-		  end_of_line = true;
-	      if (end_of_line)
-		{
-		  gotone = s->read_ready = true;
-		  goto out;
-		}
-	      else
-		goto out;
-	    }
-	}
-
       if (IsEventSignalled (ptys->input_available_event))
 	{
 	  gotone = s->read_ready = true;
-- 
2.21.0
