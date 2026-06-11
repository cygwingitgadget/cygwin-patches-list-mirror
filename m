Return-Path: <SRS0=e8Pc=EH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 833B94BA2E13
	for <cygwin-patches@cygwin.com>; Thu, 11 Jun 2026 07:35:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 833B94BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 833B94BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781163357; cv=none;
	b=crSZLcdCm0pRIYRB/q8RTrzKDbKr8aWZ9+2ocbgHvvG+MDnVNqT+61o8RYPAbQ/q+8QroEowJ/cjnh7stV31yHkx4nfGGDb2szDNwHxswJpQ/mxKfQJ3mSvO6v7BDikEJE1yinyAZulpKt85lNyzohmWmyeupSWbdvrI/GUy4Cw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781163357; c=relaxed/simple;
	bh=q+yYoe6fVLNPPQprDdpH99tUwK4KZIwNOtsqUc70ITY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qZbyGNYKPVkKbGFYw/jyRc0MVfwW+KUcoitqs6lupYeQOhRsmmE+RKA6x1+ciFfb1TgiS3oFvkfZH/7B0kbrTqECvOuyCsndsGIxKNxdLrFhWqDlveYHQx9uzY23b96obnTv675MA+HjlpdBcnyKOxWaE3BjJzeHhGvD7/9tgYs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QOAfG+Xh
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 833B94BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QOAfG+Xh
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260611073550962.JUFW.44671.HP-Z230@nifty.com>;
          Thu, 11 Jun 2026 16:35:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Fix race issue between starting and exiting non-cygwin apps
Date: Thu, 11 Jun 2026 16:35:36 +0900
Message-ID: <20260611073545.1197-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781163351;
 bh=d9pLiZRrgg9t25aemlu/n3D27FADFIZza78/voJrK5g=;
 h=From:To:Cc:Subject:Date;
 b=QOAfG+XhW1H1yI8eU48axOl0jwFEzUL9bCfBIovgcvRlvrdapPtX/AvkajxMUXNLcvUhmZN1
 LNirFfHv1fS8duJPxAqDviDwNXD8bsbdHzWnlt5sfwt5Lh3aSOlAAcVhrDEBi5SkNs8GEzvHGh
 UR8fSdcSbG0D5T7/bqmdxhSeUdv8TyI1+2DvbRJwgvjDIi4FLYEwMLC1TJxB5Zg96IYwa6dOrp
 sLvPQVGI16A3tN5tDZz7cftRluNrIJsm1/Y7hGmod90hE6qtc/wqTyb0AZZ4uOcNgdt0EksFN7
 DIIkE6jWtUC8gsMP9zs48EaNLaRkpyoloJEpprMaDyxmwaOQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

 winsup/cygwin/fhandler/pty.cc | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index a8557bf3c..baba1046f 100644
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
@@ -4569,27 +4570,27 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
+  WaitForSingleObject (p->input_mutex, mutex_timeout);
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
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
   ReleaseMutex (p->pipe_sw_mutex);
+  ReleaseMutex (p->input_mutex);
 }
 
 void
@@ -4597,6 +4598,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 {
   reset_switch_to_nat_pipe ();
 
+  WaitForSingleObject (input_mutex, mutex_timeout);
   WaitForSingleObject (pipe_sw_mutex, INFINITE);
   bool was_nat_fg = get_ttyp ()->nat_fg (tc ()->pgid);
   bool nat_fg = get_ttyp ()->nat_fg (pid);
@@ -4604,12 +4606,10 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
       && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
       ReleaseMutex (pipe_sw_mutex);
-      WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 		      input_available_event, input_transferred_to_cyg);
       release_attach_mutex ();
-      ReleaseMutex (input_mutex);
     }
   else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
 	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
@@ -4618,7 +4618,6 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
       DWORD resume_pid = 0;
-      WaitForSingleObject (input_mutex, mutex_timeout);
       if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
 	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
 	{
@@ -4636,10 +4635,10 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	resume_from_temporarily_attach (resume_pid);
       else
 	release_attach_mutex ();
-      ReleaseMutex (input_mutex);
     }
   else
     ReleaseMutex (pipe_sw_mutex);
+  ReleaseMutex (input_mutex);
 }
 
 bool
-- 
2.51.0

