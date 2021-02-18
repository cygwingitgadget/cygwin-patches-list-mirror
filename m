Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id A976D386F83C
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 09:03:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A976D386F83C
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 11I92pB6016932;
 Thu, 18 Feb 2021 18:02:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 11I92pB6016932
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Add console fix regarding Ctrl-Z etc. to release
 notes.
Date: Thu, 18 Feb 2021 18:02:42 +0900
Message-Id: <20210218090242.1507-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 18 Feb 2021 09:03:19 -0000

---
 winsup/cygwin/release/3.2.0 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
index d02d16863..d69ed446c 100644
--- a/winsup/cygwin/release/3.2.0
+++ b/winsup/cygwin/release/3.2.0
@@ -9,6 +9,11 @@ What's new:
   thrd_detach, thrd_equal, thrd_exit, thrd_join, thrd_sleep, thrd_yield,
   tss_create, tss_delete, tss_get, tss_set.
 
+- In cygwin console, new thread which handles special keys/signals such
+  as Ctrl-Z (VSUSP), Ctrl-\ (VQUIT), Ctrl-S (VSTOP), Ctrl-Q (VSTART) and
+  SIGWINCH has been intrudocued. There have been a long standing issue
+  that these keys/signals are handled only when app calls read() or
+  select(). Now, these work even if app does not call read() or select().
 
 What changed:
 -------------
-- 
2.30.0

