Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C179A3852134; Mon, 30 Jun 2025 09:51:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C179A3852134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751277094;
	bh=zRXcDnj98atVxyVQx4HOcTQg68eqF5vh70683N1kDck=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ciUZwApgw6hRyPJX58lATYk91jDTBS6oA8yQIAu6UgmXWzinlFtKjYCyvNGlwTig3
	 VFCfWkFOeQofWyGg4mEcawXsvpBOFEDrtYq5oy0/PH0r28igW9ZrYo86zApdX8myaF
	 +CLlTeOjcHYESLn2bcFcH7Q5AuYMGUD/QXvlrKBo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 96840A80897; Mon, 30 Jun 2025 11:51:32 +0200 (CEST)
Date: Mon, 30 Jun 2025 11:51:32 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to spawn
Message-ID: <aGJeJH1rLCeitrqo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com>
 <aF6OibgUJ3IUvmLN@calimero.vinschen.de>
 <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 10:34, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > > -Wl,--disable-high-entropy-va in LDFLAGS?
> >
> > Why?
> 
> With high-entropy-va, it has been observed that the PEB, TEB and stack can
> happen to overlap with the cygheap
> https://cygwin.com/pipermail/cygwin/2024-May/256000.html

Yeah, but HEVA simply breaks fork.  We don't have to test this, because
it won't work and we don't do it.  You can set the PE flag, but than
you're on your own.


Corinna
