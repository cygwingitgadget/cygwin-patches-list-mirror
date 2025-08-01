Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3D6773858CDA; Fri,  1 Aug 2025 07:52:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D6773858CDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1754034728;
	bh=ckYtVYTOy2tDUniDC4EYCijo8CSduINq87eQZ2BKaUY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=koRnfSrvTCzJw4SBANrXUHNBZOJCfKNTdKK5tKJPvJCyr4EqYjnQqVMaem5h4nIDO
	 rVqy6EUUR7VnNJ6FV/F77PUtK8M/JOKEJiYtDqIrlZMiilOcoe302Oyl93DS6PtcMo
	 cs/ARyYzg7TvXKwcncmRvfa2F5LkZUqlj+ZxY3VU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6BF5FA805B2; Fri, 01 Aug 2025 09:52:06 +0200 (CEST)
Date: Fri, 1 Aug 2025 09:52:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
Message-ID: <aIxyJhpNdghzzt1w@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
 <aIoOKpzb557bX0cE@calimero.vinschen.de>
 <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com>
 <aItALodM1WC7KP_C@calimero.vinschen.de>
 <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
 <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
 <834bab43-9774-fd9a-2456-ecfa4274777c@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <834bab43-9774-fd9a-2456-ecfa4274777c@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 31 16:57, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 31 Jul 2025, Corinna Vinschen wrote:
> 
> > On Jul 31 12:05, Jeremy Drake via Cygwin-patches wrote:
> > > I noticed that dll_crt0_1 calls check_sanity_and_sync which performs some
> > > checking on the per_process struct from the application, including if the
> > > application's api_major is greater than the dll's.  However, this is after
> > > _cygwin_crt0_common already runs.  I tested by downgrading to
> > > 3.7.0-0.266 and running an executable that I had built with 267 (but not
> > > using the new wrappers).  It didn't crash during startup, but it did seem
> > > to crash after forking (it was doing a posix_spawn).  So maybe the
> > > api_major check could catch this after the fact but before the corruption
> > > caused any more issues.
> >
> > How so?  That would be in the DLL, but you're running an old DLL which
> > you can't change retroactively.  OTOH, _cygwin_crt0_common already
> > overwrites memory.
> 
> Yes, this check happens after _cygwin_crt0_common has overwitten the
> bounds of the __cygwin_cxx_malloc struct, but in my testing this isn't
> immediately fatal, and the api_major check would abend the program with a
> suitable message.  I should test this with MSYS2, to make sure the memory
> layout of the dll isn't different,

The memory layout is fly-by-night.  Different compiler, different
compiler versions, subtil, unrelated changes in the DLL...

> and also because it's easier to get
> older DLL versions (I only tried with the snapshot of 3.7.0 before the new
> wrappers were added, but I can try with 3.6 3.5 3.4 and 3.3 there
> pretty easily).

Doesn't make much sense, IMHO, unless you really love spending time
with testing old versions :)


Corinna
