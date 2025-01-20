Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id 2E7153858C2B
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 17:48:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2E7153858C2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2E7153858C2B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737395338; cv=none;
	b=k4cuqHcc72BpE+0QQpp12MIItAao2RxhxYzN/QoGMQnEFvN70mDujBf3cvq9JpLDH9p56k0N8bkL2hjsNgFaRNDVgjHrCW5vNwW9sxQYvwCC93jMsOAbJEyv+1lnA6L5MLX6vGS9R6vLeDVKtkkpwQ0sTNxbwFE8xyxPZiODELQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737395338; c=relaxed/simple;
	bh=/ldgz7z35j1+8Hy7ePEZlw5gzjt6GCc576iSHQz6K8o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=pIud0CQP1tI+ZrEZewODbZWenEAJ/ByvKxO77Ye6f0gQRHCB5G0eaAkDaUv0+Lgsiaut5Pb2NbhAcIgONHEN+xWwZP4qwBPo+QHh31BxCqeMZHRY/VlEeOTm5NeKk1T4XHG8gDOGy03KrDM/Fb6WSh/C35beGMyFFhgxTs432L8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2E7153858C2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KVfEUFL/
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120174856503.TQAG.87244.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 02:48:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v5 2/3] Cygwin: cygwait: Make cygwait() reentrant
Date: Tue, 21 Jan 2025 02:47:56 +0900
Message-ID: <20250120174811.43043-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120174811.43043-1-takashi.yano@nifty.ne.jp>
References: <20250120174811.43043-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737395336;
 bh=qbKo+k+kjXbKpMHBcUe+j0c02tOUPufvAIMdH61U+K8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KVfEUFL/Krb4drwXkgnQaFcy2Tu2l0/G6QyVVfjr8vdwdzEP00oo6kxM2CcWJmZNfX2ByH6i
 5r66jKsWrwzdgXNpTaEV4PziHDQklaLnymKGAK7AvNI0KDEohHDaZwSDkKEi1YZ2vo7yx6B3C/
 RRX+frl9Sx5rn0z05i5yXaO7ynRMf540WZcNlv79y8LzORHcz9SsV9ftGRM65OIF2HrFamwCIA
 GkxSWgR7kDf3cW4qSScE5o+hsTeXMQv677AkUqqEZAozZLSSrfzwQ1YYUOS/D9CKxAAdSH2PCA
 IgHFkLOYzP6Q56/R+fMpj5g1zkU0mur60qibd7Gu61Ow44Hg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

To allow cygwait() to be called in the signal handler, a locally
created timer is used instead of _cygtls::locals.cw_timer if it is
in use.

Co-Authored-By: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/cygtls.cc               |  2 ++
 winsup/cygwin/cygwait.cc              | 23 ++++++++++++++++-------
 winsup/cygwin/local_includes/cygtls.h |  3 ++-
 winsup/cygwin/select.cc               | 21 +++++++++++++++------
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/cygtls.cc b/winsup/cygwin/cygtls.cc
index bfaa19867..1134adc3e 100644
--- a/winsup/cygwin/cygtls.cc
+++ b/winsup/cygwin/cygtls.cc
@@ -64,6 +64,7 @@ _cygtls::init_thread (void *x, DWORD (*func) (void *, void *))
   initialized = CYGTLS_INITIALIZED;
   errno_addr = &(local_clib._errno);
   locals.cw_timer = NULL;
+  locals.cw_timer_inuse = false;
   locals.pathbufs.clear ();
 
   if ((void *) func == (void *) cygthread::stub
@@ -85,6 +86,7 @@ _cygtls::fixup_after_fork ()
   signal_arrived = NULL;
   locals.select.sockevt = NULL;
   locals.cw_timer = NULL;
+  locals.cw_timer_inuse = false;
   locals.pathbufs.clear ();
   wq.thread_ev = NULL;
 }
diff --git a/winsup/cygwin/cygwait.cc b/winsup/cygwin/cygwait.cc
index 80c0e971c..e9ac420e4 100644
--- a/winsup/cygwin/cygwait.cc
+++ b/winsup/cygwin/cygwait.cc
@@ -58,16 +58,21 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
     }
 
   DWORD timeout_n;
