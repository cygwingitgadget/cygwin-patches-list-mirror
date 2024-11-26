Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id AEE693857BB9
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:56:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AEE693857BB9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AEE693857BB9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611389; cv=none;
	b=sRwmEwnO8K54FsyeCiZrEiYq3jl0Q8Z6Ucbc/7FND2uIJJsQKFsghxjy2SOl0mtphguNfG5i9EpNL2p5TTq3djcjb0xAoq/OLceO2wC4y6V4LUzhqMDoVmzHNQmSrKXHL5Oum6u39OFuAbW9r2EYnyfvrU7wMM8xhy2it17fRig=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611389; c=relaxed/simple;
	bh=k1JVR0ppmy8VuQK8r0bR2/LhuRYIUOfOJFjEQQd4z+I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=XZReKa2gzxCqWNJagozvsMnV0UesKqZR0QVyrdM1w0UQmAwyaOGLmEV5/D+dAsH7J4+ki1ZPHXs2T+yXe39DgrSf8m6J5x21ca0tkLAX9PXeqk1RhTH52V/UTEe+hEn6+TBxeowwJFNwHdCGpGALkNUmqc/6C0GzcxziKQrTtLI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AEE693857BB9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IDC66yOC
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085627062.NQWI.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:56:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 4/7] Cygwin: signal: Optimize the priority of the sig thread
Date: Tue, 26 Nov 2024 17:55:01 +0900
Message-ID: <20241126085521.49604-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611387;
 bh=9ctdUr0VH0vSvx+EzS74zFn0jQp2sn9NnQIqvOpmGQo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IDC66yOC9eA9yUk3iOkuF5WUPduB4ylgIooJTAx1YJOEn3Q2Fah52Zr+Owl8sHeC+o+nEbm/
 pk7xjTXOjVQ0gxBGXwuedvv14VWfrzXfMkM46B7GToUdZxp2y/jI+cEDOK7rg+/HY9MiDVEF5W
 97hPV/7yuMmVCKgFNwhS1TU/tAGkxvxrU1y37NlANQYme1O4OnddcH3yl8Yt04hoWeQEMmXN06
 4OeZ2sJ+H/uM41EGO/XL1mRwOqDGBtTqvYhT+9AyUxBDghxQqCqf9wQ7Bn0l2LWjsVUywPemcz
 vqbDgdOkte5bT3g/P6SVkYCmqczPWWY6aEeumn9Hcy1gnFaw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
This causes a critical delay in the signal handling in the main thread
if too many signals are received rapidly and the CPU is very busy.
In this case, most of the CPU time is allocated to the sig thread, so
the main thread cannot have a chance to handle signals. With this patch,
the sig thread priority is set to the same priority as the main thread
to avoid such a situation. Furthermore, if the signal is alerted to
the main thread, but the main thread does not handle it yet, in order
to increase the chance of handling it in the main thread, reduce the
sig thread priority to THREAD_PRIORITY_LOWEST temporarily.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index b8d961a07..fc4360951 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1319,6 +1319,23 @@ wait_sig (VOID *)
     {
       DWORD nb;
       sigpacket pack = {};
+      /* Follow to the main thread priority */
+      int prio = THREAD_PRIORITY_NORMAL;
+      if (cygwin_finished_initializing)
+	{
+	  HANDLE h_main_thread = NULL;
+	  threadlist_t *tl_entry = cygheap->find_tls (_main_tls);
+	  if (_main_tls->thread_id)
+	    h_main_thread = OpenThread (THREAD_QUERY_INFORMATION,
+					FALSE, _main_tls->thread_id);
+	  cygheap->unlock_tls (tl_entry);
+	  if (h_main_thread)
+	    {
+	      prio = GetThreadPriority (h_main_thread);
+	      CloseHandle (h_main_thread);
+	    }
+	}
+      SetThreadPriority (GetCurrentThread (), prio);
       if (sigq.retry)
 	pack.si.si_signo = __SIGFLUSH;
       else if (sigq.start.next
@@ -1331,6 +1348,15 @@ wait_sig (VOID *)
 	  system_printf ("garbled signal pipe data nb %u, sig %d", nb, pack.si.si_signo);
 	  continue;
 	}
+      if (cygwin_finished_initializing)
+	{
+	  threadlist_t *tl_entry = cygheap->find_tls (_main_tls);
+	  if (_main_tls->current_sig)
+	    /* Decrease the priority in order to make main thread process
+	       this signal. */
+	    SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_LOWEST);
+	  cygheap->unlock_tls (tl_entry);
+	}
 
       sigq.retry = false;
       /* Don't process signals when we start exiting */
-- 
2.45.1

