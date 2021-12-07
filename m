Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id BA3A93858000
 for <cygwin-patches@cygwin.com>; Tue,  7 Dec 2021 13:33:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BA3A93858000
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 1B7DX06N002198;
 Tue, 7 Dec 2021 22:33:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1B7DX06N002198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1638883987;
 bh=lHsNFL1RT+9nC4vRc5PWj1TOlYHBPw3BbYdbY7DMXRI=;
 h=From:To:Cc:Subject:Date:From;
 b=bigey3tVDJhY1KlvfLKRFIA7NF8EwF5C655xfBFunXW25+p/GlI/bC05xKfPNSA+A
 u/6dqxTXwlFu7krE4VKhf5TUeRwjL3N7ZDlK6m7CUEnz8Ao454G2qy5m1e7453x7WJ
 CZh6n2sZEL9aiyv3jOj/MJocskocMt96o/6FjNAckJEIdcPOkL8iXdUtS0S+OQU4dH
 Ud234CHcRYAk0HEBOaDIiSBG0ZcVBkZvYrc/w28bns2adASlIsD1QzY3YU4kptkicG
 eE+Ts2dMr+gOHAJz1dSTxJwr9oOFt2kMUjcIej2lfPSSnLVaHtO/Hd30u60YinnpTM
 vfHMTbfTqHJXA==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: clipboard: Fix a bug in read().
Date: Tue,  7 Dec 2021 22:32:52 +0900
Message-Id: <20211207133252.751-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
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
X-List-Received-Date: Tue, 07 Dec 2021 13:33:23 -0000

- Fix a bug in fhandler_clipboard::read() that the second read fails
  with 'Bad address'.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-December/250141.html
---
 winsup/cygwin/fhandler_clipboard.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index 0b87dd352..ae10228a7 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
       if (pos < (off_t) clipbuf->cb_size)
 	{
 	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
-	  memcpy (ptr, &clipbuf[1] + pos , ret);
+	  memcpy (ptr, (char *) &clipbuf[1] + pos, ret);
 	  pos += ret;
 	}
     }
-- 
2.34.1

