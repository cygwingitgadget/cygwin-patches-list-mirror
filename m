Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id E5A8A3857B80
 for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2022 12:51:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E5A8A3857B80
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 26TCp5rU024774;
 Fri, 29 Jul 2022 21:51:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26TCp5rU024774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1659099071;
 bh=oW4D1eCplDaE2y45wfJze0vczXHpO7seUp62Wmarw1M=;
 h=From:To:Cc:Subject:Date:From;
 b=NEf/2G4+5GJLZaW3NAufkz0/dpnh/fB20sWE8dywtd6RGRf8Dyyt79ExqBm7rRty/
 +v+Qafl6jwl/YN+2EAcOxsaBdnInU7cOhbRbzLubu4QNKYmXwiCtWO92PdRlIfcntX
 Tip6UPX6wE5LnxHAjn88hdOWL9wX7g12pr/jnNqo3a0zC3/fNbqnk/swlrvKo0KjaS
 bh9m55SUZKnJdnO2yMdxSuffGQtuwSI+jizjKhRhRXkvD/21nu9zRvWf9ld7Eh9ZVc
 qjWSppZ+3/fMTrRk3j+V2ShErEXMD5Vmiw1x7M3Z1vjgvGKqi46yXcExQ6B3sCzWiO
 ghWlyoWCpNc9A==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Avoid accessing NULL pointer via
 cygheap->ctty.
Date: Fri, 29 Jul 2022 21:50:56 +0900
Message-Id: <20220729125056.452-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Fri, 29 Jul 2022 12:51:52 -0000

- Recent commit "Cygwin: console: Add missing input_mutex guard."
  has a problem that causes NULL pointer access if cygheap->ctty
  is NULL. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h          |  2 +-
 winsup/cygwin/fhandler_console.cc | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index a12e907ff..e4f1a2d94 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2298,7 +2298,7 @@ private:
   static void cleanup_for_non_cygwin_app (handle_set_t *p);
   static void set_console_mode_to_native ();
   bool need_console_handler ();
-  static void set_disable_master_thread (bool x);
+  static void set_disable_master_thread (bool x, fhandler_console *cons = NULL);
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 37262f638..d17f03acf 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -791,7 +791,7 @@ fhandler_console::setup_for_non_cygwin_app ()
     (get_ttyp ()->getpgid ()== myself->pgid) ? tty::native : tty::restore;
   set_input_mode (conmode, &tc ()->ti, get_handle_set ());
   set_output_mode (conmode, &tc ()->ti, get_handle_set ());
-  set_disable_master_thread (true);
+  set_disable_master_thread (true, this);
 }
 
 void
@@ -986,7 +986,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
   if (sig == SIGTTIN)
     {
       set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
-      set_disable_master_thread (false);
+      set_disable_master_thread (false, this);
     }
   if (sig == SIGTTOU)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
@@ -1721,7 +1721,7 @@ fhandler_console::post_open_setup (int fd)
   if (fd == 0)
     {
       set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-      set_disable_master_thread (false);
+      set_disable_master_thread (false, this);
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
@@ -1749,7 +1749,7 @@ fhandler_console::close ()
 	  /* Cleaning-up console mode for cygwin apps. */
 	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
 	  set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-	  set_disable_master_thread (true);
+	  set_disable_master_thread (true, this);
 	}
     }
 
@@ -3975,7 +3975,7 @@ fhandler_console::set_console_mode_to_native ()
 	    termios *cons_ti = &cons->tc ()->ti;
 	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
 	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
-	    set_disable_master_thread (true);
+	    set_disable_master_thread (true, cons);
 	    break;
 	  }
       }
@@ -4321,11 +4321,17 @@ fhandler_console::need_console_handler ()
 }
 
 void
-fhandler_console::set_disable_master_thread (bool x)
+fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 {
-  if (cygheap->ctty->get_major () != DEV_CONS_MAJOR)
+  if (con.disable_master_thread == x)
     return;
-  fhandler_console *cons = (fhandler_console *) cygheap->ctty;
+  if (cons == NULL)
+    {
+      if (cygheap->ctty && cygheap->ctty->get_major () == DEV_CONS_MAJOR)
+	cons = (fhandler_console *) cygheap->ctty;
+      else
+	return;
+    }
   cons->acquire_input_mutex (mutex_timeout);
   con.disable_master_thread = x;
   cons->release_input_mutex ();
-- 
2.37.1

