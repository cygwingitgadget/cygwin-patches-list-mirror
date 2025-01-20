Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 313903858429; Mon, 20 Jan 2025 15:53:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 313903858429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737388416;
	bh=PiJ7KBpnf10yrZQqaDZpJ1goX8TxnFvUXr2WRCjCl6M=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dqkc8Ek4sWNUauiKEc0/seZVZwkJ51d0ggH0ID9dJpCdTd17P/TdhClIQCvPKluWO
	 n3JO57z66QHMELN8CCaoGXofvkp05N6Cd6zc/ugiSJWfhznDg+taqTjaY6kg9x/AZ3
	 HlHKd+rpEe1V58cepMgiSC5mVcZDyZrHUpqBsWNY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6A9B4A80D3F; Mon, 20 Jan 2025 16:53:34 +0100 (CET)
Date: Mon, 20 Jan 2025 16:53:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-ID: <Z45xfvmN1s6oGJKE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250120085249.1242380-1-takashi.yano@nifty.ne.jp>
 <20250120085249.1242380-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120085249.1242380-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

do you want to keep it this way, or do you rather want to change
cygwait to use a local timer?


Thanks,
Corinna

On Jan 20 17:52, Takashi Yano wrote:
> The commit a22a0ad7c4f0 was not exactly the correct thing. Even with
> the patch, some hangs still happen. This patch overrides the previous
> commit to fix these hangs.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256987.html
> Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
> Fixes: a22a0ad7c4f0 ("Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent")
> Reported-by: Daisuke Fujimura <booleanlabel@gmail.com>
> Reported-by: Jeremy Drake <cygwin@jdrake.com>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index ba7818a68..4dcdd94de 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -751,8 +751,19 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>        res = WriteFile (sendsig, leader, packsize, &nb, NULL);
>        if (!res || packsize == nb)
>  	break;
> -      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
> -	_my_tls.call_signal_handler ();
> +      if (pack.si.si_signo == __SIGFLUSHFAST)
> +	Sleep (10);
> +      else /* Handle signals */
> +	do
> +	  {
> +	    DWORD rc = WaitForSingleObject (_my_tls.get_signal_arrived (), 10);
> +	    if (rc == WAIT_OBJECT_0)
> +	      {
> +		_my_tls.call_signal_handler ();
> +		continue;
> +	      }
> +	  }
> +	while (false);
>        res = 0;
>      }
>  
> @@ -785,7 +796,20 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>    if (wait_for_completion)
>      {
>        sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
> -      rc = cygwait (pack.wakeup, WSSC);
> +      if (pack.si.si_signo == __SIGFLUSHFAST)
> +	rc = WaitForSingleObject (pack.wakeup, WSSC);
> +      else /* Handle signals */
> +	do
> +	  {
> +	    HANDLE w[2] = {pack.wakeup, _my_tls.get_signal_arrived ()};
> +	    rc = WaitForMultipleObjects (2, w, FALSE, WSSC);
> +	    if (rc == WAIT_OBJECT_0 + 1) /* signal arrived */
> +	      {
> +		_my_tls.call_signal_handler ();
> +		continue;
> +	      }
> +	  }
> +	while (false);
>        ForceCloseHandle (pack.wakeup);
>      }
>    else
> @@ -806,9 +830,6 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>        rc = -1;
>      }
>  
> -  if (wait_for_completion && si.si_signo != __SIGFLUSHFAST)
> -    _my_tls.call_signal_handler ();
> -
>  out:
>    if (communing && rc)
>      {
> -- 
> 2.45.1
