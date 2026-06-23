Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id CB59E4BA2E27
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 12:29:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB59E4BA2E27
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB59E4BA2E27
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782217792; cv=none;
	b=KvUU9KcejAYWgLq9FUtxecqs9vMQKfcREtHD5jI+LLIzE0ZNE5RvCrkrcTBqMO6J70sZSf2iQdpR8sr/16UOyihxKf2godEGBTHPgRebQhMpGh/8sAE2Em4y0BRq9Utic6JZA4mfe2ls2UosqnA20v3p90AcCT58bquHA+kVavI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782217792; c=relaxed/simple;
	bh=VnGACd5/IJmoAvxZd/OqR99gk6tXlyvMhVVg4O6oJpI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=n4JvcKVjR6m0AZgG9VQZhizraP6d2iFy1aZeYdqeFXrP/iC2kAlRJv5AlPZYqEymHxsTH4+4pnhAZ6xb+HTnw16eQ2xeQZBBY8UXnp3vaO/bIEnu5kOp8UKTlB7U0fE9MBzmSEBlHlmBWqmiDa+Aduo8Ce1pjkbPb3bMsFNw/Qs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oxYrdg9Q
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB59E4BA2E27
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oxYrdg9Q
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260623122949963.UTOJ.44671.HP-Z230@nifty.com>;
          Tue, 23 Jun 2026 21:29:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v6] Cygwin: pty: Fix race issue between starting and exiting non-cygwin apps
Date: Tue, 23 Jun 2026 21:29:31 +0900
Message-ID: <20260623122939.2676206-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782217790;
 bh=BJ1BZlcxvMnKO0J98hZBvYlMJPOabJaps6WEZlTLMY4=;
 h=From:To:Cc:Subject:Date;
 b=oxYrdg9Qo/0Y5HzGSKvdp+xiewPqMhc6ah4aNuQrNNJb9ReyKzBa8VkxEKObuUcYg1AVB18W
 AlZrEoJ1iAzXM1Jf5MqzadfUp6n1ZL0/gbKoRxvg7R68Wd6BfW+Gjg9bYBRipdNP5vreCH7k5T
 EpA3MJPTQf4w/UkYSNlQmADU44ivGEHtboiqps/OKMxYhsGxZehEVng/bYnSWEM85kAE96mEYZ
 P/nyg29SpHxv26ndTLzcH3Yedzz5zIbsttxFt3+JGV/YBuYy28mH2UttxbMTO0SfSRl8VRJujV
 1hJn9xNo6fiq23/aOWWTmCI29xwzzTno59+X0bRHPIfMxsdQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Without this patch, when a non-cygwin program (A) is about to exit, and
another non-cygwin program (B) is started, input transferring between
cyg-pipe and nat-pipe may not work as expected. When the non-cygwin
program (A) exits, input transferring from nat-pipe to cyg-pipe will be
performed. However, the the non-cygwin program (B) will performs input
transferring from cyg-pipe to nat-pipe at the same time. The mechanism
of the problem is as follows.
 1) The the non-cygwin program (A) checks current input pipe state,
    then it is nat-pipe since the this program is a non-cygwin program.
    The program (A) also checks if any handover target exists, but
    it is not found since the program (B) is not started yet. So,
    the program (A) decided to transfer input form nat-pipe to cyg-
    pipe.
 2) Before the non-cygwin (A) program performs input transferring,
    if the non-cygwin program (B) is started and checks the input
    pipe state, it is nat-pipe state, so the non-cygwin program (B)
    does not perform input transferring.
 3) However, just after that, the non-cygwin program (A) performs
    input transferring from nat-pipe to cyg-pipe, so typeahead input
    will be stored in cyg-pipe.
 4) The non-cygwin program (B) cannot read the typeahead input
    because it is now in the cyg-pipe.

The following code demonstrates the issue.
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>

  int main(int argc, char *argv[])
  {
    int n = 1;
    if (argc > 1)
      n = atoi(argv[1]);
    if (fork()) {
      execlp("cmd.exe", "cmd", NULL);
      perror("execlp(\"cmd\"): ");
    }
    for (int i=0; i<n; i++) {
      if (fork() == 0) {
        execlp("./winsleep.exe", "winsleep", "0", NULL);
        perror("execlp(\"winsleep\"): ");
      }
    }
    return 0;
  }

Transferring input itself is guarded by input_mutex, but the pre-
check is not. With this patch, the guard is enhanced so that the
state check and transferring input are done in atomic way.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Mark Geisert <mark@maxrnd.com>
---
 winsup/cygwin/fhandler/pty.cc           | 114 +++++++++++++-----------
 winsup/cygwin/local_includes/fhandler.h |   2 +
 2 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e0fc67ae1..88a8a7a01 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -657,8 +657,7 @@ fhandler_pty_master::accept_input ()
 
   HANDLE write_to = get_output_handle ();
   tmp_pathbuf tp;
