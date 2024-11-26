Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DFFED3858D33; Tue, 26 Nov 2024 12:55:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DFFED3858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732625749;
	bh=tx96sI4MLtHR+t4EQUupJ18whU5KuIZvgaCuAllniW0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xhdOWTgB1MV0QgweNcc5jDgkm0kTyjocGNiZQuzCAVkfMyeaq6Q5VRhtaUWpjEIuX
	 rnMM8fChZ8wekZXGAhH01kQWwYFqr/dOmZgx+42tDDt9cmOrW4uER7+ldrJY9+8dTq
	 CiPJHuFbUI02vGeHqwOPccNP2hzgRTrxjpHxW8o4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 64733A80E83; Tue, 26 Nov 2024 13:55:47 +0100 (CET)
Date: Tue, 26 Nov 2024 13:55:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
Message-ID: <Z0XFU636aT986Vtn@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
 <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
 <5d40600d-8929-ebc4-d417-6e8b3221d09e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d40600d-8929-ebc4-d417-6e8b3221d09e@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 25 21:20, Christian Franke wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On Nov 25 15:00, Christian Franke wrote:
> > > Corinna Vinschen wrote:
> > > > Fixes: ...?
> > > ... the very first commit (cgf 2001) of sched.cc :-)
> > > 
> > > New patch attached.
> > > 
> > >  From e95fc1aceb5287f9ad65c6c078125fecba6c6de9 Mon Sep 17 00:00:00 2001
> > > From: Christian Franke <christian.franke@t-online.de>
> > > Date: Mon, 25 Nov 2024 14:51:04 +0100
> > > Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
> > > 
> > > Behave like sched_setparam() if the requested policy is identical
> > > to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
> > > 
> > > Fixes: 6b2a2aa4af1e ("Add missing files.")
> > Huh, yeah, this is spot on.  I wonder if it would make sense to change
> > that to 9a08b2c02eea ("* sched.cc: New file.  Implement sched*.")
> > though, given that was the patch intended to add sched.cc :)))
> > 
> > Sorry, but I have to ask two more questions:
> > 
> > - Isn't returning SCHED_FIFO sched_getscheduler() just as wrong?
> 
> Definitly. SCHED_FIFO is a non-preemptive(!) real-time policy. Windows does
> not offer anything like that to userland (AFAIK).
> 
> https://man7.org/linux/man-pages/man7/sched.7.html
> 
> I wonder whether there was a use case for this emulation when this module
> was introduced in 2001.

Just guessing here, but using one of the RT schedulers was the only way
to enable changing the priority from user space and using SCHED_FIFO was
maybe in error.

> >    Shouldn't that be SCHED_OTHER, and sched_setscheduler() should check
> >    for that instead?  Cygwin in a real-time scenario sounds a bit
> >    far-fetched...
> 
> Agree.
> 
> Note that SCHED_OTHER requires sched_priority == 0, so most of the
> sched_get/set*() priority related code would no longer make sense then.

This is the other problem. Changing this to SCHED_OTHER sounds like
dropping potentially used functionality.  Maybe we should just switch to
SCHED_RR?

> A related interesting snippet which I don't understand:
> sys/sched.h:
> #if defined(__CYGWIN__)
> #define SCHED_OTHER    3
> #else
> #define SCHED_OTHER    0
> #endif

Oh, that's for backward compat.  The original sched.h in Cygwin defined
SCHED_OTHER as 3, while newlib's sys/sched.h defined SCHED_OTHER as 0.
The right thing to do in 2001 would have been to define SCHED_OTHER to 0
for Cygwin as well, but unfortunately nobody really cared at the time.


Corinna
