Return-Path: <SRS0=pSQy=JX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1002.nifty.com (mta-snd01010.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 9B6AC385C422
	for <cygwin-patches@cygwin.com>; Wed, 14 Feb 2024 14:26:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9B6AC385C422
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9B6AC385C422
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1707920790; cv=none;
	b=duTVGLA0nKsmcofAXBvF1Gh9ROg36gdl25ls6i8XyqyMGxaiU4joR28kAg+0uZ0RWjR/I9TJOAouHzfhXvbllhr/oe4AUhvve3p2a+S7/fFYJamAqs5OMjQZXSiuJldZxMNYG4KhG4hmSn1JCBJi1RkH/1B7QiBNnYsgt5Lqmsw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1707920790; c=relaxed/simple;
	bh=6qz8mPqEda3zmxfdEIon9qp2PUJlrdOlMTO4pdgGxGM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X7rOR3GT8VJGkkDlqkrvv+9r8Ia9RiLa+rKw7PzLOb83bLw0nSX3DgOCqU/S3Q8ZIZ3YYjDkZkdmbYqEud1fv0osq7D0EkXijX0eBcbIJIkzWy7QpGAFRjq3dKUdhV2qq6f6qg3o4a+ynlJdvos4+L7qNIyzyP5eokf4pJN0mdY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1002.nifty.com with ESMTP
          id <20240214142625498.GBCL.26215.localhost.localdomain@nifty.com>;
          Wed, 14 Feb 2024 23:26:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Make GNU screen and tmux work in ConEmu cygwin-connector.
Date: Wed, 14 Feb 2024 23:26:00 +0900
Message-ID: <20240214142610.1711-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index d31d30b1f..e52590c9d 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -970,7 +970,7 @@ fhandler_pty_slave::open (int flags, mode_t)
   set_output_handle (to_master_local);
 
   if (_major (myself->ctty) == DEV_CONS_MAJOR
-      && !(!pinfo (myself->ppid) && getenv ("ConEmuPID")))
+      && !(!pinfo (myself->ppid) && GetModuleHandle ("ConEmuHk64.dll")))
     /* This process is supposed to be a master process which is
        running on console. Invisible console will be created in
        primary slave process to prevent overriding code page
@@ -1049,6 +1049,8 @@ fhandler_pty_slave::close ()
   fhandler_pty_common::close ();
   if (!ForceCloseHandle (output_mutex))
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
+  if (!get_ttyp ()->invisible_console_pid && myself->ctty == CTTY_RELEASED)
+    FreeConsole();
   if (get_ttyp ()->invisible_console_pid
       && !pinfo (get_ttyp ()->invisible_console_pid))
     get_ttyp ()->invisible_console_pid = 0;
-- 
2.43.0

