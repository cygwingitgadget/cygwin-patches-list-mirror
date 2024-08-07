Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1C0163858432; Wed,  7 Aug 2024 14:06:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1C0163858432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1723039594;
	bh=bZ/Dr/19kujHjGlp36Dxqq3t7p2QPorz61EUfn7fYWk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=upnQODuxkysuUJ6HnIBu90U8w+2XrPql1lYegAlSPOlaFUUD5i9iOazisobP6VOpJ
	 AUGFEYNmXHfUq6Q/45b4wVQgAHiFEJ9dQhHLctSKkAlxZTJZrGhyn68sy55wz3N/iR
	 BRheRWT7xXnlYcicBl9l4WAOzOTPVamDVqrXzuPM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3E959A80E94; Wed,  7 Aug 2024 16:06:26 +0200 (CEST)
Date: Wed, 7 Aug 2024 16:06:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/6] Cygwin: Fix warnings about narrowing conversions of
 socket ioctls
Message-ID: <ZrN_YlBeD31PpxN7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-6-jon.turney@dronecode.org.uk>
 <ZrCn00PXmRT77OKj@calimero.vinschen.de>
 <4deb7dbe-1ac0-478c-bd36-76d3937864cc@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4deb7dbe-1ac0-478c-bd36-76d3937864cc@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  6 19:58, Jon Turney wrote:
> On 05/08/2024 11:22, Corinna Vinschen wrote:
> > On Aug  4 22:48, Jon Turney wrote:
> > > Fix gcc 12 warnings about narrowing conversions of socket ioctl constants
> > > when used as case labels, e.g:
> > > [...]
> > The only caller, fhandler_socket::ioctl, passes an unsigned int
> > value to get_ifconf. Given how the value is defined, it would be
> > more straightforward to convert get_ifconf to
> > 
> >    get_ifconf (struct ifconf *ifc, unsigned int what);
> > 
> > wouldn't it?
> 
> Yeah, I'm not sure why I didn't do that.  I think I got confused about where
> this is used from.
> 
> (These constants are long int though, for whatever reason, so it's not

This is really old stuff.  The _IO definitions have been taken from BSD
in some year with a 19 in front and never changed again.  The fact that
the sizeof() gets cast to long is probably a remnant from the past when
the stuff was supposed to be used on 16 bit machines, but the value was
supposed to be 32 bit.

Given that the values are not supposed to be ever bigger than 32 bit,
we should fix the definitions of _IOR/_IOW, dropping the (long) cast.
Compare with current FreeBSD, which does not cast at all.

I did a quick check that dropping the cast does not change the value
of any of the dependent definitions in Cygwin headers.  That shouldn't
happen anyway, given sizeof() returns a size_t, i. e. 64 bit unsigned.

> immediately obvious that they all can be converted to unsigned int without
> loss, but it seems they can)
> 
> Revised patch attached.

LGTM.  I will additionally push a patch dropping the useless casts.


Thanks,
Corinna
