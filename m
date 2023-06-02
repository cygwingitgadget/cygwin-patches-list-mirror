Return-Path: <SRS0=VaJW=BW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0015.nifty.com (mta-snd00007.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 38E423858C50
	for <cygwin-patches@cygwin.com>; Fri,  2 Jun 2023 01:30:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 38E423858C50
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0015.nifty.com with ESMTP
          id <20230602013033027.RSMQ.104591.localhost.localdomain@nifty.com>;
          Fri, 2 Jun 2023 10:30:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Additional fix for transferring input at exit.
Date: Fri,  2 Jun 2023 10:30:20 +0900
Message-Id: <20230602013020.1938-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 9fc746d17dc3 does not fix transferring input at exit
appropriately. If the more than one non-cygwin apps are executed
simultaneously and one of them is terminated, the pty master failed
to send input to the other non-cygwin apps. This patch fixes that.

Fixes: 9fc746d17dc3 ("Cygwin: pty: Fix transferring type-ahead input between input pipes.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 207f37463..1f2b634a0 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4075,7 +4075,14 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
-  if ((ttyp->pcon_activated || stdin_is_ptys)
+  DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
+  DWORD switch_to = force_switch_to;
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
+  if (!switch_to)
+    switch_to = get_console_process_id (current_pid, false, true, true);
+  if (!switch_to)
+    switch_to = get_console_process_id (current_pid, false, true, false);
+  if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
       && ttyp->pty_input_state_eq (tty::to_nat))
     {
       WaitForSingleObject (p->input_mutex, mutex_timeout);
@@ -4085,7 +4092,6 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
       release_attach_mutex ();
       ReleaseMutex (p->input_mutex);
     }
-  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
-- 
2.39.0

