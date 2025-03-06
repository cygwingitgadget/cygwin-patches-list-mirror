Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DDF6C3858C5F; Thu,  6 Mar 2025 18:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DDF6C3858C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741287305;
	bh=eo4tTPbPlYVZc0Xi9T8ScEhb265lVIak52cCWjvTBSE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=CgUsbDgQCQg0H0u05F5EnZEhltnBOLQAN/j9BBdCHte0+KeambYDkxNfd3ynqp2IO
	 DdsSem9JKlAcEJ8eGj/yh2dO5K8NLpQ0x8L3ZcyiKMWPRDJVcflsRuTMxVBVZRulUq
	 BNuExC4y8/wJX3Q70leeUjiB9Rk7qdNO0Fguc9JI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5DD2FA804BD; Thu, 06 Mar 2025 19:55:00 +0100 (CET)
Date: Thu, 6 Mar 2025 19:55:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [GOLDSTAR][PLUSHHIPPO] Re: [PATCH v3 2/3] Cygwin: signal: Fix a race
 issue on modifying _pinfo::process_state
Message-ID: <Z8nvhKqPZ6k7DgIs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
 <20250228233406.950-3-takashi.yano@nifty.ne.jp>
 <Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
 <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
 <Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
 <20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp>
 <Z8X6uJJwhVA7i7lk@calimero.vinschen.de>
 <74c86bc5-ba6c-4ea2-b39f-d41ef538c5f9@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74c86bc5-ba6c-4ea2-b39f-d41ef538c5f9@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Mar  6 14:55, Jon Turney wrote:
> On 03/03/2025 18:53, Corinna Vinschen wrote:
> > On Mar  3 23:39, Takashi Yano wrote:
> > > On Mon, 3 Mar 2025 14:01:08 +0100
> > > Corinna Vinschen wrote:
> > > > but now that I'm writing it I'm even more unsure this is necessary.
> > > > The only two places doing an And and an Or are doing it with the
> > > > exact same flags.  And the combination of PID_ACTIVE and the other
> > > > three flags is never tested together.
> > > > 
> > > > What do you think?
> > > 
> > > No other code touches these flags except for:
> > > 
> > > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > > index 1ffe00a94..8739f18f5 100644
> > > --- a/winsup/cygwin/sigproc.cc
> > > +++ b/winsup/cygwin/sigproc.cc
> > > @@ -252,7 +252,7 @@ proc_subproc (DWORD what, uintptr_t val)
> > >   	  vchild->sid = myself->sid;
> > >   	  vchild->ctty = myself->ctty;
> > >   	  vchild->cygstarted = true;
> > > -	  vchild->process_state |= PID_INITIALIZING;
> > > +	  InterlockedOr ((LONG *)&vchild->process_state, PID_INITIALIZING);
> > >   	  vchild->ppid = myself->pid;	/* always set last */
> > >   	}
> > >         break;
> > > 
> > > Moreover, using InterlockedOr()/InterlockedAnd() can ensure that
> > > the other flags than the current code is modifying will be kept
> > > during modification. So using InterlockedCompareExchange() might
> > > be over the top.
> > 
> > Okidoki!
> > 
> > > > Either way, I would add a volatile to _pinfo::process_state.
> > > 
> > > Thanks. I will.
> > 
> > Great.  Feel free to push the patch without sending another patch
> > submission to cygwin-patches.
> 
> I think Takashi-san must be about due another gold star, as he's been doing
> some sterling work recently, fixing complex and difficult to reproduce bugs!

Absolutely!  Yesterday I was even mulling over a pink plush hippo, but
Takashi already has one over his fireplace and I wasn't sure if a second
one isn't taking too much space.


Corinna
