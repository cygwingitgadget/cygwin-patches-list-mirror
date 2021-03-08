Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id F1CDA3959CB8
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 14:55:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F1CDA3959CB8
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 128EtHH8020532;
 Mon, 8 Mar 2021 23:55:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 128EtHH8020532
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Transfer input for native app only if the stdin
 is pcon.
Date: Mon,  8 Mar 2021 23:55:10 +0900
Message-Id: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
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
X-List-Received-Date: Mon, 08 Mar 2021 14:55:54 -0000

- Currently, transfer input is triggered even if the stdin of native
  app is not a pseudo console. With this patch it is triggered only
  if the stdin is a pseudo console.
---
 winsup/cygwin/fhandler_tty.cc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3bfc8c0c8..47d59e8c5 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3084,14 +3084,16 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
   if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
       && !!pinfo (get_ttyp ()->pcon_pid) && get_ttyp ()->pcon_activated)
     {
-      /* Send CSI6n just for requesting transfer input. */
-      DWORD n;
-      WaitForSingleObject (input_mutex, INFINITE);
-      get_ttyp ()->req_xfer_input = true;
-      get_ttyp ()->pcon_start = true;
-      get_ttyp ()->pcon_start_pid = myself->pid;
-      WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
-      ReleaseMutex (input_mutex);
+      if (GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
+	{ /* Send CSI6n just for requesting transfer input. */
+	  DWORD n;
+	  WaitForSingleObject (input_mutex, INFINITE);
+	  get_ttyp ()->req_xfer_input = true;
+	  get_ttyp ()->pcon_start = true;
+	  get_ttyp ()->pcon_start_pid = myself->pid;
+	  WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
+	  ReleaseMutex (input_mutex);
+	}
       /* Attach to the pseudo console which already exits. */
       pinfo p (get_ttyp ()->pcon_pid);
       HANDLE pcon_owner =
-- 
2.30.1

