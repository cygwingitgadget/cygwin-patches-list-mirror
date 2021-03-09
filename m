Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 643AB3857832
 for <cygwin-patches@cygwin.com>; Tue,  9 Mar 2021 03:23:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 643AB3857832
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 1293NYSG003126;
 Tue, 9 Mar 2021 12:23:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 1293NYSG003126
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Transfer input only if the stdin is a pty.
Date: Tue,  9 Mar 2021 12:23:34 +0900
Message-Id: <20210309032334.1197-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 09 Mar 2021 03:23:57 -0000

- The commit 12325677f73a did not fix enough. With this patch, more
  transfer_input() calls are skipped if stdin is redirected or piped.
---
 winsup/cygwin/fhandler_tty.cc | 10 ++++++++--
 winsup/cygwin/spawn.cc        |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 47d59e8c5..643a357ad 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -131,7 +131,9 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
 	{
 	  fhandler_base *fh = cfd;
 	  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	  if (*in == ptys->get_handle ())
+	  if (*in == ptys->get_handle ()
+	      || *out == ptys->get_output_handle ()
+	      || *err == ptys->get_output_handle ())
 	    ptys_pcon = ptys;
 	}
     }
@@ -284,6 +286,7 @@ exit_Hooked (int e)
 	    HANDLE from = ptys->get_handle ();
 	    HANDLE input_available_event = ptys->get_input_available_event ();
 	    if (ttyp->getpgid () == myself->pgid
+		&& GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ()
 		&& ttyp->pcon_input_state_eq (tty::to_nat))
 	      {
 		WaitForSingleObject (ptys->input_mutex, INFINITE);
@@ -1035,6 +1038,7 @@ fhandler_pty_slave::set_switch_to_pcon (void)
       bool pcon_enabled = setup_pseudoconsole (nopcon);
       ReleaseMutex (pcon_mutex);
       if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
+	  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
 	  && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
 	{
 	  WaitForSingleObject (input_mutex, INFINITE);
@@ -1062,6 +1066,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	  if (isHybrid)
 	    {
 	      if (get_ttyp ()->getpgid () == myself->pgid
+		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
 		  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 		{
 		  WaitForSingleObject (input_mutex, INFINITE);
@@ -1204,7 +1209,8 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
   /* In GDB, transfer input based on setpgid() does not work because
      GDB may not set terminal process group properly. Therefore,
      transfer input here if isHybrid is set. */
-  if (isHybrid && !!masked != mask && xfer)
+  if (isHybrid && !!masked != mask && xfer
+      && GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
     {
       if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 	{
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 9d70cb2b7..7a585392a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -665,6 +665,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       HANDLE ptys_pcon_mutex = NULL;
       HANDLE ptys_input_mutex = NULL;
       tty *ptys_ttyp = NULL;
+      bool stdin_is_ptys = false;
       if (!iscygwin () && ptys_primary && is_console_app (runpath))
 	{
 	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
@@ -675,6 +676,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (ptys_primary->setup_pseudoconsole (nopcon))
 	    enable_pcon = true;
 	  ReleaseMutex (ptys_primary->pcon_mutex);
+	  HANDLE h_stdin = handle ((in__stdin < 0 ? 0 : in__stdin), false);
+	  if (h_stdin == ptys_primary->get_handle ())
+	    stdin_is_ptys = true;
 	  ptys_from_master = ptys_primary->get_handle ();
 	  DuplicateHandle (GetCurrentProcess (), ptys_from_master,
 			   GetCurrentProcess (), &ptys_from_master,
@@ -691,6 +695,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			   GetCurrentProcess (), &ptys_input_mutex,
 			   0, 0, DUPLICATE_SAME_ACCESS);
 	  if (!enable_pcon && ptys_ttyp->getpgid () == myself->pgid
+	      && stdin_is_ptys
 	      && ptys_ttyp->pcon_input_state_eq (tty::to_cyg))
 	    {
 	      WaitForSingleObject (ptys_input_mutex, INFINITE);
@@ -983,7 +988,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (ptys_ttyp)
 	    {
 	      ptys_ttyp->wait_pcon_fwd ();
-	      if (ptys_ttyp->getpgid () == myself->pgid
+	      if (ptys_ttyp->getpgid () == myself->pgid && stdin_is_ptys
 		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
 		{
 		  WaitForSingleObject (ptys_input_mutex, INFINITE);
@@ -1020,7 +1025,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (ptys_ttyp)
 	    {
 	      ptys_ttyp->wait_pcon_fwd ();
-	      if (ptys_ttyp->getpgid () == myself->pgid
+	      if (ptys_ttyp->getpgid () == myself->pgid && stdin_is_ptys
 		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
 		{
 		  WaitForSingleObject (ptys_input_mutex, INFINITE);
-- 
2.30.1

