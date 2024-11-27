Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BEFF23858D28; Wed, 27 Nov 2024 14:38:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BEFF23858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732718318;
	bh=W1Vp4McRZejlquIW3QCoiwHwIYCrbRTZQxnmnZaPWkQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=oqsoz6oR13FQPTV6hUPKOf+V/7K/h0HxJYaYK9FyhqfNX2BF/yHM+Y1l6bS+DtdYX
	 eM5NbLWLL9lWyp8xkAXfWu+yB6faOccINQBczImVikZEwgSFCeBaUhgxJttn3MPKYr
	 KLBpwJFI9vJ/XrtrzCZSoXZ+YIzEo8TDeZL6O4cE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B1C57A80E4D; Wed, 27 Nov 2024 15:38:36 +0100 (CET)
Date: Wed, 27 Nov 2024 15:38:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
Message-ID: <Z0cu7Dzbq9RMSmrD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
 <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
 <5d40600d-8929-ebc4-d417-6e8b3221d09e@t-online.de>
 <Z0XFU636aT986Vtn@calimero.vinschen.de>
 <a4acc9e3-8363-b9af-e92e-b3a865b18d20@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4acc9e3-8363-b9af-e92e-b3a865b18d20@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 10:14, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Nov 25 21:20, Christian Franke wrote:
> > > Corinna Vinschen wrote:
> > > > - Isn't returning SCHED_FIFO sched_getscheduler() just as wrong?
> > > Definitly. SCHED_FIFO is a non-preemptive(!) real-time policy. Windows does
> > > not offer anything like that to userland (AFAIK).
> > > 
> > > https://man7.org/linux/man-pages/man7/sched.7.html
> > > 
> > > I wonder whether there was a use case for this emulation when this module
> > > was introduced in 2001.
> > Just guessing here, but using one of the RT schedulers was the only way
> > to enable changing the priority from user space and using SCHED_FIFO was
> > maybe in error.
> > 
> > > >     Shouldn't that be SCHED_OTHER, and sched_setscheduler() should check
> > > >     for that instead?  Cygwin in a real-time scenario sounds a bit
> > > >     far-fetched...
> > > Agree.
> > > 
> > > Note that SCHED_OTHER requires sched_priority == 0, so most of the
> > > sched_get/set*() priority related code would no longer make sense then.
> > This is the other problem. Changing this to SCHED_OTHER sounds like
> > dropping potentially used functionality.  Maybe we should just switch to
> > SCHED_RR?
> 
> Yes, it at least would be closer to what windows does. It is still
> non-preemptive from the point of view of lower priorities. I don't know what
> the Win32 *_PRIORITY_CLASSes actually do.

Who does? :}

> As far as I understand the related documentation, a more sophisticated
> emulation (aka fake) of SCHED_* would be:
> 
> - Allow to switch between SCHED_OTHER (default) and SCHED_RR with
> sched_setscheduler().
> 
> - If SCHED_OTHER is selected, change PRIORITY_CLASS with setpriority() and
> ignore (or fail on?) attempts to change sched_priority with
> sched_setparam().
> 
> - If SCHED_RR is selected, ignore setpriority() and change PRIORITY_CLASS
> with sched_setparam().
> 
> Possibly not worth the effort...

Why not?  It should probably also allow SCHED_FIFO for backward compat,
since, in a way, it doesn't really matter anyway.  This would be nice
for 3.6.

And I think your patch here should go in as is, just with the release
message in release/3.5.5 so we can cherry-pick it to the 3.5 branch.


Thanks,
Corinna
