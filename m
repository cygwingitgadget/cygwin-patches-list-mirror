Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id BFEEE384B009
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 11:04:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BFEEE384B009
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 0ANB3DwB027048;
 Mon, 23 Nov 2020 20:03:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 0ANB3DwB027048
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/3] Cygwin: pty: Fix minor style issue.
Date: Mon, 23 Nov 2020 20:03:04 +0900
Message-Id: <20201123110304.1368-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123110304.1368-1-takashi.yano@nifty.ne.jp>
References: <20201123110304.1368-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 23 Nov 2020 11:04:20 -0000

---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3d58cc7df..422d7349d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2043,7 +2043,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  /* Remove CSI > Pm m */
 	  int state = 0;
 	  int start_at = 0;
-	  for (DWORD i=0; i<rlen; i++)
+	  for (DWORD i = 0; i < rlen; i ++)
 	    if (outbuf[i] == '\033')
 	      {
 		start_at = i;
-- 
2.29.2

