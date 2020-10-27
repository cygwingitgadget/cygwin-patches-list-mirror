Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 85FA13858D37
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 08:27:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 85FA13858D37
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 09R8QiP1017894;
 Tue, 27 Oct 2020 17:26:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 09R8QiP1017894
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Disable ResizePseudoConsole() if stdout is
 redirected.
Date: Tue, 27 Oct 2020 17:26:34 +0900
Message-Id: <20201027082634.441-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 27 Oct 2020 08:27:34 -0000

- Calling ResizePseudoConsole() generates some escape sequences.
  Due to this behaviour, if the output of non-cygwin app is piped
  to less, screen is sometimes distorted when the screen is resized.
  With this patch, ResizePseudoConsole() is not called if stdout is
  redirected.
---
 winsup/cygwin/fhandler_tty.cc | 8 ++++++--
 winsup/cygwin/tty.cc          | 1 +
 winsup/cygwin/tty.h           | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c5a081ebd..600de085c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1511,7 +1511,7 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
   size.X = ws->ws_col;
   size.Y = ws->ws_row;
   pinfo p (get_ttyp ()->pcon_pid);
-  if (p)
+  if (p && !get_ttyp ()->do_not_resize_pcon)
     {
       HPCON_INTERNAL hpcon_local;
       HANDLE pcon_owner =
@@ -2489,7 +2489,10 @@ fhandler_pty_slave::setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon)
       si->StartupInfo.hStdInput = fh0->get_handle ();
     fhandler_base *fh1 = ::cygheap->fdtab[1];
     if (fh1 && fh1->get_device () != get_device ())
-      si->StartupInfo.hStdOutput = fh1->get_output_handle ();
+      {
+	get_ttyp ()->do_not_resize_pcon = true;
+	si->StartupInfo.hStdOutput = fh1->get_output_handle ();
+      }
     fhandler_base *fh2 = ::cygheap->fdtab[2];
     if (fh2 && fh2->get_device () != get_device ())
       si->StartupInfo.hStdError = fh2->get_output_handle ();
@@ -2535,6 +2538,7 @@ fhandler_pty_slave::close_pseudoconsole (void)
       get_ttyp ()->switch_to_pcon_in = false;
       get_ttyp ()->pcon_pid = 0;
       get_ttyp ()->pcon_start = false;
+      get_ttyp ()->do_not_resize_pcon = false;
     }
 }
 
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 7e3b88b0b..d4b8d7651 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -245,6 +245,7 @@ tty::init ()
   pcon_cap_checked = false;
   has_csi6n = false;
   has_set_title = false;
+  do_not_resize_pcon = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 4e9199dba..2c1ac7f5d 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -104,6 +104,7 @@ private:
   bool pcon_cap_checked;
   bool has_csi6n;
   bool has_set_title;
+  bool do_not_resize_pcon;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.29.0

