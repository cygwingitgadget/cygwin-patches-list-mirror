Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 6AC353857C7A
 for <cygwin-patches@cygwin.com>; Sat, 20 Feb 2021 22:45:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6AC353857C7A
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 11KMjJVw022471;
 Sun, 21 Feb 2021 07:45:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 11KMjJVw022471
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
Date: Sun, 21 Feb 2021 07:45:16 +0900
Message-Id: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 20 Feb 2021 22:45:43 -0000

- After commit 253352e796ff9ec9a447e5375f5bc3e2b92b5293, mc (midnight
  commander) crashes with segfault if the shell is bash. This is due
  to NULL pointer access in read(). This patch fixes the issue.
  Addresses::
    https://cygwin.com/pipermail/cygwin/2021-February/247870.html
---
 winsup/cygwin/fhandler_tty.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index d30041af1..3fcaa8277 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1474,8 +1474,11 @@ wait_retry:
 out:
   termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
-  bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
-  mask_switch_to_pcon_in (false, saw_eol);
+  if (ptr0)
+    { /* Not tcflush() */
+      bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
+      mask_switch_to_pcon_in (false, saw_eol);
+    }
 }
 
 int
-- 
2.30.0

