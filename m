Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3007D3858CDA; Fri,  1 Aug 2025 08:00:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3007D3858CDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1754035236;
	bh=i+89qEmOZlfmDh3MpTiPWyJMl5W0ihD4Ez5bj5MLBM0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OXSKe0cglPUFVmjDa66r6YY1Vr/RgtwZhW3lOefromzQYPeDfOq1WVdAiv8KO5Zfk
	 3ar6vv3GWNpqFbwD8lm+Zn8rt1Hzm1Q+lmdiusZ2od917pY1l8CZ1z+MxU9hTioBnX
	 14z/+ujSQCuwEyrIn6cGZ8NBJUZivPGBACOXlKjw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F3168A805B2; Fri, 01 Aug 2025 10:00:33 +0200 (CEST)
Date: Fri, 1 Aug 2025 10:00:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
Message-ID: <aIx0IV_Nl2DboOTS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
 <aIoOKpzb557bX0cE@calimero.vinschen.de>
 <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com>
 <aItALodM1WC7KP_C@calimero.vinschen.de>
 <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
 <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
 <a5299499-c6ee-598a-dca4-f7a6bbedeb07@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5299499-c6ee-598a-dca4-f7a6bbedeb07@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 31 14:05, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 31 Jul 2025, Corinna Vinschen wrote:
> > libstdc++-6.dll already uses the newer new/delete calls, right?  Looks
> > like this works with old DLLs except overloading the operators will have
> > no result because these operators are unused in libstdc++-6.dll?
> >
> > I do hope I got that right...
> 
> I'm not sure it uses them, but if it does it would not work with
> overloading the operators because they are not wrapped yet.

Yeah, but then, even today.

> > We know that old DLLs don't write a value into __cygwin_user_data.api_major
> > and __cygwin_user_data.api_minor.
> >
> > But what if the new Cygwin DLL does just that?
> >
> > Assuming dll_crt0_0 (definitely called prior to _cygwin_crt0_common)
> > writes the current DLL CYGWIN_VERSION_API_MAJOR and
> > CYGWIN_VERSION_API_MINOR values into __cygwin_user_data.api_major/minor.
> >
> > Then _cygwin_crt0_common could check this before api_major/minor are
> > overwritten with the app version, and then use this info when
> > performing the CONDITIONALLY_OVERRIDEs.
> 
> > +  if (newu)
> > +    new_dll_with_additional_operators = newu->api_major != 0
> > +					|| newu->api_minor != 0;
> > +
> 
> I'm considering 3 cases for _cygwin_crt0_common here, order in which they
> happen
> 1) running from a linked dll's startup (ie, libstdc++-6.dll)
>   newu would contain values initialized from cygwin dll's startup, would
>   write its api versions to static struct per_process in
>   cygwin_attach_dll, OK
> 
> 2) running from exe's startup
>   newu would still contain values initialized from cygwin dll's startup,
>   would write it's api versions to newu due to assignment of u = newu.
>   OK for now
> 
> 3) running from dynamically loaded DLL's startup
>   newu would contain values from exe's startup, not zero, so would always
>   write the new pointers to cxx_malloc, memory corruption.

Ah, ok, but then again, in this case a check against the actual version
instead of checking just against != 0 should do it, shouldn't it?

E.g.

  new_dll_with_additional_operators = newu->api_major != 0
                                      || newu->api_minor >= 359;

That should be rewritten to a version check macro eventually, but
it would disable wrapping the new functions depending on the
executable being too old, even if the just loaded DLL is new enough.
But that should be ok.  Better than crashing methinks.


Corinna
