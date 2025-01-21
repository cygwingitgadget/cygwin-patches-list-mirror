Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D49D23857400; Tue, 21 Jan 2025 13:45:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D49D23857400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737467111;
	bh=ht6e3R96wiVpi8I6JfMWc3kqdi/0LvXar69N2n2v2Bg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pOGnsVJAvCtCOMxfKdGXQJVpMeuymuDZ/zlFLnOnTY+wzKzzwpPr2KrEOmUKJQrzU
	 j3m2e+5cXUO6w9yuHMTW5Y2wXWBFrAPYW2raBOXLp0oz8HRNyQTETo8VLr1YH8ItL/
	 9BYiGBT0g0ntXehsqIdr0u8z52ju6m+AHlSqthEQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 17D1EA80A5D; Tue, 21 Jan 2025 14:45:10 +0100 (CET)
Date: Tue, 21 Jan 2025 14:45:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/3] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-ID: <Z4-k5oypdJ2gDavi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
 <20250121031544.1716992-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121031544.1716992-4-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

There's a minor style thingy and one question...

On Jan 21 12:15, Takashi Yano wrote:
> +++ b/winsup/cygwin/sigproc.cc
> @@ -742,6 +742,12 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>        memcpy (p, si._si_commune._si_str, n); p += n;
>      }
>  
> +  unsigned cw_mask;
> +  if (pack.si.si_signo == __SIGFLUSHFAST)
> +    cw_mask = 0;
> +  else
> +    cw_mask = cw_sig_restart;
> +

This could be a one-liner, unsigned cw_mask = ... ? ... : ...;

>    DWORD nb;
>    BOOL res;
>    /* Try multiple times to send if packsize != nb since that probably
> @@ -751,8 +757,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>        res = WriteFile (sendsig, leader, packsize, &nb, NULL);
>        if (!res || packsize == nb)
>  	break;
> -      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
> -	_my_tls.call_signal_handler ();
> +      cygwait (NULL, 10, cw_mask);

This bugs me a bit.  While your solution nicely wraps the entire
timer problem into cygwait(), the downside is that each invocation
of cygwait() creates its own timer. Theoretically, given this is in a
loop with up to 100 iterations, you have up to 100 additional timer
create/destroy sequences.

So the question is, do you think this matters at all in this scenario,
given we're in a 10 ms wait state anyway?

If you think that's not an issue, feel free to apply the patch with
just the one-liner above.


Thanks,
Corinna
