Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 58CE6385843B; Tue, 24 Jun 2025 08:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 58CE6385843B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750752130;
	bh=eJdGAU+wOLnWmheNCOPUaOqYgj43jOU7cyt4PiNN+sE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=bKwTDp50cqcjQhfUnqTIR3oq/ZWk3sPPCtQRl9C2qAMA4vDe5SFIy+yzGxBKpmwvs
	 vWZducEwJSo759tVpiZXrjEuADpHMwC82Ayip1vUb3UrSz06TmTFqJeRDu07GmOG5q
	 wQa91znErE1DzB72Fqq7n1sn+icIqxVsJAMmc14k=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 326A5A80CF9; Tue, 24 Jun 2025 10:02:08 +0200 (CEST)
Date: Tue, 24 Jun 2025 10:02:08 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: signal: Do not suspend myself and use VEH
Message-ID: <aFpbgHpjSYkgPGGI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250623205707.1387-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623205707.1387-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jun 24 05:56, Takashi Yano wrote:
> After the commit f305ca916ad2, some stress-ng tests fail in arm64
> windows. There seems to be two causes for this issue. One is that
> calling SuspendThread(GetCurrentThread()) may suspend myself in
> the kernel. Branching to sigdelayed in the kernel code does not
> work as expected as the original _cygtls::interrup_now() intended.
> The other cause is, single step exception sometimes does not trigger
> exception::handle() for some reason. Therefore, register vectored
> exception handler (VEH) and use it for single step exception instead.

Patch LGTM, except that we have to link against another DLL now.
I searched for another way and it turns out there are equivalent
Rtl functions RtlWaitOnAddress/RtlWakeAddressSingle in ntdll.dll.

I pasted my tweak to your patch below, hope that's ok with you.

Can you check that it still works as expected?

Thanks,
Corinna

P.S.: There is also a function RtlWakeAddressSingleNoFence.
      Can anybody imagine what the difference is?  I'm not familiar with
      this fence / no fence stuff...


From 735c8d2cd6b27e810024a53e467bc5a2fc9d94d4 Mon Sep 17 00:00:00 2001
From: Takashi Yano <takashi.yano@nifty.ne.jp>
Date: Tue, 24 Jun 2025 05:56:57 +0900
Subject: [PATCH] Cygwin: signal: Do not suspend myself and use VEH

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
 winsup/cygwin/exceptions.cc           | 50 ++++++++++++++++-----------
 winsup/cygwin/local_includes/cygtls.h |  1 +
 winsup/cygwin/local_includes/ntdll.h  |  2 ++
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a4699b17271a..4105a4bc560f 100644
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
@@ -942,27 +953,26 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
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
+	  while (!in_singlestep_handler)
+	    RtlWaitOnAddress (&in_singlestep_handler, &bool_false,
+			      sizeof (bool), NULL);
+	  SuspendThread (*this);
 	  GetThreadContext (*this, cx);
+	  RemoveVectoredExceptionHandler (h_veh);
 	  suspend_on_exception = false;
 	}
 #endif
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 44bd44e72946..9f83c134c88c 100644
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
index a2c5b27db843..19908935fc59 100644
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
2.49.0

