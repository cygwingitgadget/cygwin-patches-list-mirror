Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A1FE74BAE7FB; Wed, 11 Mar 2026 15:11:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A1FE74BAE7FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773241870;
	bh=nl8J+a0pPVIssFVzYp7Zhc/HFpQnCU+fwV3u7jDCYjQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rx6S86mpjP+HT2PZnuiXKgB3DMB6+0zG5GIGH/fIluKMxs9SgWPTrFtbgeVcyjaXj
	 JZnQs54rnfOg+EpWzcqjH1FnA5+DOlfNPbfY26ksQ2NmNYR+zeDaBxhuy2WZSXBJdv
	 Yk/BSJccDI9P6Zfvz7uqbcSMBk8jzH/+CwtA4oqk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A7641A80859; Wed, 11 Mar 2026 16:11:08 +0100 (CET)
Date: Wed, 11 Mar 2026 16:11:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: signal: Wait for `sendsig` for a sufficient
 amount of time
Message-ID: <abGGDAppzfO334u8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
 <20260310085041.102-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310085041.102-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 10 17:50, Takashi Yano wrote:
> The current code waits for `sendsig` by `for` loop in sigproc.cc,
> however, the wait time might be insufficient for recent CPU.
> The current code is as follows.
> 
>    for (int i = 0; !p->sendsig && i < 10000; i++)
>      yield ();
> 
> Due to this problem, in tcsh, the following command occasionally
> cannot be terminated by Ctrl-C. This is because, SIGCONT does not
> wake-up `sleep` process correctly.
> 
>   $ cat | sleep 100 &
>   $ fg
>   $ (type Ctrl-C)
> 
> With this patch, the wait time for `sendsig` is guaranteed to be
> up to 100ms instead of looping for 10000 times.
> 
> Fixes: d584454c8231 ("* sigproc.cc (sig_send): Wait for dwProcessId to be non-zero as well as sendsig.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/sigproc.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 30779cf8e..0fd7ed3ba 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -646,7 +646,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>      {
>        HANDLE dupsig;
>        DWORD dwProcessId;
> -      for (int i = 0; !p->sendsig && i < 10000; i++)
> +      DWORD t0 = GetTickCount ();

Again a case where GetTickCount is sufficient?  I'd suggest
to use GetTickCount64 instead.

Other than that, LGTM.


Thanks,
Corinna
