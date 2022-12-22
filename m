Return-Path: <SRS0=bHOJ=4U=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
	by sourceware.org (Postfix) with ESMTPS id 334043858D1E
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 11:48:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 334043858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-12.nifty.com with ESMTP id 2BMBmN1N003810;
	Thu, 22 Dec 2022 20:48:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2BMBmN1N003810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671709707;
	bh=27cFlE5caV/WTpssN+wWhSl8sQzpx9PtJmtfQ6byjzw=;
	h=From:To:Cc:Subject:Date:From;
	b=rTnc6sr1RA4KXajwa/gJb6Po2C/X51w6mK8Xle4YsGthwmjNelu468ua64Ixzrwnh
	 mxPSvPIOVS1cfy14SUamYBIcKhAMYM7ReC/y201fnYNH8h4kh2j7iVjcz2Ddsd5+MU
	 A8yCCOj1rQgPVinN01YLDInWY2A6S6goxryuyhQSvB+ORkSpiGeBJc7QFpYQHQ3JkQ
	 SnaSjrt9stiJc58wYCrneV4WVRjM9hVgL8aeDNAus3KWBkqaJhQ8ocN9fB85a0xWq5
	 sYx6F7Jfvv5477agtIrgij8fb6v/sbLz+wJaMz2S7jrA5rkBusEdIqoc241WAl8FQs
	 Z7O6dB1tUcWpQ==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>, Gregory Mason <grmason@epic.com>
Subject: [PATCH] Cygwin: console: Fix hangup of less on quit after the window is resized.
Date: Thu, 22 Dec 2022 20:48:13 +0900
Message-Id: <20221222114813.1220-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

https://cygwin.com/pipermail/cygwin/2022-December/252737.html

If the less is started from non-cygwin shell and window size is
changed, it will hang-up when quitting. The cause of the proglem is
that less uses longjump() in signal handler. If the signal handler
is called while cygwin is acquiring the mutex, cygwin loses the
chance to release mutex. With this patch, the mutex is released
just before calling kill_pgrp() and re-acquired when kill_pgrp()
returns.

Reported-by: Gregory Mason <grmason@epic.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 4 ++++
 winsup/cygwin/release/3.4.4       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index bbf4b0103..ee07c84f8 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -928,7 +928,11 @@ fhandler_console::send_winch_maybe ()
       if (wincap.has_con_24bit_colors () && !con_is_legacy
 	  && wincap.has_con_broken_tabs ())
 	fix_tab_position (get_output_handle ());
+      /* longjmp() may be called in the signal handler like less,
+	 so release input_mutex temporarily before kill_pgrp(). */
+      release_input_mutex ();
       get_ttyp ()->kill_pgrp (SIGWINCH);
+      acquire_input_mutex (mutex_timeout);
       return true;
     }
   return false;
diff --git a/winsup/cygwin/release/3.4.4 b/winsup/cygwin/release/3.4.4
index 6ac702375..3331b3166 100644
--- a/winsup/cygwin/release/3.4.4
+++ b/winsup/cygwin/release/3.4.4
@@ -3,3 +3,7 @@ Bug Fixes
 
 - Fix an uninitialized variable having weird side-effects in path handling.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-December/252734.html
+
+- Fix hang-up of less on quit which occurs when it is started from non-cygwin
+  shell and window is resized.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-December/252737.html
-- 
2.39.0

