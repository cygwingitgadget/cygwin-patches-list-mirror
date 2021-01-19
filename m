Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 27A13384BC14
 for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021 09:27:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 27A13384BC14
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 10J9RCaY011156;
 Tue, 19 Jan 2021 18:27:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 10J9RCaY011156
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Lessen the side effect of workaround for rlwarp.
Date: Tue, 19 Jan 2021 18:27:02 +0900
Message-Id: <20210119092702.1339-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 19 Jan 2021 09:27:48 -0000

- This patch lessens the side effect of the workaround for rlwrap
  introduced by commit 4e16b033.
---
 winsup/cygwin/fhandler_tty.cc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 473c0c968..c78e996e8 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1176,11 +1176,19 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
 {
   reset_switch_to_pcon ();
   *t = get_ttyp ()->ti;
+
   /* Workaround for rlwrap */
-  if (get_ttyp ()->pcon_start)
-    t->c_lflag &= ~(ICANON | ECHO);
-  if (get_ttyp ()->h_pseudo_console)
-    t->c_iflag &= ~ICRNL;
+  cygheap_fdenum cfd (false);
+  while (cfd.next () >= 0)
+    if (cfd->get_major () == DEV_PTYM_MAJOR
+	&& cfd->get_minor () == get_minor ())
+      {
+	if (get_ttyp ()->pcon_start)
+	  t->c_lflag &= ~(ICANON | ECHO);
+	if (get_ttyp ()->h_pseudo_console)
+	  t->c_iflag &= ~ICRNL;
+	break;
+      }
   return 0;
 }
 
-- 
2.30.0

