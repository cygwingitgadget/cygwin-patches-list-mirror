Return-Path: <cygwin-patches-return-9672-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21383 invoked by alias); 13 Sep 2019 21:48:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21352 invoked by uid 89); 13 Sep 2019 21:48:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Sep 2019 21:48:30 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x8DLmI1m024407;	Sat, 14 Sep 2019 06:48:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x8DLmI1m024407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568411306;	bh=Xl5FL8iDvDcxaOH9uJW3yz8S6CxSpLLfsIQrh9u3WBo=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=Mt/k+4W1u//iWV6zAHYGQBc2VDgbnzyWlepJZT+1BS1ejrxwkjSZ52dYjS+KgwmzY	 rW5A8MwfqGE5Be9tokPcM8F1SAozt89DnMqjubrdd86iGWYEN38p3P7Jzh6ZJEKEZV	 CHvnJOk8kIqBRUOSfP5kijznYfHEQ4tnONGBaIIu6ndCTtZp070ock2w9FJinH09zp	 Rtv4xvD7F566Q04shypm97xLYpSNpwl5cqR2hqKlZE5j5sZC6bMuz6iftp5jdOYH10	 IDe8WyCRuDeKqwldEVbvSvYxVPorDL6YbtvEeK651y50RcsoRrmwiAufGlsdk7XTYn	 TfSQLdT97hijQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: pty: Switch input and output pipes individually.
Date: Fri, 13 Sep 2019 21:48:00 -0000
Message-Id: <20190913214814.1868-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190913214814.1868-1-takashi.yano@nifty.ne.jp>
References: <20190913214814.1868-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00192.txt.bz2

- Previously, input and output pipes were switched together between
  the traditional pty and the pseudo console. However, for example,
  if stdin is redirected to another device, it is better to leave
  input pipe traditional pty side even for non-cygwin program. This
  patch realizes such behaviour.
---
 winsup/cygwin/dtable.cc           |   6 +-
 winsup/cygwin/fhandler.h          |   9 +-
 winsup/cygwin/fhandler_console.cc |   7 +-
 winsup/cygwin/fhandler_tty.cc     | 194 +++++++++++++++++++++---------
 winsup/cygwin/select.cc           |   4 +-
 winsup/cygwin/spawn.cc            |  44 +++----
 winsup/cygwin/tty.cc              |   5 +-
 winsup/cygwin/tty.h               |   5 +-
 8 files changed, 173 insertions(+), 101 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 7b2e52005..cb5f47395 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -147,9 +147,9 @@ dtable::get_debugger_info ()
 void
 dtable::stdio_init ()
 {
-  int chk_order[] = {1, 0, 2};
   for (int i = 0; i < 3; i ++)
     {
+      const int chk_order[] = {1, 0, 2};
       int fd = chk_order[i];
       fhandler_base *fh = cygheap->fdtab[fd];
       if (fh && fh->get_major () == DEV_PTYS_MAJOR)
@@ -169,12 +169,14 @@ dtable::stdio_init ()
 		  FreeConsole ();
 		  if (AttachConsole (ptys->getHelperProcessId ()))
 		    {
-		      ptys->fixup_after_attach (false);
+		      ptys->fixup_after_attach (false, fd);
 		      break;
 		    }
 		}
 	    }
 	}
+      else if (fh && fh->get_major () == DEV_CONS_MAJOR)
+	break;
     }
 
   if (myself->cygstarted || ISSTATE (myself, PID_CYGPARENT))
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e0c56cd34..1bf5dfb09 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2114,6 +2114,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   HANDLE inuse;			// used to indicate that a tty is in use
   HANDLE output_handle_cyg, io_handle_cyg;
   DWORD pid_restore;
+  int fd;
 
   /* Helper functions for fchmod and fchown. */
   bool fch_open_handles (bool chown);
@@ -2175,18 +2176,18 @@ class fhandler_pty_slave: public fhandler_pty_common
     copyto (fh);
     return fh;
   }
