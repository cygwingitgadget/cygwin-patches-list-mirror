Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DAEF23842FF7; Fri, 28 Mar 2025 10:08:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DAEF23842FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743156510;
	bh=LcxttaiHklhWtBEQRcwyPWTRLqiy1+TMj8fKwCRhEos=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QnIhC3Pq5Ik/UJHfoWhDPlRxV7Cv/JmSZVf3pwp19kFaLMg09bvpOYv1OWMqMhIzk
	 pT/bH2LVn/7+TR5J7WHkGbhYZr0muZU2XcLjTmQichREDaiacqiccFclcSDAqpv4UH
	 q+eqfuB32Y2SjD+ah+wszV4sUfH+S747EnmBo85U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CADDAA80B96; Fri, 28 Mar 2025 11:08:28 +0100 (CET)
Date: Fri, 28 Mar 2025 11:08:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: use udis86 to find fast cwd pointer on x64
Message-ID: <Z-Z1HJZKiHi6YUcd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com>
 <Z-U5WFBxoUfeVwn7@calimero.vinschen.de>
 <f7b8d776-ca5b-a0b3-63bb-02ea496e5bb6@jdrake.com>
 <Z-Wm3C1AoXLaYeMg@calimero.vinschen.de>
 <580c99c4-d0bb-ee54-3a39-43b55f5abc1f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <580c99c4-d0bb-ee54-3a39-43b55f5abc1f@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 27 17:52, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 27 Mar 2025, Corinna Vinschen wrote:
> 
> > On Mar 27 10:26, Jeremy Drake via Cygwin-patches wrote:
> > > comment, it seems 8.0 is the odd-version-out here.
> >
> > Yeah, but we don't support 8.0 anymore, only 8.1.
> >
> > > BTW, something I would *like* to do but haven't figured out how to
> > > accomplish cleanly yet is to follow the registers.  What I mean by this is
> > > illustrated by what I did in the aarch64 version: I could find the call to
> > > RtlEnterCrticalSection, then work backwards, find the add whose Rd was x0
> > > (the register for the first (pointer) parameter in the calling
> > > convention), then find the adrp whose Rd was the Rn of the add.  What I
> > > would do on x86_64 is find the call to RtlEnterCriticalSection, find any
> > > mov rcx, <reg> before, then find the lea <reg>, [rip+XXX] (where reg would
> > > be rcx if there wasn't a mov rcx after the lea).  Unfortunately, the
> > > variable length-ness doesn't lend itself to iterating backwards, so I am
> > > not confirming that the lea actually ends up in rcx for the function call.
> > > The only register correlation I do is that the register used in the
> > > mov <reg>, QWORD PTR [rip+XXX] is then used in the next instruction that
> > > must be test <reg>, <reg>.  The old code required that <reg> to be rbx,
> > > but I don't see any reason that rbx is required...
> >
> > Yeah, reading x86_64 backwards will lead to confusion.  And no, rbx
> > isn't required, any non-volatile register could do it.  It seems that
> > rbx is used because of the way vc++ allocates register.
> 
> 
> After taking out the windows 8.0 case, I think this should be doable:
> * when finding the lea that we're already looking for, save the
>   destination register
> 
> * if the destination register is not rcx, look for a 64-bit mov into rcx
>   from <reg> (where <reg> is the register from the lea) before the call to
>   RtlEnterCriticalSection
> 
> This won't catch cases where they shuffle it between multiple registers,
> or otherwise obfusate the load into rcx (push/pop, xchg, using some memory
> location, ...) but I think this covers every case I've seen (including
> those mentioned in comments about preview builds).  It would also allow us
> to skip the theoretical-but-legal sequence (intel)
> 
> lea rXX, [rip+XXXX] ; FastPebLock
> ...
> call UnrelatedFunction
> mov rcx, rXX
> call RtlEnterCriticalSection
> mov rYY, QWORD PTR [rip+YYYY] ; RtlpCurDirRef
> test rYY, rYY
> ...
> 
> I'll try to find some time to test this latest round on as many released
> Windows versions >= 8.1 as I can, and then send a v3 series.  It works on
> 22631 at least.

This sounds great, but don't put too many effort into past preview
releases.  We try hard that Cygwin runs on released versions of
Windows.  But preview versions of the past are a thing of the past.  Not
only that, but you're putting a lot of effort into versions sometimes
used by a single machine.
It might further simplify the code if you don't handle these old
temporary versions anymore and concentrate on the past releases.

Btw., wouldn't you have fun to join our Libera IRC channel
#cygwin-developers?  https://cygwin.com/irc.html


Thanks,
Corinna
