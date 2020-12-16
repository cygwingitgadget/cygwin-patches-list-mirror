Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 281BA3844011
 for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2020 09:10:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 281BA3844011
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 0BG9ACD8024844;
 Wed, 16 Dec 2020 18:10:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0BG9ACD8024844
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Check response for CSI6n more strictly.
Date: Wed, 16 Dec 2020 18:10:15 +0900
Message-Id: <20201216091016.1890-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 16 Dec 2020 09:10:45 -0000

- Previous code to read response for CSI6n allows invalid response
  such as "CSI Pl; Pc H" other than correct response "CSI Pl; Pc R".
  With this patch, the response is checked more strictly.
---
 winsup/cygwin/fhandler_tty.cc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5f38ca8d3..77d9d9b47 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2682,7 +2682,9 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 	  len -= n;
 	  *p = '\0';
 	  char *p1 = strrchr (buf, '\033');
-	  if (p1 == NULL || sscanf (p1, "\033[%d;%dR", &y1, &x1) != 2)
+	  char c;
+	  if (p1 == NULL || sscanf (p1, "\033[%d;%d%c", &y1, &x1, &c) != 3
+	      || c != 'R')
 	    continue;
 	  wait_cnt = 0;
 	  break;
@@ -2715,7 +2717,9 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
       len -= n;
       *p = '\0';
       char *p2 = strrchr (buf, '\033');
-      if (p2 == NULL || sscanf (p2, "\033[%d;%dR", &y2, &x2) != 2)
+      char c;
+      if (p2 == NULL || sscanf (p2, "\033[%d;%d%c", &y2, &x2, &c) != 3
+	  || c != 'R')
 	continue;
       break;
     }
-- 
2.29.2

