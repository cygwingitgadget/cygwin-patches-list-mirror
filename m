Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 3A0D1385840C
 for <cygwin-patches@cygwin.com>; Fri, 18 Mar 2022 23:49:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3A0D1385840C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 22INnIPd009643;
 Sat, 19 Mar 2022 08:49:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 22INnIPd009643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1647647376;
 bh=XaRrh0jgoTt7CVFULKi66rRlXr5xzrtqxhRc7ElJhpo=;
 h=From:To:Cc:Subject:Date:From;
 b=XwmjGYm7ddkWarcNd5HDtrefsIa0hHg9QM/ZeI147X2Y9+XVvQ1K8nukEZbCd4XGV
 SxtdG88mkJINPZhEw5klKaNdieloI8gRhWJCY+mW0aP+Yjue4AVFIvAYLB8Bp7Zyxf
 ywtMUR7duEKwpbsrL3bHb6zAWMmlMaxL3RmfZl2QI9ZoLhaZTmY4hlFkAMo87Q3KoN
 Ouv5oOtpe81I7hOfgh4R5FZ+1doW9BSVp8GyOWmVpLitCuW0cWSVK0asq1awpD6Md6
 r7q/sOCkDosJ54H2TSxkMqNi6MLJCZQi5kb6AF1F4pgenidLcIDaCgpaUIS0bDfSdU
 DdidzFIl6tYsQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Ignore dwControlKeyState in event comparison.
Date: Sat, 19 Mar 2022 08:49:12 +0900
Message-Id: <20220318234912.12195-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 18 Mar 2022 23:49:56 -0000

- dwControlKeyState also may be null'ed on WriteConsoleInputW().
  Therefore ignore it in event comparison as well as wVirtualKeyCode
  and wVirtualScanCode.
---
 winsup/cygwin/fhandler_console.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 68248d16c..fd5f972d8 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -187,13 +187,13 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
   for (DWORD i = 0; i < n; i++)
     {
       if (a[i].EventType == KEY_EVENT && b[i].EventType == KEY_EVENT)
-	{ /* wVirtualKeyCode and wVirtualScanCode of the readback
-	     key event may be different from that of written event. */
+	{ /* wVirtualKeyCode, wVirtualScanCode and dwControlKeyState
+	     of the readback key event may be different from that of
+	     written event. Therefore they are ignored. */
 	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
 	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
 	  if (ak->bKeyDown != bk->bKeyDown
 	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
-	      || ak->dwControlKeyState != bk->dwControlKeyState
 	      || ak->wRepeatCount != bk->wRepeatCount)
 	    return false;
 	}
-- 
2.35.1

