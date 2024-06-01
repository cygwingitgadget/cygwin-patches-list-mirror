Return-Path: <SRS0=TcHI=ND=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 179FB3858C35
	for <cygwin-patches@cygwin.com>; Sat,  1 Jun 2024 14:17:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 179FB3858C35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 179FB3858C35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717251440; cv=none;
	b=AmEgciKk2SIel8fRmjkmjTPi7G5d2CrePm47h19DyiyCJJ1YyHRYayy9/r2YWoMA+MdRgr5s5p7SbGmtxH1TTMypAywzXkjwI/z+Hx5crUcbIE554Q5yujixHHze9gKCe28IyZHFUSEJIJYPz4QjOXEM/+Y9qYW4zdhdA3Sefto=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717251440; c=relaxed/simple;
	bh=SIzXdKWTN82UCewz8auXcp82VvDIsKqatXvXO2C0hYQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ctqvm9Dm1EU5GW40JHvdwZneQrJwucTLdiTqFx6kMhdlx6EWLIq2Gf25s4fB/nOAad7652T181xVVH2I4keEbLxJzqvc2mzy5wMQ/D5VoP9e9vAEPMjyAypKl5T+nM0EVpfaqyd9AcC7ZckFU/fIkpm/S8Y5duubiZOyK/7CEHE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e10.mail.nifty.com
          with ESMTP
          id <20240601141714723.IWXT.33191.localhost.localdomain@nifty.com>;
          Sat, 1 Jun 2024 23:17:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH v4] Cygwin: pthread: Fix a race issue introduced by the commit 2c5433e5da82
Date: Sat,  1 Jun 2024 23:16:52 +0900
Message-ID: <20240601141700.3911-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717251434;
 bh=nE7PH4VcQaRCQShB0474WUy2vurzbQiIQ4BN92q7aA0=;
 h=From:To:Cc:Subject:Date;
 b=dHmr80vRC0Preki7TfPlGueHh0tNK5+tZ7GrjoQ0LIVgxf2BL5P7UAoY6P+fXaaWy9RGKKIH
 AqSF/smfelKof6DD28oSg4DOmRvDZhqIO9NVVUn077xgIGP1Fg0987EH8UXGe3u5S3jCmmHvc6
 pXxWuh2uRilcuL/gEu2XfjWAdYqcnf+DwI5FGhNMJlD37Md8BETvxrnN643FhauDEx23Rw2JOJ
 qYZ++RNyVFvHvvjOd4r8nrrfugmgCJPPCgb1w8X85Vhyp91BoE67IDuXeb2hnAfJDky6VIZf3A
 VB3JJqt+kN6zUx409pKuqb2zmsTAbJTLcnE6rMoU1cN1MZnA==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

To avoid race issues, pthread::once() uses pthread_mutex. This caused
the handle leak which was fixed by the commit 2c5433e5da82. However,
this fix introduced another race issue, i.e., the mutex may be used
after it is destroyed. This patch fixes the issue. Special thanks to
Bruno Haible for discussing how to fix this.

Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255987.html
Reported-by: Bruno Haible <bruno@clisp.org>
Fixes: 2c5433e5da82 ("Cygwin: pthread: Fix handle leak in pthread_once.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/thread.h |  2 +-
 winsup/cygwin/thread.cc               | 34 ++++++++++++++-------------
 2 files changed, 19 insertions(+), 17 deletions(-)

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
index 0f8327831..e060af084 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -2045,27 +2045,29 @@ pthread::create (pthread_t *thread, const pthread_attr_t *attr,
 int
 pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
 {
-  // already done ?
-  if (once_control->state)
+  /* Sign bit of once_control->state is used as done flag.
+     Similary, the next significant bit is used as destroyed flag. */
+  const int done = INT_MIN;		/* 0b1000000000000000 */
+  const int destroyed = INT_MIN >> 1;	/* 0b1100000000000000 */
+  if (once_control->state & done)
     return 0;
 
-  pthread_mutex_lock (&once_control->mutex);
-  /* Here we must set a cancellation handler to unlock the mutex if needed */
-  /* but a cancellation handler is not the right thing. We need this in the thread
-   *cleanup routine. Assumption: a thread can only be in one pthread_once routine
-   *at a time. Stote a mutex_t *in the pthread_structure. if that's non null unlock
-   *on pthread_exit ();
-   */
-  if (!once_control->state)
+  /* The type of &once_control->state is int *, which is compatible with
+     LONG * (the type of the pointer argument of InterlockedXxx()). */
+  if ((InterlockedIncrement (&once_control->state) & done) == 0)
     {
-      init_routine ();
-      once_control->state = 1;
+      pthread_mutex_lock (&once_control->mutex);
+      if (!(once_control->state & done))
+	{
+	  init_routine ();
+	  InterlockedOr (&once_control->state, done);
+	}
       pthread_mutex_unlock (&once_control->mutex);
-      while (pthread_mutex_destroy (&once_control->mutex) == EBUSY);
-      return 0;
     }
-  /* Here we must remove our cancellation handler */
-  pthread_mutex_unlock (&once_control->mutex);
+  InterlockedDecrement (&once_control->state);
+  if (InterlockedCompareExchange (&once_control->state,
+				  destroyed, done) == done)
+    pthread_mutex_destroy (&once_control->mutex);
   return 0;
 }
 
-- 
2.45.1

