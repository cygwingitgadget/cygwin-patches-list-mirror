Return-Path: <SRS0=edmR=JW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1019.nifty.com (mta-snd01008.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 719E53858C50
	for <cygwin-patches@cygwin.com>; Tue, 13 Feb 2024 14:29:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 719E53858C50
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 719E53858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1707834595; cv=none;
	b=VYBSJhVf5vUJqpMUr7NJ/kFx9/8VqhGI+p20zzx808t2Md2WeOcEv1/4hPj2ZfBCRqyQBPNRcSydd3qqPRHikHKh/yiaNJc0VxFwEvhRTdnsjkCnyZuoapRS20ch45kCgJDAVt4SAzJH7dhlBU1dasmO6xEzzxgp/uk2t7Ywc6s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1707834595; c=relaxed/simple;
	bh=aJcY3ruXxbbni2DWm694ZtVEJNkoqv1SgmTIe5GgKe0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=x+qwyWWd6fXzWn/Gva4GOayE82eCShV7iiVmTW1kQatKfrkegQY4/lEBMnOPBqEMf9vP1mVJMOtDc2WGrG3jN/8ftNZSIXgI2NT1PkMMbpaT6r3ZPRKWB/aYc26YonUolDqW5fYfnGQP+xqWGtglGIH95HCGegqFwplO0WiZYFI=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1019.nifty.com with ESMTP
          id <20240213142949975.BOLE.96055.localhost.localdomain@nifty.com>;
          Tue, 13 Feb 2024 23:29:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix handle leak in master process.
Date: Tue, 13 Feb 2024 23:29:23 +0900
Message-ID: <20240213142934.1879-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If non-cygwin process is started in pty, closing from_master_nat
pipe handle was missing in fhandler_pty_slave::input_transfer().
This occured because the handle was duplicated but not closed.

https://github.com/msys2/msys2-runtime/issues/198

Fixes: 29431fcb5b14 ("Cygwin: pty: Inherit typeahead data between two input pipes.")
Reported-by: Hakkin Lain
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 1 +
 winsup/cygwin/release/3.5.1   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 3f4bc56b5..c5c792144 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3995,6 +3995,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	    transfered = true;;
 	}
     }
+  CloseHandle (to);
 
   /* Fix input_available_event which indicates availability in cyg pipe. */
   if (dir == tty::to_nat) /* all data is transfered to nat pipe,
diff --git a/winsup/cygwin/release/3.5.1 b/winsup/cygwin/release/3.5.1
index 81945dbda..715fcf74d 100644
--- a/winsup/cygwin/release/3.5.1
+++ b/winsup/cygwin/release/3.5.1
@@ -12,3 +12,7 @@ Fixes:
   error mode is now possible by using the new CYGWIN environment variable
   option "winjitdebug".
   Addresses: https://cygwin.com/pipermail/cygwin/2024-February/255305.html
+
+- Fix handle leak in pty master which occurs when non-cygwin process
+  is started in pty.
+  Addresses: https://github.com/msys2/msys2-runtime/issues/198
-- 
2.43.0

