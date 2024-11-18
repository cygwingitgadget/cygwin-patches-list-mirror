Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 99B2D385B83D; Mon, 18 Nov 2024 15:34:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 99B2D385B83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731944097;
	bh=AwPTF4WdiGpuhFHiYImSzsQf/KdOu3oT6eUScIOaDG0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=hMQwbAz+Mgqk4KVsATn4INIANtBP3mMWlk/RQ/VO0iQVbgWBSLXjsN60B+t0osHK9
	 pJcs8LbAdywBrC2alyWK6w/SMHVgtmdwB6Rcbxbhx91OhznttBp25H6/sQTweDhdJz
	 JyuvMQ59jzFrDfMuSoo8Rxr1LmgWlK2CS59rN0fU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0C489A80650; Mon, 18 Nov 2024 16:34:55 +0100 (CET)
Date: Mon, 18 Nov 2024 16:34:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigtimedwait: Fix segfault when timeout is used
Message-ID: <Zzten8QZMrpkvjZb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241117154829.1578-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241117154829.1578-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

thanks for looking into this problem.

On Nov 18 00:48, Takashi Yano wrote:
> @@ -640,6 +641,16 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
>  	    }
>  	  break;
>  	case WAIT_TIMEOUT:
> +	  _my_tls.lock ();
> +	  if (_my_tls.sigwait_mask == 0)
> +	    {
> +	      /* sigpacket::process() already started. */
> +	      waittime = cw_infinite;

cw_infinite?  Shouldn't this situation lead to cygwait returning
immediately with WAIT_SIGNALLED?  The theory would explain to me
that the timeout doesn't matter in this case, but given that the
actual, configured timeout already occured, wouldn't it be
safer to set timeout to 0?  Just in case?

> +	      _my_tls.unlock ();
> +	      goto do_wait;
> +	    }
> +	  _my_tls.sigwait_mask = 0;
> +	  _my_tls.unlock ();
>  	  set_errno (EAGAIN);
>  	  break;
>  	default:

Thanks,
Corinna

