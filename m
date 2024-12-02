Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D4AD93858C54; Mon,  2 Dec 2024 15:18:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D4AD93858C54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733152697;
	bh=CegPtpS0+wfCTe1Xebz9kWIKu4XSo9yn0zZjJGMK6pY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=wNj8bPB/eMWuUHZewLlsKVVOiJqt43QoyYoygGgeXoBCi6RupmdXXFWP6C+EnLR4T
	 NjoZooMHNGEo2jtJcfgL3raSceOpuG0T/YSLQaLl8nZaep5beepOpFwP6x+jQBiUN7
	 nBadqffXTcrMUSqtPNZEs6iAkaAS8dhBCcEjG3IE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D0B82A80BC2; Mon,  2 Dec 2024 16:18:15 +0100 (CET)
Date: Mon, 2 Dec 2024 16:18:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 4/9] Cygwin: signal: Optimize the priority of the sig
 thread
Message-ID: <Z03PtxZzigl-xvU0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 29 20:59, Takashi Yano wrote:
> Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> This causes a critical delay in the signal handling in the main
> thread if too many signals are received rapidly and the CPU is very
> busy. In this case, most of the CPU time is allocated to the sig
> thread, so the main thread cannot have a chance of handling signals.
> With this patch, to avoid such a situation, the priority of the sig
> thread is set to THREAD_PRIORITY_NORMAL priority. Furthermore, if
> the signal is alerted to the main thread, but the main thread does
> not handle it yet, to increase the chance of handling it in the main
> thread, reduce the sig thread priority to THREAD_PRIORITY_LOWEST
> priority temporarily before calling _cygtls::handle_SIGCONT().
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc | 6 ++++++
>  winsup/cygwin/sigproc.cc    | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 0f8c21939..7fc644af1 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -978,6 +978,9 @@ sigpacket::setup_handler (void *handler, struct sigaction& siga, _cygtls *tls)
>    CONTEXT cx;
>    bool interrupted = false;
>  
> +  for (int i = 0; i < 100 && tls->current_sig; i++)
> +    yield ();
> +

Is that a piece of stray code left from testing, or is that actually
part of the patch?  The commit message doesn't explain it...


Thanks,
Corinna
