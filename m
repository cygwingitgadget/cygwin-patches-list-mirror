Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 93DCD3858C56; Mon,  4 Mar 2024 10:34:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 93DCD3858C56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709548442;
	bh=+xkZl2iZJPcVL+bwWkt6Gjvyd8ydc/mqHd07LYENmZA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ogUMvTzJ4buscxevs4nVT7k0mOUMwO392Quf6Y/gSppjiaiB6ju8lYLgTVTzzwUTY
	 +12aYn0T80OK5iQsmF/tWBwxPAEw4knfM9jVdJdC8aXHlq3obDngmcYpR8EolBnSDO
	 whetW/d3anXpZNhYBaXig7g5jJoeDn5ZH0+QtjiM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 90D4FA809C6; Mon,  4 Mar 2024 11:34:00 +0100 (CET)
Date: Mon, 4 Mar 2024 11:34:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-ID: <ZeWjmEikjIUushtk@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
 <b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
 <20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
 <87a5nfbnv7.fsf@Gerda.invalid>
 <20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  3 20:36, Takashi Yano wrote:
> On Sun, 03 Mar 2024 11:39:40 +0100
> ASSI wrote:
> > Takashi Yano writes:
> > >> After noticing that we enumerate all the processes (which is an expensive
> > >> operation) just to skip all of the non-Cygwin ones anyway, I wonder if it
> > >> wouldn't be smarter to go through the internal list of cygpids and take it
> > >> from there, skipping the `SystemProcessInformation` calls altogether.
> > >
> > > Yeah, that makes sens. I'll submit v2 patch.
> > 
> > Keep in mind that there may be different independent Cygwin
> > installations running on the same nachine.
> 
> That's possible. But how can we know that is a process in another
> installaion of cygwin?
> 
> If it is difficult, I think it is not so nonsense to treat it as
> same as non-cygwin process.

Right you are.  We always said that independent Cygwin installations
are supposed to *stay* independent.

Keep in mind that they don't share the same shared objects in the native
NT namespace and they don't know of each other.  It's not only the
process table but also in-use FIFO stuff, pty info, etc.


Corinna
