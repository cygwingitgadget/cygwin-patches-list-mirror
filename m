Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 48A5D3857C7B
 for <cygwin-patches@cygwin.com>; Sat, 15 Aug 2020 03:24:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 48A5D3857C7B
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 07F3Nng8002956;
 Sat, 15 Aug 2020 12:23:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 07F3Nng8002956
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Change the timing of set_locale() call again.
Date: Sat, 15 Aug 2020 12:23:52 +0900
Message-Id: <20200815032352.283-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 15 Aug 2020 03:24:16 -0000

- After commit 095972ce5b1d319915501a7e381802914bed790c, charset
  conversion in mintty is broken if charset is set to other than
  UTF-8. This seems to be caused because mintty does not set locale
  yet at fork() call. This patch changes the timing of set_locale()
  call again to avoid this issue.
---
 winsup/cygwin/fhandler_tty.cc | 10 ++++++----
 winsup/cygwin/spawn.cc        | 12 ++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 40b79bfbb..6294e2c20 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2852,6 +2852,9 @@ get_langinfo (char *locale_out, char *charset_out)
 void
 fhandler_pty_slave::setup_locale (void)
 {
+  if (get_ttyp ()->term_code_page != 0)
+    return;
+
   char locale[ENCODING_LEN + 1] = "C";
   char charset[ENCODING_LEN + 1] = "ASCII";
   LCID lcid = get_langinfo (locale, charset);
@@ -2983,10 +2986,6 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
   report_tty_counts (this, "inherited", "");
-
-  /* Set locale */
-  if (get_ttyp ()->term_code_page == 0)
-    setup_locale ();
 }
 
 void
@@ -3024,6 +3023,9 @@ fhandler_pty_slave::fixup_after_exec ()
 	}
     }
 
+  /* Set locale */
+  setup_locale ();
+
   /* Hook Console API */
   if (get_pseudo_console ())
     {
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index e70ceb86d..af177c0f1 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -628,6 +628,18 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	}
 
+      if (!iscygwin ())
+	{
+	  cfd.rewind ();
+	  while (cfd.next () >= 0)
+	    if (cfd->get_major () == DEV_PTYS_MAJOR)
+	      {
+		fhandler_pty_slave *ptys =
+		  (fhandler_pty_slave *)(fhandler_base *) cfd;
+		ptys->setup_locale ();
+	      }
+	}
+
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
       si.hStdInput = handle ((in__stdin < 0 ? 0 : in__stdin), false,
-- 
2.28.0

