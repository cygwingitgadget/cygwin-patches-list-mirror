Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 439A63858D33
 for <cygwin-patches@cygwin.com>; Thu, 28 Jul 2022 15:13:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 439A63858D33
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 26SFDVpY011517;
 Fri, 29 Jul 2022 00:13:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 26SFDVpY011517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1659021215;
 bh=V1GjeNYvqklR0Qfo8RKs+S0kCtHSrQG0rwfYxkF58C0=;
 h=From:To:Cc:Subject:Date:From;
 b=bHYzuXit44064EFyKoualSNT1pF8R53lNRD/rYgT6AGTfh4R7TrMaQ924bt7X0tFz
 hDJkbOvtvhtLk4hyVSBnUAKt8XKIBItjknpOMUrADrTrRTKnzbGKrSI+LgjJJL+BRm
 tyttvFbcntwh8JYID+GICFMZYK5T+8jPrfvsnT+1nyWYI7dnWquik9qeLiK7+WmdGV
 jq/tL0J+rBsIyEn4SDdLlYDb64f70LRy+9x66JwakzfyEpLvVoJ40Z3qY/BFpAoIYN
 gVs5mQcuLTsZJxC+1p2k8YSjlnikG5nccwZ0y36PKRdAb4R5gFZ48sA/jHvoQEfBNc
 4VdUgSB8/J85g==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Add missing input_mutex guard.
Date: Fri, 29 Jul 2022 00:13:20 +0900
Message-Id: <20220728151320.1834-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 28 Jul 2022 15:13:51 -0000

- Setting con.disable_master_thread flag should be guarded by
  input_mutex, however, it was not. This patch fixes that.
---
 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 23 +++++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 2b403d06e..e47b38e9a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2294,6 +2294,7 @@ private:
   static void cleanup_for_non_cygwin_app (handle_set_t *p);
   static void set_console_mode_to_native ();
   bool need_console_handler ();
+  static void set_disable_master_thread (bool x);
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index e080fd6c8..e90b8d5ee 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -790,7 +790,7 @@ fhandler_console::setup_for_non_cygwin_app ()
     (get_ttyp ()->getpgid ()== myself->pgid) ? tty::native : tty::restore;
   set_input_mode (conmode, &tc ()->ti, get_handle_set ());
   set_output_mode (conmode, &tc ()->ti, get_handle_set ());
-  con.disable_master_thread = true;
+  set_disable_master_thread (true);
 }
 
 void
@@ -806,7 +806,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     (con.owner == myself->pid) ? tty::restore : tty::cygwin;
   set_output_mode (conmode, ti, p);
   set_input_mode (conmode, ti, p);
-  con.disable_master_thread = (con.owner == myself->pid);
+  set_disable_master_thread (con.owner == myself->pid);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -984,7 +984,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
   if (sig == SIGTTIN)
     {
       set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
-      con.disable_master_thread = false;
+      set_disable_master_thread (false);
     }
   if (sig == SIGTTOU)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
@@ -1715,7 +1715,7 @@ fhandler_console::post_open_setup (int fd)
   if (fd == 0)
     {
       set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-      con.disable_master_thread = false;
+      set_disable_master_thread (false);
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
@@ -1743,7 +1743,7 @@ fhandler_console::close ()
 	  /* Cleaning-up console mode for cygwin apps. */
 	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
 	  set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-	  con.disable_master_thread = true;
+	  set_disable_master_thread (true);
 	}
     }
 
@@ -3969,7 +3969,7 @@ fhandler_console::set_console_mode_to_native ()
 	    termios *cons_ti = &cons->tc ()->ti;
 	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
 	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
-	    con.disable_master_thread = true;
+	    set_disable_master_thread (true);
 	    break;
 	  }
       }
@@ -4322,3 +4322,14 @@ fhandler_console::need_console_handler ()
 {
   return con.disable_master_thread || con.master_thread_suspended;
 }
+
+void
+fhandler_console::set_disable_master_thread (bool x)
+{
+  if (cygheap->ctty->get_major () != DEV_CONS_MAJOR)
+    return;
+  fhandler_console *cons = (fhandler_console *) cygheap->ctty;
+  cons->acquire_input_mutex (mutex_timeout);
+  con.disable_master_thread = x;
+  cons->release_input_mutex ();
+}
-- 
2.37.1

