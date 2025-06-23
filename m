Return-Path: <SRS0=2kyc=ZG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 0EB46384671F
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 20:57:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0EB46384671F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0EB46384671F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750712245; cv=none;
	b=cpfI2cvvJPJTdwgG0FhYhjScbYUy865k1Po1NEL3JSwwQ4D1ML0IBfsLHww61BaIjKwjY+Sl6O4CLJjdfexgMFK1Wms1e3nXpQOAy84ez+iH/yBqp0BxIzvMbL+xOyKl9mSRZPyU4FMyGpi7L3bnRxY1ADvmAh35Gqc6ru24A64=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750712245; c=relaxed/simple;
	bh=5J2I55EqysrqMrXy+swUsK/chnrRsWYfwM/DMUDNat8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nszXKje0T9sshdovTyuY51EBBQYN+JJ3mVO0qw26u8AwoveU959aQp+XQTM7C3fjicq2pUxwK0ILtGbmcLFu/PQ69zx9bTqfe9XjdEa9pWxCM1bP78YYmjjxuft5wvO4pXRaFJOFFthfjOx8ySQmKEm7N0IuO451N6ELHgaQLFc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0EB46384671F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tBHlPeBW
Received: from localhost.localdomain by mta-snd-e04.mail.nifty.com
          with ESMTP
          id <20250623205722884.NEYA.38814.localhost.localdomain@nifty.com>;
          Tue, 24 Jun 2025 05:57:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jeremy Drake <cygwin@jdrake.com>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3] Cygwin: signal: Do not suspend myself and use VEH
Date: Tue, 24 Jun 2025 05:56:57 +0900
Message-ID: <20250623205707.1387-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750712242;
 bh=bQpL6cwcXWfJoR84kJKEZTzRbPEIh2oosYKt82OrG9w=;
 h=From:To:Cc:Subject:Date;
 b=tBHlPeBWs69mUCLuFka2NTaSXNjePgI5rt3r59n+7jCGfmyYWSVZFGmTU9OPzcqLDagrie8w
 PUJHams95bFujfl+WGPjpY1Qth05OwTOBouHjsljJgB+g1hYSs2IE5Tkd3w6F1QEEODAwgrB9Y
 kmXWsv7nu7fJfzmubdPOYiA9R506r9K7UtwcYxtP0i9E8gtIgkOl91pmrjfE9TxBKRlHBjx1n5
 FvGGci5YtRAiwIWhDX8olEcKTokhryp20WDEhIH6Z6S0pqVgpekg4KIJYSf2ceXneq/9X6mQoF
 i6lDo/XptyBiHBZuwWZMrVP7+w64uXNgyIYBKRVV8rIQr4cw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/Makefile.am             |  2 +-
 winsup/cygwin/exceptions.cc           | 50 ++++++++++++++++-----------
 winsup/cygwin/local_includes/cygtls.h |  1 +
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 31747ac98..04f78ed03 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -624,7 +624,7 @@ $(NEW_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES) $(LIBSERVER)\
 	$(LIBSERVER) \
 	$(newlib_build)/libm.a \
 	$(newlib_build)/libc.a \
-	-lgcc -lkernel32 -lntdll -Wl,-Map,cygwin.map
+	-lgcc -lkernel32 -lntdll -lsynchronization -Wl,-Map,cygwin.map
 	@$(MKDIR_P) ${target_builddir}/winsup/testsuite/testinst/bin/
 	$(AM_V_at)$(INSTALL_PROGRAM) $(NEW_DLL_NAME) ${target_builddir}/winsup/testsuite/testinst/bin/$(DLL_NAME)
 
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a4699b172..6e0bf69f1 100644
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
+      WakeByAddressSingle ((void *) &_my_tls.in_singlestep_handler);
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
+	    WaitOnAddress (&in_singlestep_handler, &bool_false,
+			   sizeof (bool), INFINITE);
+	  SuspendThread (*this);
 	  GetThreadContext (*this, cx);
+	  RemoveVectoredExceptionHandler (h_veh);
 	  suspend_on_exception = false;
 	}
 #endif
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
-- 
2.45.1

