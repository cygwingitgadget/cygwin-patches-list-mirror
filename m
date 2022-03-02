Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 449383858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 02:15:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 449383858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 2222EmUS022558;
 Wed, 2 Mar 2022 11:14:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2222EmUS022558
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646187293;
 bh=HlVSuUlydFmRcXh5KVhbTxHDg/dha0ZhJ89J/IJOZ/0=;
 h=From:To:Cc:Subject:Date:From;
 b=L/iIS0HZKo7Zk4PfTz2PpLlVZdvLdqOmHVR8zL0tPyEecV50/+Xxgt6d/f7tucbOa
 YS3r2wVjOiibJhap+H5QY7UE42KgcUpuMmbIQ2gWNf71ey7k5J4xnHliOx+5SV+A/x
 Iawk9HU5Qfguq33LX7WBNBgDmyttcqdpJGF9W2D9ESQ/wgjpCBpFAwRa2Kd6zH7w8f
 YuIlq/7P9crUKeFhrStOcMicalv7eaGLyVnbDOAGIArWlBFXG4d+b0x+iMy8Z4hmiG
 fv6C4DnNAH206UKlfBy4WCRrwnsx1WFcm649uSXJcOFczYC7gX+xOd18wfQ5VVsXvD
 XNz9GGhrzRGYQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix a bug from comparison between int and
 DWORD.
Date: Wed,  2 Mar 2022 11:14:47 +0900
Message-Id: <20220302021447.1988-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Wed, 02 Mar 2022 02:15:26 -0000

---
 winsup/cygwin/fhandler_console.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 7e51ea19e..7693ab8e4 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1274,7 +1274,7 @@ out:
     {
       DWORD discarded;
       ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
-      con.num_processed = max (con.num_processed - discarded, 0);
+      con.num_processed -= min (con.num_processed, discarded);
     }
   return stat;
 }
-- 
2.35.1

