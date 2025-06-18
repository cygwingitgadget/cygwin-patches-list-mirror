Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6F51E3841B91; Wed, 18 Jun 2025 08:17:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6F51E3841B91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750234655;
	bh=4n+c/qAnuhILa3YenK8w74qsLQD2Z9gbkpRgXOKPG1o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=acaN2JPtGCfy53kkvf7Wk/Qgy/soWUhmR78tIhcEpqkxXilI7A2ApGq2aGlyHf8IR
	 x12UxcF3JSJO2vQ5Qs0WLEOPvD9IrhMIingYAIa6TAAJa5724o2OJcAsHwRghOvUv0
	 9UutBnNLk84Z1EdOt+wYcfb52CUOmdVofqi2AxAw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4D613A80D4E; Wed, 18 Jun 2025 10:17:33 +0200 (CEST)
Date: Wed, 18 Jun 2025 10:17:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
Message-ID: <aFJ2Ha72ezNQrCR4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com>
 <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com>
 <aFFNnpI5eBgSl805@calimero.vinschen.de>
 <413d1875-ed41-9ad0-3954-4df6bae666e7@jdrake.com>
 <aFGyoVdstMJOjEBD@calimero.vinschen.de>
 <b668190b-65c4-6c0a-4188-39733ce2ab49@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b668190b-65c4-6c0a-4188-39733ce2ab49@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 17 11:35, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 17 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 17 10:21, Jeremy Drake via Cygwin-patches wrote:
> > > The pthread macros were previously casts of integers to pointers, which
> > > would always be full absolute pointers.  This change is making them actual
> > > symbols which the linker fills in with absolute addresses.  This would be
> > > out of range of a 32-bit rip-relative relocation in cases where the image
> > > base is >4GB.
> > >
> > > This is really gross, as I said, but was the only way I came up with to
> > > make them satisfy constinit's restrictions in clang (and the standard, it
> > > seems GCC allows things that are explicitly disallowed by the standard).
> >
> > Ok, but then I'm still puzzled about the code.
> >
> > First of all, shouldn't the new symbols get exported explicitly via
> > cygwin.din?
> 
> No, as i said they can't be used from the DLL anyway.  I included them in
> libcygwin.a (LIB_FILES) for external users, and in the dll (DLL_FILES) for
> internal uses.
> 
> > Second, I'm puzzeling over the #if expression (cut for a simple example):
> >
> >   #if !defined(__INSIDE_CYGWIN__) || !defined(__cplusplus)
> >   /* use symbols */
> >   #else
> >   /* use const int cast to pointer */
> >   #endif
> >
> > So this is a problem in terms of constinit.  Constinit is a C++20
> > expression.  But the condition will only define PTHREAD_...  using the
> > symbols if this is either outside Cygwin, or if the Cygwin code is NOT
> > C++.
> >
> > The usage inside Cygwin seems upside down to me.  Shouldn't it use the
> > symbols in C++ code but not in plain C?  Or am I misunderstanding the
> > condition entirely?
> 
> The reason I kept the old cast-to-pointer path inside Cygwin C++ code is
> that that case triggered the "relocation truncated to fit" error.  Also,
> that matches the condition inside sys/_pthreadtypes.h to cast to a class
> pointer instead of a struct pointer.
> >
> > > Somewhat surprising to me is that clang also disallows using the address
> > > of a dllimported extern variable in constinit, so we couldn't even
> > > dllexport "magic" objects from the DLL whose addresses could be compared
> > > against instead of (pthread_mutex_t)19 and such.
> >
> > We also have the choice to export the symbols from libcygwin.a, see the
> > files in LIB_FILES in Makefile.am.  Would that allow clang to use them
> > in constinit?  Theoretically we could also define them in crt0.o, but
> > this looks too much like just another hack...
> 
> Yes, that's what I did...

So it all boils down to me not reading your patch correctly. D'oh.

And no, I don't see a better way to avoid the original constinit problem,
so your patch is GTG.  3.6 branch, too, I guess.


Thanks,
Corinna
