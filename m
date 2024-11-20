Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0C61B3858D26; Wed, 20 Nov 2024 15:30:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0C61B3858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732116612;
	bh=ekrigWDsK+uBHPjpWWY1idP1p71RpRivUdiTbR7ibzY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=n4ZV1AYGA7Uz7QX/h/lHDcPsANkKlwj3GRCPthTZbZDDZJ9CXKcnjLhUPyq38PEW2
	 b4JQDrAHcCubSW73hvxwlC7q5uw18A0MiKrL+DyNiVaqUI/BCca8UlBm1X3MEmTvY9
	 u0V4RtYKtQtGzccgeXT71QmuiNsHxMpavPmfOLkQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id ED5A5A8045B; Wed, 20 Nov 2024 16:30:09 +0100 (CET)
Date: Wed, 20 Nov 2024 16:30:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: sigtimedwait: Fix segfault when timeout is
 used
Message-ID: <Zz4AgZCApEQEwb-w@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241119084057.945-1-takashi.yano@nifty.ne.jp>
 <ZzxtpcNi85kNQX2g@calimero.vinschen.de>
 <20241120220024.dd039419f2523a6bc3339e26@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120220024.dd039419f2523a6bc3339e26@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 20 22:00, Takashi Yano wrote:
> On Tue, 19 Nov 2024 11:51:17 +0100
> Corinna Vinschen wrote:
> > Maybe we can utilize WaitOnAddress, kind of like this?
> > 
> > sigwait_common, just the fallthrough snippet:
> > 
> >   +       /* sigpacket::process() already started.
> >   +          Go through to WAIT_SIGNALED case. */
> >   +       _my_tls.unlock ();
> >   +       sigset_t compare = 0;
> >   +       WaitOnAddress (&_my_tls.sigwait_mask, &compare,
> >   +                      sizeof (sigset_t), INFINITE);
> >   +       _my_tls.sigwait_mask = 0;
> >   +       fallthrough;
> > 
> > sigpacket::process():
> > 
> > @@ -1457,6 +1457,7 @@ sigpacket::process ()
> >    bool issig_wait = false;
> >    struct sigaction& thissig = global_sigs[si.si_signo];
> >    void *handler = have_execed ? NULL : (void *) thissig.sa_handler;
> > +  sigset_t orig_wait_mask = 0;
> >  
> >    threadlist_t *tl_entry = NULL;
> >    _cygtls *tls = NULL;
> > @@ -1527,11 +1528,15 @@ sigpacket::process ()
> >    if ((HANDLE) *tls)
> >      tls->signal_debugger (si);
> >  
> > -  if (issig_wait)
> > +  tls->lock ();
> > +  if (issig_wait && tls->sigwait_mask != 0)
> >      {
> > +      orig_wait_mask = tls->sigwait_mask;
> >        tls->sigwait_mask = 0;
> > +      tls->unlock ();
> >        goto dosig;
> >      }
> > +  tls->unlock ();
> >  
> >    if (handler == SIG_IGN)
> >      {
> > @@ -1606,6 +1611,11 @@ dosig:
> >    /* Dispatch to the appropriate function. */
> >    sigproc_printf ("signal %d, signal handler %p", si.si_signo, handler);
> >    rc = setup_handler (handler, thissig, tls);
> > +  if (orig_wait_mask)
> > +    {
> > +      tls->sigwait_mask = orig_wait_mask;
> > +      WakeByAddressAll (&tls->sigwait_mask);
> > +    }
> >  
> >  done:
> >    cygheap->unlock_tls (tl_entry);
> > 
> > Mind, that's just an idea.  There may be a simpler way to do this.
> > 
> > Alternatively we can just fallback to your version 1.
> 
> Using WaitOnAddress() may be nice idea, however, I prefer my v1 patch.
> It's simpler and the intent of the code is clearer, isn't it?

And somehow an iteration of the above code doesn't actually fix the
problem, your original patch does.  So please push.

The WaitOnAddress/WakeByAddressAll seems to work nicely, but it still
crashes.  There's something else which is fixed by calling cygwait
again.  I'm not sure what I'm missing.

Pity.  I like the WaitOnAddress/WakeByAddressXYZ calls and was really
hot to use them finally :}


Thanks,
Corinna
