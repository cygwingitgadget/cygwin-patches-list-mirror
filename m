Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 2834B3858406
 for <cygwin-patches@cygwin.com>; Mon, 22 Nov 2021 16:22:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2834B3858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 1AMGLru5027062;
 Tue, 23 Nov 2021 01:21:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1AMGLru5027062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637598118;
 bh=6iDKJg4NLrtKQZUMxNXOR12x7ryKVJs9/GlvS5ug/gQ=;
 h=From:To:Cc:Subject:Date:From;
 b=y6bZ8toZm/JkGnDUpNonyj1D84Y0hIqISMn/xmSpUphVn8p38eSIgB5CHRurvwPPU
 MaIkN/4ObVFcgL3MqguxxvVivjwrnP9ZrS8Uly2F0fkMlzVPOUOkIYJLMOX8AyZcRS
 Dx8GmEMf2chVf1KlmSGfJV2GuN5GCdh2J04UpuRrALWbnS9xYJY7UeQ3yQo/KvJz9M
 b0cabpCnabeqo8TspwEFG0Q21RMyXYfZvop/jTnXu+7Di71E+3NkI85LSYfcczdlat
 ahDgwo1uMN/aUT69x7WeKqVnesQatkjaKiqoHYX8JXPmCukSknubqpg9QbNgfwVoQ0
 bbZqDsN1qcUpw==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Fix release note 3.3.3.
Date: Tue, 23 Nov 2021 01:21:47 +0900
Message-Id: <20211122162147.4108-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 22 Nov 2021 16:22:31 -0000

- Removes the bug fix entry that was accidentally added to the
  release notes 3.3.3, even though it had been already fixed in
  3.3.2.
---
 winsup/cygwin/release/3.3.3 | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/winsup/cygwin/release/3.3.3 b/winsup/cygwin/release/3.3.3
index 908ebe402..8d1752b56 100644
--- a/winsup/cygwin/release/3.3.3
+++ b/winsup/cygwin/release/3.3.3
@@ -1,10 +1,6 @@
 Bug Fixes
 ---------
 
-- Fix issue that new pipe code doesn't handle reading zero byte reads
-  emitted by some non-Cygwin apps.
-  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249777.html
-
 - Fix issue that new pipe code doesn't handle size zero pipe which
   may be created by non-cygwin apps.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249844.html
-- 
2.33.0

