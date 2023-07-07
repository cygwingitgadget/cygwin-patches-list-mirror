Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 40C2438013B0; Fri,  7 Jul 2023 10:46:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 40C2438013B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688726760;
	bh=EwXbcJrQMh7uVs1xNCRqY1JLir9X7VS7bY75PR4su8E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Tn1Kl8WJtgaH9Cz8TUCqWf5nNLCXzmMGCXWqvXpXbzxOD9IeTXGhi55M1rDFf2W5y
	 QdA1FhAx05VD5EKly+s6E11BsDa+a9I0rs8LjECaBxSweXzM2DAf4uk1wvvYHRwNdY
	 RKKMgB5O/wFL42/FBbqsCE47BHUj2b+L5eWKVf3U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 69073A80BDA; Fri,  7 Jul 2023 12:45:58 +0200 (CEST)
Date: Fri, 7 Jul 2023 12:45:58 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
Message-ID: <ZKfs5ivJ94sVv77t@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
 <465f8863-6559-e061-684a-a2a812e9c4c6@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <465f8863-6559-e061-684a-a2a812e9c4c6@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 03:13, Mark Geisert wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> > On Jul  7 00:41, Mark Geisert wrote:
> > > The current version of <sys/cpuset.h> cannot be compiled by Clang due to
> > > the use of __builtin* functions.  Their presence here was a dubious
> > > optimization anyway, so their usage has been converted to standard
> > > library functions.  A popcnt (population count of 1 bits in a word)
> > > function is provided here because there isn't one in the standard library
> > > or elsewhere in the Cygwin DLL.
> > 
> > And clang really doesn't provide it?  That's unfortunate.
> > 
> > Do you really think it's not worth to use it if it's available?
> 
> I don't know for sure.  I'd guess the popcnt op should be optimized if
> available; the others probably don't need it.
> 
> > You could workaround it like this:
> > 
> > > +/* Modern CPUs have popcnt* instructions but the need here is not worth
> > > + * worrying about builtins or inline assembler for different compilers. */
> > > +static inline int
> > > +__maskpopcnt (__cpu_mask mask)
> > > +{
> > #if (__GNUC__ >= 4)
> >       return __builtin_popcountl (mask);
> > #else
> > > +  int res = 0;
> > > +  unsigned long ulmask = (unsigned long) mask;
> > > +
> > > +  while (ulmask != 0)
> > > +    {
> > > +      if (ulmask & 1)
> > > +        ++res;
> > > +      ulmask >>= 1;
> > > +    }
> > > +  return res;
> > #endif
> > > +}
> > > +
> 
> The first version of the patch (unsubmitted) worked something like that,
> though it was a chore figuring out how to tell the difference between gcc
> and clang.  clang #defines __GNUC__ (?!) for example.  I ended up using

Oh well...

> __GNUC_PREREQ__ with the hope clang version numbers stay lower than gcc
> version numbers.  Has to be a better way than that.
> 
> On the other hand, one compilation with clang or clang++, I forget which,
> and with some optimization flag, recognized the 'while' loop in that
> function and turned it into the Hackers Delight algorithm for popcnt in ~20
> instructions and no loop.
> 
> TL;DR let me ponder this over the weekend.
> Thanks for listening,

No worries,
Corinna
