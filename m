Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1B8333858D21; Mon, 17 Mar 2025 18:57:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B8333858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742237851;
	bh=FUNgfJoHxkLjwRgyAX3J8HASyQhZ7nFavhrmsAoQ6k4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IpSWHOqQaC6O/Z0voDXSIiy379NiKdjdAtYD/KpDLcDC04/R9gFNIY9n5xJGOOUOT
	 coGORUcivsLEUdKpi+TiO7SRqBMTYjPMigS7tFjaPpjVRmWXDw8jy9ZdClDHEcg6FB
	 fu9GpkgvXIlRD3ixfIqU4aJGgQjvKuaO/Gmuh5VU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6544EA8077E; Mon, 17 Mar 2025 19:57:28 +0100 (CET)
Date: Mon, 17 Mar 2025 19:57:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0
Message-ID: <Z9hwmMDsTXgBpeLZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev>
 <Z886PJK2OMtcUwEC@calimero.vinschen.de>
 <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev>
 <Z9AT-rlIU0StWEzQ@calimero.vinschen.de>
 <4dd8a82a-d345-5339-5a90-7d5e72b65454@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dd8a82a-d345-5339-5a90-7d5e72b65454@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 17 11:15, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 11 Mar 2025, Corinna Vinschen wrote:
> 
> > Hi Chris,
> >
> > This was a bit of a puzzler for me, given we added the PC_SYM_NOFOLLOW_REP
> > only 2011 with commit be371651146c ("* path.cc (path_conv::check): Don't
> > follow reparse point symlinks if PC_SYM_NOFOLLOW_REP flag is set.")
> >
> > I think we should use this patch for the "Fixes:" info.
> >
> > > Signed-off-by: SquallATF <squallatf@gmail.com>
> >
> > Hmm, on second thought, we can't do that.
> >
> > Given you provide your own version of this patch, and given that this is
> > a trivial patch, I would prefer your personal Signed-off-by.
> >
> > If you just agree here on the list, I will do the above changes manually.
> > No reason to send another patch version.
> >
> > Ok?
> 
> 
> Ping?

Ping who?  I for one am still waiting for Chris' ok.


Corinna