-  void set_switch_to_pcon (void);
+  void set_switch_to_pcon (int fd);
   void reset_switch_to_pcon (void);
   void push_to_pcon_screenbuffer (const char *ptr, size_t len);
-  void mask_switch_to_pcon (bool mask)
+  void mask_switch_to_pcon_in (bool mask)
   {
     if (!mask && get_ttyp ()->pcon_pid &&
 	get_ttyp ()->pcon_pid != myself->pid &&
 	kill (get_ttyp ()->pcon_pid, 0) == 0)
       return;
-    get_ttyp ()->mask_switch_to_pcon = mask;
+    get_ttyp ()->mask_switch_to_pcon_in = mask;
   }
-  void fixup_after_attach (bool native_maybe);
+  void fixup_after_attach (bool native_maybe, int fd);
   bool is_line_input (void)
   {
     return get_ttyp ()->ti.c_lflag & ICANON;
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 1b034f4b9..778279f99 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -3156,10 +3156,9 @@ fhandler_console::get_console_process_id (DWORD pid, bool match)
   tmp = 0;
   for (DWORD i=0; i<num; i++)
     if ((match && list[i] == pid) || (!match && list[i] != pid))
-      {
-	tmp = list[i];
-	break;
-      }
+      /* Last one is the oldest. */
+      /* https://github.com/microsoft/terminal/issues/95 */
+      tmp = list[i];
   HeapFree (GetProcessHeap (), 0, list);
   return tmp;
 }
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index b4591c17a..9aa832641 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -80,12 +80,13 @@ static void
 set_switch_to_pcon (void)
 {
   cygheap_fdenum cfd (false);
-  while (cfd.next () >= 0)
+  int fd;
+  while ((fd = cfd.next ()) >= 0)
     if (cfd->get_major () == DEV_PTYS_MAJOR)
       {
 	fhandler_base *fh = cfd;
 	fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	ptys->set_switch_to_pcon ();
+	ptys->set_switch_to_pcon (fd);
       }
 }
 
@@ -124,6 +125,29 @@ force_attach_to_pcon (HANDLE h)
 		break;
 	      }
 	  }
+	else if (cfd->get_major () == DEV_CONS_MAJOR)
+	  {
+	    fhandler_base *fh = cfd;
+	    fhandler_console *cons = (fhandler_console *) fh;
+	    if (n != 0
+		|| h == cons->get_handle ()
+		|| h == cons->get_output_handle ())
+	      {
+		/* If the process is running on a console,
+		   the parent process should be attached
+		   to the same console. */
+		pinfo p (myself->ppid);
+		FreeConsole ();
+		if (AttachConsole (p->dwProcessId))
+		  {
+		    pcon_attached_to = -1;
+		    attach_done = true;
+		  }
+		else
+		  pcon_attached_to = -1;
+		break;
+	      }
+	  }
       if (attach_done)
 	break;
     }
@@ -303,7 +327,7 @@ PeekConsoleInputW_Hooked
 #define WriteFile_Orig 0
 #define ReadFile_Orig 0
 #define PeekConsoleInputA_Orig 0
-void set_ishybrid_and_switch_to_pcon (void) {}
+void set_ishybrid_and_switch_to_pcon (HANDLE) {}
 #endif /* USE_API_HOOK */
 
 bool
@@ -596,7 +620,7 @@ out:
 
 fhandler_pty_slave::fhandler_pty_slave (int unit)
   : fhandler_pty_common (), inuse (NULL), output_handle_cyg (NULL),
-  io_handle_cyg (NULL), pid_restore (0)
+  io_handle_cyg (NULL), pid_restore (0), fd (-1)
 {
   if (unit >= 0)
     dev ().parse (DEV_PTYS_MAJOR, unit);
@@ -896,7 +920,7 @@ fhandler_pty_slave::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (pcon_attached_to == get_minor ())
     get_ttyp ()->num_pcon_attached_slaves --;
-  get_ttyp ()->mask_switch_to_pcon = false;
+  get_ttyp ()->mask_switch_to_pcon_in = false;
   return 0;
 }
 
