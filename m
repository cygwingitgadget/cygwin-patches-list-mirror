Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3C5543857810; Thu,  3 Jul 2025 13:41:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3C5543857810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751550064;
	bh=ELip8F7aClRVvtWxMmz885AJeLFdUcBkrHotkHZGwZE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lqx+GBnl4iCEwTKtucUsm4D+ixIH+oogZcVNsQwSn27XBrZKQN1kaaLOS/R2Clj/M
	 TkTu3848JJCO5nP3LzYAv8JutnteI3ZhYk/t2ZKPgaD4zbslAFuFKzr2ik8x4GuUGZ
	 K0+ZE+k6XZ+PFpHWK2iFhXGrT/Mvuf48ndrsIVGo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1ED44A80CC8; Thu, 03 Jul 2025 15:41:02 +0200 (CEST)
Date: Thu, 3 Jul 2025 15:41:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to spawn
Message-ID: <aGaIblK4MDa0AHPq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com>
 <aF6OibgUJ3IUvmLN@calimero.vinschen.de>
 <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com>
 <aGJeJH1rLCeitrqo@calimero.vinschen.de>
 <8d3b0ebf-4766-cf94-13c0-8176a8ac3da7@jdrake.com>
 <aGUMafwtImU7wGrZ@calimero.vinschen.de>
 <1fd4e2b5-bbcc-4f5f-0085-c3138bdc914c@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fd4e2b5-bbcc-4f5f-0085-c3138bdc914c@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  2 10:37, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 2 Jul 2025, Corinna Vinschen wrote:
> 
> > On Jun 30 10:11, Jeremy Drake via Cygwin-patches wrote:
> > > On Mon, 30 Jun 2025, Corinna Vinschen wrote:
> > >
> > > > On Jun 27 10:34, Jeremy Drake via Cygwin-patches wrote:
> > > > > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> > > > >
> > > > > > On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > > > > > > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > > > > > > -Wl,--disable-high-entropy-va in LDFLAGS?
> > > > > >
> > > > > > Why?
> > > > >
> > > > > With high-entropy-va, it has been observed that the PEB, TEB and stack can
> > > > > happen to overlap with the cygheap
> > > > > https://cygwin.com/pipermail/cygwin/2024-May/256000.html
> > > >
> > > > Yeah, but HEVA simply breaks fork.  We don't have to test this, because
> > > > it won't work and we don't do it.  You can set the PE flag, but than
> > > > you're on your own.
> > >
> > > Outside of fork, is cygheap able to "relocate" in case the memory it would
> > > like to occupy is already used?
> >
> > I don't think so, without checking and, well, fixing every pointer usage
> > potentially pointing into the cygheap.  Even fhandlers have pointers to
> > fhandlers...
> >
> 
> So shouldn't any user of the cygwin dll then need
> -Wl,--disable-high-entropy-va to avoid the chance that Windows places its
> structures where cygheap wants to be?

-Wl,--disable-high-entropy-va isn't required because gcc doesn't enable
it by default on Cygwin.

If newer versions do, it's a bug in these gcc versions.


Corinna
