Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 1A46F3858C52
 for <cygwin-patches@cygwin.com>; Mon,  9 May 2022 03:35:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1A46F3858C52
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 2493YaVN009536;
 Mon, 9 May 2022 12:34:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2493YaVN009536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652067284;
 bh=ISzWRSzjRfaFg/bf0lObDRoAxOLn3JJOkT0gxEpT4o4=;
 h=From:To:Cc:Subject:Date:From;
 b=n2p9Yo1C+qazmyom+A6d4A4PK8KxJdAMH/SXTdLlpfBSex3sIlm17D9GlqMdw6v5Q
 s/3wHRWv//HyoM4LAGPLbfLj2unvln16am9B7VBNkHHmIMoadpl3wD+gFh+/777mtx
 AnFfaRKJRO/FuYjw561VVA84/O9+K8wdgxO5wZay3QEtpfBkuaXxuOzkD2xgBclUiq
 CzCxXJsutqMJrpkpTNv5LmQbvEmlK9BVM5XZ9Lq/t2ULQCvHhznI7M9N1LAMlNBhpJ
 s6N3hAUJLTiWfYQQ0LZ/rF1tpwXpGU/Lqdj88HEqoMAfKhh8mzRTLyyYjHlIXH8UQp
 bi++HpeDIqoOg==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Not to change code page of parent console.
Date: Mon,  9 May 2022 12:34:36 +0900
Message-Id: <20220509033436.829-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 09 May 2022 03:35:13 -0000

- The recent commit "Cygwin: pty: Fix timing of creating invisible
  console." breaks the feature added by commit 72770148, which
  prevents pty from changing code page of parent console. This patch
  restores that.
---
 winsup/cygwin/fhandler_console.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 5625b7be2..933614228 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1610,7 +1610,7 @@ fhandler_console::close ()
   if (con_ra.rabuf)
     free (con_ra.rabuf);
 
-  if (!have_execed)
+  if (!have_execed && !invisible_console)
     free_console ();
   return 0;
 }
-- 
2.36.0

