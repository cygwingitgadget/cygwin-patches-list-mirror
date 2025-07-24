Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 463013858433; Thu, 24 Jul 2025 08:03:12 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 58086A80864; Thu, 24 Jul 2025 10:03:10 +0200 (CEST)
Date: Thu, 24 Jul 2025 10:03:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Message-ID: <aIHovtkfg_7GU9Tz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
 <aIClgpTaJ_6khEmq@calimero.vinschen.de>
 <20250723195536.5783866c1683727f0ca49fb1@nifty.ne.jp>
 <aIDbTUeOEM6kSDUh@calimero.vinschen.de>
 <20250724091016.f04b1709e164619f58b21032@nifty.ne.jp>
 <20250724111733.90d0b036a2113af56199dcf9@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724111733.90d0b036a2113af56199dcf9@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 24 11:17, Takashi Yano wrote:
> On Thu, 24 Jul 2025 09:10:16 +0900
> Takashi Yano wrote:
> > On Wed, 23 Jul 2025 14:53:33 +0200
> > Corinna Vinschen wrote:
> > > No, wait.  build_fh_name() creates a path_conv instance and that in turn
> > > is used to call build_fh_pc().  build_fh_pc() calls fh_alloc() and then
> > > calls fh->set_name (pc) in allmost all scenarios.  This in turn should
> > > copy pc.path_flags, because the underlying path_conv::<< operator is
> > > basically a memcpy().
> > 
> > In the case use_archetype() is true, fh->set_name(pc) does not seem
> > to be called.
> > https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=f1832a1693d45d5fd1e27acb830d5a12a6a34238;hb=HEAD#l683
> https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=f1832a1693d45d5fd1e27acb830d5a12a6a34238;hb=HEAD#l676

Ah, right, thank you.  That's what I missed.  I only saw the
fh->set_name() calls but missed the fact that some of them are not using
the variation taking a path_conv argument.  D'oh.

> So, the following patch also fixes the issue.
> 
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index f1832a169..3b25e9160 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -674,6 +674,7 @@ build_fh_pc (path_conv& pc)
>  		    fh->archetype->get_handle ());
>        if (!fh->get_name ())
>  	fh->set_name (fh->archetype->dev ().name ());
> +      fh->pc.set_isopen ();

I think it's basically the right thing to do, but like this?

         if (pc->isopen())
	   fh->pc.set_isopen ();

?


Thanks,
Corinna
