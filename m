Return-Path: <SRS0=Yn/K=BV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1019.nifty.com (mta-snd01003.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 3B1963858421
	for <cygwin-patches@cygwin.com>; Thu,  1 Jun 2023 11:07:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3B1963858421
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1019.nifty.com with ESMTP
          id <20230601110729024.TUUP.25661.localhost.localdomain@nifty.com>;
          Thu, 1 Jun 2023 20:07:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix transferring type-ahead input between input pipes.
Date: Thu,  1 Jun 2023 20:07:04 +0900
Message-Id: <20230601110704.242-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit e5fcc5837c95, transferring type-ahead input between
the pipe for cygwin app and the pipe for non-cygwin app will not be
done appropriately when the stdin of the non-cygwin app is not pty.
Due to this issue, sometimes the keyboard input might be lost which
should be sent to cygwin app. This patch fixes the issue.

Fixes: e5fcc5837c95 ("Cygwin: pty: Fix reading CONIN$ when stdin is not a pty.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 03c859172..207f37463 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1297,17 +1297,7 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
   else if (InterlockedDecrement (&num_reader) == 0)
     CloseHandle (slave_reading);
 
-  /* This is needed when cygwin-app is started from non-cygwin app if
-     pseudo console is disabled. */
-  bool need_xfer = get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
-    && get_ttyp ()->switch_to_nat_pipe && !get_ttyp ()->pcon_activated;
-
-  /* In GDB, transfer input based on setpgid() does not work because
-     GDB may not set terminal process group properly. Therefore,
-     transfer input here if isHybrid is set. */
-  bool need_gdb_xfer =
-    isHybrid && GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
-  if (!!masked != mask && xfer && (need_gdb_xfer || need_xfer))
+  if (!!masked != mask && xfer && get_ttyp ()->switch_to_nat_pipe)
     {
       if (mask && get_ttyp ()->pty_input_state_eq (tty::to_nat))
 	{
@@ -2238,11 +2228,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       if (!get_ttyp ()->pcon_start)
 	{ /* Pseudo console initialization has been done in above code. */
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
-	  bool pcon_fg = (pp && get_ttyp ()->getpgid () == pp->pgid);
-	  /* GDB may set WINPID rather than cygwin PID to process group
-	     when the debugged process is a non-cygwin process.*/
-	  pcon_fg |= !pinfo (get_ttyp ()->getpgid ());
-	  if (get_ttyp ()->switch_to_nat_pipe && pcon_fg
+	  if (get_ttyp ()->switch_to_nat_pipe
 	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
 	    {
 	      /* This accept_input() call is needed in order to transfer input
@@ -4089,7 +4075,7 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
-  if (ttyp->getpgid () == myself->pgid && stdin_is_ptys
+  if ((ttyp->pcon_activated || stdin_is_ptys)
       && ttyp->pty_input_state_eq (tty::to_nat))
     {
       WaitForSingleObject (p->input_mutex, mutex_timeout);
-- 
2.39.0

