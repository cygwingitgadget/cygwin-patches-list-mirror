Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id AC1E0385800D
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 11:03:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AC1E0385800D
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 0ANB3Dw7027048;
 Mon, 23 Nov 2020 20:03:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 0ANB3Dw7027048
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/3] Cygwin: pty: Fix a bug in the code removing "CSI > Pm
 m".
Date: Mon, 23 Nov 2020 20:03:02 +0900
Message-Id: <20201123110304.1368-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123110304.1368-1-takashi.yano@nifty.ne.jp>
References: <20201123110304.1368-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 23 Nov 2020 11:03:50 -0000

- The code added by 8121b606e843c001d5ca5213d24099e04ebc62ca has a
  bug which fails to remove multiple "CSI > Pm m" sequences. This
  patch fixes the bug.
---
 winsup/cygwin/fhandler_tty.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 600de085c..911945675 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2063,6 +2063,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
 		rlen = wlen = start_at + rlen - i - 1;
 		state = 0;
+		i = start_at - 1;
 		continue;
 	      }
 	    else
-- 
2.29.2

