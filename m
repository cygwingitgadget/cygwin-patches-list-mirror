Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 285A53858D33; Tue,  3 Dec 2024 14:31:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 285A53858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733236264;
	bh=+wE4l7j9/R/oujNVqq65qpymW/nsS+btVF0TrRrarRA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=O70CfXJJBSZWg77PzJGgRrUdhfd00l1qeyuiqFVCWgerYhTXJjoLQFIujQRELVeSt
	 eLinXTqgcSJOAF+bFvO9lFaiFoEGffSjNNitvq8a0hlVivzAUYqL4Tfe06eRmmWKGO
	 Tw8sou8FQBms7OL6tOuvKHhNqRZ57KbzWdRHNe1k=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 06457A80BDA; Tue,  3 Dec 2024 15:31:02 +0100 (CET)
Date: Tue, 3 Dec 2024 15:31:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: signal: Optimize the priority of the sig
 thread
Message-ID: <Z08WJazDsg535Bew@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  3 23:01, Takashi Yano wrote:
> Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> This causes a critical delay in the signal handling in the main
> thread if too many signals are received rapidly and the CPU is very
> busy. In this case, most of the CPU time is allocated to the sig
> thread, so the main thread cannot have a chance of handling signals.
> With this patch, to avoid such a situation, the priority of the sig
> thread is set to THREAD_PRIORITY_NORMAL priority.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 730259484..4c557f048 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1333,6 +1333,7 @@ wait_sig (VOID *)
>  
>    hntdll = GetModuleHandle ("ntdll.dll");
>  
> +  SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_NORMAL);
>    for (;;)
>      {
>        DWORD nb;
> -- 
> 2.45.1

Yep, please push.  This is the one you can eventually push to
the 3.5 branch.

For 3.6 I suggest that you or I'll submit a patch removing this line
again, in favor of dropping the line in cygthread::async_create
setting the prio to HIGHEST.  But only after the threasd series is
complete, ok?


Thanks,
Corinna
