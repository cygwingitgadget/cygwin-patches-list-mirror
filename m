Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 87EB8388A029
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 11:52:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 87EB8388A029
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 13JBpsai000515;
 Mon, 19 Apr 2021 20:51:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 13JBpsai000515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618833118;
 bh=wVUMwQEFjR0JauMbohUOFYQW34xdHl6PdRTSz36QZcg=;
 h=From:To:Cc:Subject:Date:From;
 b=E2RpEAKrjaK+ttzYpgMsw3TbuRqXixVJoYkKTd6ZFufwq//JiAn0oOCfiz0O3Nyv7
 6dcF5adq0ksR3IZWebh4Ny4C45BgJtstjHSKxixtBbd6imwtLsJAkuIsDHmEcbLPz2
 0UoH8o7l7X/KocMJVwjetzXW+88dr+RmnZN+xhBf0VSyfaI4rQLQcEOhv1GyD26UVU
 8Wz8Fb8yQO6zzk3kCeFGBLYkIOQFXT2aePtpgE0h6xLwk2XUsedd75SNC3ALtx7MWX
 orguj+0ePKQKxkgJpdvoTJEKR0IVvscYz92hP7AMZZEEm5XmmKwNjX2S/r/Uj3nScW
 Br1BBCBiVpJ2Q==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Make rlwrap work with cmd.exe.
Date: Mon, 19 Apr 2021 20:51:53 +0900
Message-Id: <20210419115153.1983-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
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
X-List-Received-Date: Mon, 19 Apr 2021 11:52:40 -0000

- After the commit 919dea66, "rlwrap cmd" fails to start pseudo
  console. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index ba9f4117f..d44728795 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1170,6 +1170,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   if (isHybrid)
     return;
+  if (get_ttyp ()->pcon_start)
+    return;
   WaitForSingleObject (pcon_mutex, INFINITE);
   if (!pcon_pid_self (get_ttyp ()->pcon_pid)
       && pcon_pid_alive (get_ttyp ()->pcon_pid))
-- 
2.31.1

