Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 568DC385840D
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 03:28:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 568DC385840D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 568DC385840D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741750139; cv=none;
	b=Jholh7upP6QYGITLz9xa/NkM8+nDbqX1EQcoFkrLu78rU+xzACZU8Wgkhsdt9W8xwyv/X57saArRs5+GfiC7vzCeWSZ/xFvnGxFz3jzrFc1o7wxYzN9DXJ2Ewn9BqDHNcPthnmqvWwfl0fE/+2ON4XeCz1fp+YXG/UXC+0vmpR4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741750139; c=relaxed/simple;
	bh=nb/MsOpsBXsWQsut993gIzt9/y7H4oOuvvekKweHaQg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=HaSUtgtm5y0W9WilAJXfaptuUSjQy/5pvak2rUCwg7ZhFG9gKwcLDCPsjtpsIrvXhQOvNL1T9SI4r8xwHQYFrN2Udz9Gv+kINs0DgFILPXL1FDTOP6fEA/igIBepq/O3QEB3bYRbKRDCRn9n+kFH/Re4F3+Dno5Gq+3KGd44cnc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 568DC385840D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hyCAzI0A
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250312032856235.XTSJ.17135.localhost.localdomain@nifty.com>;
          Wed, 12 Mar 2025 12:28:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 5/6] Cygwin: signal: Use context locally copied in call_signal_handler()
Date: Wed, 12 Mar 2025 12:27:31 +0900
Message-ID: <20250312032748.233077-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741750136;
 bh=HfM2HRLrUF2/lJL5Jh9f2lUcnfDSEh5wjgobZrSE1cs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hyCAzI0AISTSdy5EqYtJeunZ2zzPahGRqZ2RbKL6jnTVkx5JQnvHHZJM1xMCmCIURdobU+nt
 4xA4RgMk8AX0FEBhJONwehv54M+nYcd1kW/DeOi46diWxm/qF21CYdcTFLSSswlxczZd4hpUBI
 dF7TWiHhkE0DARgcXLEgXWTQvDd8lwRr5g/7JPE62XxiC9+BiU+/WbqorIIz63lRzttMRO7c51
 zr8D6X0Ptkxfsv046rFP5H36QRTKV5zCRhyGgJHn83se4qffiywa9QZ5ODWxdme4+FxKXwygr+
 EYRCvIheI88TWDIDqoBC58it6HzM6K/VmUbdAfulEn1eRr7Q==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the signal handler is called from inside of another signal handler,
_cygtls::context may be destroyed by call_signal_handler() newly called.
To avoid this situation, this patch used context locally copied in
call_signal_handler().

Addresses: https://cygwin.com/pipermail/cygwin-patches/2025q1/013461.html
Fixes: 9043956ce859 ("Only construct ucontext for SA_SIGINFO signal handlers")
Reported-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 41 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 18a566c45..1e19af68c 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1660,6 +1660,8 @@ altstack_wrapper (int sig, siginfo_t *siginfo, ucontext_t *sigctx,
 int
 _cygtls::call_signal_handler ()
 {
+  ucontext_t context1 = context;
+
   int this_sa_flags = SA_RESTART;
   while (1)
     {
@@ -1697,10 +1699,10 @@ _cygtls::call_signal_handler ()
       /* Only make a context for SA_SIGINFO handlers */
       if (this_sa_flags & SA_SIGINFO)
 	{
-	  context.uc_link = 0;
-	  context.uc_flags = 0;
+	  context1.uc_link = 0;
+	  context1.uc_flags = 0;
 	  if (thissi.si_cyg)
-	    memcpy (&context.uc_mcontext,
+	    memcpy (&context1.uc_mcontext,
 		    ((cygwin_exception *) thissi.si_cyg)->context (),
 		    sizeof (CONTEXT));
 	  else
@@ -1710,13 +1712,13 @@ _cygtls::call_signal_handler ()
 		 from sigdelayed, fix the instruction pointer accordingly. */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
-	      RtlCaptureContext ((PCONTEXT) &context.uc_mcontext);
+	      RtlCaptureContext ((PCONTEXT) &context1.uc_mcontext);
 #pragma GCC diagnostic pop
-	      __unwind_single_frame ((PCONTEXT) &context.uc_mcontext);
+	      __unwind_single_frame ((PCONTEXT) &context1.uc_mcontext);
 	      if (stackptr > stack)
 		{
 #ifdef __x86_64__
-		  context.uc_mcontext.rip = retaddr ();
+		  context1.uc_mcontext.rip = retaddr ();
 #else
 #error unimplemented for this target
 #endif
@@ -1727,30 +1729,30 @@ _cygtls::call_signal_handler ()
 	      && !_my_tls.altstack.ss_flags
 	      && _my_tls.altstack.ss_sp)
 	    {
-	      context.uc_stack = _my_tls.altstack;
-	      context.uc_stack.ss_flags = SS_ONSTACK;
+	      context1.uc_stack = _my_tls.altstack;
+	      context1.uc_stack.ss_flags = SS_ONSTACK;
 	    }
 	  else
 	    {
-	      context.uc_stack.ss_sp = NtCurrentTeb ()->Tib.StackBase;
-	      context.uc_stack.ss_flags = 0;
+	      context1.uc_stack.ss_sp = NtCurrentTeb ()->Tib.StackBase;
+	      context1.uc_stack.ss_flags = 0;
 	      if (!NtCurrentTeb ()->DeallocationStack)
-		context.uc_stack.ss_size
+		context1.uc_stack.ss_size
 		  = (uintptr_t) NtCurrentTeb ()->Tib.StackLimit
 		    - (uintptr_t) NtCurrentTeb ()->Tib.StackBase;
 	      else
-		context.uc_stack.ss_size
+		context1.uc_stack.ss_size
 		  = (uintptr_t) NtCurrentTeb ()->DeallocationStack
 		    - (uintptr_t) NtCurrentTeb ()->Tib.StackBase;
 	    }
-	  context.uc_sigmask = context.uc_mcontext.oldmask = this_oldmask;
+	  context1.uc_sigmask = context1.uc_mcontext.oldmask = this_oldmask;
 
-	  context.uc_mcontext.cr2 = (thissi.si_signo == SIGSEGV
-				     || thissi.si_signo == SIGBUS)
-				    ? (uintptr_t) thissi.si_addr : 0;
+	  context1.uc_mcontext.cr2 = (thissi.si_signo == SIGSEGV
+				      || thissi.si_signo == SIGBUS)
+				     ? (uintptr_t) thissi.si_addr : 0;
 
-	  thiscontext = &context;
-	  context_copy = context;
+	  thiscontext = &context1;
+	  context_copy = context1;
 	}
 
       int this_errno = saved_errno;
@@ -1836,10 +1838,11 @@ _cygtls::call_signal_handler ()
       incyg = true;
 
       set_signal_mask (_my_tls.sigmask, (this_sa_flags & SA_SIGINFO)
-					? context.uc_sigmask : this_oldmask);
+					? context1.uc_sigmask : this_oldmask);
       if (this_errno >= 0)
 	set_errno (this_errno);
     }
+  context = context1;
 
   /* FIXME: Since 2011 this return statement always returned 1 (meaning
      SA_RESTART is effective) if the thread we're running in is not the
-- 
2.45.1

