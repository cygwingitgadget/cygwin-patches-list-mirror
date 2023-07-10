Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4808D3858D35; Mon, 10 Jul 2023 08:31:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4808D3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688977876;
	bh=yDeWqLgQS+prXwIKlbQKuUbuerej5QPlA5pJYzJMU3E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=vD+1XlJD2lcKMEm+mdl6NMvryQPVVdsGaAxwoARasmjOqTvvZTF5SNHfv5rzaCF23
	 xn+jgPGeQregYfnay03ntmj4NiVbXCCiFAPQT0o+yOg0o0JUm8J2V3sZTy4z7KskaR
	 UpaZUTJLCMS9167mqw9yJkCYuDdsSV0o293x/hkI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2A290A80CD6; Mon, 10 Jul 2023 10:31:12 +0200 (CEST)
Date: Mon, 10 Jul 2023 10:31:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: stat(): Fix "Bad address" error on stat()
 for /dev/tty.
Message-ID: <ZKvB0EJbsYWUerUb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
 <20230707033458.1034-2-takashi.yano@nifty.ne.jp>
 <ZKfe55PgjTJwWmIQ@calimero.vinschen.de>
 <20230708075911.61d84f6053821845b39d6d34@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708075911.61d84f6053821845b39d6d34@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul  8 07:59, Takashi Yano wrote:
> Hi Corinna,
> 
> On Fri, 7 Jul 2023 11:46:15 +0200
> Corinna Vinschen wrote:
> > On Jul  7 12:34, Takashi Yano wrote:
> > > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > > index 18e0f3097..2aae2fd65 100644
> > > --- a/winsup/cygwin/dtable.cc
> > > +++ b/winsup/cygwin/dtable.cc
> > > @@ -600,7 +600,13 @@ fh_alloc (path_conv& pc)
> > >  	case FH_TTY:
> > >  	  if (!pc.isopen ())
> > >  	    {
> > > -	      fhraw = cnew_no_ctor (fhandler_console, -1);
> > > +	      if (CTTY_IS_VALID (myself->ctty))
> > > +		{
> > > +		  if (iscons_dev (myself->ctty))
> > > +		    fhraw = cnew_no_ctor (fhandler_console, -1);
> > > +		  else
> > > +		    fhraw = cnew_no_ctor (fhandler_pty_slave, -1);
> > > +		}
> > 
> > What happens if CTTY_IS_VALID fails at this point?  There's no
> > `else' catching that situation?
> > 
> > >  	      debug_printf ("not called from open for /dev/tty");
> > >  	    }
> > >  	  else if (!CTTY_IS_VALID (myself->ctty) && last_tty_dev
> 
> That happens when CTTY is not assigned. In that case fhandler_nodevice
> is assigned at:
> https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=18e0f3097823f00ff9651685be06583818eb2140;hb=e38f91d5a96c4554c69c833243e5afec8e3e90eb#l634
> 
> Then fhandler_base::fstat() is called when stat() is called.

Oh, ok.  Sorry, I was a bit puzzled by the missing else.

Please push.


Thanks,
Corinna
