Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id C0ECC3858426
 for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021 08:24:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C0ECC3858426
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 1AA8No2I014749;
 Wed, 10 Nov 2021 17:23:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1AA8No2I014749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1636532635;
 bh=3/jQghYoKEZCn5TmsM/1VrMvUUwqQZyDiojoZ5JmDZU=;
 h=From:To:Cc:Subject:Date:From;
 b=1mfi0Nu1EB8Va9vALuyZALexr9QlmIV7HAkcE2NudL7oCiXCs/uNngK+HinoE9ryB
 mlNPBOQk+2l8QcyAIh7Hgk6wVpoW2cZ5348h8p+Bfms3vpgba4PfkeHd2oohadUJTM
 BYXsZPd48D2UmiSctJEZUDgl/vpVdEeBCFkILBt7H4t0DlJBF1UR367KFQxjTCj6Rg
 KeLMvHZYTRfqr4S4wUM5JawJBJwsVxV0IbwvEAb/gRmPw35jTRsJkcfWWq0D+z8qCv
 gKprNGpMj2vkOD3vQYNVB/9HSluZhzGgoSRU70djtp35DezzlWH6E3268e+WgZw2MU
 u6UiYGKEKE0iw==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Handle WAIT_CANCELED when waiting read_mtx.
Date: Wed, 10 Nov 2021 17:23:52 +0900
Message-Id: <20211110082352.1253-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 10 Nov 2021 08:24:11 -0000

- Add missing handling for WAIT_CANCELED in cygwait() for read_mtx
  in raw_read().
---
 winsup/cygwin/fhandler_pipe.cc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index bc06d157c..13731437e 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -302,10 +302,18 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
       set_errno (EAGAIN);
       len = (size_t) -1;
       return;
-    default:
+    case WAIT_SIGNALED:
       set_errno (EINTR);
       len = (size_t) -1;
       return;
+    case WAIT_CANCELED:
+      pthread::static_cancel_self ();
+      /* NOTREACHED */
+    default:
+      /* Should not reach here. */
+      __seterrno ();
+      len = (size_t) -1;
+      return;
     }
   while (nbytes < len)
     {
-- 
2.33.0

