Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 28536397182D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 08:33:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 28536397182D
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10F8WSAX017561;
 Fri, 15 Jan 2021 17:32:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10F8WSAX017561
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/5] Cygwin: pty: Add workaround for rlwrap 0.40 or later.
Date: Fri, 15 Jan 2021 17:32:09 +0900
Message-Id: <20210115083213.676-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
References: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 15 Jan 2021 08:33:10 -0000

- The workaround for rlwrap introduced by commit 8199b0cc does not
  take effect for rlwrap 0.40 or later. This patch add a workaround
  for rlwrap 0.40 or later as well.
---
 winsup/cygwin/fhandler_tty.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 77f7bfe43..8ff74cdde 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1720,6 +1720,11 @@ int
 fhandler_pty_master::tcgetattr (struct termios *t)
 {
   *t = cygwin_shared->tty[get_minor ()]->ti;
+  /* Workaround for rlwrap v0.40 or later */
+  if (get_ttyp ()->pcon_start)
+    t->c_lflag &= ~(ICANON | ECHO);
+  if (get_ttyp ()->h_pseudo_console)
+    t->c_iflag &= ~ICRNL;
   return 0;
 }
 
-- 
2.30.0

