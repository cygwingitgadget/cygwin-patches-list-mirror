Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 363E33856DF1
 for <cygwin-patches@cygwin.com>; Sat, 28 May 2022 14:21:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 363E33856DF1
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 24SEKuOT028488;
 Sat, 28 May 2022 23:21:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24SEKuOT028488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1653747663;
 bh=DmyMbu1AGRJ8a1Zla+HDMdmY4iRVNhJT7Avke4Rfipg=;
 h=From:To:Cc:Subject:Date:From;
 b=Korn1amNJdDK5wV3hB4McjxPf0CCFgq7w01FCn70jV02Ah3ajo+B5ArnzFL5DX2eC
 blCs8isKHZMaRTJxm+Vzv+F6NUSSTz99jpQIddYGhtzar9+voroEGoZrBvgjVAKDNm
 MIDC7M/2qSVOsH+RIo/Qk5t4rYs0NzavmI5XavTEOGSLixJn1bmrss3nikT8UGDBiX
 ZE+rFzFOOQpMPrXhQhBO0L8nFbeE7ZNTtnGqm8nPyZdEmMYVS7WDexIYmp5xl1M+h/
 I2PASwWI1wPaJBkYNRdxWYqU9TwITtEzb3vkYYG+oEV7UayA7Jl8wqkUJRZRtf3hMh
 1mIMXZM8yb8rQ==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: cygheap: Fix the issue of cygwin1.dll in the root
 directory.
Date: Sat, 28 May 2022 23:20:45 +0900
Message-Id: <20220528142045.8402-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 28 May 2022 14:21:23 -0000

- After the commit 6d898f43, cygwin fails to start if cygwin1.dll
  is placed in the root directory. This patch fixes the issue.
Addresses: https://cygwin.com/pipermail/cygwin/2022-May/251548.html
---
 winsup/cygwin/cygheap.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/cygheap.cc b/winsup/cygwin/cygheap.cc
index 01b49468e..1a817b743 100644
--- a/winsup/cygwin/cygheap.cc
+++ b/winsup/cygwin/cygheap.cc
@@ -183,6 +183,11 @@ init_cygheap::init_installation_root ()
 	  if (p)
 	    p = wcschr (p + 1, L'\\');  /* Skip share name */
 	}
+      else /* Long path prefix followed by drive letter path */
+	{
+	  len = 4;
+	  p += 4;
+	}
     }
   installation_root_buf[1] = L'?';
   RtlInitEmptyUnicodeString (&installation_key, installation_key_buf,
-- 
2.36.1

