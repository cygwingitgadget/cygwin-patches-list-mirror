Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 786FC3858D26; Mon,  3 Mar 2025 13:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 786FC3858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741006870;
	bh=qbAjasCxdpCVPpdf8qCRW+mFjp3ZMxxpoyu5Agp+4yo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=uitIxxuhcyKSPVkqGTAH2i/0Bz/da2xFuzfVmxkY5Qc5+K1nazgkTSu/csAxJw24W
	 6VeBrmfXNDYxYqQCeJQIlAbQEq9pBuc+gvJxnH40+gILJh/ujp6xFUfh26G5EH6aFq
	 OjcfERY5a9XbVYPN24qP9J0imH/AmZ6kTnCODVQA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 44A99A80770; Mon, 03 Mar 2025 14:01:08 +0100 (CET)
Date: Mon, 3 Mar 2025 14:01:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] Cygwin: signal: Fix a race issue on modifying
 _pinfo::process_state
Message-ID: <Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
 <20250228233406.950-3-takashi.yano@nifty.ne.jp>
 <Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
 <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  3 21:24, Takashi Yano wrote:
> On Mon, 3 Mar 2025 10:51:30 +0100
> Corinna Vinschen wrote:
> > On Mar  1 08:33, Takashi Yano wrote:
> > > The PID_STOPPED flag in _ponfo::process_state is sometimes accidentally
> > > cleared due to a race condition when modifying it with the "|=" or "&="
> > > operators. This patch uses InterlockedOr/And() instead to avoid the
> > > race condition.
> > 
> > Is this really sufficent?  I'm asking because of...
> > 
> > > @@ -678,8 +678,9 @@ dofork (void **proc, bool *with_forkables)
> > >  
> > >    if (ischild)
> > >      {
> > > -      myself->process_state |= PID_ACTIVE;
> > > -      myself->process_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
> > > +      InterlockedOr ((LONG *) &myself->process_state, PID_ACTIVE);
> > > +      InterlockedAnd ((LONG *) &myself->process_state,
> > > +		      ~(PID_INITIALIZING | PID_EXITED | PID_REAPED));
> > >      }
> > >    else if (res < 0)
> > >      {
> > 
> > ...places like these.  Every single Interlocked call is safe in itself,
> > but what if somebody else changes something between the two interlocked
> > calls?  Maybe this should be done with InterlockedCompareExchange.
> 
> Thanks for reviewing.
> 
> How can we guard that situation by using InterlockedCompareExchange()?
> Could you please give me some more instruction?

The InterlockedCompareExchange can be used to check for a parallel
change, kind of like this:

  DWORD old_state, new_state;
  do
    {
      old_state = myself->process_state;
      new_state = old_state | PID_ACTIVE;
      new_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
    }
  while (InterlockedCompareExchange (&myself->process_state,
                                     new_state,
                                     old_state) != old_state);

but now that I'm writing it I'm even more unsure this is necessary.
The only two places doing an And and an Or are doing it with the
exact same flags.  And the combination of PID_ACTIVE and the other
three flags is never tested together.

What do you think?

Either way, I would add a volatile to _pinfo::process_state.


Thanks,
Corinna
