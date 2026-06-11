Return-Path: <SRS0=e8Pc=EH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 16B914BA543C
	for <cygwin-patches@cygwin.com>; Thu, 11 Jun 2026 11:27:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 16B914BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 16B914BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781177265; cv=none;
	b=AJKWXCtAAGVvnjqerSxIMkBH//zir8kIRr6bDEaarKhYCcytON6/4hJIlqm9LbWX8RxTxSfTXfFwAMDc3aWd66it5qfTIFERL9CFYA98Z0XvLdGAjtms/PuD4K0qkV5e/TY3+YByMEPBtqTJAtj2BmlR6BOEN0ko8NqS6nCQwqs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781177265; c=relaxed/simple;
	bh=j2jgjrqC/zjstNDHy2bPwS5e4T/S0HjnM/g1Oarx2IQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jw6rfQxgU/2wXqG+dvY+S14e6fNe307O459iGMnJK+ZDQZF6Mf/8m8zM9bWqS0gOdxYZmgHMjGMadAW6UCqKV9QVnEcvBhpQok6v6I9lbSfy9y7e/+qPVcijj6vAHrDHTgSbeh7F9e6Ax/VsNpkB5IuwL//w5Iseg6/OBfXg99k=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nAYRANHE
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 16B914BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nAYRANHE
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260611112742240.OHJY.17441.HP-Z230@nifty.com>;
          Thu, 11 Jun 2026 20:27:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3] Cygwin: pty: Fix race issue between starting and exiting non-cygwin apps
Date: Thu, 11 Jun 2026 20:27:26 +0900
Message-ID: <20260611112736.5574-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781177262;
 bh=UY7e4awsStqnGC/fANnNlpBX7XQUHGLkNukHqJxf1zM=;
 h=From:To:Cc:Subject:Date;
 b=nAYRANHEt/k/32lbIenRv4532uGH8rQw0NKH5Xm3EQbVJzN7UJzWrFbj4gRldxfVa9XO8mNd
 8FH3nJbiuqtMdBVLyuHqNKqfw9ktKHDzqGktwEspvXp/KHhnLHrsfcxV5Nd4TCkKvx0yDsKgFc
 /k3R1wBsX55+i7UKcZDXFpkEiWPLsjm41Q53GkBBXmLSdbg36biOtEebqU9IeNwJOA5T14uZvz
 pK6qyU0TLfpeY5UOKfXjpebDrGWKjXMDPm1kiRA7e4HkRylR1pIC3KVe+8kskRrIdaxIFq4TFV
 cW9hKkkpt/XiN+wY9q6VmG77TZBLuwcre0ZWHZERp6GUjzhw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, when a non-cygwin program (A) is about to exit, and another
non-cygwin program (B) is started, input transferring between cyg-pipe
and nan-pipe may not work as expected. When the non-cygwin program (A)
exits, input transferring from nat-pipe to cyg-pipe will be performed.
However, the the non-cygwin program (B) will performs input transferring
from cyg-pipe to nat-pipe at the same time.
 1) The the non-cygwin program (A) checks current input pipe state,
    then it is nat-pip since the this program is a non-cygwin program.
    The program (A) also checkes if any handover target exists, but
    it is not found since the probram (B) is not started yet. So,
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
Transferring input itself is guarded by input_mutex, but the pre-
check is not. With this patch, the guard is enhanced so that the
state check and tranferring input are done in atomic way.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
v2: Guard term_has_pcon_cap() as well
v3: Acquire pipe_sw_mutex first before acquiring input_mutex

 winsup/cygwin/fhandler/pty.cc | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index a8557bf3c..031ea696a 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1274,18 +1274,18 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
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
@@ -1459,7 +1459,8 @@ fhandler_pty_common::to_be_read_from_nat_pipe (void)
      return false. */
   while (WaitForSingleObject (pipe_sw_mutex, 0) == WAIT_TIMEOUT)
     if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c
-	|| get_ttyp ()->pcon_start_pid)
+	|| get_ttyp ()->pcon_start_pid
+	|| IsEventSignalled (input_transferred_to_cyg))
       return false;
     else
       yield ();
@@ -2455,6 +2456,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       if (pcon_start_mode
 	  && !get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
 	{ /* Pseudo console initialization has been done in above code. */
+	  WaitForSingleObject (input_mutex, mutex_timeout);
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
 	  if (get_ttyp ()->switch_to_nat_pipe
 	      && pp && pp->pgid == get_ttyp ()->getpgid ()
@@ -2472,7 +2474,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
 	      /* This accept_input() call is needed in order to transfer input
 		 which is not accepted yet to non-cygwin pipe. */
-	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      if (get_readahead_valid ())
 		accept_input ();
 	      acquire_attach_mutex (mutex_timeout);
@@ -2481,8 +2482,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 						  input_available_event,
 						  input_transferred_to_cyg);
 	      release_attach_mutex ();
-	      ReleaseMutex (input_mutex);
 	    }
+	  ReleaseMutex (input_mutex);
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
       if (len == 0)
@@ -4533,9 +4534,9 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
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
@@ -4551,16 +4552,16 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
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
@@ -4569,26 +4570,26 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
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
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
     hand_over_only (ttyp, force_switch_to);
+  ReleaseMutex (p->input_mutex);
   ReleaseMutex (p->pipe_sw_mutex);
 }
 
@@ -4598,27 +4599,23 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
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
@@ -4636,10 +4633,9 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
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
-- 
2.51.0

