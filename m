Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 2D8CA397182D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 08:33:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2D8CA397182D
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10F8WSAb017561;
 Fri, 15 Jan 2021 17:33:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10F8WSAb017561
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/5] Cygwin: pty: Make close_pseudoconsole() be a static
 member function.
Date: Fri, 15 Jan 2021 17:32:11 +0900
Message-Id: <20210115083213.676-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
References: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 15 Jan 2021 08:33:40 -0000

- The function close_pseudoconsole() should be static so that it
  can be safely called in spawn.cc even after the fhandler_pty_slave
  instance has been deleted. That is, there is a problem with the
  current code. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h      |  3 ++-
 winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++----------
 winsup/cygwin/spawn.cc        |  6 ++++--
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 45ac17af2..2077b5245 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2339,12 +2339,13 @@ class fhandler_pty_slave: public fhandler_pty_common
     return fh;
   }
   bool setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon);
-  void close_pseudoconsole (void);
+  static void close_pseudoconsole (tty *ttyp);
   bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
   void mask_switch_to_pcon_in (bool mask);
   void setup_locale (void);
+  tty *get_ttyp () { return (tty *) tc (); } /* Override as public */
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8ff74cdde..0c92f41d4 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2563,21 +2563,23 @@ fallback:
   return false;
 }
 
+/* The function close_pseudoconsole() should be static so that it can
+   be called even after the fhandler_pty_slave instance is deleted. */
 void
-fhandler_pty_slave::close_pseudoconsole (void)
+fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
 {
-  if (get_ttyp ()->h_pseudo_console)
+  if (ttyp->h_pseudo_console)
     {
-      get_ttyp ()->wait_pcon_fwd ();
-      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_ttyp ()->h_pseudo_console;
+      ttyp->wait_pcon_fwd ();
+      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) ttyp->h_pseudo_console;
       HANDLE tmp = hp->hConHostProcess;
-      ClosePseudoConsole (get_ttyp ()->h_pseudo_console);
+      ClosePseudoConsole (ttyp->h_pseudo_console);
       CloseHandle (tmp);
-      get_ttyp ()->h_pseudo_console = NULL;
-      get_ttyp ()->switch_to_pcon_in = false;
-      get_ttyp ()->pcon_pid = 0;
-      get_ttyp ()->pcon_start = false;
-      get_ttyp ()->do_not_resize_pcon = false;
+      ttyp->h_pseudo_console = NULL;
+      ttyp->switch_to_pcon_in = false;
+      ttyp->pcon_pid = 0;
+      ttyp->pcon_start = false;
+      ttyp->do_not_resize_pcon = false;
     }
 }
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 94909df4c..bf1b08057 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -664,6 +664,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	init_console_handler (myself->ctty > 0);
 
       bool enable_pcon = false;
+      tty *ptys_ttyp = NULL;
       STARTUPINFOEXW si_pcon;
       ZeroMemory (&si_pcon, sizeof (si_pcon));
       STARTUPINFOW *si_tmp = &si;
@@ -677,6 +678,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      c_flags |= EXTENDED_STARTUPINFO_PRESENT;
 	      si_tmp = &si_pcon.StartupInfo;
 	      enable_pcon = true;
+	      ptys_ttyp = ptys_primary->get_ttyp ();
 	    }
 	}
 
@@ -954,7 +956,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (enable_pcon)
 	    {
 	      WaitForSingleObject (pi.hProcess, INFINITE);
-	      ptys_primary->close_pseudoconsole ();
+	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
 	    }
 	  else if (cons_native)
 	    {
@@ -973,7 +975,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (waitpid (cygpid, &res, 0) != cygpid)
 	    res = -1;
 	  if (enable_pcon)
-	    ptys_primary->close_pseudoconsole ();
+	    fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
 	  else if (cons_native)
 	    {
 	      fhandler_console::request_xterm_mode_output (true,
-- 
2.30.0

