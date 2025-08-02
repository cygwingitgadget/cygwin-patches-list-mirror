Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 336F83858D1E; Sat,  2 Aug 2025 18:14:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 336F83858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1754158445;
	bh=5/Yiu/0P0+8eMkj4Wth7czb6dCJ4DMp5bMudI+tEOq8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=UdANQ/Tq8zopiTy79TnzfHOw99eDJ4/XJGvoUofFQ3kzSZXOQsW4EWnL07yhIGbKx
	 NWn/cC9IGXsy6nUSwb2iHsIvumdP97B4+RUeYKeMb1YL+tCsuq1EdEUVPX3OAU+zce
	 PX8T/x059Tsw0xwcExHT1vwn7zhMeQmMXv2L3iGE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 743B6A80B7A; Sat, 02 Aug 2025 20:14:03 +0200 (CEST)
Date: Sat, 2 Aug 2025 20:14:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add api version check to c++ malloc struct
 override.
Message-ID: <aI5Va0_O8rg0VCbh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com>
 <aI42aRxXOsYFOzpq@calimero.vinschen.de>
 <4f3bd8e1-b32c-9e9e-bc94-5dc0d0bd52a9@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f3bd8e1-b32c-9e9e-bc94-5dc0d0bd52a9@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Aug  2 10:53, Jeremy Drake via Cygwin-patches wrote:
> On Sat, 2 Aug 2025, Corinna Vinschen wrote:
> > There's no good reason that user_data->cxx_malloc points to
> > default_cygwin_cxx_malloc, other than to prime __cygwin_cxx_malloc.
> >
> > And then we could just
> >
> >   newu->cxx_malloc = &__cygwin_cxx_malloc;
> >
> > This survives fork, but not execve.  Do you see any reason
> > that we shouldn't just overwrite user_data->cxx_malloc as above?
> 
> The comments suggest that it used to do that, but a prior bug resulted in
> it being changed to what it is now.  I'd be concerned if the struct is
> expanded again in future that you'd have a hard time telling which version
> of the struct the pointer happens to point to when DLLs built with
> different versions of startup code are loaded in the same process.  I'd
> rather keep it pointing tothe default_cygwin_cxx_malloc struct to be safe.

ACK

> 
> > > diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> > > index 5900e6315d..87f3e8042b 100644
> > > --- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
> > > +++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> > > @@ -124,6 +124,9 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
> > >  {
> > >    per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
> > >    bool uwasnull;
> > > +  bool new_dll_with_additional_operators =
> > > +       newu ? CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS (newu)
> > > +            : false;
> >
> > On second thought, why do we check newu for being not NULL again?
> > I added a comment to lib/_cygwin_crt0_common.cc back in 2009:
> >
> >   newu is the Cygwin DLL's internal per_process and never NULL
> >
> > but never followed up on this.  We can be sure that newu is non-NULL
> > *and* we can be sure that newu->cxx_malloc is non-NULL.  In contrast
> > to u and u->cxx_malloc, but those are never referenced.
> 
> I'll drop those checks.

Thanks,
Corinna
