Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 2824A3864858
 for <cygwin-patches@cygwin.com>; Thu, 13 Aug 2020 05:42:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2824A3864858
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 07D5gVb2013389;
 Thu, 13 Aug 2020 14:42:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 07D5gVb2013389
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Change the timing of setup_locale() call.
Date: Thu, 13 Aug 2020 14:42:20 +0900
Message-Id: <20200813054220.1844-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Thu, 13 Aug 2020 05:42:55 -0000

- If native app is exec()'ed in a new pty, setup_locale() loses the
  chance to be called. For example, with "mintty -e cmd", charset
  conversion does not work as expected. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 92449ad7e..40b79bfbb 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2983,6 +2983,10 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
   report_tty_counts (this, "inherited", "");
+
+  /* Set locale */
+  if (get_ttyp ()->term_code_page == 0)
+    setup_locale ();
 }
 
 void
@@ -3020,10 +3024,6 @@ fhandler_pty_slave::fixup_after_exec ()
 	}
     }
 
-  /* Set locale */
-  if (get_ttyp ()->term_code_page == 0)
-    setup_locale ();
-
   /* Hook Console API */
   if (get_pseudo_console ())
     {
-- 
2.27.0

