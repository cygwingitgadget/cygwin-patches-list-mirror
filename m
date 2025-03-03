Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 896203858D21; Mon,  3 Mar 2025 09:51:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 896203858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740995492;
	bh=SBOj8DbJFpO0KfKIw6nNQKp1n3W+UrZlCAzRhEMMHHA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=A9YwIxmBtXlwS72LQS/5+m/B8g8tkklvCgQ+QXGC5bQWZPl3a9EqeGpLTfvoii0Sj
	 doe67kbCrEYwlx7pUYYItMXRSa3tXjuAFmwpKFYddV5AAk5tK7TscKbFUJ/kZCrQM2
	 jSu0UB6sFBhko82AU/CupQXh8FJ8pndYJ/4jxgIU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 57634A80770; Mon, 03 Mar 2025 10:51:30 +0100 (CET)
Date: Mon, 3 Mar 2025 10:51:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] Cygwin: signal: Fix a race issue on modifying
 _pinfo::process_state
Message-ID: <Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
 <20250228233406.950-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228233406.950-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mar  1 08:33, Takashi Yano wrote:
> The PID_STOPPED flag in _ponfo::process_state is sometimes accidentally
> cleared due to a race condition when modifying it with the "|=" or "&="
> operators. This patch uses InterlockedOr/And() instead to avoid the
> race condition.

Is this really sufficent?  I'm asking because of...

> @@ -678,8 +678,9 @@ dofork (void **proc, bool *with_forkables)
>  
>    if (ischild)
>      {
> -      myself->process_state |= PID_ACTIVE;
> -      myself->process_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
> +      InterlockedOr ((LONG *) &myself->process_state, PID_ACTIVE);
> +      InterlockedAnd ((LONG *) &myself->process_state,
> +		      ~(PID_INITIALIZING | PID_EXITED | PID_REAPED));
>      }
>    else if (res < 0)
>      {

...places like these.  Every single Interlocked call is safe in itself,
but what if somebody else changes something between the two interlocked
calls?  Maybe this should be done with InterlockedCompareExchange.

Also, I think it might be better to define process_state as volatile.

Other than that (and I'm not sure if I'm not just being paranoid here),
the patchset looks good.


Thanks,
Corinna
