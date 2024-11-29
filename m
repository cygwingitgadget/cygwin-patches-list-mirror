Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 343253858D26; Fri, 29 Nov 2024 10:24:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 343253858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732875890;
	bh=PUi3motHEE7XeSw4BFZe4KPpcReVw/ampKHyBs3xAlI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=XSBTgvK2xiVHut6LUxIDW4zvPSTLEvGrFZu5Gw+rCru5vDGORR1ppXc4/y1aejbXx
	 fZ7+iLCCOm/0l7bVTDPlpq/RCpt4hAJblZ699mvGVAr0tsNG9Pj7kF2lXI7HJv2FYS
	 EwuMb4LJ51CKJEJti9x/H6TWOQLC2fRA0eOXuqzc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2FB9FA80984; Fri, 29 Nov 2024 11:24:48 +0100 (CET)
Date: Fri, 29 Nov 2024 11:24:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: finding fast_cwd_pointer on ARM64
Message-ID: <Z0mWcOh_WWtGKN1s@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com>
 <Z0XOOW365ff53K6B@calimero.vinschen.de>
 <59f580ca-bded-6d45-c624-fd1ca13bd744@jdrake.com>
 <ec73a729-57e8-11f7-78be-ab78bde6c0a6@jdrake.com>
 <Z0c50yOraHdefcmw@calimero.vinschen.de>
 <ee47c1e8-13c0-73cc-b479-62d20c9874cd@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee47c1e8-13c0-73cc-b479-62d20c9874cd@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 14:04, Jeremy Drake via Cygwin-patches wrote:
> > > > On Tue, 26 Nov 2024, Corinna Vinschen wrote:
> > > >
> > > > > Btw...
> > > > >
> > > > > We're doing this because nobody being able to debug ARM64 assembler came
> > > > > up with a piece of code checking the ntdll assembler code to find the
> > > > > address of the fast_cwd_pointer on ARM64.
> > > > >
> > > > > You seem to have the knowledge and the means to do that, Jeremy.
> > > > >
> > > > > Any fun tracking this down?
> 
> I decided to hack together a bit of an ugly proof-of-concept.  No error
> checking or validating that it's finding the right instructions, but it
> does work for native arm64, x86_64, and i686 on windows 10 22h2 (not
> x86_64 of course) and windows 11 23h2.  It doesn't work on 32-bit arm, but
> I'm sure nobody cares ;)
> 
> https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9

Nice!  If you feel confident to merge something like this into
Cygwin, feel free to send patches.


Thanks,
Corinna
