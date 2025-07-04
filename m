Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F3BB63851A9E; Fri,  4 Jul 2025 07:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F3BB63851A9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751615452;
	bh=wbg7DNJcccNScHe+KZbMBYXPlsOS+PXVhRyhhGppj44=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=SM/ixAlh+H1xTG1js+FKj+Sc6l1Secqx55kCo26SfhFppcrebj2P0rmcozzK44h4Q
	 ycIXUbe/WkSFTlxnJLzTBxBT9m994D2TD6k0qOU3HKOWNneSGjw0VtBHAY6pqYFYtq
	 k0IeqyChfrS3kz5i6QF2lcK8XyjCm9+TEwFKbdig=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D3E49A80858; Fri, 04 Jul 2025 09:50:49 +0200 (CEST)
Date: Fri, 4 Jul 2025 09:50:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to spawn
Message-ID: <aGeH2YwTlYqps1wq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com>
 <aF6OibgUJ3IUvmLN@calimero.vinschen.de>
 <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com>
 <aGJeJH1rLCeitrqo@calimero.vinschen.de>
 <8d3b0ebf-4766-cf94-13c0-8176a8ac3da7@jdrake.com>
 <aGUMafwtImU7wGrZ@calimero.vinschen.de>
 <1fd4e2b5-bbcc-4f5f-0085-c3138bdc914c@jdrake.com>
 <aGaIblK4MDa0AHPq@calimero.vinschen.de>
 <6ff55395-7a18-0995-7b16-7bf2e7655370@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ff55395-7a18-0995-7b16-7bf2e7655370@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  3 11:06, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 3 Jul 2025, Corinna Vinschen wrote:
> 
> > On Jul  2 10:37, Jeremy Drake via Cygwin-patches wrote:
> > > On Wed, 2 Jul 2025, Corinna Vinschen wrote:
> > >
> > > > On Jun 30 10:11, Jeremy Drake via Cygwin-patches wrote:
> > > > > On Mon, 30 Jun 2025, Corinna Vinschen wrote:
> > > > >
> > > > > > On Jun 27 10:34, Jeremy Drake via Cygwin-patches wrote:
> > > > > > > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> > > > > > >
> > > > > > > > On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > > > > > > > > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > > > > > > > > -Wl,--disable-high-entropy-va in LDFLAGS?
> > > > > > > >
> > > > > > > > Why?
> > > > > > >
> > > > > > > With high-entropy-va, it has been observed that the PEB, TEB and stack can
> > > > > > > happen to overlap with the cygheap
> > > > > > > https://cygwin.com/pipermail/cygwin/2024-May/256000.html
> > > > > >
> > > > > > Yeah, but HEVA simply breaks fork.  We don't have to test this, because
> > > > > > it won't work and we don't do it.  You can set the PE flag, but than
> > > > > > you're on your own.
> > > > >
> > > > > Outside of fork, is cygheap able to "relocate" in case the memory it would
> > > > > like to occupy is already used?
> > > >
> > > > I don't think so, without checking and, well, fixing every pointer usage
> > > > potentially pointing into the cygheap.  Even fhandlers have pointers to
> > > > fhandlers...
> > > >
> > >
> > > So shouldn't any user of the cygwin dll then need
> > > -Wl,--disable-high-entropy-va to avoid the chance that Windows places its
> > > structures where cygheap wants to be?
> >
> > -Wl,--disable-high-entropy-va isn't required because gcc doesn't enable
> > it by default on Cygwin.
> >
> > If newer versions do, it's a bug in these gcc versions.
> 
> cygload is built in the mingw directory, with the mingw cross toolchain.

D'oh.  You were talking about "any user" of the DLL.  I was only
thinking of Cygwin executables.  Our Makefile for the mingw tools in the
utils subdir already disables HEVA.  If this is missing for cygload,
sure, just go ahead and fix it.

Thanks,
Corinna
