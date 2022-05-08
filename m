Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 4C9663858C54
 for <cygwin-patches@cygwin.com>; Sun,  8 May 2022 11:04:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4C9663858C54
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 248B4FBJ029436;
 Sun, 8 May 2022 20:04:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 248B4FBJ029436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652007861;
 bh=NGwwz4L7NirH536Sd9sBGCBBxf/qMcvr/oEJ3zcDBt8=;
 h=From:To:Cc:Subject:Date:From;
 b=tdFi0WVIHgSN17pWlBwBrosz2Vl7qwXXuBhIi9LqSftRl0E4gD++S8+eUL/eMqwyM
 ZaiYeqw+xFNlPq18T4G6Ab88+ckLZnTIL40EYJvfe3UQkieh/8m0MsssI8N8NeoRZV
 W0MpXq6GyuiyhySB2uVEWSP+O4j/377gHBGruhvhDSpuBpUMfoDWsRU82gGIE1kIe/
 Dp26xlmqrbooO7Ss+F+b4RDY6mba5cO/hYj7dTXC+HdN8z5N1DN/a9GcNmbeSe2TA1
 V/+lpdIkIuRd3IduSBC2Tx7CbIcCMg4SrJFE+OyzbciforM0+aCJOdFoB/HBT6gyo9
 eQDqvvSsLuxKg==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix timing of creating invisible console.
Date: Sun,  8 May 2022 20:04:06 +0900
Message-Id: <20220508110406.20963-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 08 May 2022 11:04:57 -0000

- Previously, invisible console was created in fixup_after_exec().
  However, actually this should be done in fixup_after_fork(). this
  patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index bdde1dce6..9ab681d6c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2467,6 +2467,8 @@ fhandler_pty_slave::bg_check (int sig, bool dontsignal)
 void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
+  create_invisible_console ();
+
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
   report_tty_counts (this, "inherited", "");
@@ -2475,8 +2477,6 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 void
 fhandler_pty_slave::fixup_after_exec ()
 {
-  create_invisible_console ();
-
   if (!close_on_exec ())
     fixup_after_fork (NULL);	/* No parent handle required. */
 
-- 
2.36.0

