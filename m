Return-Path: <cygwin-patches-return-9662-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13906 invoked by alias); 8 Sep 2019 12:58:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13864 invoked by uid 89); 8 Sep 2019 12:58:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=furthermore, H*Ad:D*jp, retrieve, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 08 Sep 2019 12:58:49 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x88CwdjP014113;	Sun, 8 Sep 2019 21:58:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x88CwdjP014113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567947524;	bh=ERKbAwQtEiswNcy11TQYuPOfhI6bdVph13n6VWC2+s0=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=LcLKf6AbflntxRp51zY33KSVcrqeuu40MGuWS/fJBkGrjtVrFtMyHHzCZ7qoPkWA2	 9PVLNgqIoKkyKUlVgVvGD/dzdCs/TZAc40G65OYWT7dXWkFMDHWe0X9U0tV4WYsQdD	 uv268yyeUadmR2dFwk/x/RcoV6dEELIdI493+sdWuqe3fTUlZ+Hq9tEccijHb4/mFw	 UZCQP7wW/7XuXj09mYxNny0Jfg8O8KWA57B1797+BnOhoF23GvhcvsDP857DnQ1G0B	 4mJvtvF/7rdmHZeDIyfNDUJspHPz+gH8N7PGSHqQcGWhiYfOixcGfWKlC1kAAj5P5U	 J3r7+zWRwYiew==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 1/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Sun, 08 Sep 2019 12:58:00 -0000
Message-Id: <20190908125835.5184-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190908125835.5184-1-takashi.yano@nifty.ne.jp>
References: <20190908125835.5184-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00182.txt.bz2

- When the I/O pipe is switched to the pseudo console side, the
  behaviour of Ctrl-C was unstable. This rarely happens, however,
  for example, shell sometimes crashes by Ctrl-C in that situation.
  Furthermore, Ctrl-C was ignored if output of non-cygwin program
  is redirected to pipe. This patch fixes these issues.
---
 winsup/cygwin/fhandler.h      |  4 ----
 winsup/cygwin/fhandler_tty.cc | 44 +++++++++++++++++++++++++----------
 winsup/cygwin/select.cc       |  2 +-
 winsup/cygwin/spawn.cc        | 42 ++++++++++++++-------------------
 4 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e72e11f7a..e0c56cd34 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2187,10 +2187,6 @@ class fhandler_pty_slave: public fhandler_pty_common
     get_ttyp ()->mask_switch_to_pcon = mask;
   }
   void fixup_after_attach (bool native_maybe);
-  pid_t get_pcon_pid (void)
-  {
-    return get_ttyp ()->pcon_pid;
-  }
   bool is_line_input (void)
   {
     return get_ttyp ()->ti.c_lflag & ICANON;
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3ffd64e21..a8821c72c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -895,6 +895,7 @@ fhandler_pty_slave::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (pcon_attached_to == get_minor ())
     get_ttyp ()->num_pcon_attached_slaves --;
+  get_ttyp ()->mask_switch_to_pcon = false;
   return 0;
 }
 
@@ -1026,20 +1027,26 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
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
+      if (ALWAYS_USE_PCON)
+	{
+	  DWORD mode;
+	  GetConsoleMode (get_handle (), &mode);
+	  SetConsoleMode (get_handle (), mode & ~ENABLE_PROCESSED_INPUT);
+	}
+      get_ttyp ()->pcon_pid = 0;
+      init_console_handler (true);
+      return;
+    }
+  if (get_ttyp ()->switch_to_pcon)
     {
       DWORD mode;
       GetConsoleMode (get_handle (), &mode);
@@ -1048,6 +1055,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon = false;
+  init_console_handler (true);
 }
 
 void
@@ -1307,8 +1315,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
   if (ptr) /* Indicating not tcflush(). */
     {
       reset_switch_to_pcon ();
-      if (get_ttyp ()->pcon_pid != myself->pid)
-	mask_switch_to_pcon (true);
+      mask_switch_to_pcon (true);
     }
 
   if (is_nonblocking () || !ptr) /* Indicating tcflush(). */
@@ -1428,7 +1435,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    flags &= ~ENABLE_ECHO_INPUT;
 	  if ((get_ttyp ()->ti.c_lflag & ISIG) &&
 	      !(get_ttyp ()->ti.c_iflag & IGNBRK))
-	    flags |= ENABLE_PROCESSED_INPUT;
+	    flags |= ALWAYS_USE_PCON ? 0 : ENABLE_PROCESSED_INPUT;
 	  if (dwMode != flags)
 	    SetConsoleMode (get_handle (), flags);
 	  /* Read get_handle() instad of get_handle_cyg() */
@@ -2222,6 +2229,16 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       return len;
     }
 
+  if (get_ttyp ()->switch_to_pcon &&
+      (ti.c_lflag & ISIG) &&
+      memchr (p, ti.c_cc[VINTR], len) &&
+      get_ttyp ()->getpgid () == get_ttyp ()->pcon_pid)
+    {
+      DWORD n;
+      /* Send ^C to pseudo console as well */
+      WriteFile (to_slave, "\003", 1, &n, 0);
+    }
+
   line_edit_status status = line_edit (p++, len, ti, &ret);
   if (status > line_edit_signalled && status != line_edit_pipe_full)
     ret = -1;
@@ -2875,8 +2892,10 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
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
@@ -2891,6 +2910,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
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
index 15cba3610..7c9e67303 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -261,6 +261,21 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   int res = -1;
   DWORD pidRestore = 0;
   bool attach_to_pcon = false;
+  pid_t ctty_pgid = 0;
+
+  /* Search for CTTY and retrieve its PGID */
+  cygheap_fdenum cfd (false);
+  while (cfd.next () >= 0)
+    if (cfd->get_major () == DEV_PTYS_MAJOR ||
+	cfd->get_major () == DEV_CONS_MAJOR)
+      {
+	fhandler_termios *fh = (fhandler_termios *) (fhandler_base *) cfd;
+	if (fh->tc ()->ntty == myself->ctty)
+	  {
+	    ctty_pgid = fh->tc ()->getpgid ();
+	    break;
+	  }
+      }
 
   /* Check if we have been called from exec{lv}p or spawn{lv}p and mask
      mode to keep only the spawn mode. */
@@ -539,8 +554,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 in a console will break native processes running in the background,
 	 because the Ctrl-C event is sent to all processes in the console, unless
 	 they ignore it explicitely.  CREATE_NEW_PROCESS_GROUP does that for us. */
-      if (!iscygwin () && fhandler_console::exists ()
-	  && fhandler_console::tc_getpgid () != myself->pgid)
+      if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
       refresh_cygheap ();
 
@@ -606,33 +620,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			  attach_to_pcon = true;
 			  break;
 			}
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
 		    }
 		}
 	    }
 	}
-      if (ptys)
+      if (ptys && attach_to_pcon)
 	ptys->fixup_after_attach (!iscygwin ());
 
       if (!iscygwin ())
-- 
2.21.0