+  HANDLE *wait_timer = &_my_tls.locals.cw_timer;
+  HANDLE local_wait_timer = NULL;
   if (!timeout)
     timeout_n = WAIT_TIMEOUT + 1;
   else
     {
+      if (_my_tls.locals.cw_timer_inuse)
+	wait_timer = &local_wait_timer;
+      else
+	_my_tls.locals.cw_timer_inuse = true;
       timeout_n = WAIT_OBJECT_0 + num++;
-      if (!_my_tls.locals.cw_timer)
-	NtCreateTimer (&_my_tls.locals.cw_timer, TIMER_ALL_ACCESS, NULL,
-		       NotificationTimer);
-      NtSetTimer (_my_tls.locals.cw_timer, timeout, NULL, NULL, FALSE, 0, NULL);
-      wait_objects[timeout_n] = _my_tls.locals.cw_timer;
+      if (!*wait_timer)
+	NtCreateTimer (wait_timer, TIMER_ALL_ACCESS, NULL, NotificationTimer);
+      NtSetTimer (*wait_timer, timeout, NULL, NULL, FALSE, 0, NULL);
+      wait_objects[timeout_n] = *wait_timer;
     }
 
   while (1)
@@ -100,7 +105,7 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
     {
       TIMER_BASIC_INFORMATION tbi;
 
-      NtQueryTimer (_my_tls.locals.cw_timer, TimerBasicInformation, &tbi,
+      NtQueryTimer (*wait_timer, TimerBasicInformation, &tbi,
 		    sizeof tbi, NULL);
       /* if timer expired, TimeRemaining is negative and represents the
 	  system uptime when signalled */
@@ -108,7 +113,11 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
 	timeout->QuadPart = tbi.SignalState || tbi.TimeRemaining.QuadPart < 0LL
                             ? 0LL : tbi.TimeRemaining.QuadPart;
       }
-      NtCancelTimer (_my_tls.locals.cw_timer, NULL);
+      NtCancelTimer (*wait_timer, NULL);
+      if (local_wait_timer)
+	NtClose(local_wait_timer);
+      else
+	_my_tls.locals.cw_timer_inuse = false;
     }
 
   if (res == WAIT_CANCELED && is_cw_cancel_self)
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index e0de712f4..d814814b1 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -135,6 +135,7 @@ struct _local_storage
 
   /* thread.cc */
   HANDLE cw_timer;
+  bool cw_timer_inuse;
 
   tls_pathbuf pathbufs;
   char ttybuf[32];
@@ -180,7 +181,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   siginfo_t *sigwait_info;
   HANDLE signal_arrived;
   bool will_wait_for_signal;
-#if 0
+#if 1
   long __align;			/* Needed to align context to 16 byte. */
 #endif
   /* context MUST be aligned to 16 byte, otherwise RtlCaptureContext fails.
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index a440a98d4..e44d42a0d 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -385,13 +385,18 @@ next_while:;
      to create the timer once per thread.  Since WFMO checks the handles
      in order, we append the timer as last object, otherwise it's preferred
      over actual events on the descriptors. */
-  HANDLE &wait_timer = _my_tls.locals.cw_timer;
+  HANDLE *wait_timer = &_my_tls.locals.cw_timer;
+  HANDLE local_wait_timer = NULL;
   if (us > 0LL)
     {
       NTSTATUS status;
-      if (!wait_timer)
+      if (_my_tls.locals.cw_timer_inuse)
+	wait_timer = &local_wait_timer;
+      else
+	_my_tls.locals.cw_timer_inuse = true;
+      if (!*wait_timer)
 	{
-	  status = NtCreateTimer (&wait_timer, TIMER_ALL_ACCESS, NULL,
+	  status = NtCreateTimer (wait_timer, TIMER_ALL_ACCESS, NULL,
 				  NotificationTimer);
 	  if (!NT_SUCCESS (status))
 	    {
@@ -400,7 +405,7 @@ next_while:;
 	    }
 	}
       LARGE_INTEGER ms_clock_ticks = { .QuadPart = -us * 10 };
-      status = NtSetTimer (wait_timer, &ms_clock_ticks, NULL, NULL, FALSE,
+      status = NtSetTimer (*wait_timer, &ms_clock_ticks, NULL, NULL, FALSE,
 			   0, NULL);
       if (!NT_SUCCESS (status))
 	{
@@ -408,7 +413,7 @@ next_while:;
 			 status, ms_clock_ticks.QuadPart);
 	  return select_error;
 	}
-      w4[m] = wait_timer;
+      w4[m] = *wait_timer;
       timer_idx = m++;
     }
 
@@ -430,7 +435,11 @@ next_while:;
   if (timer_idx)
     {
       BOOLEAN current_state;
-      NtCancelTimer (wait_timer, &current_state);
+      NtCancelTimer (*wait_timer, &current_state);
+      if (local_wait_timer)
+	NtClose (local_wait_timer);
+      else
+	_my_tls.locals.cw_timer_inuse = false;
     }
 
   wait_states res;
-- 
2.45.1

