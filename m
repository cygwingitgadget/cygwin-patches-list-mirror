Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id E25713851C27
 for <cygwin-patches@cygwin.com>; Wed,  3 Jun 2020 09:45:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E25713851C27
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 0539j5KE000626;
 Wed, 3 Jun 2020 18:45:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 0539j5KE000626
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pty: Fix screen distortion after less for native
 apps again.
Date: Wed,  3 Jun 2020 18:45:11 +0900
Message-Id: <20200603094511.9-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 03 Jun 2020 09:45:32 -0000

- Commit c4b060e3fe3bed05b3a69ccbcc20993ad85e163d seems to be not
  enough. Moreover, it does not work as expected at all in Win10
  1809. This patch essentially reverts that commit and add another
  fix. After all, the cause of the problem was a race issue in
  switch_to_pcon_out flag. That is, this flag is set when native
  app starts, however, it is delayed by wait_pcon_fwd(). Since the
  flag is not set yet when less starts, the data which should go
  into the output_handle accidentally goes into output_handle_cyg.
  This patch fixes the problem more essentially for the cause of
  the problem than previous one.
---
 winsup/cygwin/fhandler.h      |  1 -
 winsup/cygwin/fhandler_tty.cc | 47 +++++++++++------------------------
 winsup/cygwin/tty.cc          |  7 +++++-
 winsup/cygwin/tty.h           |  1 -
 4 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4035c7e56..c6ce6d8e1 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2354,7 +2354,6 @@ class fhandler_pty_slave: public fhandler_pty_common
   void setup_locale (void);
   void set_freeconsole_on_close (bool val);
   void trigger_redraw_screen (void);
-  void wait_pcon_fwd (void);
   void pull_pcon_input (void);
   void update_pcon_input_state (bool need_lock);
 };
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index bcc7648f3..d7bcd5f41 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1277,6 +1277,7 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
 {
   if (fd < 0)
     fd = fd_set;
+  acquire_output_mutex (INFINITE);
   if (fd == 0 && !get_ttyp ()->switch_to_pcon_in)
     {
       pull_pcon_input ();
@@ -1286,13 +1287,13 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
       get_ttyp ()->switch_to_pcon_in = true;
       if (isHybrid && !get_ttyp ()->switch_to_pcon_out)
 	{
-	  wait_pcon_fwd ();
+	  get_ttyp ()->wait_pcon_fwd ();
 	  get_ttyp ()->switch_to_pcon_out = true;
 	}
     }
   else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
     {
-      wait_pcon_fwd ();
+      get_ttyp ()->wait_pcon_fwd ();
       if (get_ttyp ()->pcon_pid == 0 ||
 	  !pinfo (get_ttyp ()->pcon_pid))
 	get_ttyp ()->pcon_pid = myself->pid;
@@ -1300,6 +1301,7 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
       if (isHybrid)
 	get_ttyp ()->switch_to_pcon_in = true;
     }
+  release_output_mutex ();
 }
 
 void
@@ -1314,12 +1316,14 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     return;
   if (do_not_reset_switch_to_pcon)
     return;
+  acquire_output_mutex (INFINITE);
   if (get_ttyp ()->switch_to_pcon_out)
     /* Wait for pty_master_fwd_thread() */
-    wait_pcon_fwd ();
+    get_ttyp ()->wait_pcon_fwd ();
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->switch_to_pcon_out = false;
+  release_output_mutex ();
   init_console_handler (true);
 }
 
@@ -1372,7 +1376,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
 	  p0 = (char *) memmem (p1, nlen - (p1-buf), "\033[?1049h", 8);
 	  if (p0)
 	    {
-	      p0 += 8;
+	      //p0 += 8;
 	      get_ttyp ()->screen_alternated = true;
 	      if (get_ttyp ()->switch_to_pcon_out)
 		do_not_reset_switch_to_pcon = true;
@@ -1384,7 +1388,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
 	  p1 = (char *) memmem (p0, nlen - (p0-buf), "\033[?1049l", 8);
 	  if (p1)
 	    {
-	      //p1 += 8;
+	      p1 += 8;
 	      get_ttyp ()->screen_alternated = false;
 	      do_not_reset_switch_to_pcon = false;
 	      memmove (p0, p1, buf+nlen - p1);
@@ -1504,8 +1508,9 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   reset_switch_to_pcon ();
 
-  bool output_to_pcon =
-    get_ttyp ()->switch_to_pcon_out && !get_ttyp ()->screen_alternated;
+  acquire_output_mutex (INFINITE);
+  bool output_to_pcon = get_ttyp ()->switch_to_pcon_out;
+  release_output_mutex ();
 
   UINT target_code_page = output_to_pcon ?
     GetConsoleOutputCP () : get_ttyp ()->term_code_page;
@@ -2420,8 +2425,6 @@ fhandler_pty_master::close ()
 	    }
 	  release_output_mutex ();
 	  master_fwd_thread->terminate_thread ();
-	  CloseHandle (get_ttyp ()->fwd_done);
-	  get_ttyp ()->fwd_done = NULL;
 	}
     }
 
