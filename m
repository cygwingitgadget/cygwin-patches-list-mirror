Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 105B53858C62; Wed, 12 Jul 2023 11:50:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 105B53858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689162617;
	bh=ho2b5ZawBTzZMSIr5YdmMIRV4AJZ7Bd0Edf8DC4e2vw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=saeYONo06UPCWT3iME0KiV2GliJBNQYyMhMW+yvq1XlSjCfcW5OdFeYUNBQTs6CVU
	 55YIAdE4z8exGQP45f/lmgcZp3a3qSLi/QFWdtnldH06+Iyr6KU/xq7TZ6a1qoLaGw
	 MkvToNZGo596u7AV5PzLSIVX5V4VscS9cnHN36tM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3D7AAA80CDB; Wed, 12 Jul 2023 13:50:15 +0200 (CEST)
Date: Wed, 12 Jul 2023 13:50:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fchmodat/fstatat: fix regression with empty `pathname`
Message-ID: <ZK6Td2TrKNDWZwHp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
 <ZKKo8Ez3nIf7klxz@calimero.vinschen.de>
 <d983003d-b8e6-e312-2197-499cc7f29306@gmx.de>
 <ZKRnIfNCwKhAGi1d@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKRnIfNCwKhAGi1d@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Jul  4 20:38, Corinna Vinschen wrote:
> On Jul  4 17:45, Johannes Schindelin wrote:
> > [...]
> > BTW a colleague and I were wondering whether we really want to set
> > `errno=ENOTDIR` in `gen_full_path_at()` for empty paths when
> > `AT_EMPTY_PATH` is _not_ specified. As far as we can tell, Linux sets
> > `errno=ENOENT` in that instance.
> 
> I wonder if that's really what you mean.  gen_full_path_at() generates
> ENOTDIR in two scenarios:
> 
> - At line 4443, if Cygwin can't resolve dirfd into a valid directory.
> 
> - At line 4450 if ... actually... never.  Given that p is always
>   set to the end of the directory string copied into path_ret, it
>   can never be NULL. Looks like this check for !p is a remnant from
>   the past.  We should remove it.
> 
> The actual check for an empty path is done in line 4457, and this
> results in ENOENT, as desired.
> 
> So, by any chance, do you mean the situation handled in line 4443,
> that is, returning ENOTDIR if dirfd doesn't resolve to a directory?
> 
> Yeah, it slightly complicates the caller, but it's not exactly
> wrong, given your patch.
> 
> OTOH, this entire thing doesn't look overly well thought out.  We try
> to generate a full path in gen_full_path_at() and if it fails in
> a certain way and AT_EMPTY_PATH is given, we basically repeat
> trying to create a full path in the caller.  Maybe some
> streamlining would be in order...

I actually found some time, to do that.  So I now have a counter
proposal to your patch.  I'll send the patch series in a minute.  Would
you mind to take a discerning look and, perhaps, give it a try, too?


Thanks,
Corinna
