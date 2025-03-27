Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 19FA3385843B; Thu, 27 Mar 2025 19:28:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 19FA3385843B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743103714;
	bh=f37ARSucgfXiruUvcVrIb3j19ypzb7Ke+06ubMxomqY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=HdtnshP6J8c09H0iihN8hG8RGfQWJ+Fd6oSTdFXWVMOrvHpxgTFGSMOAGgcmCo6PD
	 bC0cgpyS6VEL/4zA9DN6TjHu0g6Ohr7xCJM8UyiXg2Fpx96JdXjPWrovkDZlmcAqpr
	 9mi76CJofa3u3fGw3cv6fS+ioivjew/JqfAsH+HE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1225DA806F0; Thu, 27 Mar 2025 20:28:28 +0100 (CET)
Date: Thu, 27 Mar 2025 20:28:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: use udis86 to find fast cwd pointer on x64
Message-ID: <Z-Wm3C1AoXLaYeMg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com>
 <Z-U5WFBxoUfeVwn7@calimero.vinschen.de>
 <f7b8d776-ca5b-a0b3-63bb-02ea496e5bb6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7b8d776-ca5b-a0b3-63bb-02ea496e5bb6@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 27 10:26, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 27 Mar 2025, Corinna Vinschen wrote:
> 
> > Hi Jeremy,
> >
> > ok, three questions...
> >
> > Q1: How does it compare performancewise to the old code?  Fortunately
> >     it's only called once per process tree, so this shoudn't have much
> >     impact, but still nice to know...
> 
> How would you go about finding that out?
> 
> > Q2: Would you mind to add more comments?
> >
> > Q2a: A preceeding one line comment briefly explaining the function?
> >
> > > +static inline const void *
> > > +rip_rel_offset (const ud_t *ud_obj, const ud_operand_t *opr, int sub_off=0)
> 
> rip_rel_offset helper function?  OK...

Yeah, I'm aware that the name is kind of speaking, but still...

The number of code snippets I wrote myself but had a hard time
understanding 10 years later makes me wary.

> > Q2b: Comment like "Initializing" blah?
> >
> > > +  ud_t ud_obj;
> > > +  ud_init (&ud_obj);
> > > +  ud_set_mode (&ud_obj, 64);
> > > +  ud_set_input_buffer (&ud_obj, get_dir, 80);
> > > +  ud_set_pc (&ud_obj, (const uint64_t) get_dir);
> 
> > > -     On Pre-Windows 8 we basically look for the RtlEnterCriticalSection call.
> > > -     Windows 8 does not call RtlEnterCriticalSection.  The code manipulates
> > > -     the FastPebLock manually, probably because RtlEnterCriticalSection has
> > > -     been converted to an inline function.  Either way, we test if the code
> > > -     uses the FastPebLock. */
> > > +     On Pre- (or Post-) Windows 8 we basically look for the
> >
> > Q3: or post?  Really?  AFAIK, this was only an issue on pre W8, so it
> >     affects Vista and W7 only.  Theoretically this check can go away,
> >     unless you have proof this is still an issue in some later Windows
> >     starting with 8.1.
> 
> I haven't confirmed what pre-8 does, but 8.0 appears to inline
> RtlEnterCriticalSection while 8.1 and later call it.  Based on the
> comment, it seems 8.0 is the odd-version-out here.

Yeah, but we don't support 8.0 anymore, only 8.1.

> > > +     RtlEnterCriticalSection.  The code manipulates the FastPebLock manually,
> > > +     probably because RtlEnterCriticalSection has been converted to an inline
> > > +     function.  Either way, we test if the code uses the FastPebLock. */
> 
> > Q2c: Roundabout here, I'm getting the impression we're losing
> >      more comments than we gain.  This is not a good way to raise
> >      confidence ;)
> >
> > Codewise I have nothing to carp at, but comments are a bit sparse
> > for my taste...
> 
> I thought the only comments I lost were related to each insider version
> workaround that was piled on top that are no longer necessary.

Hmm, ok.  Never mind then.

> BTW, something I would *like* to do but haven't figured out how to
> accomplish cleanly yet is to follow the registers.  What I mean by this is
> illustrated by what I did in the aarch64 version: I could find the call to
> RtlEnterCrticalSection, then work backwards, find the add whose Rd was x0
> (the register for the first (pointer) parameter in the calling
> convention), then find the adrp whose Rd was the Rn of the add.  What I
> would do on x86_64 is find the call to RtlEnterCriticalSection, find any
> mov rcx, <reg> before, then find the lea <reg>, [rip+XXX] (where reg would
> be rcx if there wasn't a mov rcx after the lea).  Unfortunately, the
> variable length-ness doesn't lend itself to iterating backwards, so I am
> not confirming that the lea actually ends up in rcx for the function call.
> The only register correlation I do is that the register used in the
> mov <reg>, QWORD PTR [rip+XXX] is then used in the next instruction that
> must be test <reg>, <reg>.  The old code required that <reg> to be rbx,
> but I don't see any reason that rbx is required...

Yeah, reading x86_64 backwards will lead to confusion.  And no, rbx
isn't required, any non-volatile register could do it.  It seems that
rbx is used because of the way vc++ allocates register.


Corinna
