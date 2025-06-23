Return-Path: <SRS0=2kyc=ZG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.185])
	by sourceware.org (Postfix) with ESMTPS id A96E13851158
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 11:52:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A96E13851158
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A96E13851158
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.185
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750679532; cv=none;
	b=hr3OsioiGoHRCTFcY4TidZL1CIiOWXx178GMq1P9PlgU82QHkBrQfrhlI7sSDmz+vRYiva/D6XZL8DzbjIPXUqvTlmP4UzbUDxDZaD5cGqclRY586HaG3c/k4MjC5hSYFLnhFTzLMTWYIRnYce5hx3hUuC1I/ThbeDSNXMZ2g70=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750679532; c=relaxed/simple;
	bh=kwyrqyERxpZggELrtvBeed/ibbd/lMhfOZDibe8fAsE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Fkkp8+W2naf7jgxJobZIR1uHkTClTSwLKDREEnyiYCFayYohpCjpWjYn8Oaii4eSMFcfAlZ9HpERSR8FTnG9PT8BFub7FkWVTQvM4j8Yyx9rzTL8ConzE/sSIu1Y4DxXfQzR4R23C6sx8G7BQe1bHA1+rp29ylrRrAC2z7Q6/ZQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A96E13851158
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KMbKoFAt
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20250623115208405.DLLV.58584.localhost.localdomain@nifty.com>;
          Mon, 23 Jun 2025 20:52:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: signal: Do not suspend myself and use VEH
Date: Mon, 23 Jun 2025 20:51:44 +0900
Message-ID: <20250623115152.1844-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750679528;
 bh=6DdYj/8QfzHx5JbnIXU4p6fPUV6nuP9qFt2NqiJ009Y=;
 h=From:To:Cc:Subject:Date;
 b=KMbKoFAtVOoziPGLe4lk1p6eO+6Dj5dXvnXRvMCYrHtiI3kZVLkifDwKnt8ugyQpVqIgxEaP
 Lpl5aQ+WUTUnsT87d+lsKaR+a0rELgQGGFfpEyA6w3Mrl486+xYvkkj58OC2dX2XoMjdz2Wuir
 E7DByjFuBX4Q56Glwl4cfje0iCDzssYEkyRC66V5Sjpks4ejt+k73Jlti9iYjRlOeDrJUw2F9L
 xdsGgB1FkpvMScxUaOXocQHtAYoDGSTB1oSNBuqySFN3jtYkk4+SDqt44U6KmBQOEu2ojaZmhf
 sLvuqw7yJVnU54Fio3RHyLiXoTN1HtjCpQJQrBJw6DNN/4Ww==
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_PSBL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/exceptions.cc           | 46 +++++++++++++++------------
 winsup/cygwin/local_includes/cygtls.h |  1 +
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a4699b172..e5193551b 100644
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
@@ -923,6 +916,22 @@ sig_handle_tty_stop (int sig, siginfo_t *, void *)
 }
 } /* end extern "C" */
 
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
+
 bool
 _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
 			struct sigaction& siga)
@@ -943,25 +952,22 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
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

