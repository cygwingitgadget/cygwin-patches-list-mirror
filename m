Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B4F693858C52; Mon,  2 Dec 2024 15:21:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B4F693858C52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733152873;
	bh=FpKHAaPJ/wsuTXnaN7T/UE9MwXXHAUqdyluGr5tcdKQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=TMx/NWTXXMUS6OMS3uCeNghB3Ev5uaE72KOXxtv6TkpGHz7SJWdf6G0zlGWEn+IY/
	 +0NNvS9dkRz+3LUd98YK7rel7y9g/eQqNl4uVV3ntYkH7S9YF1rgG0xiJkH4rqrtQR
	 KmZexozcMN6njokEgj6hfV4DjEQ9ay9Cca5bL2cw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AF17DA80BC2; Mon,  2 Dec 2024 16:21:11 +0100 (CET)
Date: Mon, 2 Dec 2024 16:21:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 9/9] Cygwin: signal: Fix a short period of deadlock
Message-ID: <Z03QZ4FGdzxbYvBr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
 <20241129120007.14516-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129120007.14516-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 29 20:59, Takashi Yano wrote:
> The main thread waits for the sig thread to read the signal pipe by
> calling Sleep(10) if writing to the signal pipe has failed. However,
> if the signal thread waiting for another signal being handled in the
> main thread, the sig thread does not read the signal pipe. To avoid
> such a situation, this patch replaces Sleep(10) to cygwait().
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 6f05b327678f ("(sig_send): Retry WriteFiles which fail when there is no error but packbytes have not been sent.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 8c788bd20..4c557f048 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -741,7 +741,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>        res = WriteFile (sendsig, leader, packsize, &nb, NULL);
>        if (!res || packsize == nb)
>  	break;
> -      Sleep (10);
> +      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
> +	_my_tls.call_signal_handler ();
>        res = 0;
>      }
>  
> -- 
> 2.45.1

LGTM.


Thanks,
Corinna
