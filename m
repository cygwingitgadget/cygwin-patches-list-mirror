Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 464DA3857C67; Wed, 25 Jun 2025 11:39:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 464DA3857C67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750851586;
	bh=/LWaKXfo+He3CR7ge93Y2U4Uvg00E0MdWHljtGvMVGc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cNcpolGTIDOUoeMNADzcEaO1nwCTmjr9VVQvbDPoCy9ltXBmGXihcZBZdajPOSWg8
	 96Wuv0jC+DVLSuj/kacnaukrD2MTf1YeXQApXfyP3tV8dy+jCQni0U6VrMpZVXVNnv
	 XydyG8+2eoBmAmNosk8do+3J8USWdG3ogGmeLWK4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 22EE1A80E29; Wed, 25 Jun 2025 13:39:44 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:39:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Message-ID: <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jun 25 12:15, Jon Turney wrote:
> On 25/06/2025 08:47, Corinna Vinschen wrote:
> [...]
> > > diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> > > index 5007a3694..3322810cc 100644
> > > --- a/winsup/cygwin/cygwin.sc.in
> > > +++ b/winsup/cygwin/cygwin.sc.in
> > > @@ -1,6 +1,9 @@
> > >   #ifdef __x86_64__
> > >   OUTPUT_FORMAT(pei-x86-64)
> > >   SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> > > +#elif __aarch64__
> > > +OUTPUT_FORMAT(pei-aarch64-little)
> > > +SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> > 
> > Given that /usr/lib/w32api is arch independent, maybe we should
> > take out that SEARCH_DIR from the arch dependent code, i.e.
> > 
> > if x86_64
> > SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api");
> > elif aarch
> > SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api");
> > else
> > error
> > endif
> > SEARCH_DIR("=/usr/lib/w32api");
> > 
> > What do you think?
> > 
> 
> Maybe even a pair of comments, to identify that the first search path in the
> sys-root when cross-compiling, the second is for when building natively?
> 
> (I'm guessing that's what's going on?)
> 
> (Hmm... in which case, couldn't the first one be written as just
> "=/lib/w32api"? (since the '=' stands for $SYSROOT?). But maybe there's some
> wrinkle which prevents that from working?)

It might work, but it would also enable the /lib/w32api search path
on a native install.


Corinna
