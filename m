Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 0E05E3846035
 for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2020 08:26:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0E05E3846035
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 0BE8Q8MV002330;
 Mon, 14 Dec 2020 17:26:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0BE8Q8MV002330
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Revise the code for timeout in
 term_has_pcon_cap().
Date: Mon, 14 Dec 2020 17:26:09 +0900
Message-Id: <20201214082609.679-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 14 Dec 2020 08:26:49 -0000

- Sometimes timeout period in term_has_pcon_cap() may not be enough
  when the machine slows down for some reason. This patch eases the
  issue. In the new code, effective timeout period is expected to be
  extended as a result due to slowing-down the wait loop as well when
  the machine gets into busy.
---
 winsup/cygwin/fhandler_tty.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 845e51184..04a9a2bf5 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2651,7 +2651,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   char *p;
   int len;
   int x1, y1, x2, y2;
-  DWORD t0;
+  int wait_cnt = 0;
 
   /* Check if terminal has ANSI escape sequence. */
   if (!has_ansi_escape_sequences (env))
@@ -2668,7 +2668,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   ReleaseMutex (input_mutex);
   p = buf;
   len = sizeof (buf) - 1;
-  t0 = GetTickCount ();
   do
     {
       if (::bytes_available (n, get_handle ()) && n)
@@ -2680,9 +2679,10 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 	  char *p1 = strrchr (buf, '\033');
 	  if (p1 == NULL || sscanf (p1, "\033[%d;%dR", &y1, &x1) != 2)
 	    continue;
+	  wait_cnt = 0;
 	  break;
 	}
-      else if (GetTickCount () - t0 > 40) /* Timeout */
+      else if (++wait_cnt > 100) /* Timeout */
 	goto not_has_csi6n;
       else
 	Sleep (1);
-- 
2.29.2

