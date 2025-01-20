Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.226.35])
	by sourceware.org (Postfix) with ESMTPS id 2D6263858429
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 15:46:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2D6263858429
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2D6263858429
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737387968; cv=none;
	b=pOkRBw5i3MSbKesLHFgMNnbOxs2Q+q/w5jvPIayCvHEtOrgOncgZnQguF1+sWBzDxdfx8/ooXUAHWz/hbUB6o6HlwkdNCdeXhiAi95v3ILJnVHOCreVqAebNqzPW3Thj/B1UkCqcOIj3UzlfIUY8JOCZMhHlc91eIDhQTdnZpug=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737387968; c=relaxed/simple;
	bh=5iVm1Q9tLl3EUFNKLX2VGuXDmEfe9nmtTTA5EmiOOBw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=CmWrFfL2dR/kvwZuiQxErugoKRW4K0gOCBp7c/LL9jL71TsSJNHS90aLxB04UaDvOBC0Sufbn5XPq0TSGJqDUgI8FQ3l4NILqE1hbJ0gin+Vh8hxrBaWlMikKb5urantqUch8A/4YwomW4LhkDIcLcc+nK+P6D/uCTrX5vY++pU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2D6263858429
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jj741N+K
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20250120154604954.PCXA.51700.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 00:46:04 +0900
Date: Tue, 21 Jan 2025 00:46:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250121004603.860b03858ca205237c6d7689@nifty.ne.jp>
In-Reply-To: <Z441sDy8OrMd6NS7@calimero.vinschen.de>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
	<20250119094014.feebd5b313cc71b4c9b79680@nifty.ne.jp>
	<20250120003326.65c26a184ef90a5793c374c1@nifty.ne.jp>
	<20250120180806.60f4a0b13261891d325f6c37@nifty.ne.jp>
	<Z441sDy8OrMd6NS7@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737387965;
 bh=f644IJlRFF75/Keh2jZ5ZI/t5VGoEXDbuicF7cKkMIk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=jj741N+KVJdrea9xt35qEtaBry4kaZY6v1ZgDRAL2i/XSUjQVsS9+R/JZvmfu8mR1+Aq/Wtl
 cCtK6M/znX5r5HIDqhZXY8ZS7PqU7E10tFaWezNV3Qqn1B49Yfadoy8O+iDjzE2SWWF+vi8GOr
 /fpnmpXwRxwyY1XRPBU1tLxEItTGiStybGAZ9nA0k0LW8CN54eHP6LEyBCl/WnToOIy+VSndvU
 WF9W7pTLkndvNgyaZpW9FZ9X7AfgVXRA/z/G8W47f2U6kM7Dw912R0FArZ6nvNefxdctrUTPqP
 ygKdowDT3IHBBdJwuiUR/DmAvonub4Y8wWrrCI61Mkwbx3vg==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 20 Jan 2025 12:38:24 +0100
Corinna Vinschen wrote:
> On Jan 20 18:08, Takashi Yano wrote:
> > On Mon, 20 Jan 2025 00:33:26 +0900
> > Takashi Yano wrote:
> > > On Sun, 19 Jan 2025 09:40:14 +0900
> > > Takashi Yano wrote:
> > > > However, I wonder if cw_timer is re-set by NtSetTimer() in the
> > > > cygwait(), it will be set to WSSC (60 sec) (or 10msec) in the
> > > > sig_send(), so the hang should end with in at most 60 sec unlike
> > > > the the hang Jeremy reported.
> > > > 
> > > > I should still overlook something.
> > > 
> > > Yes, I did.
> > > cygwait() calls NtCancelTimer() on return. So, cw_timer will be
> > > never signalled after recursive cygwait() call. Therefore,
> > > L358:         waitret = cygwait (select_sem, select_sem_timeout);
> > > will return only when select_sem is signalled though it is expected
> > > that cygwait() at L358 spends 1msec at most. This is most likely
> > > the reason of the hang at L358 in fhandler_pipe::raw_read().
> > > 
> > > The conclusion is:
> > > Do not use cygwait() in sig_send().
> > > 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> > > is the right thing while
> > > ng-0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> > > and previous v2 __SIGFLUSHFAST patch
> > > are not.
> > 
> > I tried adding NtSetTimer() immediately after call_signal_handler()
> > in cygwait() to easily make it reentrant. The result is,
> > the hang in repeated cygwin1.dll build no longer happen even with
> > v2 __SIGFLUSHFAST patch.
> > 
> > It seems that making cygwait() reentrant is an alternative idea.
> 
> The TLS cw_timer was introduced in f0968c1e7eda ("* cygtls.h (struct
> _local_storage): Add cw_timer member.") to avoid having to create and
> destroy a timer on each invocation of cygwait, which would occur pretty
> often in some scenarios.
> 
> cw_timer was then recycled for select() by commit 7186b657e74b ("Improve
> timer handling in select.") for the same reason. Select may even be the
> worse problem.
> 
> And the problem doesn't go away of course, so it would be nice if we
> could keep using cw_timer in most cases in cygwait() and only fall back
> to another timer in case we use it in signal handling reentrantly.
> 
> It might have been a good idea to use different timers in cygwait()
> and select(), which could use it's own "sel_timer" or something,
> but that doesn't fix the signal handler reentrancy thingy.
> 
> So what about redefining cygwait to take a fourth parameter and
> use that if it's != NULL?  The caller can then just create its own
> timer.  Kind of like this:
> 
> diff --git a/winsup/cygwin/cygwait.cc b/winsup/cygwin/cygwait.cc
> index 80c0e971c77d..b54d6ae6f8a4 100644
> --- a/winsup/cygwin/cygwait.cc
> +++ b/winsup/cygwin/cygwait.cc
> @@ -24,10 +24,11 @@
>  LARGE_INTEGER cw_nowait_storage;
>  
>  DWORD
> -cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
> +cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask, HANDLE timer)
>  {
>    DWORD res;
>    DWORD num = 0;
> +  HANDLE &wait_timer = timer ? timer : _my_tls.locals.cw_timer;
>    HANDLE wait_objects[4];
>    pthread_t thread = pthread::self ();
>  
>   [use wait_timer in place of _my_tls.locals.cw_timer throughout cygwait]
> diff --git a/winsup/cygwin/local_includes/cygwait.h b/winsup/cygwin/local_includes/cygwait.h
> index 6212c334e1b9..4eda290782c0 100644
> --- a/winsup/cygwin/local_includes/cygwait.h
> +++ b/winsup/cygwin/local_includes/cygwait.h
> @@ -27,8 +27,8 @@ extern LARGE_INTEGER cw_nowait_storage;
>  
>  const unsigned cw_std_mask = cw_cancel | cw_cancel_self | cw_sig;
>  
> -DWORD cygwait (HANDLE, PLARGE_INTEGER timeout,
> -		       unsigned = cw_std_mask);
> +DWORD cygwait (HANDLE, PLARGE_INTEGER,
> +		       unsigned = cw_std_mask, HANDLE = NULL);
>  
>  extern inline DWORD __attribute__ ((always_inline))
>  cygwait (HANDLE h, DWORD howlong, unsigned mask)

Thanks for the nice idea.
I'll submit v4 seriese patch. Please review.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
