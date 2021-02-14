Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 936FD3858024
 for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2021 09:43:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 936FD3858024
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 11E9gxTY026697;
 Sun, 14 Feb 2021 18:43:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 11E9gxTY026697
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: console: Abort read() on signal if SA_RESTART is
 not set.
Date: Sun, 14 Feb 2021 18:42:50 +0900
Message-Id: <20210214094250.1245-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 14 Feb 2021 09:43:36 -0000

- Currently, console read() keeps reading after SIGWINCH is sent
  even if SA_RESTART flag is not set. With this patch, read()
  returns EINTR on SIGWINCH if SA_RESTART flag is not set.
  The same problem for SIGQUIT and SIGTSTP has also been fixed.
---
 winsup/cygwin/fhandler_console.cc | 7 +++----
 winsup/cygwin/fhandler_termios.cc | 1 +
 winsup/cygwin/tty.cc              | 1 +
 winsup/cygwin/tty.h               | 1 +
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 3c0783575..78af6cf2b 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -586,12 +586,11 @@ wait_retry:
 	case input_ok: /* input ready */
 	  break;
 	case input_signalled: /* signalled */
-	  release_input_mutex ();
-	  /* The signal will be handled by cygwait() above. */
-	  continue;
 	case input_winch:
 	  release_input_mutex ();
-	  continue;
+	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
+	    continue;
+	  goto sig_exit;
 	default:
 	  /* Should not come here */
 	  release_input_mutex ();
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 9fbace95c..e8daf946b 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -133,6 +133,7 @@ tty_min::kill_pgrp (int sig)
   siginfo_t si = {0};
   si.si_signo = sig;
   si.si_code = SI_KERNEL;
+  last_sig = sig;
 
   for (unsigned i = 0; i < pids.npids; i++)
     {
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 41f81f694..7627cd6c7 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -251,6 +251,7 @@ tty::init ()
   master_is_running_as_service = false;
   req_xfer_input = false;
   pcon_input_state = to_cyg;
+  last_sig = 0;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index e1de7ab46..a8ddd68d6 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -48,6 +48,7 @@ public:
   fh_devices ntty;
   ULONGLONG last_ctrl_c;	/* tick count of last ctrl-c */
   bool is_console;
+  int last_sig;
 
   IMPLEMENT_STATUS_FLAG (bool, initialized)
   IMPLEMENT_STATUS_FLAG (bool, rstcons)
-- 
2.30.0

