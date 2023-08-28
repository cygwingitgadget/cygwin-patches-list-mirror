Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 686CD3858D33; Mon, 28 Aug 2023 11:18:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 686CD3858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1693221498;
	bh=Xkvts8lhtzTFFCOK5BwLCrRCeVkbsfq6CZ042iVup00=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=e4SRvKZVielhEOvqvHwdlerLPwUipub0Ka3oarw0ovcrPuVC6CIKSNjiIMwlZtzF4
	 K6yvAT7NjxxTcEaLKCOw9uVkEy20hbQwLIJ3ICiu4/sXWrBp09iEatekqlhgo++g1a
	 nQpG3BGeGAPLOTO4VCBJOndFQb46u7n22NkWX1+I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 97924A80D4E; Mon, 28 Aug 2023 13:18:16 +0200 (CEST)
Date: Mon, 28 Aug 2023 13:18:16 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: spawn: Fix segfalt when too many command line
 args are specified.
Message-ID: <ZOyCeBEP9MBjosHV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230828094605.2405-1-takashi.yano@nifty.ne.jp>
 <ZOx9j/YRr3UX88wV@calimero.vinschen.de>
 <ZOyAXmWkAH1BBCh2@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOyAXmWkAH1BBCh2@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Aug 28 13:09, Corinna Vinschen wrote:
> On Aug 28 12:57, Corinna Vinschen wrote:
> > On Aug 28 18:46, Takashi Yano wrote:
> > > Previously, the number of command line args was not checked for
> > > cygwin process. Due to this, segmentation fault was caused if too
> > > many command line args are specified.
> > > https://cygwin.com/pipermail/cygwin/2023-August/254333.html
> > > 
> > > Since char *argv[argc + 1] is placed on the stack in dll_crt0_1(),
> > > STATUS_STACK_OVERFLOW occurs if the stack does not have enough
> > > space.
> > > 
> > > With this patch, the total length of the arguments and the size of
> > > argv[] is restricted to 1/4 of total stack size for the process, and
> > > spawnve() returns E2BIG if the size exceeds the limit.
> > > [...]
> > I tried this simple patch:
> > 
> > diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> > index 49b7a44aeb15..961dea4ab993 100644
> > --- a/winsup/cygwin/dcrt0.cc
> > +++ b/winsup/cygwin/dcrt0.cc
> > @@ -978,11 +978,8 @@ dll_crt0_1 (void *)
> >  	 a change to an element of argv[] it does not affect Cygwin's argv.
> >  	 Changing the the contents of what argv[n] points to will still
> >  	 affect Cygwin.  This is similar (but not exactly like) Linux. */
> > -      char *newargv[__argc + 1];
> > -      char **nav = newargv;
> > -      char **oav = __argv;
> > -      while ((*nav++ = *oav++) != NULL)
> > -	continue;
> > +      char **newargv = (char **) malloc ((__argc + 1) * sizeof (char **));
> > +      memcpy (newargv, __argv, (__argc + 1) * sizeof (char **));
> >        /* Handle any signals which may have arrived */
> >        sig_dispatch_pending (false);
> >        _my_tls.call_signal_handler ();
> > 
> > and the testcase `LC_ALL=C sed 's/x/y/' $(seq 1000000)' simply ran
> > as desired.  Combined with a bit of error checking...
> 
> We may also get away with storing it in the Windows heap, but I didn't
> test this .

No, we don't. The Windows heap would not be inherited by a forked
child and argv would be lost.  Sounds not great.


Corinna
