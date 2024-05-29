Return-Path: <SRS0=v+Dn=NA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.226.35])
	by sourceware.org (Postfix) with ESMTPS id 3FBA3385840F
	for <cygwin-patches@cygwin.com>; Wed, 29 May 2024 10:30:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3FBA3385840F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3FBA3385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1716978653; cv=none;
	b=waqGFn5vuNykzeVrUeEeKMNcZPvqAp5R1GjBjmiFFjWmFab4vcnAGfcbJyMrIoVgR4lVC3Ic6APdA/3nlUMQPjMtw/Q8Mwyr+yn9kWAgVh53mJf+DLVhoVpOVDBEHz4ZVyeAubUgQK9x9tcVhrg8yNDPtfo1aZtYj+hYZv69ftU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716978653; c=relaxed/simple;
	bh=zZe/V5TBIwq0Wt0u8AWp+5I2rsILThLM5mUHqubQ2AY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=VTLe1frG6dMb+trD7wPeQVn8bZy4Y7IQnDbkBQLiloCVHp3Wl5s6VnyzlBoRimxSWnKTRkm5N/34GBqbdCtUvg84zK12SR5u+lRpIVDIMlvW6nFnxQIigjYYj3L3YbMYiPilnui6Y8M73NCBzohojf6MCWw96dQN0r4VMEutw04=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e03.mail.nifty.com
          with ESMTP
          id <20240529103049514.EWIJ.40277.localhost.localdomain@nifty.com>;
          Wed, 29 May 2024 19:30:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH] Cygwin: pthread: Fix a race issue introduced by the commit 2c5433e5da82
Date: Wed, 29 May 2024 19:30:12 +0900
Message-ID: <20240529103020.53514-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1716978649;
 bh=/lown3lK/vb1OHiwyYFjbrzlybjQ+01xHzXbuxlNpl8=;
 h=From:To:Cc:Subject:Date;
 b=VYdPEtLs4xPriziDbyGwwWJw+LndslFtP5ywlblFzTIzDS94EDSewswwLY0L6VP6/TBAYIml
 cSsPaD/d2axgFZQxeGZSUhB2J6HJQZCx6HZnD49srwVTPUl/Tmv6qoTPlsgWoln3bGIsSqmfML
 f4ah/uEE9sdn3IX7iDRM0K73sDUeqeHcMSRa9oiOCSbxrOStrMh4vUlvcfKtzo3wmE+XY/qilj
 N5FFuoyZNRlG3khkvXi801lNd71FWiFPKcbvPSchcZTQMTvEAAud1y4M7St9XuA9XTfwmjcHVe
 hP7eXW80vZb6mXL78BtaIusq6CfUlLSk/7BYOJ7LGVBM7H8g==
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

To avoid race issues, pthread::once() uses pthread_mutex. This caused
the handle leak which was fixed by the commit 2c5433e5da82. However,
this fix introduced another race issue, i.e., the mutex may be used
after it is destroyed. With this patch, do not use pthread_mutex in
pthread::once() to avoid both issues. Instead, InterlockedExchage()
is used.

Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255987.html
Reported-by: Bruno Haible <bruno@clisp.org>
Fixes: 2c5433e5da82 ("Cygwin: pthread: Fix handle leak in pthread_once.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/thread.cc | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 0f8327831..1e5f9362b 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -2045,27 +2045,10 @@ pthread::create (pthread_t *thread, const pthread_attr_t *attr,
 int
 pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
 {
-  // already done ?
-  if (once_control->state)
-    return 0;
-
-  pthread_mutex_lock (&once_control->mutex);
-  /* Here we must set a cancellation handler to unlock the mutex if needed */
-  /* but a cancellation handler is not the right thing. We need this in the thread
-   *cleanup routine. Assumption: a thread can only be in one pthread_once routine
-   *at a time. Stote a mutex_t *in the pthread_structure. if that's non null unlock
-   *on pthread_exit ();
-   */
-  if (!once_control->state)
-    {
-      init_routine ();
-      once_control->state = 1;
-      pthread_mutex_unlock (&once_control->mutex);
-      while (pthread_mutex_destroy (&once_control->mutex) == EBUSY);
-      return 0;
-    }
-  /* Here we must remove our cancellation handler */
-  pthread_mutex_unlock (&once_control->mutex);
+  /* The type of &once_control->state is int *, which is compatible with
+     LONG * (the type of the first argument of InterlockedExchange()). */
+  if (!InterlockedExchange (&once_control->state, 1))
+    init_routine ();
   return 0;
 }
 
-- 
2.45.1

