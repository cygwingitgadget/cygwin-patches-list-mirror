Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 2C33F393BC3C
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 10:55:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2C33F393BC3C
Received: from localhost.localdomain (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 04JAtWeK020796;
 Tue, 19 May 2020 19:55:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04JAtWeK020796
X-Nifty-SrcIP: [124.155.40.7]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pty: Call FreeConsole() only if attached to
 current pty.
Date: Tue, 19 May 2020 19:55:23 +0900
Message-Id: <20200519105523.1620-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 19 May 2020 10:55:58 -0000

- After commit 071b8e0cbd4be33449c12bb0d58f514ed8ef893c, the problem
  reported in https://cygwin.com/pipermail/cygwin/2020-May/244873.html
  occurs. This is due to freeing console device accidentally rather
  than pseudo console. This patch makes sure to call FreeConsole()
  only if the process is attached to the pseudo console of the current
  pty.
---
 winsup/cygwin/fhandler.h      |  1 +
 winsup/cygwin/fhandler_tty.cc | 28 +++++++++++++---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index ae64086df..857f0a4e0 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2284,6 +2284,7 @@ class fhandler_pty_slave: public fhandler_pty_common
 
   bool try_reattach_pcon ();
   void restore_reattach_pcon ();
+  inline void free_attached_console ();
 
  public:
   /* Constructor */
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8547ec7c4..5a1bcd3ce 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -180,6 +180,16 @@ set_ishybrid_and_switch_to_pcon (HANDLE h)
     }
 }
 
+inline void
+fhandler_pty_slave::free_attached_console ()
+{
+  if (freeconsole_on_close && get_minor () == pcon_attached_to)
+    {
+      FreeConsole ();
+      pcon_attached_to = -1;
+    }
+}
+
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
 DEF_HOOK (WriteFile);
 DEF_HOOK (WriteConsoleA);
@@ -708,11 +718,7 @@ fhandler_pty_slave::~fhandler_pty_slave ()
   if (!get_ttyp ())
     {
       /* Why comes here? Who clears _tc? */
-      if (freeconsole_on_close)
-	{
-	  FreeConsole ();
-	  pcon_attached_to = -1;
-	}
+      free_attached_console ();
       return;
     }
   if (get_pseudo_console ())
@@ -739,11 +745,7 @@ fhandler_pty_slave::~fhandler_pty_slave ()
       if (used == 0)
 	{
 	  init_console_handler (false);
-	  if (freeconsole_on_close)
-	    {
-	      FreeConsole ();
-	      pcon_attached_to = -1;
-	    }
+	  free_attached_console ();
 	}
     }
 }
@@ -3006,11 +3008,7 @@ fhandler_pty_slave::fixup_after_exec ()
       if (used == 1 /* About to close this tty */)
 	{
 	  init_console_handler (false);
-	  if (freeconsole_on_close)
-	    {
-	      FreeConsole ();
-	      pcon_attached_to = -1;
-	    }
+	  free_attached_console ();
 	}
     }
 
-- 
2.21.0

