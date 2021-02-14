Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id AD3B7385802B
 for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2021 18:48:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AD3B7385802B
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 11EIluTw011057;
 Mon, 15 Feb 2021 03:48:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 11EIluTw011057
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix a bug in input transfer for GDB.
Date: Mon, 15 Feb 2021 03:47:51 +0900
Message-Id: <20210214184752.716-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 14 Feb 2021 18:48:41 -0000

- With this patch, not only NL but also CR is treated as a line end
  in the code checking if input transfer is necessary.
---
 winsup/cygwin/fhandler_tty.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f6eb3ae4d..5afede859 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1181,7 +1181,7 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
   /* In GDB, transfer input based on setpgid() does not work because
      GDB may not set terminal process group properly. Therefore,
      transfer input here if isHybrid is set. */
-  if (get_ttyp ()->switch_to_pcon_in && !!masked != mask && xfer && isHybrid)
+  if (isHybrid && !!masked != mask && xfer)
     {
       if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 	{
@@ -1471,7 +1471,8 @@ wait_retry:
 out:
   termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
-  mask_switch_to_pcon_in (false, totalread > 0 && ptr0[totalread - 1] == '\n');
+  bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
+  mask_switch_to_pcon_in (false, saw_eol);
 }
 
 int
-- 
2.30.0

