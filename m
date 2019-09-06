Return-Path: <cygwin-patches-return-9650-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19301 invoked by alias); 6 Sep 2019 14:43:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19210 invoked by uid 89); 6 Sep 2019 14:43:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 14:43:03 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x86EgdUR013938;	Fri, 6 Sep 2019 23:42:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x86EgdUR013938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567780966;	bh=bEM8bSkXzOV8DRZ63HinrmxHX886aF5qkgI+4vo/S4U=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=J7nUSysiNrqwYD9NrrNPmQ4Ir5jthPsHh3uNHgEZH69gNMplKUeolMg7G+ddIsjOP	 19GxitmvyfIz/xHK5Dv5lKphro20zg4mmlzPPO2CH7pUHs8X4FxWNyx7oYxPydfneZ	 A8KbKK2RMlJLAxCyB0KcsNXaUiBEi1IrbUsVud8ji2NduEvotCHUkymnhMO8QAEbN+	 F/z0muf9vieq9sHnAtZOqJxaUcEPsMv3VQu3PuhOCs4R9zlGqGymLD7aHK5dA8EqAV	 9HmWh4w87W5IRVjfHaOllYT51TkgClpUPbsy9Fix9PfQlNqUJalwtWKPIKdmSWLtiy	 neeiGldxmLE+w==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Fri, 06 Sep 2019 14:43:00 -0000
Message-Id: <20190906144239.671-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190906144239.671-1-takashi.yano@nifty.ne.jp>
References: <20190906144239.671-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00170.txt.bz2

- When the I/O pipe is switched to the pseudo console side, the
  behaviour of Ctrl-C is unstable. This rarely happens, however,
  for example, shell sometimes crashes by Ctrl-C in that situation.
  This patch fixes that issue.
---
 winsup/cygwin/fhandler.h      |   4 +-
 winsup/cygwin/fhandler_tty.cc |  32 +++++----
 winsup/cygwin/select.cc       |   2 +-
 winsup/cygwin/spawn.cc        | 128 +++++++++++++++++-----------------
 4 files changed, 88 insertions(+), 78 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e72e11f7a..1e3cada08 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2187,9 +2187,9 @@ class fhandler_pty_slave: public fhandler_pty_common
     get_ttyp ()->mask_switch_to_pcon = mask;
   }
   void fixup_after_attach (bool native_maybe);
-  pid_t get_pcon_pid (void)
+  pid_t getpgid (void)
   {
-    return get_ttyp ()->pcon_pid;
+    return get_ttyp ()->getpgid ();
   }
   bool is_line_input (void)
   {
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 2533e5618..d4a0c232d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1018,20 +1018,25 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       get_ttyp ()->need_clear_screen = false;
     }
 
-  if (ALWAYS_USE_PCON)
-    return;
   if (isHybrid)
-    {
-      this->set_switch_to_pcon ();
-      return;
-    }
+    this->set_switch_to_pcon ();
   if (get_ttyp ()->pcon_pid &&
       get_ttyp ()->pcon_pid != myself->pid &&
       kill (get_ttyp ()->pcon_pid, 0) == 0)
     /* There is a process which is grabbing pseudo console. */
     return;
-  if (get_ttyp ()->switch_to_pcon &&
-      get_ttyp ()->pcon_pid != myself->pid)
+  if (isHybrid)
+    {
+      DWORD mode;
+      GetConsoleMode (get_handle (), &mode);
+      if (ALWAYS_USE_PCON)
+	mode &= ~ENABLE_PROCESSED_INPUT;
+      SetConsoleMode (get_handle (), mode);
+      get_ttyp ()->pcon_pid = 0;
+      init_console_handler (true);
+      return;
+    }
+  if (get_ttyp ()->switch_to_pcon)
     {
       DWORD mode;
       GetConsoleMode (get_handle (), &mode);
@@ -1040,6 +1045,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon = false;
+  init_console_handler (true);
 }
 
 void
@@ -1299,8 +1305,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
   if (ptr) /* Indicating not tcflush(). */
     {
       reset_switch_to_pcon ();
-      if (get_ttyp ()->pcon_pid != myself->pid)
-	mask_switch_to_pcon (true);
+      mask_switch_to_pcon (true);
     }
 
   if (is_nonblocking () || !ptr) /* Indicating tcflush(). */
@@ -1420,7 +1425,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    flags &= ~ENABLE_ECHO_INPUT;
 	  if ((get_ttyp ()->ti.c_lflag & ISIG) &&
 	      !(get_ttyp ()->ti.c_iflag & IGNBRK))
-	    flags |= ENABLE_PROCESSED_INPUT;
+	    flags |= ALWAYS_USE_PCON ? 0 : ENABLE_PROCESSED_INPUT;
 	  if (dwMode != flags)
 	    SetConsoleMode (get_handle (), flags);
 	  /* Read get_handle() instad of get_handle_cyg() */
@@ -2867,8 +2872,10 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 	      get_ttyp ()->num_pcon_attached_slaves ++;
 	    }
 	}
+      if (ALWAYS_USE_PCON && pcon_attached_to == get_minor ())
+	set_ishybrid_and_switch_to_pcon (get_output_handle ());
     }
