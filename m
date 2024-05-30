Return-Path: <SRS0=PzXf=NB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 77ED5385840F
	for <cygwin-patches@cygwin.com>; Thu, 30 May 2024 11:55:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 77ED5385840F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 77ED5385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717070149; cv=none;
	b=VHyOb9oQGVZP2lD0NP7ZHtFziHyjLm7VT8H1vuC4/7ZsDRqDg7qlYktvZeFystsuB40q+IUA9Bg/RfeAIaaoI2VedWI21ZDWCA5KfjeBtr2rjBCuu1QfmHgrgMkXXKeYW8jbkQioGoC4ZUGng3Ixa+75RkpB0QeAJ0fDiqp3yFk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717070149; c=relaxed/simple;
	bh=iC6+8+AwtFJGGk0pWBCz8LoTW5JcCfKBI8uF0xk8rrk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=tQd3xW1yTwx3J1R7J6M3+Yr6yNAUwAlN9iCi2D0SOU9IpxQvwBqDbrtLTvvMRhwxKbf1ZnZrhpLdaz/MzjN76SLK1aV+B+K15gwErG8ZBKwp0QaKcTjEaqzivCxsNvp19tIusEHkP9beijFrGWdWgilh28cmuY83LRutZ6tPQ2k=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20240530115545573.SFOI.90249.localhost.localdomain@nifty.com>;
          Thu, 30 May 2024 20:55:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH v3] Cygwin: pthread: Fix a race issue introduced by the commit 2c5433e5da82
Date: Thu, 30 May 2024 20:55:20 +0900
Message-ID: <20240530115529.57034-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717070145;
 bh=Zeo2FHWUyYrwzTWz5XK3uYLmFdiF5hgLXd6RTs+ZEAs=;
 h=From:To:Cc:Subject:Date;
 b=bb9c5b8tY5R/zUTVBSTrpV/bn0klg03nEUJjlddwCAqmIhGAIWoPyYj+SJHIOiSIYovEhBD0
 maKoXVhcCy3MC3ur/NE7clr6SMQFUaBdN5zQZ76vDLmrzV85Hf7SHvgtLoO8Jr9PbQZjD96q0F
 Xa54PxEUiZvPDP1jdqRP/yIrE0zE9NE+hQNXkuFos+Rq3AzjMUx8jRAzBP8yhgUCEfuO7eYROm
 5B3dxGa9Ks1iZNn5aJ3z279QzyTVIjJ+uES4Rr63sH3jVHq57tC0fGMq1txBsLPV8CDXMluTi9
 2+Us9gwqfd+NGuN8FrP1VrXaAr9KJ8JCxTdz1MD1vVIEzChQ==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/local_includes/thread.h |  2 +-
 winsup/cygwin/thread.cc               | 23 +++++++++--------------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_includes/thread.h
index 9939c4224..b3496281e 100644
--- a/winsup/cygwin/local_includes/thread.h
+++ b/winsup/cygwin/local_includes/thread.h
@@ -674,7 +674,7 @@ class pthread_once
 {
 public:
   pthread_mutex_t mutex;
-  int state;
+  volatile int state;
 };
 
 /* shouldn't be here */
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 0f8327831..c78c1e63b 100644
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
+      InterlockedOr (once_control->state, INT_MIN);
     }
-  /* Here we must remove our cancellation handler */
   pthread_mutex_unlock (&once_control->mutex);
+  if (InterlockedDecrement (&once_control->state) == INT_MIN)
+    pthread_mutex_destroy (&once_control->mutex);
   return 0;
 }
 
-- 
2.45.1

