Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 3D15B3857810
 for <cygwin-patches@cygwin.com>; Fri,  3 Dec 2021 03:18:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3D15B3857810
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 1B33IHQ2004583;
 Fri, 3 Dec 2021 12:18:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1B33IHQ2004583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1638501502;
 bh=7fiXG1dbacnAZrw55e/KDzVQp+cGzgsekWv8R8P1cFE=;
 h=From:To:Cc:Subject:Date:From;
 b=xaNBBNDOl/pao3S+yS8jjRhuCquoaO1z+HscMAHfhDWvcs9sJvj7vDETbdL1bL3ma
 lh43nL+6HsGQvm/hZbJMbFJbV3caECll8HDFMH/tc1nuHreGfzRUm2wpULQYEaR9tY
 Ml7VknpgCfkvikcQjpRO1EY4gsB6IrWd61tZZ3gYaaDGlM/Bm0bjpsJh/EM9UxxVNk
 1VP4LWQxYdxgFCkuJkv6g3eGtEG9ah8OZoMnaV6vF9G5uSIES8WP344wVkPNw3XxTD
 E8R/b0487w1ukBXc9lVnIEIqdh5g5yYUM176YawvlgWCnbyVb6CJPdzfWTM8+weeNn
 gw6N+Kn+zZjTw==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Fix typo in new-features.xml
Date: Fri,  3 Dec 2021 12:18:17 +0900
Message-Id: <20211203031817.11640-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Fri, 03 Dec 2021 03:19:02 -0000

---
 winsup/doc/new-features.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index e05ffe38e..4fdfafc24 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -4,7 +4,7 @@
 
 <sect1 id="ov-new"><title>What's new and what changed in Cygwin</title>
 
-<sect2 id="ov-new3.4"><title>What's new and what changed in 3.3</title>
+<sect2 id="ov-new3.4"><title>What's new and what changed in 3.4</title>
 
 <itemizedlist mark="bullet">
 
-- 
2.33.0