-  if (to_be_read_from_nat_pipe ()
-      && get_ttyp ()->pty_input_state == tty::to_nat)
+  if (get_ttyp ()->pty_input_state == tty::to_nat)
     {
       /* This code is reached if non-cygwin app is foreground and
 	 pseudo console is not enabled. */
@@ -1274,18 +1273,18 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	  mutex_timeout = INFINITE;
 	  if (isHybrid)
 	    {
+	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      if (get_ttyp ()->getpgid () == myself->pgid
 		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
 		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
 		{
-		  WaitForSingleObject (input_mutex, mutex_timeout);
 		  acquire_attach_mutex (mutex_timeout);
 		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 				  input_available_event,
 				  input_transferred_to_cyg);
 		  release_attach_mutex ();
-		  ReleaseMutex (input_mutex);
 		}
+	      ReleaseMutex (input_mutex);
 	      if (get_ttyp ()->master_is_running_as_service
 		  && get_ttyp ()->pcon_activated)
 		/* If the master is running as service, re-attaching to
@@ -1452,19 +1451,10 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 bool
 fhandler_pty_common::to_be_read_from_nat_pipe (void)
 {
-  /* If the slave is in setup_pseudoconsole(), pipe_sw_mutex cannot
-     be acquired because the slave has it. In this case pcon_start
-     will be asserted. During pcon_start, other input than response
-     to CSI6n should be go to cyg-pipe. So, wait for pcon_start and
-     return false. */
-  while (WaitForSingleObject (pipe_sw_mutex, 0) == WAIT_TIMEOUT)
-    if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c
-	|| get_ttyp ()->pcon_start_pid)
-      return false;
-    else
-      yield ();
-
   bool ret = false;
+
+  WaitForSingleObject (pipe_sw_mutex, INFINITE);
+
   if (!get_ttyp ()->switch_to_nat_pipe)
     goto out;
 
@@ -2364,6 +2354,22 @@ fhandler_pty_master::close (int flag)
   return 0;
 }
 
+line_edit_status
+fhandler_pty_master::line_edit_maybe (const char *ptr, size_t len,
+				      termios &ti, ssize_t *n)
+{
+  DWORD m;
+  if (get_ttyp ()->req_xfer_input
+      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
+    {
+      WriteFile (to_slave_nat, ptr, len, &m, NULL);
+      *n = (ssize_t) m;
+      return line_edit_ok;
+    }
+  else
+    return line_edit (ptr, len, ti, n);
+}
+
 ssize_t
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
@@ -2383,6 +2389,26 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   int pcon_start_mode =
     get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
+
+  /* This input transfer is needed when cygwin-app which is started from
+     non-cygwin app is terminated while pseudo console is disabled. */
+  if (!get_ttyp ()->pcon_activated && !pcon_start_mode
+      && to_be_read_from_nat_pipe ())
+    {
+      WaitForSingleObject (input_mutex, mutex_timeout);
+      if (get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
+	  && get_ttyp ()->pty_input_state == tty::to_cyg)
+	{
+	  acquire_attach_mutex (mutex_timeout);
+	  fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
+					      get_ttyp (),
+					      input_available_event,
+					      input_transferred_to_cyg);
+	  release_attach_mutex ();
+	}
+      ReleaseMutex (input_mutex);
+    }
+
   if (pcon_start_mode)
     { /* Reaches here when pseudo console initialization is on going. */
       /* Pseudo condole support uses "CSI6n" to get cursor position.
@@ -2404,7 +2430,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	  if (p[i] == '\033')
 	    {
 	      if (ixput)
-		line_edit (wpbuf, ixput, ti, &ret);
+		line_edit_maybe (wpbuf, ixput, ti, &ret);
 	      ixput = 0;
 	      state = 1;
 	      wp_tid = _my_tls.thread_id;
@@ -2422,7 +2448,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 		}
 	    }
 	  else
-	    line_edit (p + i, 1, ti, &ret);
+	    line_edit_maybe (p + i, 1, ti, &ret);
 	  len = orig_len - i - 1;
 	  ptr = p + i + 1;
 	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'R')
@@ -2454,6 +2480,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       if (pcon_start_mode
 	  && !get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
 	{ /* Pseudo console initialization has been done in above code. */
+	  WaitForSingleObject (input_mutex, mutex_timeout);
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
 	  if (get_ttyp ()->switch_to_nat_pipe
 	      && pp && pp->pgid == get_ttyp ()->getpgid ()
@@ -2463,8 +2490,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 		{
 		  HANDLE pcon_handle_ready_event =
 		    get_ttyp ()->pcon_handle_ready_event;
-		  get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
-					   pcon_handle_ready_event);
+		  pcon_handle_ready_event =
+		    get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
+					     pcon_handle_ready_event);
 		  if (pcon_handle_ready_event)
 		    {
 		      cygwait (pcon_handle_ready_event, INFINITE);
@@ -2475,7 +2503,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
 	      /* This accept_input() call is needed in order to transfer input
 		 which is not accepted yet to non-cygwin pipe. */
-	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      if (get_readahead_valid ())
 		accept_input ();
 	      acquire_attach_mutex (mutex_timeout);
@@ -2484,9 +2511,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 						  input_available_event,
 						  input_transferred_to_cyg);
 	      release_attach_mutex ();
-	      ReleaseMutex (input_mutex);
 	    }
 	  get_ttyp ()->req_xfer_input = false;
