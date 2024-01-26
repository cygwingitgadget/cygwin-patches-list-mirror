Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8DF5E3858C31; Fri, 26 Jan 2024 11:12:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8DF5E3858C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706267560;
	bh=7wdqJ3hZLXhG4w6mvqf33Jsnp632sHKNKH17B23RA+s=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QTzC+M7XNjXLiGE65CYPFcJ+WTnk4zj4+ScJGOyJ1WbOklN43w9uvgugxhY9mplel
	 iCC6xeCEXcwRQ9a0T1Xw+Ui4JZWw6hnCLTi2ZP9QfxI2vHnnMikU6LiKryLRb3rrFf
	 kMVSshRns4eVwbX+W+IH0SlosrlbLJNso5PYu0JM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A0440A80BDF; Fri, 26 Jan 2024 12:12:37 +0100 (CET)
Date: Fri, 26 Jan 2024 12:12:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZbOTpaBfEZwAkxcf@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
 <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
 <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
 <ZbEhEP-MI7oX_2px@calimero.vinschen.de>
 <b140b902-8c5d-47f8-910e-f30d835bf185@dronecode.org.uk>
 <ZbKmwy7wKjAJvF1u@calimero.vinschen.de>
 <0613f2c3-4e1f-452a-8055-59d34d16c821@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0613f2c3-4e1f-452a-8055-59d34d16c821@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 25 20:03, Jon Turney wrote:
> On 25/01/2024 18:21, Corinna Vinschen wrote:
> > On Jan 25 14:50, Jon Turney wrote:
> > > On 24/01/2024 14:39, Corinna Vinschen wrote:
> > > > On Jan 24 13:28, Jon Turney wrote:
> > > > > On 23/01/2024 14:29, Corinna Vinschen wrote:
> > > > > > On Jan 23 14:20, Jon Turney wrote:
> [...]
> > > So this situation with a JIT debugger is even stranger than my emendations
> > > to the documentation say.
> > > 
> > > Because we're hitting try_to_debug() in exception::handle(), which has some
> > > code to replay the exception via ExceptionContinueExecution (which I guess
> > > the debugger will catch as a first-chance) (and goes into a mode where it
> > > ignores the next half-million exceptions... no idea what that's about!)
> > > 
> > > That's not the same as signal_exit() with a coredumping signal (haven't
> > > checked if those are all generated from exceptions, but seems probable, so
> > > the try_to_debug() there maybe isn't doing anything?), where we're going to
> > > exit thereafter.
> > 
> > try_to_debug() is only calling IsDebuggerPresent() as test, and that's
> > nothing but a flag in the PEB which is set by the OS after a debugger
> > attached to the process.  So the test is by definition extremely
> > flaky, if the debugger is connecting and disconnecting, as you
> > already pointed out.
> > 
> > I'm wondering if we can't define our own way to attach to a process,
> > allowing to "WaitForDebugger" as long as the debugger is a Cygwin
> > debugger.  If we define a matching function (along the lines of
> > prctl(2) on Linux), we could change our debuggers, core dumpers
> > and stracers to call this attach function.
> > 
> > The idea would be to define some shared mutex object, the inferior
> > waits for and the debugger releases after having attached.
> > 
> > Is there really any need to support non-Cygwin debuggers?
> 
> idk
> 
> I think something like that used to exist a long time ago, see commit
> 8abeff1ead5f3824c70111bc0ff74ff835dafa55

Yeah, just, as was the default at the time, without any trace of a
*rational* why it has been removed.  Also, it was too simple anyway.

First, if we want to support WIndows debugger, the inferior has to check
if the debugger is a Cygwin or native debugger.  If a native debugger,
just stick to what we have today.  Otherwise:

- Create a named mutex with a reproducible name (no need to use
  the name as parameter) and immediately grab it.
- Call CreateProcess to start the debugger with CREATE_SUSPENDED
  flag.
- Create a HANDLE array with the mutex and the process HANDLE.
- Call ResumeThread on the primary debugger thread.
- Call WFMO with timeout.

Later on, the debugger either fails and exits or it calls
ReleaseMutex after having attached to the process.

- WFMO returns
- If the mutex has triggered, we're being debugged (but check
  IsDebuggerPresent() just to be sure)
- If the process has triggered, the debugger exited
- If the timeout triggers... oh well.

> That long predates my involvement with cygwin so I've no idea why that was
> removed.

It doesn't predate mine, but I know just as much as you do.
Maybe the mailing list archives help, but tht's no safe bet.

> > > The practical upshot of this is if the JIT debugger doesn't terminate or fix
> > > the erroring process, we'll just replay the faulting instruction and invoke
> > > the JIT debugger again.
> > 
> > Hmm, ok.  This signal stuff *is* complicated and I'd be happy
> > if anybody finds out how to fix that...
> 
> To be clear, not a problem with "core dumping signals", as the process now
> always end up exiting, one way or another.
> 
> It's only a problem when someone has set "CYGWIN=error_start:true" or
> something equally dumb.

Ok.


Corinna
