Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6B3F13857400; Wed, 25 Jun 2025 15:47:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6B3F13857400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750866441;
	bh=eSO6I3xfUKON7UMLaoUpq6rog21aCe7ra8PFCzZ5720=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rJmB7oMkd8OxVALB31Kyt5PmCdL0xzRMqnktiw1f54tmHLREruekvth3v3C2NNoDi
	 P/FTse86dOUVoJJyQofH+c7idv/Zcf5+X1IqIwKWhWRGSAC1CuGFt+fGlqo6ipO93O
	 ZF3mmawBPHDrvzSxP8AM/ztKAi1uBnRZtKDfJcvA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1F70EA80E29; Wed, 25 Jun 2025 17:47:19 +0200 (CEST)
Date: Wed, 25 Jun 2025 17:47:19 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Message-ID: <aFwaB47HM8UDH9CK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
 <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jun 25 16:42, Jon Turney wrote:
> On 25/06/2025 12:39, Corinna Vinschen wrote:
> > On Jun 25 12:15, Jon Turney wrote:
> > > On 25/06/2025 08:47, Corinna Vinschen wrote:
> > > [...]
> > > > > diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> > > > > index 5007a3694..3322810cc 100644
> > > > > --- a/winsup/cygwin/cygwin.sc.in
> > > > > +++ b/winsup/cygwin/cygwin.sc.in
> > > > > @@ -1,6 +1,9 @@
> > > > >    #ifdef __x86_64__
> > > > >    OUTPUT_FORMAT(pei-x86-64)
> > > > >    SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> > > > > +#elif __aarch64__
> > > > > +OUTPUT_FORMAT(pei-aarch64-little)
> > > > > +SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> > > > 
> > > > Given that /usr/lib/w32api is arch independent, maybe we should
> > > > take out that SEARCH_DIR from the arch dependent code, i.e.
> > > > 
> > > > if x86_64
> > > > SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api");
> > > > elif aarch
> > > > SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api");
> > > > else
> > > > error
> > > > endif
> > > > SEARCH_DIR("=/usr/lib/w32api");
> > > > 
> > > > What do you think?
> > > > 
> > > 
> > > Maybe even a pair of comments, to identify that the first search path in the
> > > sys-root when cross-compiling, the second is for when building natively?
> > > 
> > > (I'm guessing that's what's going on?)
> > > 
> > > (Hmm... in which case, couldn't the first one be written as just
> > > "=/lib/w32api"? (since the '=' stands for $SYSROOT?). But maybe there's some
> > > wrinkle which prevents that from working?)
> > 
> > It might work, but it would also enable the /lib/w32api search path
> > on a native install.
> 
> Which is what /usr/lib/w32api is bound to, anyhow, so uh?

So you're trying to tell me we could get rid of the entire thing
and just set a single search path

  SEARCH_DIR("=/lib/w32api");

?

Somebody would have to try that...


Corinna
