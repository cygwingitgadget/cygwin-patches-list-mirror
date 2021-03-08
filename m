Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id A016D394EC2D
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 13:15:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A016D394EC2D
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 128DF600012724;
 Mon, 8 Mar 2021 22:15:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 128DF600012724
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Attach to stub process when non-cygwin app
 inherits pcon.
Date: Mon,  8 Mar 2021 22:14:58 +0900
Message-Id: <20210308131458.1736-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
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
X-List-Received-Date: Mon, 08 Mar 2021 13:15:29 -0000

- If two non-cygwin apps are started simultaneously, attaching to
  pseudo console sometimes fails. This is because the second app
  trys to attach to the process not started yet. This patch avoids
  the issue by attaching to the stub process rather than the other
  non-cygwin app.
---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 4358bceec..3bfc8c0c8 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3104,7 +3104,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 		       0, TRUE, DUPLICATE_SAME_ACCESS);
       CloseHandle (pcon_owner);
       FreeConsole ();
-      AttachConsole (p->dwProcessId);
+      AttachConsole (p->exec_dwProcessId);
       goto skip_create;
     }
 
-- 
2.30.1