+	  ReleaseMutex (input_mutex);
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
       if (len == 0)
@@ -2496,7 +2523,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   /* Write terminal input to to_slave_nat pipe instead of output_handle
      if current application is native console application. */
   WaitForSingleObject (input_mutex, mutex_timeout);
-  if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
+  if (get_ttyp ()->pcon_activated
       && get_ttyp ()->pty_input_state == tty::to_nat)
     { /* Reaches here when non-cygwin app is foreground and pseudo console
 	 is activated. */
@@ -2580,20 +2607,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   /* The code path reaches here when pseudo console is not activated
      or cygwin process is foreground even though pseudo console is
      activated. */
-
-  /* This input transfer is needed when cygwin-app which is started from
-     non-cygwin app is terminated if pseudo console is disabled. */
-  if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
-      && get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
-      && get_ttyp ()->pty_input_state == tty::to_cyg)
-    {
-      acquire_attach_mutex (mutex_timeout);
-      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
-					  get_ttyp (), input_available_event,
-					  input_transferred_to_cyg);
-      release_attach_mutex ();
-    }
-
   line_edit_status status = line_edit (p, len, ti, &ret);
   ReleaseMutex (input_mutex);
 
@@ -4537,9 +4550,9 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
 					      const WCHAR *envblock,
 					      bool stdin_is_ptys)
 {
+  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   if (disable_pcon || !term_has_pcon_cap (envblock))
     nopcon = true;
-  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   /* Setting switch_to_nat_pipe is necessary even if pseudo console
      will not be activated. */
   fhandler_base *fh = ::cygheap->fdtab[0];
@@ -4555,16 +4568,16 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
     pcon_enabled = setup_pseudoconsole ();
   ReleaseMutex (pipe_sw_mutex);
   /* For pcon enabled case, transfer_input() is called in master::write() */
+  WaitForSingleObject (input_mutex, mutex_timeout);
   if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
       && stdin_is_ptys && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
-      WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 		      input_available_event, input_transferred_to_cyg);
       release_attach_mutex ();
-      ReleaseMutex (input_mutex);
     }
+  ReleaseMutex (input_mutex);
 }
 
 void
@@ -4573,22 +4586,22 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
+  WaitForSingleObject (p->input_mutex, mutex_timeout);
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
       if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
 	  && ttyp->pty_input_state_eq (tty::to_nat))
 	{
-	  WaitForSingleObject (p->input_mutex, mutex_timeout);
 	  acquire_attach_mutex (mutex_timeout);
 	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
 			  p->input_available_event,
 			  p->input_transferred_to_cyg);
 	  release_attach_mutex ();
-	  ReleaseMutex (p->input_mutex);
 	}
     }
-  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
+  ReleaseMutex (p->input_mutex);
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
@@ -4602,27 +4615,23 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   reset_switch_to_nat_pipe ();
 
   WaitForSingleObject (pipe_sw_mutex, INFINITE);
+  WaitForSingleObject (input_mutex, mutex_timeout);
   bool was_nat_fg = get_ttyp ()->nat_fg (tc ()->pgid);
   bool nat_fg = get_ttyp ()->nat_fg (pid);
   if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
       && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
-      ReleaseMutex (pipe_sw_mutex);
-      WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 		      input_available_event, input_transferred_to_cyg);
       release_attach_mutex ();
-      ReleaseMutex (input_mutex);
     }
   else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
 	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
     {
-      ReleaseMutex (pipe_sw_mutex);
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
       DWORD resume_pid = 0;
-      WaitForSingleObject (input_mutex, mutex_timeout);
       if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
 	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
 	{
@@ -4640,10 +4649,9 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	resume_from_temporarily_attach (resume_pid);
       else
 	release_attach_mutex ();
-      ReleaseMutex (input_mutex);
     }
-  else
-    ReleaseMutex (pipe_sw_mutex);
+  ReleaseMutex (input_mutex);
+  ReleaseMutex (pipe_sw_mutex);
 }
 
 bool
@@ -4653,8 +4661,8 @@ fhandler_pty_master::need_send_ctrl_c_event ()
      apps will be done in pseudo console, therefore, sending it in
      fhandler_pty_master::write() duplicates that event for non-cygwin
      apps. So return false if pseudo console is activated. */
-  return !(to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
-    && get_ttyp ()->pty_input_state == tty::to_nat);
+  return !(get_ttyp ()->pcon_activated
+	   && get_ttyp ()->pty_input_state == tty::to_nat);
 }
 
 void
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 4f5605524..209b5601e 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2637,6 +2637,8 @@ public:
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   bool need_send_ctrl_c_event ();
   void apply_line_edit_to_transferred_input ();
+  line_edit_status line_edit_maybe (const char *p, size_t len, termios&,
+				    ssize_t *n);
 };
 
 class fhandler_dev_null: public fhandler_base
-- 
2.51.0