@@ -985,14 +1009,16 @@ fhandler_pty_slave::restore_reattach_pcon (void)
 }
 
 void
-fhandler_pty_slave::set_switch_to_pcon (void)
+fhandler_pty_slave::set_switch_to_pcon (int fd_set)
 {
+  if (fd < 0)
+    fd = fd_set;
   if (!isHybrid)
     {
       reset_switch_to_pcon ();
       return;
     }
-  if (!get_ttyp ()->switch_to_pcon)
+  if (fd == 0 && !get_ttyp ()->switch_to_pcon_in)
     {
       pid_restore = 0;
       if (pcon_attached_to != get_minor ())
@@ -1000,15 +1026,22 @@ fhandler_pty_slave::set_switch_to_pcon (void)
 	  goto skip_console_setting;
       FlushConsoleInputBuffer (get_handle ());
       DWORD mode;
-      GetConsoleMode (get_handle (), &mode);
-      SetConsoleMode (get_handle (), mode | ENABLE_ECHO_INPUT);
+      mode = ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+      SetConsoleMode (get_handle (), mode);
 skip_console_setting:
       restore_reattach_pcon ();
+      if (get_ttyp ()->pcon_pid == 0 ||
+	  kill (get_ttyp ()->pcon_pid, 0) != 0)
+	get_ttyp ()->pcon_pid = myself->pid;
+      get_ttyp ()->switch_to_pcon_in = true;
+    }
+  else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
+    {
       Sleep (20);
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
 	get_ttyp ()->pcon_pid = myself->pid;
-      get_ttyp ()->switch_to_pcon = true;
+      get_ttyp ()->switch_to_pcon_out = true;
     }
 }
 
@@ -1029,7 +1062,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
 
   if (isHybrid)
-    this->set_switch_to_pcon ();
+    this->set_switch_to_pcon (fd);
   if (get_ttyp ()->pcon_pid &&
       get_ttyp ()->pcon_pid != myself->pid &&
       kill (get_ttyp ()->pcon_pid, 0) == 0)
@@ -1041,7 +1074,10 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	{
 	  DWORD mode;
 	  GetConsoleMode (get_handle (), &mode);
-	  SetConsoleMode (get_handle (), mode & ~ENABLE_PROCESSED_INPUT);
+	  mode |= ENABLE_ECHO_INPUT;
+	  mode |= ENABLE_LINE_INPUT;
+	  mode &= ~ENABLE_PROCESSED_INPUT;
+	  SetConsoleMode (get_handle (), mode);
 	}
       get_ttyp ()->pcon_pid = 0;
       init_console_handler (true);
@@ -1049,15 +1085,17 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   if (do_not_reset_switch_to_pcon)
     return;
-  if (get_ttyp ()->switch_to_pcon)
+  if (get_ttyp ()->switch_to_pcon_in)
     {
       DWORD mode;
       GetConsoleMode (get_handle (), &mode);
       SetConsoleMode (get_handle (), mode & ~ENABLE_ECHO_INPUT);
-      Sleep (20); /* Wait for pty_master_fwd_thread() */
     }
+  if (get_ttyp ()->switch_to_pcon_out)
+    Sleep (20); /* Wait for pty_master_fwd_thread() */
   get_ttyp ()->pcon_pid = 0;
-  get_ttyp ()->switch_to_pcon = false;
+  get_ttyp ()->switch_to_pcon_in = false;
+  get_ttyp ()->switch_to_pcon_out = false;
   init_console_handler (true);
 }
 
@@ -1111,7 +1149,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
 	    {
 	      //p0 += 8;
 	      get_ttyp ()->screen_alternated = true;
-	      if (get_ttyp ()->switch_to_pcon)
+	      if (get_ttyp ()->switch_to_pcon_out)
 		do_not_reset_switch_to_pcon = true;
 	    }
 	}
