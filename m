Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 3BC22385840D
 for <cygwin-patches@cygwin.com>; Tue,  2 Nov 2021 08:09:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3BC22385840D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 1A289bdg027089;
 Tue, 2 Nov 2021 17:09:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1A289bdg027089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1635840582;
 bh=xnKLixwgy0mV2ZC7whewoxmelJyMr61Fk6sLjMTzjvY=;
 h=From:To:Cc:Subject:Date:From;
 b=1mKdmCUZUuPxqzq4u+6wT3xqnxDoJz0H6UGZeY+t00gmpLopVPiOUKBUUTMaO2vuQ
 6Nv/dU7SzjJ6e0gEG68fJmHxG46ZuScViauKMhjAU5IiTDiegv/1xn0Gl3jViD3TuI
 jSLr5xayQjuE8C5pFa9/s7ouORfvPo5umVAYhSNnGtj1vhRkmCzBjrpDx4yuhv+/iJ
 X/1XcHM3UelWuIpmZsuVrdGfYIQoI7MmBhFDvbaztpafUsWm4ZA0QTS4cyYwqf7xBF
 M4ruR9zGmXtgs4Qa6PSKAf6bZUnIbaOuZWYT6ZYjSi+JH3TaT//AOci6k528Y+icpc
 Zxtt1i4pj9xqQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix yet another bug on input when signalled.
Date: Tue,  2 Nov 2021 17:09:40 +0900
Message-Id: <20211102080940.1694-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 02 Nov 2021 08:09:58 -0000

- Currently, read() returns EINTR due to a bug if signal handler
  is SIG_DFL and the process is suspended by Ctrl-Z and restarted.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_termios.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 012ecb356..b72f01f22 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -133,7 +133,8 @@ tty_min::kill_pgrp (int sig)
   siginfo_t si = {0};
   si.si_signo = sig;
   si.si_code = SI_KERNEL;
-  last_sig = sig;
+  if (sig > 0 && sig < _NSIG)
+    last_sig = sig;
 
   for (unsigned i = 0; i < pids.npids; i++)
     {
-- 
2.33.0

