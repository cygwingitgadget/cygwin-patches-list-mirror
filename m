Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 349363858C3A; Wed, 27 Nov 2024 15:25:09 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3097CA81058; Wed, 27 Nov 2024 16:25:07 +0100 (CET)
Date: Wed, 27 Nov 2024 16:25:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: finding fast_cwd_pointer on ARM64
Message-ID: <Z0c50yOraHdefcmw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com>
 <Z0XOOW365ff53K6B@calimero.vinschen.de>
 <59f580ca-bded-6d45-c624-fd1ca13bd744@jdrake.com>
 <ec73a729-57e8-11f7-78be-ab78bde6c0a6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec73a729-57e8-11f7-78be-ab78bde6c0a6@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 26 17:25, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 26 Nov 2024, Jeremy Drake via Cygwin-patches wrote:
> 
> > On Tue, 26 Nov 2024, Corinna Vinschen wrote:
> >
> > > Btw...
> > >
> > > We're doing this because nobody being able to debug ARM64 assembler came
> > > up with a piece of code checking the ntdll assembler code to find the
> > > address of the fast_cwd_pointer on ARM64.
> > >
> > > You seem to have the knowledge and the means to do that, Jeremy.
> > >
> > > Any fun tracking this down?
> >
> > Ha, no, not really.  I looked into something similar trying to get Ruby
> > running on Windows on ARM64, and learned enough to know that how ARM64
> > encodes addresses is odd enough that I didn't want to dig further ;)
> >
> > Somebody else did end up implementing getting a private variable (out of
> > UCRT) by looking at ARM64 assembler, maybe that could work as a starting
> > point?
> >
> > https://github.com/ruby/ruby/commit/784fdecc4c9f6ba9a8fc872518872ed6bdbc6670#diff-883ccab70529ab9c4e51fa7b67e178a205940056b21cd123115ebadd8029f50f
> 
> 
> I had a quick look in the debugger, and it's even worse than that...
> 
> First, because we're running emulated x64 code, the address returned from
> GetProcAddress is an x64 stub, presumably to exit emulation and call the
> native function.  Ok, not too bad, there's a jmp instruction in there to
> the ARM64 function...  In RtlGetCurrentDirectory_U, again pretty
> straightforward, first call is to RtlpReferenceCurrentDirectory... In that
> function, however, is where things get intesting.  It's still much the
> same theory as described for x86_64, however:
> 
> 1) note that loading an absolute pointer on ARM64 involves 2 instructions.
> The instructions getting the address of the fast peb lock and the fast cwd
> pointer are actually *interleaved*, the upper bits of the fast cwd pointer
> are loaded before the upper bits of the fast peb lock, but the lower bits
> are not added until *after* the RtlEnterCriticalSection call.
> 
> 2) the registers used differ between Windows 10 22H2 and Windows 11 23H2
> (these are what I had handy - who knows what other versions do).
> 
> Also, because of the x64 stub thing, the address you'd get from
> GetProcAddress for RtlEnterCriticalSection would differ from the native
> RtlEnterCriticalSection actually called by the ARM64 code.

Yeah, that sounds... icky.


Thanks,
Corinna
