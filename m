Return-Path: <SRS0=+5Fr=HE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id A68A64A9734C
	for <cygwin-patches@cygwin.com>; Sat, 12 Sep 2026 04:28:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A68A64A9734C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A68A64A9734C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789187289; cv=none;
	b=MJsGi5GnFmhTMvGfjUO0rV5RWMGqfy27ISLyJKBzope5wnwLw3g7ejZBdcb5KA4EWvHiJOWa9fpxnxssVpF4zF66RM/Y/P/EArT3MGAE+W0Aqd0IA6SItWr6Md3MPROtJmIj6l0hOHV5q9xxTng17jhBGXYI6K7kcbrYJmGbPyA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789187289; c=relaxed/simple;
	bh=uuGd2Qim0uirumeszJG27fMO6awbyGD6lWIo+syUr64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=KyGA3RYIRg9xVP613d1yFQcJh/N4amazwIrPG+5Ve0PucCTQZ/hRLeGnVM6wSfGwMBnTh7eHogQjuctni0P/TKZcxJz+SQaNiyP8lRQ/voeTHdbGzoLUUCg41eABnfRrUbytxf9q9KoSwHzsb7aWAGT9HS7z2hqrCq7TkcQpi5I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=n69H6J0V
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A68A64A9734C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=n69H6J0V
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260912042804776.VNCZ.117312.HP-Z230@nifty.com>;
          Sat, 12 Sep 2026 13:28:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jay Libove Alzina <libove@felines.org>
Subject: [PATCH v2] Cygwin: console: Abort setting disable_master_thread when no con.owner
Date: Sat, 12 Sep 2026 13:27:48 +0900
Message-ID: <20260912042757.1700-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789187284;
 bh=x0r0pZ5gEp8JhpDSyd0BJN+3xyH1Ivfwg09pHI8PIDA=;
 h=From:To:Cc:Subject:Date;
 b=n69H6J0Vrmu7E9AqvQvfhJQVZKmVrnRDMaFkD6JM18Lpo/MgLgxqZtDsKdzG1FP0pcMuoSkB
 k6izZJLXk10cnug3Bqth8A/zsvDWhL0Rpm/PqVNI5Rq4BfJMpidGCN++5Gv/4rQZAzogzO2Kt3
 A7nbr0moDxP6rk4w9UYu/bVMi9DM0GLwapZVrFdl54VTIi1P2g+zBsZS7UL/iYRMd9oyPiiaVS
 kMxRoIkLP22FUyOcHGG3+k7CyQS8NUFOO8hIGgDYYI5Sg/tpa9AgTXBj59BDOyAPgpxo1m9XQH
 hlVKkvZ5hpsGpxYfGcmdM4zTjxj1pbstDwkpkNoDR+Jv04Jw==
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
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
v2:
  Fix the race

 winsup/cygwin/fhandler/console.cc | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 5f78d0c62..4b1ba60ca 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -5009,11 +5009,24 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 	return;
     }
   const _minor_t unit = cons->get_minor ();
+  if (con.owner == 0)
+    /* The process that runs cons_master_thread no longer exists. */
+    return;
   cons->acquire_input_mutex (mutex_timeout);
   con.disable_master_thread = x;
   cons->release_input_mutex ();
   while (con.master_thread_suspended != x)
-    Sleep (1);
+    {
+      Sleep (1);
+      if (con.owner == 0)
+	{
+	  cons->acquire_input_mutex (mutex_timeout);
+	  con.disable_master_thread = true;
+	  con.master_thread_suspended = true;
+	  cons->release_input_mutex ();
+	  return;
+	}
+    }
 }
 
 int
-- 
2.51.0

