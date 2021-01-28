Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 591743857C70
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 11:15:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 591743857C70
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 10SBERd2025778;
 Thu, 28 Jan 2021 20:15:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 10SBERd2025778
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: pty: Make slave read() thread-safe.
Date: Thu, 28 Jan 2021 20:14:09 +0900
Message-Id: <20210128111409.581-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128111409.581-1-takashi.yano@nifty.ne.jp>
References: <20210128111409.581-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 28 Jan 2021 11:15:42 -0000

- Currently slave read() is somehow not thread-safe. This patch
  fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 06fc19ac2..48b89ae77 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1241,6 +1241,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	time_to_wait = !vtime ? INFINITE : 100 * vtime;
     }
 
+wait_retry:
   while (len)
     {
       switch (cygwait (input_available_event, time_to_wait))
@@ -1319,6 +1320,11 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    }
 	  goto out;
 	}
+      if (!IsEventSignalled (input_available_event))
+	{ /* Maybe another thread has processed input. */
+	  ReleaseMutex (input_mutex);
+	  goto wait_retry;
+	}
 
       if (!bytes_available (bytes_in_pipe))
 	{
-- 
2.30.0