-  if (pcon_attached_to == get_minor () && (native_maybe || ALWAYS_USE_PCON))
+  if (pcon_attached_to == get_minor () && native_maybe)
     {
       FlushConsoleInputBuffer (get_handle ());
       DWORD mode;
@@ -2883,6 +2890,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
 	get_ttyp ()->pcon_pid = myself->pid;
       get_ttyp ()->switch_to_pcon = true;
+      init_console_handler(false);
     }
 }
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 4efc302df..3589ccabf 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1294,7 +1294,7 @@ pty_slave_startup (select_record *me, select_stuff *stuff)
 {
   fhandler_base *fh = (fhandler_base *) me->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-  if (me->read_selected && ptys->get_pcon_pid () != myself->pid)
+  if (me->read_selected)
     ptys->mask_switch_to_pcon (true);
 
   select_pipe_info *pi = stuff->device_specific_ptys;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 15cba3610..2cd43f681 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -262,6 +262,67 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   DWORD pidRestore = 0;
   bool attach_to_pcon = false;
 
+  /* Attach to pseudo console if pty salve is used */
+  pidRestore = fhandler_console::get_console_process_id
+    (GetCurrentProcessId (), false);
+  fhandler_pty_slave *ptys = NULL;
+  int chk_order[] = {1, 0, 2};
+  for (int i = 0; i < 3; i ++)
+    {
+      int fd = chk_order[i];
+      fhandler_base *fh = ::cygheap->fdtab[fd];
+      if (fh && fh->get_major () == DEV_PTYS_MAJOR)
+	{
+	  ptys = (fhandler_pty_slave *) fh;
+	  if (ptys->getPseudoConsole ())
+	    {
+	      DWORD dwHelperProcessId = ptys->getHelperProcessId ();
+	      debug_printf ("found a PTY slave %d: helper_PID=%d",
+			    fh->get_minor (), dwHelperProcessId);
+	      if (fhandler_console::get_console_process_id
+		  (dwHelperProcessId, true))
+		{
+		  /* Already attached */
+		  attach_to_pcon = true;
+		  break;
+		}
+	      else
+		{
+		  FreeConsole ();
+		  if (AttachConsole (dwHelperProcessId))
+		    {
+		      attach_to_pcon = true;
+		      break;
+		    }
+		  else
+		    {
+		      /* Fallback */
+		      DWORD target[3] = {
+			STD_INPUT_HANDLE,
+			STD_OUTPUT_HANDLE,
+			STD_ERROR_HANDLE
+		      };
+		      if (fd == 0)
+			{
+			  ptys->set_handle (ptys->get_handle_cyg ());
+			  SetStdHandle (target[fd],
+					ptys->get_handle ());
+			}
+		      else if (fd < 3)
+			{
+			  ptys->set_output_handle (
+				       ptys->get_output_handle_cyg ());
+			  SetStdHandle (target[fd],
+					ptys->get_output_handle ());
+			}
+		    }
+		}
+	    }
+	}
+    }
+  if (ptys)
+    ptys->fixup_after_attach (!iscygwin ());
+
   /* Check if we have been called from exec{lv}p or spawn{lv}p and mask
      mode to keep only the spawn mode. */
   bool p_type_exec = !!(mode & _P_PATH_TYPE_EXEC);
@@ -539,8 +600,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 in a console will break native processes running in the background,
 	 because the Ctrl-C event is sent to all processes in the console, unless
 	 they ignore it explicitely.  CREATE_NEW_PROCESS_GROUP does that for us. */
-      if (!iscygwin () && fhandler_console::exists ()
-	  && fhandler_console::tc_getpgid () != myself->pgid)
+      if (!iscygwin () &&
+	  ((fhandler_console::exists ()
+		&& fhandler_console::tc_getpgid () != myself->pgid)
+	   || (ptys && ptys->getpgid () != myself->pgid)))
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
       refresh_cygheap ();
 
@@ -574,67 +637,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			 PROCESS_QUERY_LIMITED_INFORMATION))
 	sa = &sec_none_nih;
 
-      /* Attach to pseudo console if pty salve is used */
-      pidRestore = fhandler_console::get_console_process_id
-	(GetCurrentProcessId (), false);
-      fhandler_pty_slave *ptys = NULL;
-      int chk_order[] = {1, 0, 2};
-      for (int i = 0; i < 3; i ++)
-	{
-	  int fd = chk_order[i];
-	  fhandler_base *fh = ::cygheap->fdtab[fd];
-	  if (fh && fh->get_major () == DEV_PTYS_MAJOR)
-	    {
-	      ptys = (fhandler_pty_slave *) fh;
-	      if (ptys->getPseudoConsole ())
-		{
-		  DWORD dwHelperProcessId = ptys->getHelperProcessId ();
-		  debug_printf ("found a PTY slave %d: helper_PID=%d",
-				    fh->get_minor (), dwHelperProcessId);
-		  if (fhandler_console::get_console_process_id
-					      (dwHelperProcessId, true))
-		    {
-		      /* Already attached */
-		      attach_to_pcon = true;
-		      break;
-		    }
-		  else
-		    {
-		      FreeConsole ();
-		      if (AttachConsole (dwHelperProcessId))
-			{
-			  attach_to_pcon = true;
-			  break;
-			}
-		      else
-			{
-			  /* Fallback */
-			  DWORD target[3] = {
-			    STD_INPUT_HANDLE,
-			    STD_OUTPUT_HANDLE,
-			    STD_ERROR_HANDLE
-			  };
-			  if (fd == 0)
-			    {
-			      ptys->set_handle (ptys->get_handle_cyg ());
-			      SetStdHandle (target[fd],
-					    ptys->get_handle ());
-			    }
-			  else if (fd < 3)
-			    {
-			      ptys->set_output_handle (
-					   ptys->get_output_handle_cyg ());
-			      SetStdHandle (target[fd],
-					    ptys->get_output_handle ());
-			    }
-			}
-		    }
-		}
-	    }
-	}
-      if (ptys)
-	ptys->fixup_after_attach (!iscygwin ());
-
       if (!iscygwin ())
 	{
 	  init_console_handler (myself->ctty > 0);
-- 
2.21.0
