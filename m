Return-Path: <SRS0=2kyc=ZG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id C099638505D4
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 13:38:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C099638505D4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C099638505D4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750685918; cv=none;
	b=d0rW0891EU2US6C9G9obxzdnvHG3CumGGNirms7lHr2pJt6oRhyFz0pbNpyO6RY1Frf6jKawFS5cupC0GybNsHri6Rgf1SRt9gDnnmcYVTTB9oOVTKuxH3B2/JQfbHfEBuiLiWLF/v2cgAe8hGXxpLJYazNgf4fWrMUiT/w+R3k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750685918; c=relaxed/simple;
	bh=CQETNiXLB+85XC04gzTPqgylhAlB17t4DqlGq8Xbujo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=a+AiEu7iLcRt57cCCWyNNN+wAVPQA/pMG+nuoeJa+U/+L5+C9UcXuNvxlsnGPE0Boy7bFr/tdU1OZv1uvy4ok2dJkdBEGiONHAQQZod2GMRzbGncvFS75lNMWm4oowMwHjS9uEDha52sj1kBzMXqG+pEWM/+SMRh5C7W9Uw37Ys=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C099638505D4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TD3OlIlA
Received: from localhost.localdomain by mta-snd-e07.mail.nifty.com
          with ESMTP
          id <20250623133835741.EFAP.70161.localhost.localdomain@nifty.com>;
          Mon, 23 Jun 2025 22:38:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v2] Cygwin: signal: Do not suspend myself and use VEH
Date: Mon, 23 Jun 2025 22:38:12 +0900
Message-ID: <20250623133820.1645-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750685915;
 bh=zqYgP0L0Yhexhw5EI98QUOul4X345SSZkkPkgb/DNlk=;
 h=From:To:Cc:Subject:Date;
 b=TD3OlIlAHZ+t5lgfqHl+0v2gCGkLmeJlZeefKjUT9YjOXzi5iS3hPuOreA/bxhtP2wwHay50
 K0gBOq4hS5mKXc3HDHLl1W0320e7bzPPxNL9bGWLKyP2wbTfCp/SUprGIyGmjEaJMeqzCHhD3d
 Ibz6sZlydCvmsNuhgGJW/fAx00SQEqqLM7MWaBzO5prtcjzR5hs/NEDE2IY3CNq/KA6PiS3bnu
 TvJ553CNw4VJkEXHNybvulrpuVqmH5L5vjcNpFmubC+7TATSEf5t5kKh5YYuN4JoAMu0GTaI4d
 ixMXb+gIIGyUME4d868qI6GvXHjnIgXd03zW5KVInoqYNXFA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit f305ca916ad2, some stress-ng tests fail in arm64
windows. There seems to be two causes for this issue. One is that
calling SuspendThread(GetCurrentThread()) may suspend myself in
the kernel. Branching to sigdelayed in the kernel code does not
work as expected as the original _cygtls::interrup_now() intended.
The other cause is, single step exception sometimes does not trigger
exception::handle() for some reason. Therefore, register vectored
exception handler (VEH) and use it for single step exception instead.

Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258332.html
Fixes: f305ca916ad2 ("Cygwin: signal: Prevent unexpected crash on frequent SIGSEGV")
Reported-by: Jeremy Drake <cygwin@jdrake.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 48 ++++++++++++++++-----------
 winsup/cygwin/local_includes/cygtls.h |  1 +
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a4699b172..d599ee509 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -653,13 +653,6 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
   static int NO_COPY debugging = 0;
   _cygtls& me = _my_tls;
 
-  if (me.suspend_on_exception)
-    {
-      SuspendThread (GetCurrentThread ());
-      if (e->ExceptionCode == (DWORD) STATUS_SINGLE_STEP)
-	return ExceptionContinueExecution;
-    }
-
   if (debugging && ++debugging < 500000)
     {
       SetThreadPriority (hMainThread, THREAD_PRIORITY_NORMAL);
@@ -923,6 +916,24 @@ sig_handle_tty_stop (int sig, siginfo_t *, void *)
 }
 } /* end extern "C" */
 
+#ifdef __x86_64__
+static HANDLE h_veh = NULL;
+static LONG CALLBACK
+veh (EXCEPTION_POINTERS *ep)
+{
+  if (_my_tls.suspend_on_exception)
+    {
+      _my_tls.in_exception_handler = true;
+      while (_my_tls.suspend_on_exception) ; /* Don't call yield() to privent
+						the thread form being suspended
+						in the kernel. */
+      if (ep->ExceptionRecord->ExceptionCode == (DWORD) STATUS_SINGLE_STEP)
+	return EXCEPTION_CONTINUE_EXECUTION;
+    }
+  return EXCEPTION_CONTINUE_SEARCH;
+}
+#endif
+
 bool
 _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
 			struct sigaction& siga)
@@ -943,25 +954,22 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
 	 by setting the trap flag (TF) before calling ResumeThread(). This
 	 will trigger either STATUS_SINGLE_STEP or the exception caused by
 	 the instruction that Rip originally pointed to.  By suspending the
-	 targeted thread within exception::handle(), Rip no longer points
-	 to the problematic instruction, allowing safe handling of the
-	 interrupt. As a result, Rip can be adjusted appropriately, and the
-	 thread can resume execution without unexpected crashes.  */
+	 targeted thread within the vectored exception handler veh(), Rip no
+	 longer points to the problematic instruction, allowing safe handling
+	 of the interrupt.  As a result, Rip can be adjusted appropriately,
+	 and the thread can resume execution without unexpected crashes. */
       if (!inside_kernel (cx, true))
 	{
+	  if (h_veh == NULL)
+	    h_veh = AddVectoredExceptionHandler (1, veh);
 	  cx->EFlags |= 0x100; /* Set TF (setup single step execution) */
 	  SetThreadContext (*this, cx);
 	  suspend_on_exception = true;
+	  in_exception_handler = false;
 	  ResumeThread (*this);
-	  ULONG cnt = 0;
-	  NTSTATUS status;
-	  do
-	    {
-	      yield ();
-	      status = NtQueryInformationThread (*this, ThreadSuspendCount,
-						 &cnt, sizeof (cnt), NULL);
-	    }
-	  while (NT_SUCCESS (status) && cnt == 0);
+	  while (!in_exception_handler)
+	    yield ();
+	  SuspendThread (*this);
 	  GetThreadContext (*this, cx);
 	  suspend_on_exception = false;
 	}
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 44bd44e72..05ac5627d 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -204,6 +204,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   __tlsstack_t stack[TLS_STACK_SIZE];
   unsigned initialized;
   volatile bool suspend_on_exception;
+  volatile bool in_exception_handler;
 
 public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   void init_thread (void *, DWORD (*) (void *, void *));
-- 
2.45.1

