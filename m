Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3F52C4BB5886; Wed, 11 Mar 2026 15:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3F52C4BB5886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773241918;
	bh=liyHrrq0zV1JpXP4/Br6YXk3jHQK8puL2rNumTcclnI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=GYT5OQcD2L1kQuVKJJQNtyo/n8BwGpbdbePyU/84V8EudWRVKwKR3QY6qL5GyoMEl
	 sDfMY6MuqMRHr7dXymSei3TXrx5bsu9nZhEENXUnPp+hmNXETQ7e58DSN+WCH9tZTa
	 Azbw2S24yc91AITmRMvAFAXgBNzQzaPoHWNsh/QI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5BAADA80859; Wed, 11 Mar 2026 16:11:56 +0100 (CET)
Date: Wed, 11 Mar 2026 16:11:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Cygwin: signal: Do not wait for sendsig for
 non-cygwin process
Message-ID: <abGGPMXOlkGdoz-M@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
 <20260310085041.102-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310085041.102-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 10 17:50, Takashi Yano wrote:
> Waiting for `sendsig` to be non-zero for non-cygwin process is
> pointless, because it never becomes non-zero (see spawn.cc).
> Do not wait `sendsig` for a non-cygwin process.
> 
> Fixes: d584454c8231 ("* sigproc.cc (sig_send): Wait for dwProcessId to be non-zero as well as sendsig.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/sigproc.cc | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 0fd7ed3ba..4ff05967b 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -646,9 +646,12 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>      {
>        HANDLE dupsig;
>        DWORD dwProcessId;
> -      DWORD t0 = GetTickCount ();
> -      while (GetTickCount () - t0 < 100 && !p->sendsig)
> -	yield ();
> +      if (!ISSTATE (p, PID_NOTCYGWIN))
> +	{
> +	  DWORD t0 = GetTickCount ();
> +	  while (GetTickCount () - t0 < 100 && !p->sendsig)
> +	    yield ();
> +	}
>        if (p->sendsig)
>  	{
>  	  dupsig = p->sendsig;
> -- 
> 2.51.0

LGTM


Thanks,
COrinna
