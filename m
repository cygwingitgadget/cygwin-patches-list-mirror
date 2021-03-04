Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 8E126384803A
 for <cygwin-patches@cygwin.com>; Thu,  4 Mar 2021 08:58:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8E126384803A
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1248vUHk028640;
 Thu, 4 Mar 2021 17:57:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1248vUHk028640
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix restoring console mode failure.
Date: Thu,  4 Mar 2021 17:57:34 +0900
Message-Id: <20210304085734.1707-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 04 Mar 2021 08:58:14 -0000

- Restoring console mode fails in the following scenario.
   1) Start cygwin shell in command prompt.
   2) Run 'exec chcp.com'.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler.h |  1 +
 winsup/cygwin/spawn.cc   | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index ad90cf33d..9b85d1ee9 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2251,6 +2251,7 @@ private:
 			       const handle_set_t *p);
 
   static void cons_master_thread (handle_set_t *p, tty *ttyp);
+  pid_t get_owner (void) { return shared_console_info->con.owner; }
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 323630fcb..490675859 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -608,6 +608,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       fhandler_pty_slave *ptys_primary = NULL;
       fhandler_console *cons_native = NULL;
       termios *cons_ti = NULL;
+      pid_t cons_owner = 0;
       for (int i = 0; i < 3; i ++)
 	{
 	  const int chk_order[] = {1, 0, 2};
@@ -628,6 +629,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		    {
 		      cons_native = cons;
 		      cons_ti = &((tty *)cons->tc ())->ti;
+		      cons_owner = cons->get_owner ();
 		    }
 		  if (fd == 0)
 		    fhandler_console::set_input_mode (tty::native,
@@ -1000,9 +1002,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  if (cons_native)
 	    {
-	      fhandler_console::set_output_mode (tty::cygwin, cons_ti,
+	      tty::cons_mode mode =
+		cons_owner == myself->pid ? tty::restore : tty::cygwin;
+	      fhandler_console::set_output_mode (mode, cons_ti,
 						 &cons_handle_set);
-	      fhandler_console::set_input_mode (tty::cygwin, cons_ti,
+	      fhandler_console::set_input_mode (mode, cons_ti,
 						&cons_handle_set);
 	      fhandler_console::close_handle_set (&cons_handle_set);
 	    }
@@ -1035,9 +1039,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  if (cons_native)
 	    {
-	      fhandler_console::set_output_mode (tty::cygwin, cons_ti,
+	      tty::cons_mode mode =
+		cons_owner == myself->pid ? tty::restore : tty::cygwin;
+	      fhandler_console::set_output_mode (mode, cons_ti,
 						 &cons_handle_set);
-	      fhandler_console::set_input_mode (tty::cygwin, cons_ti,
+	      fhandler_console::set_input_mode (mode, cons_ti,
 						&cons_handle_set);
 	      fhandler_console::close_handle_set (&cons_handle_set);
 	    }
-- 
2.30.1

