Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A6B313857712; Mon,  7 Jul 2025 19:58:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A6B313857712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751918327;
	bh=TKDUcrfYwaZsH4zx1ooq1xrTkX1EAQ+8t4vxT2PcaqE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BsG76FjqeZqu6m25Jp/Tm4OudAYUpi+Ng6Jj2lB56PaYwnZA1M8IjOl9hY19JW8v3
	 NMq46Zmy6oemOOYzl7Soox1qPuC9ccctZe+DCM1XYh0Deaxzp2SFWcx46gC0eThLJd
	 Z4Z4xK9J3OJeZ8IzfUIGZFL4kJJo7aalHoCtakBw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6BD6DA80D01; Mon, 07 Jul 2025 21:58:45 +0200 (CEST)
Date: Mon, 7 Jul 2025 21:58:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGwm9dRIeb_s9NAL@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
 <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de>
 <51a8dd9a-2cc4-39cd-d026-2b4b3920bfb1@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51a8dd9a-2cc4-39cd-d026-2b4b3920bfb1@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 12:16, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 7 Jul 2025, Corinna Vinschen wrote:
> > All good points.  We should actually see what the Austin Group comes up
> > with and then we can reconsider.  In the meantime we stick to your current
> > implementation.  Would you mind to push it on top of main into a new
> > topic branch, i.e., something like
> >
> >   git checkout -b topic/posix_spawn main
> >
> > and push it?  If you're not aware of this, the "topic/" prefix is
> > required to allow force pushing to the branch.  It's some kind of
> > safety net from the gerrit macros activated for a couple of projects
> > on sware.
> 
> Done.
> https://www.cygwin.com/cgit/newlib-cygwin/log/?h=topic%2Fposix_spawn
> 
> This also includes the patch I recently sent, because I had done half of
> that while adding pgroup support.

Looks good.  However, shouldn't the hunk adding InterlockedCompareExchange
setting the pgid go into its own patch?  That looks more like a bugfix
to me...


Corinna
