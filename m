Return-Path: <SRS0=Rx1S=UL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 2FC493858D21
	for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 15:33:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2FC493858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2FC493858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737300811; cv=none;
	b=QmAVjL7O2iqY8WmPnBUg76ChYU9ThlaEjG8F8Wwf2Z8IeDo2E1GN9hgZtcXxNm8C96gBsGwQwOr7tWFrpFvAS3Wh0f0xtuvvyijuUMVSj0B/qDlH0WhpxkoXGJLfpzkCL1OBO8GRMooR/NraqS/F8OvyQii+GPNO+OjFJSEbvkY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737300811; c=relaxed/simple;
	bh=PSaJDAE2qY2cYEGHpkz3ZS0ZysNWIz5W0wVfKsCGYwI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=fZ/qPj98t/1iHF70iqMPTJgjJQXknpE5zQVcTgyRiMT5hdchxKNAfk2kQCWXN81BmYTbkfWPI91RGGy3vBoX/N3l5UdHwmoWiBwlatTb8tpADWsMrgvdRduUCatLGbYzwa7HJ9YsEXn9rl735/GtRxN60Cj8tk3/1Z5IO/lFIxI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2FC493858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Xft0DbdQ
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20250119153327763.THZN.4660.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 00:33:27 +0900
Date: Mon, 20 Jan 2025 00:33:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250120003326.65c26a184ef90a5793c374c1@nifty.ne.jp>
In-Reply-To: <20250119094014.feebd5b313cc71b4c9b79680@nifty.ne.jp>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
	<20250119094014.feebd5b313cc71b4c9b79680@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737300807;
 bh=lXbmWdLQRKl2v6zK6ZJH6kw7BDgGbe3VAbKJfIn37uA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Xft0DbdQR6Uy2L2KOzZQkwhv5NyzLtFZYMr6yYszQoTBzvrMres2ZEdWX/BzbELfwSZJuPpw
 BLrm3qId0CvtdYNfU0VvIxXk6oXVTYUZ7VI7T9lg0uGUQhslarts4hlGBfapEiSmXBDIKqZgjQ
 sIENGdUZdPH2c6NLjEO6fiPfYmU4cuD8y0yhTaf2Lv7JVwHFHaxEmzkTTwinDjL1KI1vvRu00V
 mbQl5xI/BH0q1VK/fPHGyJpZ0Tud+fFBvLbAq18pSSmz46MX6vFiRw+IgyfQiKwDE4rfrr269N
 RR6EHT3YsaVS/T7Kkm/O9hSFFOBwP4nxgZ7Y9HRhcOxdiJzA==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 19 Jan 2025 09:40:14 +0900
