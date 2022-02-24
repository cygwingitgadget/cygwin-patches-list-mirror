Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 089203858402
 for <cygwin-patches@cygwin.com>; Thu, 24 Feb 2022 13:44:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 089203858402
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 21ODhgVk006593;
 Thu, 24 Feb 2022 22:43:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21ODhgVk006593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645710227;
 bh=t4a0p5WUiOpzloTOP5wrGGsBRhwu+AhfA1RwFIjOLiA=;
 h=From:To:Cc:Subject:Date:From;
 b=A7ktBztmrr+BOuCGASIHqvMqCwL/IB0GR29aVASRFIIadRIZGjJVK8Xmxu4nhc16S
 TSEi2hQuTywkIUU60uCWgDPOBFulYAZL2Q3+vqXucPv+LpnU+6xuXayOegkxYiC7K9
 tvoVJrN9HcuwEMWz7Uilm57A2+TZDg8zkP6/4rSsfSv4Q+jUhqKIW69w2061UI5jRU
 zw9vbMCbBtfyLUh3RIFJxRObT6b0x7pcdY7s8HI3KVDiC2741wBNP2b4UNHvS029Zt
 rFNakHagmRM1m4iY/BOI5h5GGsTSBJLX9VWpIdGPF0jsSJOAUvpRRs9q21tAJFa0+V
 mHl6Gzwg6l9Bw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pinfo: Fix exit code when non-cygwin app exits by
 Ctrl-C.
Date: Thu, 24 Feb 2022 22:43:35 +0900
Message-Id: <20220224134335.603-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
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
X-List-Received-Date: Thu, 24 Feb 2022 13:44:15 -0000

- Previously, if non-cygwin app exits by Ctrl-C, exit code was
  0x00007f00. With this patch, the exit code will be 0x00000002,
  which means process exited by SIGINT.
---
 winsup/cygwin/pinfo.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index bce743bfc..bb7c16547 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -156,6 +156,9 @@ pinfo::status_exit (DWORD x)
 	 a lengthy small_printf instead. */
       x = SIGBUS;
       break;
+    case STATUS_CONTROL_C_EXIT:
+      x = SIGINT;
+      break;
     default:
       debug_printf ("*** STATUS_%y\n", x);
       x = 127 << 8;
-- 
2.35.1

