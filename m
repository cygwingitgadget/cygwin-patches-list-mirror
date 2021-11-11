Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 455E63858408
 for <cygwin-patches@cygwin.com>; Thu, 11 Nov 2021 08:20:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 455E63858408
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 1AB8JXpR016010;
 Thu, 11 Nov 2021 17:19:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1AB8JXpR016010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1636618779;
 bh=kuzYgOmo7YKlHDE5qdFNiSU8No0/+UzelAEa2kHgr7s=;
 h=From:To:Cc:Subject:Date:From;
 b=q2mc+ANegg6neRHv+dUvb7IklEFy4hMRLQR6woiVpzY+R0s2+8whhZY0NxcpOXvCX
 z5xyhL3rxiRUaGAHLOt6rjlTA3TgsfFxd9utR5HFenR3k751b+o/n4FdR+5S0AqFTz
 lReUXF+/T06a2cK4iGvB+Y8JFs6sNFjy+TnTsv7T7IXXRKNY3IX56hkrKMnPsQ/rfq
 +ejj1FBpbJ4qBWgeP32xKpduSp+U9gUYtK1E8246OPR03m8OmKSEt5Ci78VKPrjRZs
 ivkRkvOo4rQNLXupTmC+aWyw5eFMqiB4Svcbw9eX0H8ryPncQuyLsbjZe4YaqWvWDp
 ap14tPzBYTwKQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Fix raw_write() for non-cygwin pipe with size
 zero.
Date: Thu, 11 Nov 2021 17:19:23 +0900
Message-Id: <20211111081923.802-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 11 Nov 2021 08:20:09 -0000

- Currently, raw_write() fails to handle size zero pipe which may
  be created by non-cygwin apps (e.g. Windows native ninja). This
  patch fixes the issue.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-November/249844.html
---
 winsup/cygwin/fhandler_pipe.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index 13731437e..9392a28c1 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -449,7 +449,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       return -1;
     }
 
-  if (len <= pipe_buf_size)
+  if (len <= pipe_buf_size || pipe_buf_size == 0)
     chunk = len;
   else if (is_nonblocking ())
     chunk = len = pipe_buf_size;
-- 
2.33.0

