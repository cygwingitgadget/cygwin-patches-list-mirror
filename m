Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 671063858D26; Tue, 25 Feb 2025 11:55:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 671063858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740484522;
	bh=gZZx45Vj5GcDroCdh9t1ERDeZQ3l7YpiU6N7Q0AoaZA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=M8yJFXOnKU3hv4cuV/ztjZi3pVOB6K77J+PIxLpo0IhfmUEE4Yk/JrSCtEAMC6+RC
	 ak2w2H0+BzUEVODKSFIPRqpI3R8+WHTKlIpGDFrh+N3kI3Ylocq8ixJWVlBblgJEqY
	 9jptP3rErw6sC9k6TsgaA6zIX8puCspTHViDvpXQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5A51BA807B4; Tue, 25 Feb 2025 12:55:20 +0100 (CET)
Date: Tue, 25 Feb 2025 12:55:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add spawn family of functions to docs
Message-ID: <Z72vqPAfwbpvLzpW@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250216214657.2303-1-mark@maxrnd.com>
 <Z7MNyLzVvY_Mm_bH@calimero.vinschen.de>
 <Z7xe2UNaIBB3UFXu@calimero.vinschen.de>
 <68dc561f-5a1e-420e-a667-e97a1947dbdb@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68dc561f-5a1e-420e-a667-e97a1947dbdb@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 24 17:51, Mark Geisert wrote:
> Hi Corinna,
> 
> On 2/24/2025 3:58 AM, Corinna Vinschen wrote:
> > On Feb 17 11:22, Corinna Vinschen wrote:
> > > On Feb 16 13:46, Mark Geisert wrote:
> > > > In the doc tree, change the title of section "Other UNIX system
> > > > interfaces..." to "Other system interfaces...".  Add the spawn family of
> > > > functions noting their origin as Windows.
> [...]
> > 
> > Actually, Jon raised some reservations against adding historical
> > msvcrt functions to the set of documented POSIX functions on the
> > IRC channel.
> > 
> > We also have functions like _get_osfhandle and stuff like that.
> > Do we really want them documented in the list of POSIXy functions?
> 
> I didn't see Jon's comments unless the "1999" reference covered them ;-).
> 
> I have no issue with the Windows-derived functions going on a separate list.
> I only suggested the UNIX-* list because of the small number of
> Windows-derived functions being added.
> 
> BTW The MSDN documentation of the spawn family of functions has their names
> all starting with an underscore character.  Should we follow that or not?

We don't export them with underscore.

> On the question of documenting these funcs at all (was that being raised?),
> I don't feel very strongly about it.  Maybe it would save one out of ten
> posts asking why our POSIX environment doesn't do this Windows thing?  /s

Yeah, good point.

> If the final decision is to document in a separate list for the doc pages, I
> can submit a revised patch for that.

We could add a "Non-POSIX, non-UNIX Windowy functions added for one
reason or another" kind of section to the end, I guess.  Even the
section name isn't quite clear to me.  It's kind of "Cygwin-only",
and that would then also include the stuff from sys/cygwin.h, i.e.
cygwin_conv_path, cygwin_internal, ...


Corinna
