Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CD599385E007; Wed, 15 Jan 2025 12:18:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD599385E007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736943522;
	bh=CFxghXBLb7pEXSEX8gqs8CksATbpW8o3AtNAODU6s4Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=oekC0XPr3mYrAAzUFS0KbUYZtI5oLuy/0rT1U+3hPdXF8def/wNPHMGPs0K08aAWD
	 K2CTeswy2+IRd2iyZH8DaAzI5SKs5xKlg24+0aJH06mGYAnB9Ohu+4KK7RnMYQgT5p
	 Ycc/nPBKA4k1qDBphv2GQekwMk9KC0Dhf4xqomi8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3F87BA80D2F; Wed, 15 Jan 2025 13:18:40 +0100 (CET)
Date: Wed, 15 Jan 2025 13:18:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
Message-ID: <Z4enoJ8FefxhHtaC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
 <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
 <Z4UJVxBngAvsxXwX@calimero.vinschen.de>
 <4ad1d807-42a9-4506-9588-bc843f655df9@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ad1d807-42a9-4506-9588-bc843f655df9@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 13 11:57, Brian Inglis wrote:
> On 2025-01-13 05:38, Corinna Vinschen wrote:
> > On Jan 12 12:56, Brian Inglis wrote:
> > > Suggestions for better phrasings of these welcome.
> > 
> > "Add POSIX new additions available as symbols exported from the Cygwin
> >   DLL, as header macros and inline functions, or exported from external
> >   Cygwin distro libs."
> 
> Forgot about making distinction between newlib and Cygwin functions:
> 
> Add POSIX new additions available as header macros and inline functions,
> or exported by Cygwin distro DLL or library packages?

Good enough.

> Mark din entries as Cygwin DLL and others as Cygwin PKG...?

Sorry, I don't understand this question.  Can you make a two-line
example what you mean?

> > > in6addr_any:		nothing appropriate.
> > > in6addr_loopback:    nothing appropriate.
> > > posix_getdents:	nothing appropriate.
> > > timespec_get:	nothing appropriate.
> > > 
> > > Also is anyone aware of a good html to man page converter to generate Cygwin
> > > or POSIX man pages from HTML sources available, and are cpp-reference GPL-3
> > > allowed, or should we prefix the function source with the man doc and
> > > generate it in newlib?
> > 
> > What man pages are you looking for?  We have the man-pages-posix package
> > and we only have it because we have the official permission to do so.
> > Keep in mind that all man pages not part of the newlib-cygwin dir are
> > potentially copyrighted.
> 
> Latter four above - Cygwin only: very aware of sources and permissions.

They would have to be provided by the man-pages-posix package at one
point.

> Also aware that Austin Group want to keep nroff sources from being
> distributed

???

I'm not even aware where I could get the original nroff sources from the
Open Group.  Since 2015, we have an official permission from the Open
Group to distribute the POSIX man pages with Cygwin, but for the nroff
sources I was just relying on the Linux version of that package from
https://www.kernel.org/pub/linux/docs/man-pages/man-pages-posix/

Seems like the package has been pulled from Fedora, though.  I'm
sure I installed it once, and the files are still under my
/usr/share/man/man3p directory on my Fedora, but the files are not
owned by any package.  I vaguely remember there was "something"...

> and linux-man maintainer is inactive but participating.

I assume (i.e. hope) he or she will update to 2024 at one point?

Otherwise, yeah, would be great being able to generate man pages
from 

> Only getentropy_r is documented in:
> 
> 	/usr/src/newlib-cygwin/newlib/libc/reent/getentropyr.c
> 
> and it is in CHEW files in:
> 
> 	/usr/src/newlib-cygwin/newlib/libc/reent/Makefile.inc
> 
> but not included in list of functions in:
> 
> 	/usr/src/newlib-cygwin/newlib/libc/reent/reent.tex
> 
> and nor are any of the CHEW outputs in libc.info?

I'm not deep in this documentation creation thingy.  If something's
amiss there, feel free to provide patches.


Corinna
