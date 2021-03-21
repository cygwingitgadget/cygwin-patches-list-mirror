Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id C523B3858D29
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 23:27:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C523B3858D29
Received: from localhost.localdomain (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 12LNQsMB020384;
 Mon, 22 Mar 2021 08:27:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 12LNQsMB020384
X-Nifty-SrcIP: [118.243.84.61]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/3] Cygwin: syscalls.cc: Make _get_osfhandle() return
 appropriate handle.
Date: Mon, 22 Mar 2021 08:26:45 +0900
Message-Id: <20210321232647.56-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210321232647.56-1-takashi.yano@nifty.ne.jp>
References: <20210321232647.56-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 21 Mar 2021 23:27:37 -0000

- Currently, _get_osfhandle() returns input handle for pty even for
  stdout and stdout. This patch fixes the issue. Also, setup_locale()
  is called to make sure the charset conversion works for output.
---
 winsup/cygwin/syscalls.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 6ba4f10f7..205d15951 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3223,7 +3223,18 @@ _get_osfhandle (int fd)
 
   cygheap_fdget cfd (fd);
   if (cfd >= 0)
-    res = (long) cfd->get_handle ();
+    {
+      if (cfd->get_major () == DEV_PTYS_MAJOR)
+	{
+	  fhandler_pty_slave *ptys =
+	    (fhandler_pty_slave *) (fhandler_base *) cfd;
+	  ptys->setup_locale ();
+	}
+      if (fd == 1 || fd == 2)
+	res = (long) cfd->get_output_handle ();
+      else
+	res = (long) cfd->get_handle_cyg ();
+    }
   else
     res = -1;
 
-- 
2.30.2

