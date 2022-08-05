Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id F10B73858D37
 for <cygwin-patches@cygwin.com>; Fri,  5 Aug 2022 09:01:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F10B73858D37
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135236.dynamic.ppp.asahi-net.or.jp
 [220.150.135.236]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 27590eGP010147;
 Fri, 5 Aug 2022 18:00:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 27590eGP010147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1659690046;
 bh=v7e9cWaxx7FGl8AS63NeqbCyDgC83aGyhBw0NPIOSYg=;
 h=From:To:Cc:Subject:Date:From;
 b=c8dUaRvihkhikx+Im6QkEd221rRu/UrwMzgPqt53h+sLJeeHIH6qD0RowqBBIFGYh
 YMlx1PdecFbv9gJ3eUAQAIkmvyKl0QAsQjeHitZCfjlhycZk5UuxjQCvdC+NaogfDQ
 ZqV+WNIlzyW6b9jTFOlGlhvrVINU0wmqZFIt2nQrTvmAJ5iFfgDh2OyHSqeURAzEy8
 xrvNf4Yv+GBeUWEU2ObieZ21oZ6oZyDveKlZCKLzOlcrFXaGttJ2tk5IngX68u9c6M
 c3ytIPkubPHmTtQowNdfzPD3CcgvbI0VFxUv3RwmzpOkomVjlaRH1dU62FiVPJ76zS
 EM6iG4FHbh3LA==
X-Nifty-SrcIP: [220.150.135.236]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix a small bug in is_console_app().
Date: Fri,  5 Aug 2022 18:00:29 +0900
Message-Id: <20220805090029.1559-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Fri, 05 Aug 2022 09:01:21 -0000

- Previsouly, there was potential risk of buffer over run in
  is_console_app(). This patch fixes the issue.
---
 winsup/cygwin/spawn.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4ec6a8789..d9d771651 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -207,7 +207,7 @@ is_console_app (WCHAR *filename)
   ReadFile (h, buf, sizeof (buf), &n, 0);
   CloseHandle (h);
   char *p = (char *) memmem (buf, n, "PE\0\0", 4);
-  if (p && p + id_offset <= buf + n)
+  if (p && p + id_offset < buf + n)
     return p[id_offset] == '\003'; /* 02: GUI, 03: console */
   else
     {
-- 
2.37.1

