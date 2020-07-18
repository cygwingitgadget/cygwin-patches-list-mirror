Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 3F4563857014
 for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2020 04:49:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3F4563857014
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 06I4miTU020015;
 Sat, 18 Jul 2020 13:49:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 06I4miTU020015
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix a bug on redirecting something to /dev/pty*.
Date: Sat, 18 Jul 2020 13:48:47 +0900
Message-Id: <20200718044848.1085-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 18 Jul 2020 04:49:26 -0000

- After commit 0365031ce1347600d854a23f30f1355745a1765c, key input
  becomes not working by following steps.
   1) Start cmd.exe in mintty.
   2) Open another mintty.
   3) Execute "echo AAA > /dev/pty*" (pty* is the pty opened in 1.)
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a61167116..6a004f3a5 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -969,11 +969,6 @@ fhandler_pty_slave::open (int flags, mode_t)
       init_console_handler (true);
     }
 
-  isHybrid = false;
-  get_ttyp ()->pcon_pid = 0;
-  get_ttyp ()->switch_to_pcon_in = false;
-  get_ttyp ()->switch_to_pcon_out = false;
-
   set_open_status ();
   return 1;
 
-- 
2.27.0

