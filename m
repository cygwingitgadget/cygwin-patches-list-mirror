Return-Path: <SRS0=9siz=EI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 190FB4BA2E07
	for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 04:17:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 190FB4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 190FB4BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781237834; cv=none;
	b=e9H5gweBWcYmwzLlF/xfY2pDG5Ry6kAWqWRr+ELYYoHg070N0H9nnLLcplHydwAYzsJJQS2dtuR10Mk3Rdu8poKM3w7jDvr+6k96Ef/+R6UmX9FCzDTFSPI2YQqVYt4fpu9hRTGLj4CmJNztN69MOKRcm6Mku9hhbZxxOZl5apU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781237834; c=relaxed/simple;
	bh=0Sj0WCGgUJ8LooEj/fnx/3PPDtw21+PdeYXHxKYRk3A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=lx/Pvb15zEarloGQeIWR4SIr+oDTTZPVKRZN7nkE32xCCcEaPNrmTNOjrLV+bo3l76sDk9rPbsq0irX1eLMptA0pIAZt0Qzex//ojtApZxe55lXimhqyvsgz+/r3EW1v3LuTr0MyA6/ZTu8n8ygA7Hp4rtlexlDFV3S+7+3jFCI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Hord0Egs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 190FB4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Hord0Egs
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260612041709440.YUWC.17441.HP-Z230@nifty.com>;
          Fri, 12 Jun 2026 13:17:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4] Cygwin: pty: Fix race issue between starting and exiting non-cygwin apps
Date: Fri, 12 Jun 2026 13:16:55 +0900
Message-ID: <20260612041703.172932-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781237829;
 bh=0fvMeyalxn1CQJ2jlkfJWZIv02QDp42lovjdO+2P+Hk=;
 h=From:To:Cc:Subject:Date;
 b=Hord0EgscOV72G3+DtJqRe3le+VZdkQ32qcUP0EJJ+0fEKguKECjl6woAobkjjJ0y6r9UHzF
 Z9jaSjgVkcggJnw9JarAm8fEQcjDYm5H4r1vMkwzMXn6unjUCqI8bc3+AFjXaBFxt7P6dy4LW3
 fS4UUkAu9+c/ilyV3SHBf2wzgTGgO/ZvEHa2Ob7ImlDGnD8MEYp6BcpIVkatpxafK6v31h4w7S
 W5eRRREF144UVjzPNsxdDpmcSfxmShBhrx7hvRTCeSaB88jniDHmvELJnSim+j/s9HKepj9zh4
 AD5w5ypPRnOxxHoEcp790ocpTujLhs9eVMnoP2+ftjHpLZlw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
v4: Don't call to_be_read_from_nat_pipe() while holding input_mutex
    (This simplifies the to_be_read_from_nat_pipe())

 winsup/cygwin/fhandler/pty.cc | 89 ++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index a8557bf3c..ef79ea679 100644
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
 
@@ -2383,6 +2373,26 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   int pcon_start_mode =
     get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
+
+  /* This input transfer is needed when cygwin-app which is started from
+     non-cygwin app is terminated if pseudo console is disabled. */
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
@@ -2455,6 +2465,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       if (pcon_start_mode
 	  && !get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
 	{ /* Pseudo console initialization has been done in above code. */
+	  WaitForSingleObject (input_mutex, mutex_timeout);
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
 	  if (get_ttyp ()->switch_to_nat_pipe
 	      && pp && pp->pgid == get_ttyp ()->getpgid ()
@@ -2472,7 +2483,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
 	      /* This accept_input() call is needed in order to transfer input
 		 which is not accepted yet to non-cygwin pipe. */
-	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      if (get_readahead_valid ())
 		accept_input ();
 	      acquire_attach_mutex (mutex_timeout);
@@ -2481,8 +2491,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 						  input_available_event,
 						  input_transferred_to_cyg);
 	      release_attach_mutex ();
-	      ReleaseMutex (input_mutex);
 	    }
+	  ReleaseMutex (input_mutex);
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
       if (len == 0)
@@ -2492,7 +2502,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   /* Write terminal input to to_slave_nat pipe instead of output_handle
      if current application is native console application. */
   WaitForSingleObject (input_mutex, mutex_timeout);
-  if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
+  if (get_ttyp ()->pcon_activated
       && get_ttyp ()->pty_input_state == tty::to_nat)
     { /* Reaches here when non-cygwin app is foreground and pseudo console
 	 is activated. */
@@ -2576,20 +2586,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
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
 
@@ -4533,9 +4529,9 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
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
@@ -4551,16 +4547,16 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
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
@@ -4569,22 +4565,22 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
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
@@ -4598,27 +4594,23 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
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
@@ -4636,10 +4628,9 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
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
@@ -4649,8 +4640,8 @@ fhandler_pty_master::need_send_ctrl_c_event ()
      apps will be done in pseudo console, therefore, sending it in
      fhandler_pty_master::write() duplicates that event for non-cygwin
      apps. So return false if pseudo console is activated. */
-  return !(to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
-    && get_ttyp ()->pty_input_state == tty::to_nat);
+  return !(get_ttyp ()->pcon_activated
+	   && get_ttyp ()->pty_input_state == tty::to_nat);
 }
 
 void
-- 
2.51.0