@@ -1133,7 +1171,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
     }
   if (!nlen) /* Nothing to be synchronized */
     goto cleanup;
-  if (get_ttyp ()->switch_to_pcon)
+  if (get_ttyp ()->switch_to_pcon_out)
     goto cleanup;
   /* Remove ESC sequence which returns results to console
      input buffer. Without this, cursor position report
@@ -1209,7 +1247,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   char *buf;
   ssize_t nlen;
-  UINT targetCodePage = get_ttyp ()->switch_to_pcon ?
+  UINT targetCodePage = get_ttyp ()->switch_to_pcon_out ?
     GetConsoleOutputCP () : get_ttyp ()->TermCodePage;
   if (targetCodePage != get_ttyp ()->TermCodePage)
     {
@@ -1239,7 +1277,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   /* If not attached to this pseudo console, try to attach temporarily. */
   pid_restore = 0;
   bool fallback = false;
-  if (get_ttyp ()->switch_to_pcon && pcon_attached_to != get_minor ())
+  if (get_ttyp ()->switch_to_pcon_out && pcon_attached_to != get_minor ())
     if (!try_reattach_pcon ())
       fallback = true;
 
@@ -1248,12 +1286,12 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
       !(get_ttyp ()->ti.c_oflag & ONLCR))
     flags |= DISABLE_NEWLINE_AUTO_RETURN;
-  if (get_ttyp ()->switch_to_pcon && !fallback)
+  if (get_ttyp ()->switch_to_pcon_out && !fallback)
     {
       GetConsoleMode (get_output_handle (), &dwMode);
       SetConsoleMode (get_output_handle (), dwMode | flags);
     }
-  HANDLE to = (get_ttyp ()->switch_to_pcon && !fallback) ?
+  HANDLE to = (get_ttyp ()->switch_to_pcon_out && !fallback) ?
     get_output_handle () : get_output_handle_cyg ();
   acquire_output_mutex (INFINITE);
   if (!process_opost_output (to, buf, nlen, false))
@@ -1273,7 +1311,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   release_output_mutex ();
   HeapFree (GetProcessHeap (), 0, buf);
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-  if (get_ttyp ()->switch_to_pcon && !fallback)
+  if (get_ttyp ()->switch_to_pcon_out && !fallback)
     SetConsoleMode (get_output_handle (), dwMode | flags);
 
   restore_reattach_pcon ();
@@ -1292,8 +1330,8 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 bool
 fhandler_pty_common::to_be_read_from_pcon (void)
 {
-  return get_ttyp ()->switch_to_pcon &&
-    (!get_ttyp ()->mask_switch_to_pcon || ALWAYS_USE_PCON);
+  return get_ttyp ()->switch_to_pcon_in &&
+    (!get_ttyp ()->mask_switch_to_pcon_in || ALWAYS_USE_PCON);
 }
 
 void __reg3
@@ -1322,7 +1360,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
   if (ptr) /* Indicating not tcflush(). */
     {
       reset_switch_to_pcon ();
-      mask_switch_to_pcon (true);
+      mask_switch_to_pcon_in (true);
     }
 
   if (is_nonblocking () || !ptr) /* Indicating tcflush(). */
@@ -1475,7 +1513,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	  len = rlen;
 
 	  restore_reattach_pcon ();
-	  mask_switch_to_pcon (false);
+	  mask_switch_to_pcon_in (false);
 	  return;
 	}
 
@@ -1491,7 +1529,7 @@ do_read_cyg:
       if (ptr && !bytes_in_pipe && !vmin && !time_to_wait)
 	{
 	  ReleaseMutex (input_mutex);
-	  mask_switch_to_pcon (false);
+	  mask_switch_to_pcon_in (false);
 	  len = (size_t) bytes_in_pipe;
 	  return;
 	}
@@ -1603,7 +1641,7 @@ out:
       push_to_pcon_screenbuffer (ptr0, len);
       release_output_mutex ();
     }
