Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id AD8CE3844011
 for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2020 09:11:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AD8CE3844011
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 0BG9AtHm025632;
 Wed, 16 Dec 2020 18:10:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0BG9AtHm025632
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Revise the workaround for rlwrap.
Date: Wed, 16 Dec 2020 18:10:58 +0900
Message-Id: <20201216091058.1938-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 16 Dec 2020 09:11:13 -0000

- Previous workaround has a problem that screen is distorted if up
  arrow key is pressed at the first line after running "rlwrap cmd".
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 77d9d9b47..77f7bfe43 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1111,8 +1111,8 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
   *t = get_ttyp ()->ti;
   /* Workaround for rlwrap */
   if (get_ttyp ()->pcon_start)
-    t->c_lflag &= ~ICANON;
-  else if (get_ttyp ()->h_pseudo_console)
+    t->c_lflag &= ~(ICANON | ECHO);
+  if (get_ttyp ()->h_pseudo_console)
     t->c_iflag &= ~ICRNL;
   return 0;
 }
-- 
2.29.2

