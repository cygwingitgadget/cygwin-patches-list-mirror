Return-Path: <SRS0=PzXf=NB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 6D93F3858D20
	for <cygwin-patches@cygwin.com>; Thu, 30 May 2024 05:05:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D93F3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D93F3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717045559; cv=none;
	b=UYPQVhp0K7bjnDY8VEENbxExUJ4cJmRpMwXmXOqOgSq0redl44pBoDkW9fJGKssTyo7DNdvHimcC5O61KSIhWyrVfbTcEZGyVCp6KIqabj15Pp+OE/TP0X3IazuiV5VJMQXiGVcAnNEN4EXNzAAsKJWmqiKz87xAfcMiaO0v0Yc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717045559; c=relaxed/simple;
	bh=pHr6t/8z2e6C9XETOLspZJI3ZQS4iH4Oy7YAuWwNqkY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ZJST3vDHC4tDTCsptF4QyDthtOVyKrzO06DzMgqWR+OF5bqhLtq0eNnFwPqccr3wVos2rF8yPCQjrsKQPBnkngsUAIgrKez8ytZICz16DCemGiT89sfAevrFuifJXeVeQr5oEWZnKgHLZqACNUz7Vat0A5Umpyty04cM2WuetvA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e07.mail.nifty.com
          with ESMTP
          id <20240530050555647.HJKJ.76216.localhost.localdomain@nifty.com>;
          Thu, 30 May 2024 14:05:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH v2] Cygwin: pthread: Fix a race issue introduced by the commit 2c5433e5da82
Date: Thu, 30 May 2024 14:05:29 +0900
Message-ID: <20240530050538.53724-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717045555;
 bh=lwKqW+WuOkc7fLpWc1TbohdMF4/Gq13lo1KiDGkrho0=;
 h=From:To:Cc:Subject:Date;
 b=NS+ftvfEMFU2VH9aBfM+zXM435l8aQgw0isn4WKgLrRjw1my4ZTQrEXN7MIq8/ibGXacZ4/E
 qsT+T98BsEbtN6zlx356Zmhb4XNGeWPN+tS4KoX3/J/fnUglVVHNb91lEhLneCflg5TocRqYqy
 5Ym7iiCCnFSgUx5EFIU372cDH/AFBe6vHVQmREkEbVhDq6pm0zqaKUAWePxTXy+YT8Fexa3RJa
 Z5M7ZPARuU1jDmv15jNAsMod+4d6xndTyBDbupmH79yk1hOGVJl5pHnY6jQM0pvCWHUhQsYSxW
 vd/z1F0HFyv3Xgejk2t5Y69ucQ4bmEIYQRPG1KWOn7IQ6Uog==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

To avoid race issues, pthread::once() uses pthread_mutex. This caused
the handle leak which was fixed by the commit 2c5433e5da82. However,
this fix introduced another race issue, i.e., the mutex may be used
after it is destroyed. This patch fixes the issue. Special thanks to
Bruno Haible for discussing how to fix the issue.

Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255987.html
Reported-by: Bruno Haible <bruno@clisp.org>
Fixes: 2c5433e5da82 ("Cygwin: pthread: Fix handle leak in pthread_once.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/thread.cc | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 0f8327831..cd57a6ac1 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -2045,27 +2045,22 @@ pthread::create (pthread_t *thread, const pthread_attr_t *attr,
 int
 pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
 {
-  // already done ?
-  if (once_control->state)
+  /* Sign bit of once_control->state is used as done flag */
+  if (once_control->state & INT_MIN)
     return 0;
 
+  /* The type of &once_control->state is int *, which is compatible with
+     LONG * (the type of the first argument of InterlockedIncrement()). */
+  InterlockedIncrement (&once_control->state);
   pthread_mutex_lock (&once_control->mutex);
-  /* Here we must set a cancellation handler to unlock the mutex if needed */
-  /* but a cancellation handler is not the right thing. We need this in the thread
-   *cleanup routine. Assumption: a thread can only be in one pthread_once routine
-   *at a time. Stote a mutex_t *in the pthread_structure. if that's non null unlock
-   *on pthread_exit ();
-   */
-  if (!once_control->state)
+  if (!(once_control->state & INT_MIN))
     {
       init_routine ();
-      once_control->state = 1;
-      pthread_mutex_unlock (&once_control->mutex);
-      while (pthread_mutex_destroy (&once_control->mutex) == EBUSY);
-      return 0;
+      once_control->state |= INT_MIN;
     }
-  /* Here we must remove our cancellation handler */
   pthread_mutex_unlock (&once_control->mutex);
+  if (InterlockedDecrement (&once_control->state) == INT_MIN)
+    pthread_mutex_destroy (&once_control->mutex);
   return 0;
 }
 
-- 
2.45.1