-  mask_switch_to_pcon (false);
+  mask_switch_to_pcon_in (false);
 }
 
 int
@@ -2147,7 +2185,8 @@ fhandler_pty_master::close ()
 	      ClosePseudoConsole = (VOID (WINAPI *) (HPCON)) func;
 	      ClosePseudoConsole (getPseudoConsole ());
 	    }
-	  get_ttyp ()->switch_to_pcon = false;
+	  get_ttyp ()->switch_to_pcon_in = false;
+	  get_ttyp ()->switch_to_pcon_out = false;
 	}
       if (get_ttyp ()->getsid () > 0)
 	kill (get_ttyp ()->getsid (), SIGHUP);
@@ -2231,12 +2270,24 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	}
       DWORD wLen;
       WriteFile (to_slave, buf, nlen, &wLen, NULL);
-      SetEvent (input_available_event);
+
+      if (ALWAYS_USE_PCON &&
+	  (ti.c_lflag & ISIG) && memchr (p, ti.c_cc[VINTR], len))
+	get_ttyp ()->kill_pgrp (SIGINT);
+
+      if (ti.c_lflag & ICANON)
+	{
+	  if (memchr (buf, '\r', nlen))
+	    SetEvent (input_available_event);
+	}
+      else
+	SetEvent (input_available_event);
+
       HeapFree (GetProcessHeap (), 0, buf);
       return len;
     }
 
-  if (get_ttyp ()->switch_to_pcon &&
+  if (get_ttyp ()->switch_to_pcon_in &&
       (ti.c_lflag & ISIG) &&
       memchr (p, ti.c_cc[VINTR], len) &&
       get_ttyp ()->getpgid () == get_ttyp ()->pcon_pid)
@@ -2808,8 +2859,10 @@ restart:
 #endif /* USE_OWN_NLS_FUNC */
 
 void
-fhandler_pty_slave::fixup_after_attach (bool native_maybe)
+fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 {
+  if (fd < 0)
+    fd = fd_set;
   if (getPseudoConsole ())
     {
       if (fhandler_console::get_console_process_id (getHelperProcessId (),
@@ -2887,43 +2940,58 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 			  break;
 			}
 		}
+	    }
+	  /* Clear screen to synchronize pseudo console screen buffer
+	     with real terminal. This is necessary because pseudo
+	     console screen buffer is empty at start. */
+	  if (get_ttyp ()->num_pcon_attached_slaves == 0
+	      && !ALWAYS_USE_PCON)
+	    /* Assume this is the first process using this pty slave. */
+	    get_ttyp ()->need_clear_screen = true;
+
+	  get_ttyp ()->num_pcon_attached_slaves ++;
+	}
 
-	      /* Clear screen to synchronize pseudo console screen buffer
-		 with real terminal. This is necessary because pseudo
-		 console screen buffer is empty at start. */
-	      if (get_ttyp ()->num_pcon_attached_slaves == 0
-		  && !ALWAYS_USE_PCON)
-		/* Assume this is the first process using this pty slave. */
-		get_ttyp ()->need_clear_screen = true;
+      if (ALWAYS_USE_PCON && !isHybrid && pcon_attached_to == get_minor ())
+	set_ishybrid_and_switch_to_pcon (get_output_handle ());
 
-	      get_ttyp ()->num_pcon_attached_slaves ++;
+      if (pcon_attached_to == get_minor () && native_maybe)
+	{
+	  if (fd == 0)
+	    {
+	      FlushConsoleInputBuffer (get_handle ());
+	      DWORD mode =
+		ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+	      SetConsoleMode (get_handle (), mode);
+	      if (get_ttyp ()->pcon_pid == 0 ||
+		  kill (get_ttyp ()->pcon_pid, 0) != 0)
+		get_ttyp ()->pcon_pid = myself->pid;
+	      get_ttyp ()->switch_to_pcon_in = true;
+	    }
+	  else if (fd == 1 || fd == 2)
+	    {
+	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
+	      SetConsoleMode (get_output_handle (), mode);
+	      if (!get_ttyp ()->switch_to_pcon_out)
+		Sleep (20);
+	      if (get_ttyp ()->pcon_pid == 0 ||
+		  kill (get_ttyp ()->pcon_pid, 0) != 0)
+		get_ttyp ()->pcon_pid = myself->pid;
+	      get_ttyp ()->switch_to_pcon_out = true;
 	    }
+	  init_console_handler(false);
 	}
-      if (ALWAYS_USE_PCON && pcon_attached_to == get_minor ())
-	set_ishybrid_and_switch_to_pcon (get_output_handle ());
-    }
-  if (pcon_attached_to == get_minor () && native_maybe)
-    {
-      FlushConsoleInputBuffer (get_handle ());
-      DWORD mode;
-      mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
-      SetConsoleMode (get_output_handle (), mode);
-      FlushConsoleInputBuffer (get_handle ());
-      mode = ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
-      SetConsoleMode (get_handle (), mode);
-      Sleep (20);
-      if (get_ttyp ()->pcon_pid == 0 ||
-	  kill (get_ttyp ()->pcon_pid, 0) != 0)
-	get_ttyp ()->pcon_pid = myself->pid;
-      get_ttyp ()->switch_to_pcon = true;
-      init_console_handler(false);
+      else if (fd == 0 && native_maybe)
+	/* Read from unattached pseudo console cause freeze,
+	   therefore, fallback to legacy pty. */
+	set_handle (get_handle_cyg ());
     }
 }
 
 void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
