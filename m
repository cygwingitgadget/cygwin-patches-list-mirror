Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 9F6223858D33
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 13:55:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F6223858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F6223858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732542951; cv=none;
	b=SaDsTin8554VAZRioSdm2EroUHIwPEqxyHSaYwHRDVrQTlui1WmeseR+hhVEDJYPfoGG6r09BMno/mmhJ5O1P/qps40b7lJ48jQApyRghRo4+ArS3GXxzKWOzbbyXNPm+QpTJG88JinZOpU8j6XJU9nZ0EOYxM3oXD/v8kddhhc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732542951; c=relaxed/simple;
	bh=vz3O/c0Xc7e8k1v+TbkKI4msQorVRTdjSoUTcyz77kY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=dkStoOKnKFzLN1fRpbKUtNyYKwEuXfu6Cih/1/LzrFcChVdBdKx1PJYEnQYQcBftjL7hVWSohMxQlu1DGUsKCk0yWnJ/LJU7WSpxLPuWFpj2vvLRl/q7HC7lV481rmCP9Tb+Q219wZV3YuI0HxII6sBQjAB8vhc++JJ5sY0uBhs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F6223858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L1/vFcPh
Received: from localhost.localdomain by mta-snd-e07.mail.nifty.com
          with ESMTP
          id <20241125135548190.UECP.76216.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 22:55:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 4/6] Cygwin: signal: Optimize the priority of the sig thread
Date: Mon, 25 Nov 2024 22:55:23 +0900
Message-ID: <20241125135532.8344-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732542948;
 bh=J0FP1Dr2K6KaLtLJkv7+YmMP0TfNs2u3ISfP3Igi770=;
 h=From:To:Cc:Subject:Date;
 b=L1/vFcPhJUTi2OuUwi0yz3+069FkHF0PG6xI3DPz7cQAg+u6LS3PB+jVnN8pOsYGDs+tPw0q
 bKLzDBCp0BU6cxTGMdoydba5Ev597R181C+aLDWQC5fg0zM+m1U2TM6GwL0I4wsS2LvmF+dTIn
 XXWmZMOx4v0s8W18QY36jkWJeGXjMptR3gUxHauZ6/YQYmJuaUKLyoSY73/mr+cQzRCX7bX8gj
 X2M+L5KGutTOLTb1QX7a4mvkXb43nK3NvRF/0lJQ9+ASFBco8dJEY2UUJ5d6vmPVVqOlwWFF0Q
 ezf4tLKDLYtqjJToYdK8akk4MS5zUPeU3WhBQkBESEGgtzrA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, sig thread ran in THREAD_PRIORITY_HIGHEST priority.
This caused critical delay in signal handling in the main thread
if the too many signales are received rapidly and CPU is very busy.
I this case, most of CPU time is allocated to sig thread, so the
main thread cannot have a chance to handle signals. With this patch,
the sig thread priority is set to the same priority with main thread
to avoid such situation. Furthermore, if the signal is alarted to
the main thread, but main thread does not handle it yet, in order to
increase the chance to handle it in the main thread, reduce the sig
thread priority is to THREAD_PRIORITY_LOWEST temporarily.

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

