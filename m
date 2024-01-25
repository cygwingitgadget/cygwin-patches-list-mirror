Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CDC1C385803A; Thu, 25 Jan 2024 18:21:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CDC1C385803A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706206917;
	bh=Lr6NClIG53cRmHvXQYtNiAuLFyseXSFN682HuHtOPJc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BhULN+jvqoh7CbuxGldRXitZKveezqXy6/jJYzJKbDLZoH0UQ0dTTBDBu4J1JvpQc
	 1Ds4yiLaNMDihJgN+Q5Tj8KtajwF3NOW254gVLJJDfWgx7mZY8BIqfWvLevC2FG5Y3
	 ZsNs4BTSN63UYWnY/L/f7mta8/pEDas4YE+oACp4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CB902A80CC2; Thu, 25 Jan 2024 19:21:55 +0100 (CET)
Date: Thu, 25 Jan 2024 19:21:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZbKmwy7wKjAJvF1u@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
 <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
 <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
 <ZbEhEP-MI7oX_2px@calimero.vinschen.de>
 <b140b902-8c5d-47f8-910e-f30d835bf185@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b140b902-8c5d-47f8-910e-f30d835bf185@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 25 14:50, Jon Turney wrote:
> On 24/01/2024 14:39, Corinna Vinschen wrote:
> > On Jan 24 13:28, Jon Turney wrote:
> > > On 23/01/2024 14:29, Corinna Vinschen wrote:
> > > > On Jan 23 14:20, Jon Turney wrote:
> > > > 
> > > > > Even then this is clearly not totally bullet-proof. Maybe the right thing to
> > > > > do is add a suitable timeout here, so even if we fail to notice the
> > > > > DebugActiveProcess() (or there's a custom JIT debugger which just writes the
> > > > > fact a process crashed to a logfile or something), we'll exit eventually?
> > > > 
> > > > Timeouts are just that tiny little bit more bullet-proof, they still
> > > > aren't totally bullet-proof.
> > > > 
> > > > What timeout were you thinking of?  milliseconds?
> > > 
> > > Oh no, tens of seconds or something, just as a fail-safe.
> > 
> > Uh, sounds a lot.  10 secs?  Not longer, I think.
> > 
> > If you want to do that for 3.5, please do it this week.  You can
> > push the change without waiting for approval.
> 
> Thanks.
> 
> I pushed a small change adding this timeout.
> 
> > > (Ofc, all this is working around the fact that Win32 API doesn't have a
> > > WaitForDebuggerPresent(timeout) function)
> > 
> > Yeah, and there's no alternative way using the native API afaics :(
> 
> So this situation with a JIT debugger is even stranger than my emendations
> to the documentation say.
> 
> Because we're hitting try_to_debug() in exception::handle(), which has some
> code to replay the exception via ExceptionContinueExecution (which I guess
> the debugger will catch as a first-chance) (and goes into a mode where it
> ignores the next half-million exceptions... no idea what that's about!)
> 
> That's not the same as signal_exit() with a coredumping signal (haven't
> checked if those are all generated from exceptions, but seemly probable, so
> the try_to_debug() there maybe isn't doing anything?), where we're going to
> exit thereafter.

try_to_debug() is only calling IsDebuggerPresent() as test, and that's
nothing but a flag in the PEB which is set by the OS after a debugger
attached to the process.  So the test is by definition extremely
flaky, if the debugger is connecting and disconnecting, as you
already pointed out.

I'm wondering if we can't define our own way to attach to a process,
allowing to "WaitForDebugger" as long as the debugger is a Cygwin
debugger.  If we define a matching function (along the lines of
prctl(2) on Linux), we could change our debuggers, core dumpers
and stracers to call this attach function.

The idea would be to define some shared mutex object, the inferior
waits for and the debugger releases after having attached.

Is there really any need to support non-Cygwin debuggers?

> The practical upshot of this is if the JIT debugger doesn't terminate or fix
> the erroring process, we'll just replay the faulting instruction and invoke
> the JIT debugger again.

Hmm, ok.  This signal stuff *is* complicated and I'd be happy
if anybody finds out how to fix that...


Corinna
