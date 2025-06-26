Return-Path: <SRS0=1xMm=ZJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id B0C39385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 06:20:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B0C39385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B0C39385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750918854; cv=none;
	b=dIzth9CKqB64d8IIfHErMIaNkjkf/JD5XAmVQMor1jFBJl1GYk3fAY3680nI1cC8hLx9msN+HiZtM/NPnyfeb6Xsiui+dqUlD9DJuYy711LqeiGVkdb5AG+YyGD3BGYcx7SNuzabp2vtFiwKb4ofzrfu44iCK9BfNd7U1RM6eaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750918854; c=relaxed/simple;
	bh=b3HWni45DsVlU5foPHNjMOUYL8qkW3tcMdRsvubuQa4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=hs0Uxp7SIuvuhw8cV4Yl6KfLKhoprTS6Wifn9mw173BCIwYDR87NR9USXA5OteeFczlGJlLBY/ZN+oUPlRV8ybhngfirHumKohw7dQ9IyeNVDrF2Y+VwUZ0zjgdxDSAwpP4ctfp3VJelDBlStqOBaYOz4Dxk6NHczp9Ry475xeI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0C39385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TWiC1Qjf
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250626062051135.OEDV.17135.localhost.localdomain@nifty.com>;
          Thu, 26 Jun 2025 15:20:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jeremy Drake <cygwin@jdrake.com>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v4] Cygwin: signal: Do not suspend myself and use VEH
Date: Thu, 26 Jun 2025 15:20:18 +0900
Message-ID: <20250626062031.1093-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750918851;
 bh=1cHho5I3kvPEbXduN19hQ223zKdn50TJaED3DiptYWI=;
 h=From:To:Cc:Subject:Date;
 b=TWiC1Qjf3c62oOjw/35KdVuEjDgYh/J1tOHzuqC+hgTPHBzB6TBGyc+/A8CFLkb+j45aZkKx
 CAe+B0gqkh1okqsw+mDClsrGxJFc6ZpmnLTmZJpyEytclu4Ile/KaKj3s/aBEUE2Jre1iVEDJu
 pyH1U+EN+FhsDcFyAgJnT3dA6Sr52xsbAXSGLfNzP7bh3/eidscMmp5u/QBlLi0Gx5tKW7AVD9
 z3fsloVu/b5WiuzruIfj8iC1yHL4nUU7yJCepL5QzTZBbqkuBZvITbjvsKY+2ulOi7PVv4d+G2
 UyMaszSc2sp7FjJFMX6+nI8sbajaCf6JHwbYykmCpF8zh7VQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 55 ++++++++++++++++++---------
 winsup/cygwin/local_includes/cygtls.h |  1 +
 winsup/cygwin/local_includes/ntdll.h  |  2 +
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a4699b172..f79978f73 100644
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
+static LONG CALLBACK
+singlestep_handler (EXCEPTION_POINTERS *ep)
+{
+  if (_my_tls.suspend_on_exception)
+    {
+      _my_tls.in_singlestep_handler = true;
+      RtlWakeAddressSingle ((void *) &_my_tls.in_singlestep_handler);
+      while (_my_tls.suspend_on_exception)
+	; /* Don't call yield() to prevent the thread
+	     from being suspended in the kernel. */
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
@@ -942,28 +953,36 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
 	 a crash. To prevent this, advance execution by a single instruction
 	 by setting the trap flag (TF) before calling ResumeThread(). This
 	 will trigger either STATUS_SINGLE_STEP or the exception caused by
-	 the instruction that Rip originally pointed to.  By suspending the
-	 targeted thread within exception::handle(), Rip no longer points
+	 the instruction that Rip originally pointed to. By suspending the
+	 targeted thread within singlestep_handler(), Rip no longer points
 	 to the problematic instruction, allowing safe handling of the
-	 interrupt. As a result, Rip can be adjusted appropriately, and the
-	 thread can resume execution without unexpected crashes.  */
+	 interrupt.  As a result, Rip can be adjusted appropriately,
+	 and the thread can resume execution without unexpected crashes. */
       if (!inside_kernel (cx, true))
 	{
+	  HANDLE h_veh = AddVectoredExceptionHandler (0, singlestep_handler);
 	  cx->EFlags |= 0x100; /* Set TF (setup single step execution) */
 	  SetThreadContext (*this, cx);
 	  suspend_on_exception = true;
+	  in_singlestep_handler = false;
+	  bool bool_false = false;
+	  NTSTATUS status = STATUS_SUCCESS;
 	  ResumeThread (*this);
-	  ULONG cnt = 0;
-	  NTSTATUS status;
-	  do
+	  while (!in_singlestep_handler && NT_SUCCESS (status))
 	    {
-	      yield ();
-	      status = NtQueryInformationThread (*this, ThreadSuspendCount,
-						 &cnt, sizeof (cnt), NULL);
+	      LARGE_INTEGER timeout;
+	      timeout.QuadPart = -100000ULL; /* 10ms */
+	      status = RtlWaitOnAddress (&in_singlestep_handler, &bool_false,
+					 sizeof (bool), &timeout);
+	      if (status == STATUS_TIMEOUT)
+		break;
 	    }
-	  while (NT_SUCCESS (status) && cnt == 0);
+	  SuspendThread (*this);
 	  GetThreadContext (*this, cx);
+	  RemoveVectoredExceptionHandler (h_veh);
 	  suspend_on_exception = false;
+	  if (!NT_SUCCESS (status) || status == STATUS_TIMEOUT)
+	    return false; /* Not interrupted */
 	}
 #endif
       DWORD64 &ip = cx->_CX_instPtr;
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 44bd44e72..9f83c134c 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -204,6 +204,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   __tlsstack_t stack[TLS_STACK_SIZE];
   unsigned initialized;
   volatile bool suspend_on_exception;
+  volatile bool in_singlestep_handler;
 
 public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   void init_thread (void *, DWORD (*) (void *, void *));
diff --git a/winsup/cygwin/local_includes/ntdll.h b/winsup/cygwin/local_includes/ntdll.h
index a2c5b27db..19908935f 100644
--- a/winsup/cygwin/local_includes/ntdll.h
+++ b/winsup/cygwin/local_includes/ntdll.h
@@ -1660,6 +1660,8 @@ extern "C"
 					 BOOLEAN);
   WCHAR RtlUpcaseUnicodeChar (WCHAR);
   NTSTATUS RtlUpcaseUnicodeString (PUNICODE_STRING, PUNICODE_STRING, BOOLEAN);
+  VOID RtlWakeAddressSingle (PVOID);
+  NTSTATUS RtlWaitOnAddress (volatile void *, PVOID, SIZE_T, PLARGE_INTEGER);
   NTSTATUS RtlWriteRegistryValue (ULONG, PCWSTR, PCWSTR, ULONG, PVOID, ULONG);
 
 #ifdef __cplusplus
-- 
2.45.1

