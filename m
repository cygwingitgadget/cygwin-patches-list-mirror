Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1EFF1388E533; Tue, 17 Jun 2025 18:23:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1EFF1388E533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750184612;
	bh=jIIaqOL45Abox8y1ipKF3xzejM5qYNHQCnTqeDN9KGY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=GyRbKNlPvJB+GbkwI9jT/u5qFleVtkB22RPRzY/YPozGYhr2RxL10HUlxz6heslWC
	 RrwaqzjjtJFFJpOlecMK7uHxz5+5cj5RJ0I2zVf+cdRmuq1r3GJB3B6gEycvQIaAZy
	 Gdl5/+RyE/rA1s851COlanPbl5yZpJSMCGlOEF+0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D916DA80961; Tue, 17 Jun 2025 20:23:29 +0200 (CEST)
Date: Tue, 17 Jun 2025 20:23:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
Message-ID: <aFGyoVdstMJOjEBD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com>
 <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com>
 <aFFNnpI5eBgSl805@calimero.vinschen.de>
 <413d1875-ed41-9ad0-3954-4df6bae666e7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <413d1875-ed41-9ad0-3954-4df6bae666e7@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 17 10:21, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 17 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 16 22:12, Jeremy Drake via Cygwin-patches wrote:
> > > gcc 13.4.0 rebuilt successfully too.  The thing to watch out for with this
> > > is "relocation truncated to fit" link errors.
> >
> > I don't see those when building Cygwin. What are you doing differently?
> > Compiler or binutils version?
> 
> This was with an earlier version of the patch that failed to build in CI
> on Github.
> 
> https://github.com/jeremyd2019/cygwin/commit/cd822eb2569755e992d8ef94c4a3b4097ed2a36a
> 
> > > Oddly enough, I saw this
> > > when using the absolute symbols from the C++ inside the Cygwin DLL build,
> > > but have not seen it building either DLLs or EXEs using clang or gcc, even
> > > when trying to recreate the scenario (comparing a pthread_mutex_t to
> > > PTHREAD_MUTEX_INITIALIZER).
> >
> > This may be fallout from using -mcmodel=small, see winsup/cygwin/Makefile.am.
> > Default is -mcmodel=medium, IIRC.
> 
> That's probably it.
> 
> > When we ported Cygwin to x86_64, we got "relocation truncated to fit"
> > when we decided to move the address space used by Cygwin on 64 bit
> > beyond the 2 Gigs border.  Gcc and binutils got tweaked specificially to
> > allow Cygwin to use the full address space as desired.  But the PTHREAD
> > macros never triggered this problem before, which is puzzeling.
> 
> The pthread macros were previously casts of integers to pointers, which
> would always be full absolute pointers.  This change is making them actual
> symbols which the linker fills in with absolute addresses.  This would be
> out of range of a 32-bit rip-relative relocation in cases where the image
> base is >4GB.
> 
> This is really gross, as I said, but was the only way I came up with to
> make them satisfy constinit's restrictions in clang (and the standard, it
> seems GCC allows things that are explicitly disallowed by the standard).

Ok, but then I'm still puzzled about the code.

First of all, shouldn't the new symbols get exported explicitly via
cygwin.din?

Second, I'm puzzeling over the #if expression (cut for a simple example):

  #if !defined(__INSIDE_CYGWIN__) || !defined(__cplusplus)
  /* use symbols */
  #else
  /* use const int cast to pointer */
  #endif

So this is a problem in terms of constinit.  Constinit is a C++20
expression.  But the condition will only define PTHREAD_...  using the
symbols if this is either outside Cygwin, or if the Cygwin code is NOT
C++.

The usage inside Cygwin seems upside down to me.  Shouldn't it use the
symbols in C++ code but not in plain C?  Or am I misunderstanding the
condition entirely?

> Somewhat surprising to me is that clang also disallows using the address
> of a dllimported extern variable in constinit, so we couldn't even
> dllexport "magic" objects from the DLL whose addresses could be compared
> against instead of (pthread_mutex_t)19 and such.

We also have the choice to export the symbols from libcygwin.a, see the
files in LIB_FILES in Makefile.am.  Would that allow clang to use them
in constinit?  Theoretically we could also define them in crt0.o, but
this looks too much like just another hack...


Thanks,
Corinna
