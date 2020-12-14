Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id EFE313850417
 for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2020 08:27:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EFE313850417
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 0BE8QijA002898;
 Mon, 14 Dec 2020 17:26:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0BE8QijA002898
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add a workaround for rlwrap.
Date: Mon, 14 Dec 2020 17:26:47 +0900
Message-Id: <20201214082647.727-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 14 Dec 2020 08:27:19 -0000

- If rlwrap is used with non-cygwin apps, it fails to setup pseudo
  console. This patch adds a workaround for this issue.
---
 winsup/cygwin/fhandler_tty.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 04a9a2bf5..5f38ca8d3 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1109,6 +1109,11 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
 {
   reset_switch_to_pcon ();
   *t = get_ttyp ()->ti;
+  /* Workaround for rlwrap */
+  if (get_ttyp ()->pcon_start)
+    t->c_lflag &= ~ICANON;
+  else if (get_ttyp ()->h_pseudo_console)
+    t->c_iflag &= ~ICRNL;
   return 0;
 }
 
-- 
2.29.2

