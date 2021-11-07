Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 649E63858406
 for <cygwin-patches@cygwin.com>; Sun,  7 Nov 2021 03:47:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 649E63858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1A73lHDT023086;
 Sun, 7 Nov 2021 12:47:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1A73lHDT023086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1636256843;
 bh=447rV6RSXEzSD+OrFvf2zjknfNtQw6QECQOYjPNL51E=;
 h=From:To:Cc:Subject:Date:From;
 b=hx7VsDg5FfxCimuB+gPDB/H/pUEPhy+4hsmXTimRF7Tvp6aqSGmlIN5PRTiRx5S97
 AKnwoLQitdMLxrhAfNKJRku30N/eAeQkPCRddPko7NdbjbBNQaL/kxDeOoXwgja1fk
 /BufxuL0wJFJGyi7F+P3jsXEBi6MV1NI1jv2HLy9UbunzrB4SlxoglQ53eRWa117JP
 jngyToMAcmMHm5ZRIzjqS7ZJsMPEinUaaNzHMUfEfYmMPKxc0G5ZaJGjisRwLQaB4w
 xRqSVGaw6vQX8haTwYlSXPYPQZ+lFRLwhpgkag9A8cKz73qvFcLDyVkr4ZHFjLK8dy
 QMxnqy/oBtkZw==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Avoid false EOF while reading output of C#
 programs.
Date: Sun,  7 Nov 2021 12:47:18 +0900
Message-Id: <20211107034718.1048-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 07 Nov 2021 03:47:54 -0000

- If output of C# program is redirected to pipe, pipe reader falsely
  detects EOF. This happens after overhaul of pipe implementation.
  This patch fixes the issue.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-November/249777.html
---
 winsup/cygwin/fhandler_pipe.cc | 3 ++-
 winsup/cygwin/release/3.3.2    | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index 43771e8f7..bc06d157c 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -393,7 +393,8 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 	    }
 	}
 
-      if (nbytes_now == 0 || status == STATUS_BUFFER_OVERFLOW)
+      if ((nbytes_now == 0 && !NT_SUCCESS (status))
+	  || status == STATUS_BUFFER_OVERFLOW)
 	break;
     }
   ReleaseMutex (read_mtx);
diff --git a/winsup/cygwin/release/3.3.2 b/winsup/cygwin/release/3.3.2
index 263c3efe6..2e48e39be 100644
--- a/winsup/cygwin/release/3.3.2
+++ b/winsup/cygwin/release/3.3.2
@@ -8,3 +8,7 @@ Bug Fixes
   Addresses: https://sourceware.org/pipermail/newlib/2021/018626.html
 
 - Fix a permission problem when writing ACLs on Samba.
+
+- Fix the issue that pipe reader falsely detects EOF if the output of
+  the C# program is redirected to the pipe.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249777.html
-- 
2.33.0

