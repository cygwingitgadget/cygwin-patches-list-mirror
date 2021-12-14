Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 94C523858410
 for <cygwin-patches@cygwin.com>; Tue, 14 Dec 2021 03:29:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 94C523858410
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (v050141.dynamic.ppp.asahi-net.or.jp
 [124.155.50.141]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 1BE3TEGd019039;
 Tue, 14 Dec 2021 12:29:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 1BE3TEGd019039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639452560;
 bh=6MuGh0ySQzQlyPHHhLSnVJG73CSmodyLvipFef4kT58=;
 h=From:To:Cc:Subject:Date:From;
 b=PvO2P6A/krYOmbpL3LGsSXV6u5CRrkfAIt/Ol3d/5l4KUdvjECrMAPNyVjGIH7WJm
 2iwrguOC1+MfrmQZY+6FI6jIZme7ZTLFRO4e5ST2lpag48Hns5dXSxKH0y7gcNvFV+
 zztMoVTIqtF9v4X1Q/WJjTLFXQtPNy15BUqSLvNFzxfSRSNcAIy9ikpbeU23ZTRCas
 ytyLWjSP1KZr4wm56eCMn30UG5And1hGPkHU0yAhvB6cmBfcme0vAx9mi49m1zuN9L
 IkVpMkUEBfOUP1/6ESDcQVBcGuuWkkICAag+lACdSg6RzjOfqqlMlvmTU0d2g4kvg2
 Ejl+KRhrR44Bw==
X-Nifty-SrcIP: [124.155.50.141]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix conditions for input transfer.
Date: Tue, 14 Dec 2021 12:29:13 +0900
Message-Id: <20211214032913.321-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 14 Dec 2021 03:29:37 -0000

- The recent commit "Cygwin: pty: Add missing input transfer when
  switch_to_pcon_in state." causes regression that rlwrap cannot
  work with cmd.exe. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h      |  2 +-
 winsup/cygwin/fhandler_tty.cc | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c838d15a2..4f70c4c0b 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2279,6 +2279,7 @@ class fhandler_pty_common: public fhandler_termios
   static DWORD get_console_process_id (DWORD pid, bool match,
 				       bool cygwin = false,
 				       bool stub_only = false);
+  bool to_be_read_from_pcon (void);
 
  protected:
   static BOOL process_opost_output (HANDLE h, const void *ptr, ssize_t& len,
@@ -2445,7 +2446,6 @@ public:
     fh->copy_from (this);
     return fh;
   }
-  bool to_be_read_from_pcon (void);
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   void set_mask_flusho (bool m) { get_ttyp ()->mask_flusho = m; }
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5ec5b235d..5e76b51c5 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1176,21 +1176,12 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     return;
   if (get_ttyp ()->pcon_start)
     return;
-  /* This input transfer is needed if non-cygwin app is terminated
-     by Ctrl-C or killed. */
-  WaitForSingleObject (input_mutex, INFINITE);
-  if (!get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ())
-      && get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated
-      && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
-    transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-		    input_available_event);
-  ReleaseMutex (input_mutex);
   WaitForSingleObject (pcon_mutex, INFINITE);
   if (!pcon_pid_self (get_ttyp ()->pcon_pid)
       && pcon_pid_alive (get_ttyp ()->pcon_pid))
     {
       /* There is a process which is grabbing pseudo console. */
-      if (get_ttyp ()->pcon_activated
+      if (!to_be_read_from_pcon () && get_ttyp ()->pcon_activated
 	  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 	{
 	  HANDLE pcon_owner =
@@ -1226,6 +1217,14 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       ReleaseMutex (pcon_mutex);
       return;
     }
+  /* This input transfer is needed if non-cygwin app is terminated
+     by Ctrl-C or killed. */
+  WaitForSingleObject (input_mutex, INFINITE);
+  if (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+    transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+		    input_available_event);
+  ReleaseMutex (input_mutex);
   get_ttyp ()->pcon_input_state = tty::to_cyg;
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
@@ -1288,14 +1287,15 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
 
   /* This is needed when cygwin-app is started from non-cygwin app if
      pseudo console is disabled. */
-  bool need_xfer = get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ()) && mask
-    && get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
+  bool need_xfer =
+    get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
 
   /* In GDB, transfer input based on setpgid() does not work because
      GDB may not set terminal process group properly. Therefore,
      transfer input here if isHybrid is set. */
-  if ((isHybrid || need_xfer) && !!masked != mask && xfer
-      && GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
+  bool need_gdb_xfer =
+    isHybrid && GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
+  if (!!masked != mask && xfer && (need_gdb_xfer || need_xfer))
     {
       if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 	transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
@@ -1308,7 +1308,7 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
 }
 
 bool
-fhandler_pty_master::to_be_read_from_pcon (void)
+fhandler_pty_common::to_be_read_from_pcon (void)
 {
   if (!get_ttyp ()->switch_to_pcon_in)
     return false;
-- 
2.34.1

