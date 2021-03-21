Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id BA1003858D29
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 23:28:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BA1003858D29
Received: from localhost.localdomain (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 12LNQsMF020384;
 Mon, 22 Mar 2021 08:27:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 12LNQsMF020384
X-Nifty-SrcIP: [118.243.84.61]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/3] Cygwin: pty: Clear input_available_event if pipe is
 empty on close.
Date: Mon, 22 Mar 2021 08:26:47 +0900
Message-Id: <20210321232647.56-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210321232647.56-1-takashi.yano@nifty.ne.jp>
References: <20210321232647.56-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 21 Mar 2021 23:28:07 -0000

- If apps read input from get_handle_cyg() directly by ReadFile(),
  input_available_event may remains signalled. This patch clears
  input_available_event if the pipe is empty on closing pty slave.
---
 winsup/cygwin/fhandler_tty.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 682264130..43e83b807 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -982,6 +982,9 @@ fhandler_pty_slave::close ()
   termios_printf ("closing last open %s handle", ttyname ());
   if (inuse && !CloseHandle (inuse))
     termios_printf ("CloseHandle (inuse), %E");
+  DWORD n;
+  if (bytes_available (n) && !n)
+    ResetEvent (input_available_event);
   if (!ForceCloseHandle (input_available_event))
     termios_printf ("CloseHandle (input_available_event<%p>), %E", input_available_event);
   if (!ForceCloseHandle (get_output_handle_cyg ()))
-- 
2.30.2

