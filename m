Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 024903870855
 for <cygwin-patches@cygwin.com>; Thu, 21 May 2020 08:25:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 024903870855
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 04L8OxiL021991;
 Thu, 21 May 2020 17:25:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 04L8OxiL021991
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Revise code to make system_printf() work after
 close.
Date: Thu, 21 May 2020 17:25:01 +0900
Message-Id: <20200521082501.1324-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 21 May 2020 08:25:40 -0000

- After commit 0365031ce1347600d854a23f30f1355745a1765c, the issue
  https://cygwin.com/pipermail/cygwin-patches/2020q2/010259.html
  occurs. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 15 ++++++++++++---
 winsup/cygwin/tty.cc          | 23 +++++++++++++++++++++++
 winsup/cygwin/tty.h           |  2 ++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 02b78cd2c..5faf896e4 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -64,6 +64,7 @@ static int pcon_attached_to = -1;
 static bool isHybrid;
 static bool do_not_reset_switch_to_pcon;
 static bool freeconsole_on_close = true;
+static tty *last_ttyp = NULL;
 
 void
 clear_pcon_attached_to (void)
@@ -89,7 +90,11 @@ set_switch_to_pcon (void)
 	      ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
 	    SetConsoleMode (ptys->get_handle (), mode);
 	  }
+	return;
       }
+  /* No pty slave opened */
+  if (last_ttyp) /* Make system_printf() work after closing pty slave */
+    last_ttyp->set_switch_to_pcon_out (true);
 }
 
 static void
@@ -741,7 +746,10 @@ fhandler_pty_slave::~fhandler_pty_slave ()
 	 needed to make GNU screen and tmux work in Windows 10
 	 1903. */
       if (attached == 0)
-	pcon_attached_to = -1;
+	{
+	  pcon_attached_to = -1;
+	  last_ttyp = get_ttyp ();
+	}
       if (used == 0)
 	{
 	  init_console_handler (false);
@@ -948,6 +956,7 @@ fhandler_pty_slave::open (int flags, mode_t)
       init_console_handler (true);
     }
 
+  isHybrid = false;
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->switch_to_pcon_out = false;
@@ -1012,7 +1021,6 @@ fhandler_pty_slave::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (pcon_attached_to == get_minor ())
     get_ttyp ()->num_pcon_attached_slaves --;
-  set_switch_to_pcon (2); /* Make system_printf() work after close. */
   return 0;
 }
 
@@ -2888,7 +2896,8 @@ fhandler_pty_slave::wait_pcon_fwd (void)
   get_ttyp ()->pcon_last_time = GetTickCount ();
   ResetEvent (get_ttyp ()->fwd_done);
   release_output_mutex ();
-  cygwait (get_ttyp ()->fwd_done, INFINITE);
+  while (get_ttyp ()->fwd_done
+	 && cygwait (get_ttyp ()->fwd_done, 1) == WAIT_TIMEOUT);
 }
 
 void
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 0663dc5ee..3fc46fb29 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -294,3 +294,26 @@ tty_min::ttyname ()
   d.parse (ntty);
   return d.name ();
 }
+
+void
+tty::set_switch_to_pcon_out (bool v)
+{
+  if (switch_to_pcon_out != v)
+    {
+      wait_pcon_fwd ();
+      switch_to_pcon_out = v;
+    }
+}
+
+void
+tty::wait_pcon_fwd (void)
+{
+  const int sleep_in_pcon = 16;
+  const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
+  pcon_last_time = GetTickCount ();
+  while (GetTickCount () - pcon_last_time < time_to_wait)
+    {
+      int tw = time_to_wait - (GetTickCount () - pcon_last_time);
+      cygwait (tw);
+    }
+}
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index a24afad06..c4dd2e458 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -140,6 +140,8 @@ public:
   void set_master_ctl_closed () {master_pid = -1;}
   static void __stdcall create_master (int);
   static void __stdcall init_session ();
+  void set_switch_to_pcon_out (bool v);
+  void wait_pcon_fwd (void);
   friend class fhandler_pty_common;
   friend class fhandler_pty_master;
   friend class fhandler_pty_slave;
-- 
2.21.0

