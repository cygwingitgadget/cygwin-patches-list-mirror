Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 206023858C2D
 for <cygwin-patches@cygwin.com>; Fri,  6 May 2022 18:46:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 206023858C2D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 246IkWt2002049;
 Sat, 7 May 2022 03:46:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 246IkWt2002049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1651862799;
 bh=Tiurq20CJ4e9iMM0bC1bSmLoHP7YcPA53NgEX1LoAZ8=;
 h=From:To:Cc:Subject:Date:From;
 b=luThe7N+Yn7gA0DMGB3X99zZSxUO4Exl0ber9Ch5y7nIb7LhlD+lcz5zz1XgnFcW5
 nkq1WuCc3fOdbtPfElehxLMI582xjXZvVYcoeMTaJhY+hgcr+ZezzWnSPn0LXveh9k
 wOM26BDAkYUgR7OnxYNfLtOwkn70UGvw4+9D4iI7glLzqKt2NMRjyThR4Hl1fAUYl1
 9cLymepavaJ3K9dYeHkXaRYyDo2eDwqsPxNhKoLpztqN8gT04LDpXTpJAYAy+C4+B6
 1JCpn0HybnY4gwIVI24o+SVanjr4PYwVJS2CH/ffdFR1TCzAwxOTZlh9LJg4sWY1wC
 c1ibT8vkNSdLQ==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: sigproc: Avoid segfault caused by signal just after
 fork().
Date: Sat,  7 May 2022 03:46:27 +0900
Message-Id: <20220506184627.1650-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Fri, 06 May 2022 18:46:58 -0000

- The commit "Cygwin: always add sigmask to child info" also tries
  to fix this issue, however, did not fix enough. This patch fixes
  that.
---
 winsup/cygwin/sigproc.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 987dfea37..a70c3b6f6 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1356,9 +1356,9 @@ wait_sig (VOID *)
 	     when _main_tls points to the system-allocated stack, not to
 	     the parent thread. In that case find_tls fails, and we fetch
 	     the sigmask from the child_info passed from the parent. */
-	  tl_entry = cygheap->find_tls (_main_tls);
-	  if (tl_entry)
+	  if (cygwin_finished_initializing)
 	    {
+	      tl_entry = cygheap->find_tls (_main_tls);
 	      dummy_mask = _main_tls->sigmask;
 	      cygheap->unlock_tls (tl_entry);
 	    }
-- 
2.36.0

