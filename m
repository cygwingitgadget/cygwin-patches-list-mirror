Return-Path: <SRS0=7NHZ=YM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id DCF003857432
	for <cygwin-patches@cygwin.com>; Wed, 28 May 2025 12:52:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DCF003857432
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DCF003857432
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748436764; cv=none;
	b=SMLILspJrEN/AR+a8IJKpXuEzqtNy4I7A4xzaFLkSlzOUt53NYQurNpHaerGA8J3W63H0pzoItfsczcwIIqgLCgARCBCwUVHMxlq1uT/euR7ZMtrgyr3X2eG9qIUKUIxedWQ4JT9rIClABG4+DwNRSjCqQlamJzlYhQhnal3ubU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748436764; c=relaxed/simple;
	bh=rxeIKxRl0VXIBIzjK+aLSCsCTeYtnSWMKwPlVeir9to=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=cxcdCgAy3XKTdTPCkOMjUm6y0T/RjqLIHFS7/Kza4oflDZB7mgB/6FRwTETufdf8Vn56caPNT4dtJC6gmCoGp8QOf8nUz481JawspQbYTgzYvYbXUNymKm9l3mKlErfibKqYllg2eyhzB0gI1ol1OUKDcCXV1bKPDIbqbX9Tr+M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DCF003857432
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VtvTuJJo
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20250528125240469.GYW.116286.localhost.localdomain@nifty.com>;
          Wed, 28 May 2025 21:52:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: signal: Prevent unexpected crash on frequent SIGSEGV
Date: Wed, 28 May 2025 21:52:11 +0900
Message-ID: <20250528125222.2347-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1748436760;
 bh=5z9ryS1v/W/wNhnDtYmmLWBvg37AvzwiL8x9raNlaR8=;
 h=From:To:Cc:Subject:Date;
 b=VtvTuJJom/gjjMnAKhgErAMmkjGkqaSHuNEtdH7oyClE93xqsVcTtwHvv0ybenrP5dIjUQ94
 YptmpW1yxSSil6S8esQSZ9CpDlaIBT4G70mnpmeDd67sUs4BUoCmv8vUCQtLquFE8MC5DhNTxY
 vf5Z8DL1czuz0WWjvqfzvaL5wTmrV7217WNmgmRnFWB00FPmped4AwK6ObRItUVRGnPHuk53AA
 pMkwFCfCL7IcEkkLPg66anvQH1siyCAtoqToCgN96+lI+LSft8++zX3mvzO2GeHAEkElHf8YXN
 IG5md143bVkVuO8xuOqEdfzjxOHZx/ApLc5TrDfGl6oZYzKg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When the thread is suspended and Rip (instruction pointer) points to
an instruction that causes an exception, modifying Rip and calling
ResumeThread() may sometimes result in a crash. To prevent this,
advance execution by a single instruction by setting the trap flag
(TF) before calling ResumeThread() as a workaround. This will trigger
either STATUS_SINGLE_STEP or the exception caused by the instruction
that Rip originally pointed to. By suspending the targeted thread
within exception::handle(), Rip no longer points to the problematic
instruction, allowing safe handling of the interrupt. As a result,
Rip can be adjusted appropriately, and the thread can resume
execution without unexpected crashes.

Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258153.html
Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 37 +++++++++++++++++++++++++++
 winsup/cygwin/local_includes/cygtls.h |  1 +
 winsup/cygwin/local_includes/ntdll.h  |  3 ++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 876b79e36..804adc92b 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -653,6 +653,13 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
   static int NO_COPY debugging = 0;
   _cygtls& me = _my_tls;
 
+  if (me.suspend_on_exception)
+    {
+      SuspendThread (GetCurrentThread ());
+      if (e->ExceptionCode == (DWORD) STATUS_SINGLE_STEP)
+	return ExceptionContinueExecution;
+    }
+
   if (debugging && ++debugging < 500000)
     {
       SetThreadPriority (hMainThread, THREAD_PRIORITY_NORMAL);
@@ -929,6 +936,36 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
     interrupted = false;
   else
     {
+#ifdef __x86_64__
+      /* When the Rip points to an instruction that causes an exception,
+	 modifying Rip and calling ResumeThread() may sometimes result in
+	 a crash. To prevent this, advance execution by a single instruction
+	 by setting the trap flag (TF) before calling ResumeThread(). This
+	 will trigger either STATUS_SINGLE_STEP or the exception caused by
+	 the instruction that Rip originally pointed to.  By suspending the
+	 targeted thread within exception::handle(), Rip no longer points
+	 to the problematic instruction, allowing safe handling of the
+	 interrupt. As a result, Rip can be adjusted appropriately, and the
+	 thread can resume execution without unexpected crashes.  */
+      if (!inside_kernel (cx, true))
+	{
+	  cx->EFlags |= 0x100; /* Set TF (setup single step execution) */
+	  SetThreadContext (*this, cx);
+	  suspend_on_exception = true;
+	  ResumeThread (*this);
+	  ULONG cnt = 0;
+	  NTSTATUS status;
+	  do
+	    {
+	      yield ();
+	      status = NtQueryInformationThread (*this, ThreadSuspendCount,
+						 &cnt, sizeof (cnt), NULL);
+	    }
+	  while (NT_SUCCESS (status) && cnt == 0);
+	  GetThreadContext (*this, cx);
+	  suspend_on_exception = false;
+	}
+#endif
       DWORD64 &ip = cx->_CX_instPtr;
       push (ip);
       interrupt_setup (si, handler, siga);
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 4698352ae..1b3bf65f1 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -203,6 +203,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   __tlsstack_t *stackptr;
   __tlsstack_t stack[TLS_STACK_SIZE];
   unsigned initialized;
+  volatile bool suspend_on_exception;
 
 public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   void init_thread (void *, DWORD (*) (void *, void *));
diff --git a/winsup/cygwin/local_includes/ntdll.h b/winsup/cygwin/local_includes/ntdll.h
index 97a83d1e3..f32e850f4 100644
--- a/winsup/cygwin/local_includes/ntdll.h
+++ b/winsup/cygwin/local_includes/ntdll.h
@@ -1362,7 +1362,8 @@ typedef enum _THREADINFOCLASS
   ThreadBasicInformation = 0,
   ThreadTimes = 1,
   ThreadImpersonationToken = 5,
-  ThreadQuerySetWin32StartAddress = 9
+  ThreadQuerySetWin32StartAddress = 9,
+  ThreadSuspendCount = 35
 } THREADINFOCLASS, *PTHREADINFOCLASS;
 
 typedef struct _THREAD_BASIC_INFORMATION
-- 
2.45.1

