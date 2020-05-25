Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id D61E13858D35
 for <cygwin-patches@cygwin.com>; Mon, 25 May 2020 08:49:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D61E13858D35
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 04P8nAKm023371;
 Mon, 25 May 2020 17:49:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 04P8nAKm023371
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Stop counting number of slaves attached to
 pseudo console.
Date: Mon, 25 May 2020 17:49:08 +0900
Message-Id: <20200525084908.980-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 25 May 2020 08:49:35 -0000

- The number of slaves attached to pseudo console is used only for
  triggering redraw screen. Counting was not only needless, but also
  did not work as expected. This patch removes the code for counting.
---
 winsup/cygwin/fhandler_tty.cc | 22 +++++-----------------
 winsup/cygwin/tty.cc          |  3 +--
 winsup/cygwin/tty.h           |  1 -
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5faf896e4..df08dd20a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1019,8 +1019,6 @@ fhandler_pty_slave::close ()
   fhandler_pty_common::close ();
   if (!ForceCloseHandle (output_mutex))
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
-  if (pcon_attached_to == get_minor ())
-    get_ttyp ()->num_pcon_attached_slaves --;
   return 0;
 }
 
@@ -2924,21 +2922,11 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
     {
       if (fhandler_console::get_console_process_id (get_helper_process_id (),
 						    true))
-	{
-	  if (pcon_attached_to != get_minor ())
-	    {
-	      pcon_attached_to = get_minor ();
-	      init_console_handler (true);
-	    }
-	  /* Clear screen to synchronize pseudo console screen buffer
-	     with real terminal. This is necessary because pseudo
-	     console screen buffer is empty at start. */
-	  if (get_ttyp ()->num_pcon_attached_slaves == 0)
-	    /* Assume this is the first process using this pty slave. */
-	    get_ttyp ()->need_redraw_screen = true;
-
-	  get_ttyp ()->num_pcon_attached_slaves ++;
-	}
+	if (pcon_attached_to != get_minor ())
+	  {
+	    pcon_attached_to = get_minor ();
+	    init_console_handler (true);
+	  }
 
 #if 0 /* This is for debug only. */
       isHybrid = true;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 3fc46fb29..efdae4697 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -242,9 +242,8 @@ tty::init ()
   screen_alternated = false;
   mask_switch_to_pcon_in = false;
   pcon_pid = 0;
-  num_pcon_attached_slaves = 0;
   term_code_page = 0;
-  need_redraw_screen = false;
+  need_redraw_screen = true;
   fwd_done = NULL;
   pcon_last_time = 0;
   pcon_in_empty = true;
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index c4dd2e458..7d6fc8fef 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -103,7 +103,6 @@ private:
   bool screen_alternated;
   bool mask_switch_to_pcon_in;
   pid_t pcon_pid;
-  int num_pcon_attached_slaves;
   UINT term_code_page;
   bool need_redraw_screen;
   HANDLE fwd_done;
-- 
2.26.2

