Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id E488B3858415
 for <cygwin-patches@cygwin.com>; Tue,  2 Nov 2021 03:40:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E488B3858415
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 1A23e9pu020690;
 Tue, 2 Nov 2021 12:40:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 1A23e9pu020690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1635824414;
 bh=vwaWl0CPVFF9hSh3IBzI5GpIu+KMtnaedA87ad/ELCo=;
 h=From:To:Cc:Subject:Date:From;
 b=0k7lDn6d813U687nT8Rtj9ceAYh900NN+eYuFfRS4E3uemsL0YCa1Ffigcdk1NCcy
 wtbjLsCTVuXR6wQxd/EuAEYS8T5Ze4mYTdLfpCXStkLpS+QONPzZxCD1Jd9RatB6jz
 Wmh6SCAh3df5auIsmqvewRCyJ1CGOb+CEj7SmMM3mmaqHJwGCKTnFpO00HXoAxaNHA
 lHf9EKP+d/Olg8AvWd+HK95IV3ip5MMcYVDBpvTwFgpt2YccbK/H5pENm/sx+vKNnM
 EASaUkftLgfj2BwG21L1k2HrCh+6pYlRSTqoGO37W68SSn1pbbC+wzmFhOBFuilv42
 B9vTEdC/H2E3w==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix a bug on input when signalled.
Date: Tue,  2 Nov 2021 12:40:10 +0900
Message-Id: <20211102034010.1500-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 02 Nov 2021 03:40:47 -0000

- This patch fixes the bug that Ctrl-C sometimes does not work as
  expected in Windows Terminal.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-November/249749.html
---
 winsup/cygwin/fhandler_console.cc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 940c66a6e..0501b36fa 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1178,6 +1178,10 @@ out:
   /* Discard processed recored. */
   DWORD dummy;
   DWORD discard_len = min (total_read, i + 1);
+  /* If input is signalled, do not discard input here because
+     tcflush() is already called from line_edit(). */
+  if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
+    discard_len = 0;
   if (discard_len)
     ReadConsoleInputW (get_handle (), input_rec, discard_len, &dummy);
   return stat;
-- 
2.33.0

