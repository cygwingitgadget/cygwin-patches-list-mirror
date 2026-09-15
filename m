Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id DDBBA4BAE7FC
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 08:19:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DDBBA4BAE7FC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DDBBA4BAE7FC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789460359; cv=none;
	b=PLWjM8O1mRMg4NA6H9gz11/vvolZIALeX9sYEIqUf+WMHxjJoF8mHF6zQFGMJYP5ePpALGkMiAYKC1kJ5w9O1laAj+aixaUPcpad+t6b9tTkFV6AzfixfbVfNStbJgKMHaitWnGlVS5LE9dXaTqL3eRKC5sbhKiPMVL4g0dYlas=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789460359; c=relaxed/simple;
	bh=HolACdQ4uS2XmG0MhnNI/jVL0VWwPbkCFA7fkHJjDRE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=fcwWgSswgBPByJRKJDwRkWfqlcL5OBWVt/hyxC312GMIbwHO0dSRSg6X0TSs9sN/bMaEg98y5n6ho+s/G361RRhxla8QVKIbfDOsrfy+IdibQypAAP+lp3fb+qabR1bp/JAmGCgLjfuwgFsq4yQvnYMjF8Xr+zwnFXaI+t0UAWw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L9iF0hq0
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DDBBA4BAE7FC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L9iF0hq0
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260915081916522.QCXY.17441.HP-Z230@nifty.com>;
          Tue, 15 Sep 2026 17:19:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jay Libove Alzina <libove@felines.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: console: Abort setting disable_master_thread when no con.owner
Date: Tue, 15 Sep 2026 17:19:03 +0900
Message-ID: <20260915081911.773-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789460356;
 bh=RMT2kwV495cJk/BLNmaTTzMl4pIL8oXjZ0PfMmV1TiQ=;
 h=From:To:Cc:Subject:Date;
 b=L9iF0hq0dsD6u/68U/fZnRIy9wW+L85mGtOQ3RX9lh0iMm+RrRt9sxNWRiisAu7+o2OQfIux
 7feH8IYZAnDzYgHond0z7+YhXGLCmHtw1kvKUWYW45ILIX3fAEXN1vxxiK70Ztztx0uEOLc+wr
 WNCy/ozbpTBVVacFOB7bnNgMQGHgm2RVstIK0sHX4Uoz2tTCCaW5ybwoy91pYuP1Vxn9vKAdLo
 RaHkaRjFNuoN3RGoB3PwIWUqPRZJjwJco2BpPhDpiSNIQ8UmryHSSZtUUM26tSBhpucN7TmEU4
 DuXv6lzMWfivg631T0aSeq3tIj2AmOyvCk321szqxlTQB66g==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Treat the absence of the master thread the same as suspension.

 winsup/cygwin/fhandler/console.cc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 110e80c6b..2ae300a21 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -5029,7 +5029,17 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
   con.disable_master_thread = x;
   cons->release_input_mutex ();
   while (con.master_thread_suspended != x)
-    Sleep (1);
+    { /* Wait for the responce from the cons_master_thread. */
+      if (con.owner == 0)
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

