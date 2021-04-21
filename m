Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 408D33858031
 for <cygwin-patches@cygwin.com>; Wed, 21 Apr 2021 03:08:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 408D33858031
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 13L37ZQL003264;
 Wed, 21 Apr 2021 12:07:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 13L37ZQL003264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618974461;
 bh=TFvEyGY334MM3jpeLfbz4vQT37+BepxP0AN4pFPvSiA=;
 h=From:To:Cc:Subject:Date:From;
 b=Yz9FEirYdQw8+EYuWfhFZy54uFIG2OTFzAdcdR578qRImsvvt4DLfk0kJdyZdhH0f
 SIdFtecXrVgvq/XlY9NsQcL4kQoik6yCfcewx91HmDDPUqTlCqH82bWZZ9owRjFfPJ
 LvRPsCTWCeq2TcdyHFSlJki3MXy+9zh97OzLthKKvjZx9/D09dZ/PyIS1XTtpy+g2h
 pUE9O2ywRm1lwH38ixMPqai1ZlPifnYCmV+UGGG8XJh7GzWJrmgO64Voz8QZidOMzm
 Sf8vbVgps8O1PG9uvMN7g77UzhVJ022/zfXNa1CwDxAyZrOgmyWVdAvNlxwfM5yQY1
 8/HgKDtrEwmhQ==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add missing guard for close_pseudoconsole().
Date: Wed, 21 Apr 2021 12:07:31 +0900
Message-Id: <20210421030731.5928-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Wed, 21 Apr 2021 03:08:01 -0000

- This patch adds a missing mutex guard for close_pseudoconsole()
  call when GDB exits.
---
 winsup/cygwin/fhandler_tty.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 530321513..9c03e09a7 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -177,7 +177,9 @@ atexit_func (void)
 						    input_available_event);
 		ReleaseMutex (ptys->input_mutex);
 	      }
+	    WaitForSingleObject (ptys->pcon_mutex, INFINITE);
 	    ptys->close_pseudoconsole (ttyp, force_switch_to);
+	    ReleaseMutex (ptys->pcon_mutex);
 	    break;
 	  }
       CloseHandle (h_gdb_process);
-- 
2.31.1

