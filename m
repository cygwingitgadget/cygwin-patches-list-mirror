Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C6CEF384D146; Tue, 17 Jun 2025 11:12:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C6CEF384D146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750158752;
	bh=bCloiVblDu9ivibLy54eO9V1z51MEAZjRhBqb2durdU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JMW9yFkXo9HWyQsBvnKsRR0YTd3CubkjlYwIP0KCQsP1G+N4Qqbpk58nHDCtwmB+/
	 oXTpZP9tCLPNsGg0YDsZmmx2ZAyTYl7Nium8LtdKDFLeJxSUsFdZT+GICnwWCVX/C/
	 eDuGyHqP90kI5YE/nNUTYLu+Xz98YzL/HR7jQ4h0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B5D75A80961; Tue, 17 Jun 2025 13:12:30 +0200 (CEST)
Date: Tue, 17 Jun 2025 13:12:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
Message-ID: <aFFNnpI5eBgSl805@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com>
 <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 16 22:12, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 16 Jun 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> > In order to avoid a restriction on any reinterpret_cast-like behavior in
> > constinit expressions, use assembly and the linker to define symbols
> > with the not-valid-address addresses.
> >
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> > This is gross, but I couldn't come up with a way to make this both source
> > and ABI (including C++ name mangling) compatible.  I'd be happy to be
> > shown a cleaner way.  I built libc++ without a patch to remove constinit,
> > and I'm working on building gcc/libstdc++ to confirm it didn't break
> > anything there.
> 
> gcc 13.4.0 rebuilt successfully too.  The thing to watch out for with this
> is "relocation truncated to fit" link errors.

I don't see those when building Cygwin. What are you doing differently?
Compiler or binutils version?

> Oddly enough, I saw this
> when using the absolute symbols from the C++ inside the Cygwin DLL build,
> but have not seen it building either DLLs or EXEs using clang or gcc, even
> when trying to recreate the scenario (comparing a pthread_mutex_t to
> PTHREAD_MUTEX_INITIALIZER).

This may be fallout from using -mcmodel=small, see winsup/cygwin/Makefile.am.
Default is -mcmodel=medium, IIRC.

When we ported Cygwin to x86_64, we got "relocation truncated to fit"
when we decided to move the address space used by Cygwin on 64 bit
beyond the 2 Gigs border.  Gcc and binutils got tweaked specificially to
allow Cygwin to use the full address space as desired.  But the PTHREAD
macros never triggered this problem before, which is puzzeling.


Corinna
