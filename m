Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id E3A473858D39
 for <cygwin-patches@cygwin.com>; Sat,  5 Mar 2022 09:24:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E3A473858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 2259OXNk013046;
 Sat, 5 Mar 2022 18:24:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2259OXNk013046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646472277;
 bh=pwPJaMX9tna1mfiuFcaDD+HLOUidxJ1h6ggO8HSVwSM=;
 h=From:To:Cc:Subject:Date:From;
 b=txUElbGOqoYhdiQN4Dx2NfPGBAifPCpmD3hOBmZ75khCOKLV+aCOw3hxF7arRegOC
 G8Yeg36aHUTDOwsKIDTmObd8rKcEhuE/zXkwmHOgzru4BbKwbmUlOF+HXiGIdOsWY0
 +wamDD9GKuhFpj9kHPGxTJd78cuk98gsS9jJZqNbIpq7a7ljf33zBkMckXENRjGhLO
 5Z6fyb2MW8ifB3UGaMNayndJ4mya+fcMpETHrU537x9cL7vaHAREaAYqgkaOyobR4Y
 6e0P9fa061elMusZyfObTfMT0Oqagj2mjeDPqEcR0hgolgZCpyoamVgKz2g181j9Jk
 xyqrHvBz51sew==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: update 3.3.5 release notes
Date: Sat,  5 Mar 2022 18:24:23 +0900
Message-Id: <20220305092423.6248-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Sat, 05 Mar 2022 09:24:55 -0000

---
 winsup/cygwin/release/3.3.5 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/release/3.3.5 b/winsup/cygwin/release/3.3.5
index 11698c4e4..ce7a21268 100644
--- a/winsup/cygwin/release/3.3.5
+++ b/winsup/cygwin/release/3.3.5
@@ -23,6 +23,14 @@ Bug Fixes
   Addresses:
   https://github.com/GitCredentialManager/git-credential-manager/issues/576
 
+- Fix some problems such as:
+   1) If output of non-cygwin app and input of cygwin app are connected
+      by a pipe, Ctrl-C has to be sent twice to stop apps when the
+      cygwin app does not read stdin at the moment.
+   2) In cmd.exe started from cygwin shell, if output of non-cygwin
+      app and input of cygwin app are connected by a pipe, Ctrl-C
+      can never terminate the apps.
+
 - Fix exit code when non-cygwin app is terminated by Ctrl-C.
 
 - Fix a bug that the order of the console key inputs are occasionally
-- 
2.35.1

