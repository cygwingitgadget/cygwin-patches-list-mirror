Return-Path: <SRS0=k2H2=HJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 586C64BA7988
	for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 05:42:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 586C64BA7988
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 586C64BA7988
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789623748; cv=none;
	b=F9MNxcXpyWk4i0xrUUNljENCCrHFD9Qoh9T6mqN2CGdyrC8kRNuxiw27Ai2k2iy7zhfx8ieb2JMTPdTspPY6Xyt/dtgEfTgtvZtdyyyr4eYeJOSATND42qclyjkGtnvwBQuRiyJLSurMipqp+x+7WHXHCuGcOJB7xdfMOy3zy0c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789623748; c=relaxed/simple;
	bh=PdgUETp+69F2qJYfwwLH8HJqLWtstxH4IRYrieluOB4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=AJatMr3kh/dcBZZjQYYdLlfSuipu80q6cInhw9akxzynNRiyqLpebe8qhtRWfB0oykQaRz111Ekf302Q9iwRKSTQZ33tde/vg2BRoDdoKj9BHtH/Ru+EQojVBh5dfGSl56T+NKkrSo+arvb+Zv2IEqt7IgAXoKwoeKP0ER8UNuM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=f6CIPg7Q
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 586C64BA7988
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=f6CIPg7Q
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260917054223641.LOLI.18412.HP-Z230@nifty.com>;
          Thu, 17 Sep 2026 14:42:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jay Libove Alzina <libove@felines.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: console: Abort setting disable_master_thread when no con.owner
Date: Thu, 17 Sep 2026 14:42:00 +0900
Message-ID: <20260917054209.7682-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789623743;
 bh=lX2Cf1qJnelKBPgZs8Ncs03zCr8yHNeWeTJ0JwW+Sfo=;
 h=From:To:Cc:Subject:Date;
 b=f6CIPg7QdbMWC0683PzYLSE6B3VnGMGxmHIRxCHRb4hZPonCxO+tixPXHBQ7aWmmHLSnuX2c
 w2s2fV88zIBSRgMUiKQaOnBKt776OP7DkUUQFbH+aOogxQ9o/KCyei5C6O5I7UwNQzKaBQjP4x
 j/imp/tTZjYlUlpE8wXsMCEJsVoEMEglJhXFoB4aZQFcqM9Uc0MGXIzwha4blR/KAdJEKJ3FMP
 8Bh4hknTo95CgdQ+ukeq2vuxx7bGcr/ujGuGYmru9vBP2eInPcDQvH6E5DwLz4bykR8XV1x2SS
 xm+j9str/+tPBXnD+aW2xUNi7uNnLchXPFXbWjfDKtjsQs3g==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
thread runs only when it is supposed to"), the process which calls
set_disable_master_thread() hangs if the con.owner already exited,
because set_disable_master_thread() waits for cons_master_thread
accepting the status change and reflecting the current status to
master_thread_suspended. With this patch, set_disable_master_thread()
is aborted if the owner process no longer exists to avoid this
hang.

Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
Reported-by: Jay Libove Alzina <libove@felines.org>
Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Treat the absence of the master thread the same as suspension.
v3: Handle the crash of owner process.

 winsup/cygwin/fhandler/console.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index a877fce0b..0b9e205e6 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -5025,7 +5025,18 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
   con.disable_master_thread = x;
   cons->release_input_mutex ();
   while (con.master_thread_suspended != x)
-    Sleep (1);
+    { /* Wait for the responce from the cons_master_thread. */
+      DWORD owner = con.owner;
+      if (owner == 0 || owner == (DWORD) -1 || !process_alive (owner))
+	{ /* The process that runs cons_master_thread no longer exists. */
+	  cons->acquire_input_mutex (mutex_timeout);
+	  /* Treat the absence of the master_thread the same as suspension. */
+	  con.master_thread_suspended = true;
+	  cons->release_input_mutex ();
+	  return; /* Abort */
+	}
+      Sleep (1);
+    }
 }
 
 int
-- 
2.51.0