@@ -2903,17 +2906,6 @@ fhandler_pty_slave::set_freeconsole_on_close (bool val)
   freeconsole_on_close = val;
 }
 
-void
-fhandler_pty_slave::wait_pcon_fwd (void)
-{
-  acquire_output_mutex (INFINITE);
-  get_ttyp ()->pcon_last_time = GetTickCount ();
-  ResetEvent (get_ttyp ()->fwd_done);
-  release_output_mutex ();
-  while (get_ttyp ()->fwd_done
-	 && cygwait (get_ttyp ()->fwd_done, 1) == WAIT_TIMEOUT);
-}
-
 void
 fhandler_pty_slave::trigger_redraw_screen (void)
 {
@@ -2967,12 +2959,14 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	    {
 	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 	      SetConsoleMode (get_output_handle (), mode);
+	      acquire_output_mutex (INFINITE);
 	      if (!get_ttyp ()->switch_to_pcon_out)
-		wait_pcon_fwd ();
+		get_ttyp ()->wait_pcon_fwd ();
 	      if (get_ttyp ()->pcon_pid == 0 ||
 		  !pinfo (get_ttyp ()->pcon_pid))
 		get_ttyp ()->pcon_pid = myself->pid;
 	      get_ttyp ()->switch_to_pcon_out = true;
+	      release_output_mutex ();
 
 	      if (get_ttyp ()->need_redraw_screen)
 		trigger_redraw_screen ();
@@ -3258,19 +3252,9 @@ fhandler_pty_master::pty_master_fwd_thread ()
     {
       if (get_pseudo_console ())
 	{
-	  /* The forwarding in pseudo console sometimes stops for
-	     16-32 msec even if it already has data to transfer.
-	     If the time without transfer exceeds 32 msec, the
-	     forwarding is supposed to be finished. */
-	  const int sleep_in_pcon = 16;
-	  const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
 	  get_ttyp ()->pcon_last_time = GetTickCount ();
 	  while (::bytes_available (rlen, from_slave) && rlen == 0)
 	    {
-	      acquire_output_mutex (INFINITE);
-	      if (GetTickCount () - get_ttyp ()->pcon_last_time > time_to_wait)
-		SetEvent (get_ttyp ()->fwd_done);
-	      release_output_mutex ();
 	      /* Forcibly transfer input if it is requested by slave.
 		 This happens when input data should be transfered
 		 from the input pipe for cygwin apps to the input pipe
@@ -3695,7 +3679,6 @@ fhandler_pty_master::setup ()
       errstr = "pty master forwarding thread";
       goto err;
     }
-  get_ttyp ()->fwd_done = CreateEvent (&sec_none, true, false, NULL);
 
   t.winsize.ws_col = 80;
   t.winsize.ws_row = 25;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index efdae4697..4cb68f776 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -244,7 +244,6 @@ tty::init ()
   pcon_pid = 0;
   term_code_page = 0;
   need_redraw_screen = true;
-  fwd_done = NULL;
   pcon_last_time = 0;
   pcon_in_empty = true;
   req_transfer_input_to_pcon = false;
@@ -307,6 +306,12 @@ tty::set_switch_to_pcon_out (bool v)
 void
 tty::wait_pcon_fwd (void)
 {
+  /* The forwarding in pseudo console sometimes stops for
+     16-32 msec even if it already has data to transfer.
+     If the time without transfer exceeds 32 msec, the
+     forwarding is supposed to be finished. pcon_last_time
+     is reset to GetTickCount() in pty master forwarding
+     thread when the last data is transfered. */
   const int sleep_in_pcon = 16;
   const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
   pcon_last_time = GetTickCount ();
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 7d6fc8fef..920e32b16 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -105,7 +105,6 @@ private:
   pid_t pcon_pid;
   UINT term_code_page;
   bool need_redraw_screen;
-  HANDLE fwd_done;
   DWORD pcon_last_time;
   bool pcon_in_empty;
   bool req_transfer_input_to_pcon;
-- 
2.26.2

