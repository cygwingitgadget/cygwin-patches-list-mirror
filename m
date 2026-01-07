Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2B7BE4BA2E1F; Wed,  7 Jan 2026 13:51:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B7BE4BA2E1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1767793915;
	bh=fI09rFCWUnOL3jiYw3i/gZfS6FhVIUmhenmUkeLAU54=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=W/s2SiEB48MNy7zJGgqB4hrHHYQ8kgMc/ylGSYC+6tnghCHXokzKNY+BTIvBJKu0c
	 jljVOxo9KybN5jnpXX5QymxOYScJktwzWKl8h+mWymUohsMEpsWxk8KrVOo+Wxk79E
	 XRKy45w/B1CqVVPt29IMAaQeOakDd1p7yFRd3de8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4738AA80797; Wed, 07 Jan 2026 14:51:53 +0100 (CET)
Date: Wed, 7 Jan 2026 14:51:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: _endian.h: Add AArch64 implementations for
 `ntohl` and `ntohs`
Message-ID: <aV5k-SLWTgfx1wVv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	cygwin-patches@cygwin.com
References: <PN3P287MB30775977BEB79B12B2F3BCEE9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
 <aV5A5ENx-xQdpgzR@calimero.vinschen.de>
 <2b722c24-9ba6-42d7-b353-cc2294f3f9aa@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b722c24-9ba6-42d7-b353-cc2294f3f9aa@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan  7 12:56, Jon Turney wrote:
> On 07/01/2026 11:17, Corinna Vinschen wrote:
> > Hi Thirumalai,
> > 
> > On Jan  5 12:40, Thirumalai Nagalingam wrote:
> > > Hello Everyone,
> > > 
> > > This patch adds AArch64-specific inline asm implementations of __ntohl()
> > > and __ntohs() in `winsup/cygwin/include/machine/_endian.h`.
> > > 
> > > For AArch64 targets, the patch uses the REV and REV16 instructions
> > > to perform byte swapping, with explicit zero-extension for 16-bit
> > > values to ensure correct register semantics.
> > > 
> > > Comments and reviews are welcome.
> > > 
> > > Thanks & regards
> > > Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com<mailto:thirumalai.nagalingam@multicorewareinc.com>>
> > > 
> > > In-lined patch:
> > > 
> > > diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/include/machine/_endian.h
> > > index dbd4429b8..129cba66b 100644
> > > --- a/winsup/cygwin/include/machine/_endian.h
> > > +++ b/winsup/cygwin/include/machine/_endian.h
> > > @@ -26,16 +26,26 @@ _ELIDABLE_INLINE __uint16_t __ntohs(__uint16_t);
> > >   _ELIDABLE_INLINE __uint32_t
> > >   __ntohl(__uint32_t _x)
> > >   {
> > > +#if defined(__x86_64__)
> > >          __asm__("bswap %0" : "=r" (_x) : "0" (_x));
> > > +#elif defined(__aarch64__)
> > > +       __asm__("rev %w0, %w0" : "=r" (_x) : "0" (_x));
> > > +#endif
> 
> For a bit of future proofing, maybe this should end with
> 
> #else
> #error unknown architecture
> 
> rather than ploughing on to silently return the unmodified x?

You're right, of course.  Thirumalai, if you'd like to add this in
another patch, that would be great.

> (That's probably an observation which applies generally to aarch64 patches
> :))

Indeed.  Most of the patches are adding aarch64 code to places
already guarded against wrong architectures like this, so this is
often not a problem.

To be honest, the real bug here is that we didn't add that #if
defined(__x86_64__) already long ago.

> Also, to be hypercorrect (that is, I do not expect anyone to do anything
> about this): since big-endian ARM is a thing (although not for Windows) is
> there a more tightly scoped define we might use here?

Isn't the aarch64 architecture support on Windows restricted to LE
anyway?


Corinna
