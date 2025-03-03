Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 507E43858C48; Mon,  3 Mar 2025 18:53:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 507E43858C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741028028;
	bh=5IkPnpctz7zpHn5xVBYuvQsrMbDJ7i3YAe1z7e5w9ls=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FrGXstOQFylGIgucmHmOOU4LWzGIIHt50nYqaNAAK6Imc1W110qmxHeT0ewpqp9PL
	 cod8qLVWnmMXfvCEWf3q0SPfxEI2XyiCqzZYkQjZNSJR2+u822eaEezo8dh25Wj47D
	 wYsAx3nBT6WSxoE9K7wjtNetYIahTiH19zS0Geoo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3276AA80770; Mon, 03 Mar 2025 19:53:44 +0100 (CET)
Date: Mon, 3 Mar 2025 19:53:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] Cygwin: signal: Fix a race issue on modifying
 _pinfo::process_state
Message-ID: <Z8X6uJJwhVA7i7lk@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
 <20250228233406.950-3-takashi.yano@nifty.ne.jp>
 <Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
 <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
 <Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
 <20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  3 23:39, Takashi Yano wrote:
> On Mon, 3 Mar 2025 14:01:08 +0100
> Corinna Vinschen wrote:
> > but now that I'm writing it I'm even more unsure this is necessary.
> > The only two places doing an And and an Or are doing it with the
> > exact same flags.  And the combination of PID_ACTIVE and the other
> > three flags is never tested together.
> > 
> > What do you think?
> 
> No other code touches these flags except for:
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 1ffe00a94..8739f18f5 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -252,7 +252,7 @@ proc_subproc (DWORD what, uintptr_t val)
>  	  vchild->sid = myself->sid;
>  	  vchild->ctty = myself->ctty;
>  	  vchild->cygstarted = true;
> -	  vchild->process_state |= PID_INITIALIZING;
> +	  InterlockedOr ((LONG *)&vchild->process_state, PID_INITIALIZING);
>  	  vchild->ppid = myself->pid;	/* always set last */
>  	}
>        break;
> 
> Moreover, using InterlockedOr()/InterlockedAnd() can ensure that
> the other flags than the current code is modifying will be kept
> during modification. So using InterlockedCompareExchange() might
> be over the top.

Okidoki!

> > Either way, I would add a volatile to _pinfo::process_state.
> 
> Thanks. I will.

Great.  Feel free to push the patch without sending another patch
submission to cygwin-patches.


Thanks,
Corinna
