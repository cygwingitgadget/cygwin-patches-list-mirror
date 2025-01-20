Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3D6083858429; Mon, 20 Jan 2025 11:38:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D6083858429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737373106;
	bh=EyugVquvkJXo9Wwr3DGUDhtMwxFm7G5/ZiJdnt2hJyA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RJdmgoA3I0Dd94A1ffEQzwMBrHeIhDYbsaI4irDE7K4q3yetHCLaXCGYxA7b88P7N
	 hv0NBXYyx+HlR/UkYrPr7MPpBBUsh1mUpRdI4ucGd0IJJCeNh9OZ/vZSRaBe3FZRaq
	 HQXstqTOHuaqzIaeSZMh5eIjEtAeMC8jEGWxz6BE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 743CDA80D3F; Mon, 20 Jan 2025 12:38:24 +0100 (CET)
Date: Mon, 20 Jan 2025 12:38:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-ID: <Z441sDy8OrMd6NS7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
 <Z36eWXU8Q__9fUhr@calimero.vinschen.de>
 <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
 <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
 <20250117185241.34202389178435578f251727@nifty.ne.jp>
 <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
 <20250119094014.feebd5b313cc71b4c9b79680@nifty.ne.jp>
 <20250120003326.65c26a184ef90a5793c374c1@nifty.ne.jp>
 <20250120180806.60f4a0b13261891d325f6c37@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120180806.60f4a0b13261891d325f6c37@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan 20 18:08, Takashi Yano wrote:
> On Mon, 20 Jan 2025 00:33:26 +0900
> Takashi Yano wrote:
> > On Sun, 19 Jan 2025 09:40:14 +0900
> > Takashi Yano wrote:
> > > However, I wonder if cw_timer is re-set by NtSetTimer() in the
> > > cygwait(), it will be set to WSSC (60 sec) (or 10msec) in the
> > > sig_send(), so the hang should end with in at most 60 sec unlike
> > > the the hang Jeremy reported.
> > > 
> > > I should still overlook something.
> > 
> > Yes, I did.
> > cygwait() calls NtCancelTimer() on return. So, cw_timer will be
> > never signalled after recursive cygwait() call. Therefore,
> > L358:         waitret = cygwait (select_sem, select_sem_timeout);
> > will return only when select_sem is signalled though it is expected
> > that cygwait() at L358 spends 1msec at most. This is most likely
> > the reason of the hang at L358 in fhandler_pipe::raw_read().
> > 
> > The conclusion is:
> > Do not use cygwait() in sig_send().
> > 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> > is the right thing while
> > ng-0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> > and previous v2 __SIGFLUSHFAST patch
> > are not.
> 
> I tried adding NtSetTimer() immediately after call_signal_handler()
> in cygwait() to easily make it reentrant. The result is,
> the hang in repeated cygwin1.dll build no longer happen even with
> v2 __SIGFLUSHFAST patch.
> 
> It seems that making cygwait() reentrant is an alternative idea.

The TLS cw_timer was introduced in f0968c1e7eda ("* cygtls.h (struct
_local_storage): Add cw_timer member.") to avoid having to create and
destroy a timer on each invocation of cygwait, which would occur pretty
often in some scenarios.

cw_timer was then recycled for select() by commit 7186b657e74b ("Improve
timer handling in select.") for the same reason. Select may even be the
worse problem.

And the problem doesn't go away of course, so it would be nice if we
could keep using cw_timer in most cases in cygwait() and only fall back
to another timer in case we use it in signal handling reentrantly.

It might have been a good idea to use different timers in cygwait()
and select(), which could use it's own "sel_timer" or something,
but that doesn't fix the signal handler reentrancy thingy.

So what about redefining cygwait to take a fourth parameter and
use that if it's != NULL?  The caller can then just create its own
timer.  Kind of like this:

diff --git a/winsup/cygwin/cygwait.cc b/winsup/cygwin/cygwait.cc
index 80c0e971c77d..b54d6ae6f8a4 100644
--- a/winsup/cygwin/cygwait.cc
+++ b/winsup/cygwin/cygwait.cc
@@ -24,10 +24,11 @@
 LARGE_INTEGER cw_nowait_storage;
 
 DWORD
-cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
+cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask, HANDLE timer)
 {
   DWORD res;
   DWORD num = 0;
+  HANDLE &wait_timer = timer ? timer : _my_tls.locals.cw_timer;
   HANDLE wait_objects[4];
   pthread_t thread = pthread::self ();
 
  [use wait_timer in place of _my_tls.locals.cw_timer throughout cygwait]
diff --git a/winsup/cygwin/local_includes/cygwait.h b/winsup/cygwin/local_includes/cygwait.h
index 6212c334e1b9..4eda290782c0 100644
--- a/winsup/cygwin/local_includes/cygwait.h
+++ b/winsup/cygwin/local_includes/cygwait.h
@@ -27,8 +27,8 @@ extern LARGE_INTEGER cw_nowait_storage;
 
 const unsigned cw_std_mask = cw_cancel | cw_cancel_self | cw_sig;
 
-DWORD cygwait (HANDLE, PLARGE_INTEGER timeout,
-		       unsigned = cw_std_mask);
+DWORD cygwait (HANDLE, PLARGE_INTEGER,
+		       unsigned = cw_std_mask, HANDLE = NULL);
 
 extern inline DWORD __attribute__ ((always_inline))
 cygwait (HANDLE h, DWORD howlong, unsigned mask)


Corinna
