Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 627643858C27
 for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2021 08:09:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 627643858C27
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 1AH896YO024830;
 Wed, 17 Nov 2021 17:09:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1AH896YO024830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637136553;
 bh=d1IRSe9vYFEFwGF/rvdQOKnz5NI7KRzqL7Ec4YwM4SM=;
 h=From:To:Cc:Subject:Date:From;
 b=vE7+vnWPg1uqRuEbynIfOamOhq6rSS2pIin7Dk7EMsEtBUU6VYhRPxkG2qRxfLjX4
 YUD/h0cZwdqZ+frQ82M4kmhWd41nl09QlrGUtDDKnLIhGRNhEJz9tA/0+TSvIy5k11
 6QlO4hMXQ8YesZ9JBUEh7gOUihykdC7/9QdxBHPWrLGAAsOkkIEglBKHbdWedK2Hjs
 Htr2NYdA2OJOcC+biaB3A50ZAl2uFGv6dvJs4zUhVK0Vy0P2C/qbORrZpkPYrQuHXG
 4bIQPY+3WdmMx2lOHmm+IMmQub5nHke6JExQShimHt92EGZoLwQNDwbBEk0o4s+gkk
 n+p2VOYC/5BHQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Correct the release notes 3.3.3.
Date: Wed, 17 Nov 2021 17:09:08 +0900
Message-Id: <20211117080908.1811-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 17 Nov 2021 08:09:29 -0000

- Fix incorrect description of the bug fixes part.
---
 winsup/cygwin/release/3.3.3 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/release/3.3.3 b/winsup/cygwin/release/3.3.3
index 7248302a3..c947816db 100644
--- a/winsup/cygwin/release/3.3.3
+++ b/winsup/cygwin/release/3.3.3
@@ -3,6 +3,10 @@ Bug Fixes
 
 - Fix issue that new pipe code doesn't handle reading zero byte reads
   emitted by some non-Cygwin apps.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249777.html
+
+- Fix issue that new pipe code doesn't handle size zero pipe which
+  may be created by non-cygwin apps.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249844.html
 
 - Make sure that "X:" paths are not handled as absolute DOS paths in
-- 
2.33.0

