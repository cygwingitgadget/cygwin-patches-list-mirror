Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 1CC91386181F
 for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2021 08:52:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1CC91386181F
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 11E8qGbH026032;
 Sun, 14 Feb 2021 17:52:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 11E8qGbH026032
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Abort read() on SIGWINCH if SA_RESTART is
 not set.
Date: Sun, 14 Feb 2021 17:52:06 +0900
Message-Id: <20210214085206.1245-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 14 Feb 2021 08:52:43 -0000

- Currently, console read() keeps reading after SIGWINCH is sent
  even if SA_RESTART flag is not set. With this patch, read()
  returns EINTR on SIGWINCH if SA_RESTART flag is not set.
---
 winsup/cygwin/fhandler_console.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 3c0783575..bdd6e5bb6 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -591,7 +591,9 @@ wait_retry:
 	  continue;
 	case input_winch:
 	  release_input_mutex ();
-	  continue;
+	  if (global_sigs[SIGWINCH].sa_flags & SA_RESTART)
+	    continue;
+	  goto sig_exit;
 	default:
 	  /* Should not come here */
 	  release_input_mutex ();
-- 
2.30.0

