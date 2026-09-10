Return-Path: <SRS0=KKQs=HC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id B7F8F4AA6FEA
	for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2026 14:13:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B7F8F4AA6FEA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B7F8F4AA6FEA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789049581; cv=none;
	b=ECPmWf2qKK6Td8LDfAiq3uF2dEWkFaw1voJ1pSYn3rPkxuzfKgVH27xkZeEwn6qHArrif8zFQOD7AwwWRcJcRcrufiLqge13VK2GfcD3riTaWxteMZT7hmzEW9rz7Hog8lWReytdm8Gv69p4ou+XtLTFwUwyvf+QuTTR07r3H8U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789049581; c=relaxed/simple;
	bh=zsE/CE86v3BuZQ6XubpyYBU99nSYrQ0Jmr7uc9z/j0o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Pp2IKIMQqebL2cNqYW/3CxRT5Gy5/vV/e8eFCVYYWxJ4+bG0Rh8JCGVvnFmaCJy2UaVq99UcNMfcUfJ6ROZXcLJTwhzHnxW/mwdu7GEayAXTnmTwWXVKFJWti2enhB9/1dbo336omIhs2726lmUxrhzI/pBK/BqgCqtP005NP4s=
ARC-Authentication-Results: i=1; sourceware.org
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260910141257336.MBG.18412.HP-Z230@nifty.com>;
          Thu, 10 Sep 2026 23:12:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jay Libove Alzina <libove@felines.org>
Subject: [PATCH] Cygwin: console: Abort setting disable_master_thread when no con.owner
Date: Thu, 10 Sep 2026 23:12:40 +0900
Message-ID: <20260910141248.637-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789049577;
 bh=MYDB43FAOBvxdUzABxla7mhY530veMxbtiB0UL7akfg=;
 h=From:To:Cc:Subject:Date;
 b=QppKmrrv3dCIOq5Xm3X5TBgbUmbpc3zHjriBdsx9y4qvNgWvrcwoRDpiK0pznuc88jHM7OlM
 0+cHk1GJSJUgd/kGLgb90B3xHGeZw+BckZOAPnmXB9iwbBhYNwYa+IoneglEilcTqdfG6VgFGQ
 cwLKEqb04FI3UuAhHfcdtNizvT2uOdrLM+MjmhrMdSwGvbocJ3Vq1eVRrk1asJ8wCnwsC2P5JA
 LngGBLmR5r/2rcU/7SC9IGkiWn4+oqa9ljD+T8D7NRfq512ZoPjDyjr7DmQ7IK8XiGdOY4ke73
 +NIT4S701d2J2CsDnuRwYcX2XqpicOK32k9CiNd6yFyPhe3g==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/console.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 5f78d0c62..5d86b0952 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -5009,6 +5009,9 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 	return;
     }
   const _minor_t unit = cons->get_minor ();
+  if (con.owner == 0)
+    /* The process that runs cons_master_thread no longer exists. */
+    return;
   cons->acquire_input_mutex (mutex_timeout);
   con.disable_master_thread = x;
   cons->release_input_mutex ();
-- 
2.51.0

