Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 625814B99F40
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:09:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 625814B99F40
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 625814B99F40
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781359782; cv=none;
	b=j4CYzJRcFYFksaYqM0du0mkKdYaAKZvPTE9H5mgmDvWfIwMAXuPfvhi3uy6t74vYMJts81wMpJlgW5MWAPRdTMDSo9G8AGXoiuNG9/x/duK1pWlbzP/FJ46HeBOWtqra2nZHTtUi9K8s6FMhT95VXmEM5+GF5jqTLI9L5kLDxoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781359782; c=relaxed/simple;
	bh=TYFfhI1aq5dcJ+dF8LmxyMTkZdMXDY4ZmpJDGwZnFiw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=lKBviGFQxvMNerdN3SbUkuSS0RX3wWtxn0zkokyyTyolBqgq60SKnRsXJlM3nS2TEHU+ykoHLei5VLPVKrhNEMQM4ywMS0uEGrTnPVG/MNlUKOkDqox5ChIo5zYupJg1pEr3HHg1BgZcUdqw/YWzlaflkF1M4JKuNrY06tRGNNI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LS5Gj/O4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 625814B99F40
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LS5Gj/O4
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260613140939738.XZBU.102121.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 23:09:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app exits
Date: Sat, 13 Jun 2026 23:09:02 +0900
Message-ID: <20260613140917.27155-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781359779;
 bh=MjETvo1rdSUrxoJrryHte2mVBv5K7AYg/Vg4/r7eiW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LS5Gj/O4kCJQ73TTa240B3/tOXrDMymou49ieBYm3Nac/C3XwCL4vyEyYWgb2P0yu2jXdNzp
 15osgW/pqSfBy+Cma+OKW8RP+pbcD79e90Plm9TP1c8FE/KuW6mwDUo1oidN8lkPn+UQjruD58
 TIAy1ZQfvyt6AZE6YDYJakd6syax7FOSJfENovcYp0ekr6MbH8CyCeXx7faN+/d5lkjf5CgM/w
 V5d0Px2eJGsbeAtZI/aXzh49AQ5w+LCkYIHGXP4MwO4XvfJLrkuGMfrA9/K3GLLUgvdj1mpzLR
 9UtcEFh1eU6s6UFMKzWRS85kodhrW488P9Ak88jmZdjJOOVQ==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the cygwin process on pty is always a child of another
cygwin app on pty. If a cygwin app is a child of non-cygwin app
in pseudo console, it was running on console originating from
pseudo console. Now, the child of a non-cygwin app on pseudo console
is running on pty, so, it is necessary to restore the pty state
to the state where the parent process is running. This patch
does the following fixup:
 1) Switch pipe mode to cyg-pipe to nat-pipe.
 2) Notify the current cursor position to pseudo console

These prevent the problems:
 1) Run 'cat' in cmd.exe and stop it by Ctrl-C. After that
    cmd.exe cannot receive key input.
 2) Run 'ps' in cmd.exe. The cursor position will not be
    maintained correctly after that.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc           | 73 ++++++++++++++++++++++++-
 winsup/cygwin/local_includes/fhandler.h |  2 +
 winsup/cygwin/local_includes/tty.h      |  1 +
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index b3a8d57cc..f4473bb69 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -388,6 +388,52 @@ atexit_func (void)
     }
 }
 
+void
+fhandler_pty_slave::req_fixup_pcon_state (void)
+{
+  while (true)
+    {
+      WaitForSingleObject (input_mutex, mutex_timeout);
+      if (!get_ttyp ()->pcon_start_pid)
+	break;
+      /* Another request is on going. */
+      ReleaseMutex (input_mutex);
+      yield ();
+    }
+
+  DWORD n;
+  /* indicates that this "ESC[6n" is just for fixing-up corsor position */
+  get_ttyp ()->req_fixup_pcon_cur_pos = true;
+  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
+					 is just for transfer input */
+  get_ttyp ()->pcon_start = true;
+  get_ttyp ()->pcon_start_pid = myself->pid;
+  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
+  ReleaseMutex (input_mutex);
+  while (get_ttyp ()->pcon_start_pid)
+    /* wait for completion of fixing-up in master::write(). */
+    yield ();
+}
+
+void
+fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
+{
+  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				   get_ttyp ()->nat_pipe_owner_pid);
+  HANDLE h_pcon_out = NULL;
+  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
+		   GetCurrentProcess (), &h_pcon_out,
+		   0, TRUE, DUPLICATE_SAME_ACCESS);
+  CloseHandle (pcon_owner);
+  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
+  DWORD resume_pid =
+    fhandler_pty_common::attach_console_temporarily (target_pid);
+  COORD cur_pos = {(SHORT) (x - 1), (SHORT) (y - 1)};
+  SetConsoleCursorPosition (h_pcon_out, cur_pos);
+  fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
+  CloseHandle (h_pcon_out);
+}
+
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
 /* CreateProcess() is hooked for GDB etc. */
 DEF_HOOK (CreateProcessA);
@@ -1162,6 +1208,19 @@ err_no_msg:
 bool
 fhandler_pty_slave::open_setup (int flags)
 {
+  if (get_ttyp ()->pcon_activated)
+    {
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &get_handle_nat (),
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
+		       GetCurrentProcess (), &get_output_handle_nat (),
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      CloseHandle (pcon_owner);
+    }
+
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   myself->set_ctty (this, flags);
   report_tty_counts (this, "opened", "");
@@ -1171,6 +1230,9 @@ fhandler_pty_slave::open_setup (int flags)
 void
 fhandler_pty_slave::cleanup ()
 {
+  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
+    req_fixup_pcon_state ();
+
   /* This used to always call fhandler_pty_common::close when we were execing
      but that caused multiple closes of the handles associated with this pty.
      Since close_all_files is not called until after the cygwin process has
@@ -2478,7 +2540,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      /* req_xfer_input is true if "ESC[6n" was sent just for
 		 triggering transfer_input() in master. In this case,
 		 the response sequence should not be written. */
-	      if (!get_ttyp ()->req_xfer_input)
+	      if (get_ttyp ()->req_fixup_pcon_cur_pos)
+		{
+		  int x, y;
+		  sscanf (wpbuf, "\033[%d;%dR", &y, &x);
+		  fixup_pcon_cursor_position (x, y);
+		  get_ttyp ()->req_fixup_pcon_cur_pos = false;
+		}
+	      else if (!get_ttyp ()->req_xfer_input)
 		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
 	      ixput = 0;
 	      state = 0;
@@ -4100,8 +4169,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  ttyp->pcon_activated = false;
 	  ttyp->switch_to_nat_pipe = false;
 	  ttyp->nat_pipe_owner_pid = 0;
-	  ttyp->pcon_start = false;
-	  ttyp->pcon_start_pid = 0;
 	}
       if (ttyp->pcon_handle_ready_event)
 	{
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 322592bf1..2fa30cbce 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2533,6 +2533,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   void setpgid_aux (pid_t pid);
   static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
   void replace_nat_handles (HANDLE new_input, HANDLE new_output);
+  void req_fixup_pcon_state (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
@@ -2639,6 +2640,7 @@ public:
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   bool need_send_ctrl_c_event ();
   void apply_line_edit_to_transferred_input ();
+  void fixup_pcon_cursor_position (int x, int y);
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 507f7772e..c5102eb81 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -145,6 +145,7 @@ private:
   xfer_dir pty_input_state;
   bool discard_input;
   bool stop_fwd_thread;
+  bool req_fixup_pcon_cur_pos;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
-- 
2.51.0