-  fixup_after_attach (false);
+  fixup_after_attach (false, -1);
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
   report_tty_counts (this, "inherited", "");
@@ -2932,6 +3000,12 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 void
 fhandler_pty_slave::fixup_after_exec ()
 {
+  /* Native windows program does not reset event on read.
+     Therefore, reset here if no input is available. */
+  DWORD bytes_in_pipe;
+  if (bytes_available (bytes_in_pipe) && !bytes_in_pipe)
+    ResetEvent (input_available_event);
+
   reset_switch_to_pcon ();
 
   if (!close_on_exec ())
@@ -3169,7 +3243,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	{
 	  /* Avoid duplicating slave output which is already sent to
 	     to_master_cyg */
-	  if (!get_ttyp ()->switch_to_pcon)
+	  if (!get_ttyp ()->switch_to_pcon_out)
 	    continue;
 
 	  /* Avoid setting window title to "cygwin-console-helper.exe" */
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 3589ccabf..ed8c98d1c 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1295,7 +1295,7 @@ pty_slave_startup (select_record *me, select_stuff *stuff)
   fhandler_base *fh = (fhandler_base *) me->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
   if (me->read_selected)
-    ptys->mask_switch_to_pcon (true);
+    ptys->mask_switch_to_pcon_in (true);
 
   select_pipe_info *pi = stuff->device_specific_ptys;
   if (pi->start)
@@ -1318,7 +1318,7 @@ pty_slave_cleanup (select_record *me, select_stuff *stuff)
   fhandler_base *fh = (fhandler_base *) me->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
   if (me->read_selected)
-    ptys->mask_switch_to_pcon (false);
+    ptys->mask_switch_to_pcon_in (false);
 
   select_pipe_info *pi = (select_pipe_info *) stuff->device_specific_ptys;
   if (!pi)
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 7c9e67303..4396ec9e5 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -260,7 +260,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   bool rc;
   int res = -1;
   DWORD pidRestore = 0;
-  bool attach_to_pcon = false;
+  bool attach_to_console = false;
   pid_t ctty_pgid = 0;
 
   /* Search for CTTY and retrieve its PGID */
@@ -408,14 +408,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       pi.hProcess = pi.hThread = NULL;
       pi.dwProcessId = pi.dwThreadId = 0;
 
-      /* Set up needed handles for stdio */
-      si.dwFlags = STARTF_USESTDHANDLES;
-      si.hStdInput = handle ((in__stdin < 0 ? 0 : in__stdin), false);
-      si.hStdOutput = handle ((in__stdout < 0 ? 1 : in__stdout), true);
-      si.hStdError = handle (2, true);
-
-      si.cb = sizeof (si);
-
       c_flags = GetPriorityClass (GetCurrentProcess ());
       sigproc_printf ("priority class %d", c_flags);
 
@@ -591,15 +583,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       /* Attach to pseudo console if pty salve is used */
       pidRestore = fhandler_console::get_console_process_id
 	(GetCurrentProcessId (), false);
-      fhandler_pty_slave *ptys = NULL;
-      int chk_order[] = {1, 0, 2};
       for (int i = 0; i < 3; i ++)
 	{
+	  const int chk_order[] = {1, 0, 2};
 	  int fd = chk_order[i];
 	  fhandler_base *fh = ::cygheap->fdtab[fd];
 	  if (fh && fh->get_major () == DEV_PTYS_MAJOR)
 	    {
-	      ptys = (fhandler_pty_slave *) fh;
+	      fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 	      if (ptys->getPseudoConsole ())
 		{
 		  DWORD dwHelperProcessId = ptys->getHelperProcessId ();
@@ -607,25 +598,28 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 				    fh->get_minor (), dwHelperProcessId);
 		  if (fhandler_console::get_console_process_id
 					      (dwHelperProcessId, true))
-		    {
-		      /* Already attached */
-		      attach_to_pcon = true;
-		      break;
-		    }
-		  else
+		    /* Already attached */
+		    attach_to_console = true;
+		  else if (!attach_to_console)
 		    {
 		      FreeConsole ();
 		      if (AttachConsole (dwHelperProcessId))
-			{
-			  attach_to_pcon = true;
-			  break;
-			}
+			attach_to_console = true;
 		    }
+		  ptys->fixup_after_attach (!iscygwin (), fd);
 		}
 	    }
+	  else if (fh && fh->get_major () == DEV_CONS_MAJOR)
+	    attach_to_console = true;
 	}
-      if (ptys && attach_to_pcon)
-	ptys->fixup_after_attach (!iscygwin ());
+
+      /* Set up needed handles for stdio */
+      si.dwFlags = STARTF_USESTDHANDLES;
+      si.hStdInput = handle ((in__stdin < 0 ? 0 : in__stdin), false);
+      si.hStdOutput = handle ((in__stdout < 0 ? 1 : in__stdout), true);
+      si.hStdError = handle (2, true);
+
+      si.cb = sizeof (si);
 
       if (!iscygwin ())
 	{
@@ -931,7 +925,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   if (envblock)
     free (envblock);
 
-  if (attach_to_pcon && pidRestore)
+  if (attach_to_console && pidRestore)
     {
       FreeConsole ();
       AttachConsole (pidRestore);
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index c94aee3ba..54c25d997 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -237,9 +237,10 @@ tty::init ()
   attach_pcon_in_fork = false;
   hPseudoConsole = NULL;
   column = 0;
-  switch_to_pcon = false;
+  switch_to_pcon_in = false;
+  switch_to_pcon_out = false;
   screen_alternated = false;
-  mask_switch_to_pcon = false;
+  mask_switch_to_pcon_in = false;
   pcon_pid = 0;
   num_pcon_attached_slaves = 0;
   TermCodePage = 20127; /* ASCII */
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index c2b0490d0..b7d1e23ad 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -98,9 +98,10 @@ private:
   DWORD HelperProcessId;
   HANDLE hHelperGoodbye;
   bool attach_pcon_in_fork;
-  bool switch_to_pcon;
+  bool switch_to_pcon_in;
+  bool switch_to_pcon_out;
   bool screen_alternated;
-  bool mask_switch_to_pcon;
+  bool mask_switch_to_pcon_in;
   pid_t pcon_pid;
   int num_pcon_attached_slaves;
   UINT TermCodePage;
-- 
2.21.0
