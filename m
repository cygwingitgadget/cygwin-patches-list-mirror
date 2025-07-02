Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C8679385DDC0; Wed,  2 Jul 2025 10:39:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C8679385DDC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751452779;
	bh=1NvCcde4oYZJ+cvR9yI1BzmLQveIgjaC15A1OQXzGSU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=b8+EOaGVNp0gUpGkHDVR3E6cegUtWGN+KJb2uj0CHAh+LhnpT8+yBNdWvRwP65dmF
	 4l2QgyYgqs9x2q3fTcN75Y9z9FZUvUw20aONNhui77BqulDkSDteD26YRFvpKe/tuy
	 jTQCNehhrlWx86QvNdU+6nUSOVZ+ABuCorY9b2JY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3041BA80A36; Wed, 02 Jul 2025 12:39:37 +0200 (CEST)
Date: Wed, 2 Jul 2025 12:39:37 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to spawn
Message-ID: <aGUMafwtImU7wGrZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com>
 <aF6OibgUJ3IUvmLN@calimero.vinschen.de>
 <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com>
 <aGJeJH1rLCeitrqo@calimero.vinschen.de>
 <8d3b0ebf-4766-cf94-13c0-8176a8ac3da7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d3b0ebf-4766-cf94-13c0-8176a8ac3da7@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 30 10:11, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 30 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 27 10:34, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> > >
> > > > On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > > > > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > > > > -Wl,--disable-high-entropy-va in LDFLAGS?
> > > >
> > > > Why?
> > >
> > > With high-entropy-va, it has been observed that the PEB, TEB and stack can
> > > happen to overlap with the cygheap
> > > https://cygwin.com/pipermail/cygwin/2024-May/256000.html
> >
> > Yeah, but HEVA simply breaks fork.  We don't have to test this, because
> > it won't work and we don't do it.  You can set the PE flag, but than
> > you're on your own.
> 
> Outside of fork, is cygheap able to "relocate" in case the memory it would
> like to occupy is already used?

I don't think so, without checking and, well, fixing every pointer usage
potentially pointing into the cygheap.  Even fhandlers have pointers to
fhandlers...


Corinna

