Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 097FE3858D3C
 for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2022 00:46:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 097FE3858D3C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 22J0jwqW022004;
 Sat, 19 Mar 2022 09:46:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 22J0jwqW022004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1647650763;
 bh=vGKU0vaj+OnpWqgVF36sWUy3rbgxvlxMkldAAPlb3Fk=;
 h=From:To:Cc:Subject:Date:From;
 b=Qa+MATTvnyBejQ1zlGA1QIwCdPBgjAMp5gUy7tDpOJ9l5pLh8IsupairNxao5qTbB
 Dk/yfGV37r0imgnJsNkCJrp4PjhBSOG689ZyCxcEE3YWAy/f3BcM42Q+ToNsJvI0Cf
 5d/H9Srj2R9OwVgl+yZ1jXirCLM704P5xz3JwW8ioj+vC1LawgRpTejJThSw2ej0YV
 EdMPWH+Uvk1VcHX6DjB9xcWQH02Icp9wVcPRV7js0/8KzWOxu7UjxdbHTsBm4+tCvN
 WmHKw1jwOVsYLX4dYK0qxkLBEyTK6JH/S4c4JU5DiYQwCJV5jvTVgUKk2n176YxpE7
 CrnZot2P2bhwA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Do not use memcmp() to compare INPUT_RECORD.
Date: Sat, 19 Mar 2022 09:45:57 +0900
Message-Id: <20220319004557.30209-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sat, 19 Mar 2022 00:46:36 -0000

- Using memcmp() to compare structure such as INPUT_RECORD is not
  correct manner because padding may not be initialized. This patch
  stops to use memcmp() for comparison of INPUT_RECORD.
---
 winsup/cygwin/fhandler_console.cc | 41 ++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index fd5f972d8..5625b7be2 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -186,7 +186,9 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 {
   for (DWORD i = 0; i < n; i++)
     {
-      if (a[i].EventType == KEY_EVENT && b[i].EventType == KEY_EVENT)
+      if (a[i].EventType != b[i].EventType)
+	return false;
+      else if (a[i].EventType == KEY_EVENT)
 	{ /* wVirtualKeyCode, wVirtualScanCode and dwControlKeyState
 	     of the readback key event may be different from that of
 	     written event. Therefore they are ignored. */
@@ -197,8 +199,41 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 	      || ak->wRepeatCount != bk->wRepeatCount)
 	    return false;
 	}
-      else if (memcmp (a + i, b + i, sizeof (INPUT_RECORD)) != 0)
-	return false;
+      else if (a[i].EventType == MOUSE_EVENT)
+	{
+	  const MOUSE_EVENT_RECORD *am = &a[i].Event.MouseEvent;
+	  const MOUSE_EVENT_RECORD *bm = &b[i].Event.MouseEvent;
+	  if (am->dwMousePosition.X != bm->dwMousePosition.X
+	      || am->dwMousePosition.Y != bm->dwMousePosition.Y
+	      || am->dwButtonState != bm->dwButtonState
+	      || am->dwControlKeyState != bm->dwControlKeyState
+	      || am->dwEventFlags != bm->dwEventFlags)
+	    return false;
+	}
+      else if (a[i].EventType == WINDOW_BUFFER_SIZE_EVENT)
+	{
+	  const WINDOW_BUFFER_SIZE_RECORD
+	    *aw = &a[i].Event.WindowBufferSizeEvent;
+	  const WINDOW_BUFFER_SIZE_RECORD
+	    *bw = &b[i].Event.WindowBufferSizeEvent;
+	  if (aw->dwSize.X != bw->dwSize.X
+	      || aw->dwSize.Y != bw->dwSize.Y)
+	    return false;
+	}
+      else if (a[i].EventType == MENU_EVENT)
+	{
+	  const MENU_EVENT_RECORD *am = &a[i].Event.MenuEvent;
+	  const MENU_EVENT_RECORD *bm = &b[i].Event.MenuEvent;
+	  if (am->dwCommandId != bm->dwCommandId)
+	    return false;
+	}
+      else if (a[i].EventType == FOCUS_EVENT)
+	{
+	  const FOCUS_EVENT_RECORD *af = &a[i].Event.FocusEvent;
+	  const FOCUS_EVENT_RECORD *bf = &b[i].Event.FocusEvent;
+	  if (af->bSetFocus != bf->bSetFocus)
+	    return false;
+	}
     }
   return true;
 }
-- 
2.35.1