Takashi Yano wrote:
> On Sat, 18 Jan 2025 20:41:37 +0900
> Takashi Yano wrote:
> > On Fri, 17 Jan 2025 18:52:41 +0900
> > Takashi Yano wrote:
> > > On Wed, 8 Jan 2025 18:05:53 -0800 (PST)
> > > Jeremy Drake wrote:
> > > > On Thu, 9 Jan 2025, Takashi Yano wrote:
> > > > 
> > > > > On Wed, 8 Jan 2025 16:48:41 +0100
> > > > > Corinna Vinschen wrote:
> > > > > > Does this patch fix Bruno's bash issue as well?
> > > > >
> > > > > I'm not sure because it is not reproducible as he said.
> > > > > I also could not reproduce that.
> > > > >
> > > > > However, at least this fixes the issue that Jeremy encountered:
> > > > > https://cygwin.com/pipermail/cygwin/2024-December/256977.html
> > > > >
> > > > > But, even with this patch, Jeremy reported another hang issue
> > > > > that also is not reproducible:
> > > > > https://cygwin.com/pipermail/cygwin/2024-December/256987.html
> > > > 
> > > > Yes, this patch helped the hangs I was seeing on Windows on ARM64.
> > > > However, there is still some hang issue in 3.5.5 (which occurs on
> > > > native x86_64) that is not there in 3.5.4.  Git for Windows' test suite
> > > > seems to be somewhat reliable at triggering this, but it's hardly a
> > > > minimal test case ;).
> > > > 
> > > > Because of this issue, MSYS2 has been keeping 3.5.5 in its 'staging' state
> > > > (rather than deploying it to normal users), and Git for Windows rolled
> > > > back to 3.5.4 before the release of the latest Git RC.
> > > 
> > > I might have successfully reproduced this issue. I tried building
> > > cygwin1.dll repeatedly for some of my machines, and one of them
> > > hung in fhandler_pipe::raw_read() as lazka's case:
> > > https://github.com/msys2/msys2-runtime/pull/251#issuecomment-2571338429
> > > 
> > > The call:
> > > L358:         waitret = cygwait (select_sem, select_sem_timeout);
> > > never returned even with select_sem_timeout == 1 until a signal
> > > (such as SIGTERM, SIGKILL) arrives. In this situation, attaching
> > > gdb to the process hanging and issuing 'si' command do not return.
> > > Something (stack?) seems to be completely broken.
> > > 
> > > I'll try to bisect which commit causes this issue. Please wait
> > > a while.
> > 
> > Done.
> > 
> > This issue also seems to be related to the commit:
> > 
> > commit d243e51ef1d30312ba1e21b4d25a1ca9a8dc1f63
> > Author: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Date:   Mon Nov 25 19:51:53 2024 +0900
> > 
> >     Cygwin: signal: Fix deadlock between main thread and sig thread
> > 
> >     Previously, a deadlock happened if many SIGSTOP/SIGCONT signals were
> >     received rapidly. If the main thread sends __SIGFLUSH at the timing
> >     when SIGSTOP is handled by the sig thread, but not is handled by the
> >     main thread yet (sig_handle_tty_stop() not called yet), and if SIGCONT
> >     is received, the sig thread waits for cygtls::current_sig (is SIGSTOP
> >     now) cleared. However, the main thread waits for the pack.wakeup using
> >     WaitForSingleObject(), so the main thread cannot handle SIGSTOP. This
> >     is the mechanism of the deadlock. This patch uses cygwait() instead of
> >     WaitForSingleObject() to be able to handle the pending SIGSTOP.
> > 
> >     Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> >     Fixes: 7759daa979c4 ("(sig_send): Fill out sigpacket structure to send to signal thread rather than racily sending separate packets.")
> >     Reported-by: Christian Franke <Christian.Franke@t-online.de>
> >     Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> >     Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > 
> > Even though the reason why this issue happens is not clear at all,
> > I perhaps found the solution for that.
> > 
> > Applying the attached patch:
> > 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> > instead of previous v2 __SIGFLUSHFAST patch solves the both issues.
> > 
> > However, strangely enough, the similar patch:
> > ng-0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> > which uses cygwait() instead of WF[SM]O does not solve the issue
> > Jeremy reported.
> > 
> > The reason is also unclear. What is the difference between cygwait()
> > and WF[SM]O? I expected both patches work almost the same. The v2
> > __SIGFLUSHFAST patch also uses cygwait(), so the reason might be
> > the same (the reason why we should use WF[SM]O rather than cygwait()).
> > 
> > Corinna, any idea? I need some clue.
> 
> I might have understood. cygwait() is not reentrant in the same
> thread due to cw_timer which is in TLS, is it?
> 
> If the signal handler is called during cygwait(), then kill() is
> invoked within the signal handler, cygwait() will be called
> recursively if it is used in sig_send(). This might destroy
> cw_timer...
> 
> However, I wonder if cw_timer is re-set by NtSetTimer() in the
> cygwait(), it will be set to WSSC (60 sec) (or 10msec) in the
> sig_send(), so the hang should end with in at most 60 sec unlike
> the the hang Jeremy reported.
> 
> I should still overlook something.

Yes, I did.
cygwait() calls NtCancelTimer() on return. So, cw_timer will be
never signalled after recursive cygwait() call. Therefore,
L358:         waitret = cygwait (select_sem, select_sem_timeout);
will return only when select_sem is signalled though it is expected
that cygwait() at L358 spends 1msec at most. This is most likely
the reason of the hang at L358 in fhandler_pipe::raw_read().

The conclusion is:
Do not use cygwait() in sig_send().
0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
is the right thing while
ng-0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
and previous v2 __SIGFLUSHFAST patch
are not.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
