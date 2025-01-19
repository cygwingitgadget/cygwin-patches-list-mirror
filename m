Return-Path: <SRS0=Rx1S=UL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 0DAFD3858D21
	for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 00:40:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0DAFD3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0DAFD3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737247218; cv=none;
	b=o9hegGaKD68YzNYWFZ3qXS23tmgdTQtLICVp2LQT7LTC9CkcVIw6SiuoizOAX9r7UUOtW9qUAeJ5g5dJ30Ww6Tt1ZtJ1nhzBogGN4zagblIF+lOVdsRLmSlxCQz1AWQ8G++oJJNNVvoXNzbFJLK9HT4Xm6JLzc/UfqSzvDIL82U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737247218; c=relaxed/simple;
	bh=ARXYHD5u9ITSq4LZj25SI+7Pk6/Uw3y0sVq2R/JZ0LY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=VoAyQnNN8PaiQIWutVBjZ5J32LAKe6WETRUirnDwWCNvEtylNZtI4fMKNpBouefI5Npx0lEaBk3WHLcuDOMhx8if+ZaLWDCSynct0dr40rZfeyy1A6kkDuG8biy/266mN9pRwzswk0qe4U9r6syiZn2tiQpKjcGDn+Qd7dCkiL8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0DAFD3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JczmuHBT
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20250119004016000.DADP.9629.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 09:40:15 +0900
Date: Sun, 19 Jan 2025 09:40:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250119094014.feebd5b313cc71b4c9b79680@nifty.ne.jp>
In-Reply-To: <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737247216;
 bh=WYR1QjNepf7hz9Ntnt0q8rcPQFeeSdQiXfaDB8ttWCo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=JczmuHBTkMfk2b722PhHxwBYlxr6Xt4G+lO5WEzEO9+nEG1EgYd7uGal4DAfvoHB4RhTSy0j
 3cmFyLJrz9/oaz789tvZrT99CY6FE92SXZEjGW2FIOe4tahfieMLzb4tIkNmTgWCpyXZE5NuBW
 XcqS0OVwJkAi1QWzVfXq0UHKiBqSgp/WZ2MoDDfwqqe+PjNFhdlPFCuKLgToWFdc/VYI8cguQU
 djD9xcw5pb4OernXEzai5EoQw7koYM87aFCcEHhAMNaKRlKFmUM46UamsDOBh8m/I+SCRCbJbk
 ITwnoDim6uUyS7FDRJjOsFLPtowMUm+mDs3rKbIfdLz6QHKg==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 18 Jan 2025 20:41:37 +0900
Takashi Yano wrote:
> On Fri, 17 Jan 2025 18:52:41 +0900
> Takashi Yano wrote:
> > On Wed, 8 Jan 2025 18:05:53 -0800 (PST)
> > Jeremy Drake wrote:
> > > On Thu, 9 Jan 2025, Takashi Yano wrote:
> > > 
> > > > On Wed, 8 Jan 2025 16:48:41 +0100
> > > > Corinna Vinschen wrote:
> > > > > Does this patch fix Bruno's bash issue as well?
> > > >
> > > > I'm not sure because it is not reproducible as he said.
> > > > I also could not reproduce that.
> > > >
> > > > However, at least this fixes the issue that Jeremy encountered:
> > > > https://cygwin.com/pipermail/cygwin/2024-December/256977.html
> > > >
> > > > But, even with this patch, Jeremy reported another hang issue
> > > > that also is not reproducible:
> > > > https://cygwin.com/pipermail/cygwin/2024-December/256987.html
> > > 
> > > Yes, this patch helped the hangs I was seeing on Windows on ARM64.
> > > However, there is still some hang issue in 3.5.5 (which occurs on
> > > native x86_64) that is not there in 3.5.4.  Git for Windows' test suite
> > > seems to be somewhat reliable at triggering this, but it's hardly a
> > > minimal test case ;).
> > > 
> > > Because of this issue, MSYS2 has been keeping 3.5.5 in its 'staging' state
> > > (rather than deploying it to normal users), and Git for Windows rolled
> > > back to 3.5.4 before the release of the latest Git RC.
> > 
> > I might have successfully reproduced this issue. I tried building
> > cygwin1.dll repeatedly for some of my machines, and one of them
> > hung in fhandler_pipe::raw_read() as lazka's case:
> > https://github.com/msys2/msys2-runtime/pull/251#issuecomment-2571338429
> > 
> > The call:
> > L358:         waitret = cygwait (select_sem, select_sem_timeout);
> > never returned even with select_sem_timeout == 1 until a signal
> > (such as SIGTERM, SIGKILL) arrives. In this situation, attaching
> > gdb to the process hanging and issuing 'si' command do not return.
> > Something (stack?) seems to be completely broken.
> > 
> > I'll try to bisect which commit causes this issue. Please wait
> > a while.
> 
> Done.
> 
> This issue also seems to be related to the commit:
> 
> commit d243e51ef1d30312ba1e21b4d25a1ca9a8dc1f63
> Author: Takashi Yano <takashi.yano@nifty.ne.jp>
> Date:   Mon Nov 25 19:51:53 2024 +0900
> 
>     Cygwin: signal: Fix deadlock between main thread and sig thread
> 
>     Previously, a deadlock happened if many SIGSTOP/SIGCONT signals were
>     received rapidly. If the main thread sends __SIGFLUSH at the timing
>     when SIGSTOP is handled by the sig thread, but not is handled by the
>     main thread yet (sig_handle_tty_stop() not called yet), and if SIGCONT
>     is received, the sig thread waits for cygtls::current_sig (is SIGSTOP
>     now) cleared. However, the main thread waits for the pack.wakeup using
>     WaitForSingleObject(), so the main thread cannot handle SIGSTOP. This
>     is the mechanism of the deadlock. This patch uses cygwait() instead of
>     WaitForSingleObject() to be able to handle the pending SIGSTOP.
> 
>     Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
>     Fixes: 7759daa979c4 ("(sig_send): Fill out sigpacket structure to send to signal thread rather than racily sending separate packets.")
>     Reported-by: Christian Franke <Christian.Franke@t-online.de>
>     Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
>     Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> Even though the reason why this issue happens is not clear at all,
> I perhaps found the solution for that.
> 
> Applying the attached patch:
> 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> instead of previous v2 __SIGFLUSHFAST patch solves the both issues.
> 
> However, strangely enough, the similar patch:
> ng-0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> which uses cygwait() instead of WF[SM]O does not solve the issue
> Jeremy reported.
> 
> The reason is also unclear. What is the difference between cygwait()
> and WF[SM]O? I expected both patches work almost the same. The v2
> __SIGFLUSHFAST patch also uses cygwait(), so the reason might be
> the same (the reason why we should use WF[SM]O rather than cygwait()).
> 
> Corinna, any idea? I need some clue.

I might have understood. cygwait() is not reentrant in the same
thread due to cw_timer which is in TLS, is it?

If the signal handler is called during cygwait(), then kill() is
invoked within the signal handler, cygwait() will be called
recursively if it is used in sig_send(). This might destroy
cw_timer...

However, I wonder if cw_timer is re-set by NtSetTimer() in the
cygwait(), it will be set to WSSC (60 sec) (or 10msec) in the
sig_send(), so the hang should end with in at most 60 sec unlike
the the hang Jeremy reported.

I should still overlook something.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
