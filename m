Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EAAFE385783B; Mon, 13 Jan 2025 12:38:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EAAFE385783B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736771928;
	bh=iZcAtrO1zFORnYR4xn1wPMQoXQzCjS5YHj++ufVEYws=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fOFuKHF2PuzwJGDZu/mwTgmlXKV6CoTK9blSiGBpqyG7rg+6z3bn7RiNg4L/Q1kZ9
	 8LUCY9OXQcbsfWOhaJu8yJ3dmnrxCYjobmMNj4dI6UqPKnl+GpPwCBdh+I0cak+P67
	 Tv934y+J0O9UKYHFDHj0vJMjoty5KY66v+xtaVhc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5A150A80A67; Mon, 13 Jan 2025 13:38:47 +0100 (CET)
Date: Mon, 13 Jan 2025 13:38:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
Message-ID: <Z4UJVxBngAvsxXwX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
 <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 12 12:56, Brian Inglis wrote:
> On 2025-01-12 10:58, Jon Turney wrote:
> > On 11/01/2025 00:01, Brian Inglis wrote:
> > > Add POSIX new additions available with din entries
> > > or interfaces in headers and packages.
> > 
> > What does 'din' mean in this context?
> 
> POSIX entries which exist as exported symbols in cygwin.din but not
> mentioned elsewhere in posix.xml, so supported but not yet documented as any
> Unix interface.
> 
> Suggestions for better phrasings of these welcome.

"Add POSIX new additions available as symbols exported from the Cygwin
 DLL, as header macros and inline functions, or exported from external
 Cygwin distro libs."

> posix_getdents:		nothing appropriate.
> timespec_get:		nothing appropriate.
> 
> Also is anyone aware of a good html to man page converter to generate Cygwin
> or POSIX man pages from HTML sources available, and are cpp-reference GPL-3
> allowed, or should we prefix the function source with the man doc and
> generate it in newlib?

What man pages are you looking for?  We have the man-pages-posix package
and we only have it because we have the official permission to do so.
Keep in mind that all man pages not part of the newlib-cygwin dir are
potentially copyrighted.

> Looks like getlocalename_l doc needs updated to POSIX.1-2024, added to
> locale/Makefile.inc LIBC_CHEWOUT_FILES

Thanks, done.

> and locale.h feature test to
> 202405L?

That's already fixed since ca31784fef301 ("Fix POSIX guards for
POSIX.1-2024 extensions")

> Could CHEW doc be added to cygwin/**/*.cc or elsewhere?

Elsewhere, yes.  Inline might be a problem.  Newlib has only very few
exported symbols per file, so a single file usually matches with a
single doc.  I don't want to imagine adding docs inline to syscalls.cc :}


Thanks,
Corinna
