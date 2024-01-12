Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 796633858D1E; Fri, 12 Jan 2024 16:36:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 796633858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1705077409;
	bh=xIdalirAk0Ew0RWK48x0IWQxYaJjEAlB97+QHaJ4bn0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Qa5nMN1ZW8jydXHxxoWxVTrA5+697+G7gL+KOantgm9EbvgD6u4t8oPhi8LFz6Err
	 UnMomGnHKysdssBoW8uZh2PYFrq//vcwuUw/4g1jhWu3iBvhAiSIiyDH3x9fqItV+W
	 hPnw9wGg0RYJFZQSXlozSKELCVDMFX1wKqDCSwx8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C6FCBA807B2; Fri, 12 Jan 2024 17:36:46 +0100 (CET)
Date: Fri, 12 Jan 2024 17:36:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZaFqnr9n55YHkJ6W@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
 <20240110135705.557-2-jon.turney@dronecode.org.uk>
 <ZZ64BtnmZtmyRZYi@calimero.vinschen.de>
 <b1cbea19-824e-4763-ad69-f634beb0c081@dronecode.org.uk>
 <ZZ-39tW-1UK-69eD@calimero.vinschen.de>
 <78da8311-84d6-452f-a41a-4758e1a1bb3e@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78da8311-84d6-452f-a41a-4758e1a1bb3e@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 12 14:09, Jon Turney wrote:
> On 11/01/2024 09:42, Corinna Vinschen wrote:
> > I see.  It's a bit unfortunate though, if dumper tries to create
> > a 2 Gigs file which is later truncated, if we're low on disk space.
> > But yeah, disk space isn't much of a problem these days, I guess...
> 
> Assuming there isn't a clear specification of which of these is supposed to
> happen, I think removing is the better choice, since partial coredumps are
> just useless.
> 
> (There's still some potential lossage if the coredump is big enough to fill
> the disk, but less than the (perhaps badly-chosen) ulimit.  But maybe that
> could be fixed by having dumper remove the file if it couldn't be written
> successfully))

The Linux kernel actually writes blocks until the next write would
overrun RLIMIT_CORE.  It would be nice if we could get some similar
behaviour, but that's something for post 3.5.


Corinna
