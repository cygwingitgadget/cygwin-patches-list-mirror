Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 31C25384A46B; Fri, 17 Jan 2025 11:04:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31C25384A46B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737111858;
	bh=17JTq53/9EZfsQ69k6vD+Vz2c3PeIlW8xoQVCNr7TSs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=DWIrhe0VIgYX+7Yvk00Ec6ud4Hf1V8WeceszsPf3EEJBqzeKduu+7P+aGtMvJLveJ
	 5scYENDD1L77f7SMzbEbudJvwWjHHJDXY+czrUUaEoY3WRViK0NSAyFvkl3dbhEWAV
	 SKZl/QeorxY4LeU5AzoZOLkFDzhK7WrI2tL1oTpg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0EA78A80A5D; Fri, 17 Jan 2025 12:04:16 +0100 (CET)
Date: Fri, 17 Jan 2025 12:04:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
Message-ID: <Z4o5MCHF02UvLM-w@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <8351d131d2aae253f9172f723484f6f6ffa564d9.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4lSkZYfY83rpCCv@calimero.vinschen.de>
 <1b84ba0d-4cdb-4752-886d-2e34a11fd16d@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b84ba0d-4cdb-4752-886d-2e34a11fd16d@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 16 15:18, Brian Inglis wrote:
> On 2025-01-16 11:40, Corinna Vinschen wrote:
> > On Jan 15 12:39, Brian Inglis wrote:
> > > diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> > > index 949333b0c36c..0b23a2251028 100644
> > > --- a/winsup/doc/posix.xml
> > > +++ b/winsup/doc/posix.xml
> > > @@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
> > >   - Issue 8.</para>
> > >   <screen>
> > > +    CMPLX			(available in "complex.h" header)
> > > +    CMPLXF			(available in "complex.h" header)
> > > +    CMPLXL			(available in "complex.h" header)
> 
> Missing from 3.5 - only available with 3.6 - and no docs, info, man.

The patches will go into the main branch only anyway.  There's really
no good reason to mention the headers here.

> > > +    bind_textdomain_codeset	(available in external gettext "libintl" library)
> > > +    bindtextdomain		(available in external gettext "libintl" library)
> > > [...]
> > 
> > Either "gettext" or "libintl", not both.
> 
> Which do you think most useful?

libintl, along the lines of the existing entries

  dbm_clearerr		(available in external "libgdbm" library)
  iconv			(available in external "libiconv" library)
  xdr_array		(available in external "libtirpc" library)

There's a bug in crypt/encrypt/setkey/crypt_r, which should be
changed to

  crypt                 (available in external "libcrypt" library)

I'll fix them separately.

> > > +    getentropy		(Cygwin DLL)
> > > +    getlocalename_l		(Cygwin DLL)
> > > +    in6addr_any		(Cygwin DLL)
> > > +    in6addr_loopback	(Cygwin DLL)
> > > +    posix_getdents		(Cygwin DLL)
> > > +    timespec_get		(Cygwin DLL)
> 
> Lack of docs, info, man - except getentropy_r is in libc/reent/, should be
> included with others from reent.tex, added to CHEW doc, and getentropy
> implementation and doc could be added?

The lack of docs doesn't mean it's necessary to mention in the list of
implemented functions that those are implemented in Cygwin.  This is
implied by them showing up in the list, right?


Corinna
