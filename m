Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8F08E3858D39; Thu, 12 Dec 2024 09:58:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F08E3858D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733997496;
	bh=/+4oaNGZVqoNjtF7KujWKl/0IL7/jK2T/pjTgV9UA3I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=CkdaJ9HG9ZYVm2SUrcYzgPeTnltqW5TE23M1eknKxAK56tYqDjrN0qcvnHno1DTit
	 zSYvMPVlUrjL9m40pmRQwvs0oPTgxN9nPZHF8BKYTBVehSiOU1jeubarJSBevpTIjj
	 cSqWih0NAA9fIT9m3DkuW5P7NTVNaZscxyyCN4Jo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8913AA80C1A; Thu, 12 Dec 2024 10:58:14 +0100 (CET)
Date: Thu, 12 Dec 2024 10:58:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Fix high load when retrying to process
 pending signal
Message-ID: <Z1qzto1IvXLJFkKd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241212083223.1891-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212083223.1891-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 12 17:32, Takashi Yano wrote:
> The commit e10f822a2b39 has a problem that CPU load gets high if
> pending signal is not processed successfully for a long time.
> With this patch, wait_sig() calls Sleep(1), rather than yield(),
> if the pending signal has not been processed successfully for a
> predetermined time to prevent CPU from high load.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256884.html
> Fixes: e10f822a2b39 ("Cygwin: signal: Handle queued signal without explicit __SIGFLUSH")
> Reported-by: 凯夏 <walkerxk@gmail.com>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 59b4208a6..e01a67ebe 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1345,6 +1345,12 @@ wait_sig (VOID *)
>  
>    hntdll = GetModuleHandle ("ntdll.dll");
>  
> +  /* GetTickCount() here is enough because GetTickCount() - t0 does
> +     not overflow until 49 days psss. Even if GetTickCount() overflows,
> +     GetTickCount() - t0 returns correct value, since underflow in
> +     unsigned wraps correctly. Pending a signal for more thtn 49
> +     days would be noncense. */
> +  DWORD t0 = GetTickCount ();
>    for (;;)
>      {
>        DWORD nb;
> @@ -1354,7 +1360,10 @@ wait_sig (VOID *)
>        else if (sigq.start.next
>  	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
>  	{
> -	  yield ();
> +	  if (GetTickCount () - t0 > 10)
> +	    Sleep (1);
> +	  else
> +	    yield ();

Since yield() is the same as Sleep(0), you could also just make
that a one-liner, kind of like this:

          Sleep (GetTickCount () - t0 > 10 ? 1 : 0);

Apart from that, LGTM.

Thanks,
Corinna
