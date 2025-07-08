Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 44437385DC1B; Tue,  8 Jul 2025 07:36:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 44437385DC1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751960172;
	bh=e7TtC0IeJADLEKwIDRNo4zXubneG53DKPrXIWxzrH58=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lDmLquTXcMqRz4uDraGW5BYrTwUpivK5JEQLuiaDqVA9m4XAcu4w9lfqRcQVqDC1/
	 bViKb4zWCQoWhzLvc/zvVW2nL8+tNtDDMszx/oLnpuaFBauTRErD83yTqzA6mJvm4+
	 uFLASgd5coFgqEWhuWcMSXd96ZUW4+RlEu/3/+QU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2EBEBA809E4; Tue, 08 Jul 2025 09:36:10 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:36:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGzKagD6NIvkD-3f@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
 <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de>
 <51a8dd9a-2cc4-39cd-d026-2b4b3920bfb1@jdrake.com>
 <aGwm9dRIeb_s9NAL@calimero.vinschen.de>
 <25bf8e00-b42d-1d9e-4a1d-eff357795b76@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25bf8e00-b42d-1d9e-4a1d-eff357795b76@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 13:15, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 7 Jul 2025, Corinna Vinschen wrote:
> 
> > On Jul  7 12:16, Jeremy Drake via Cygwin-patches wrote:
> > > On Mon, 7 Jul 2025, Corinna Vinschen wrote:
> > > > All good points.  We should actually see what the Austin Group comes up
> > > > with and then we can reconsider.  In the meantime we stick to your current
> > > > implementation.  Would you mind to push it on top of main into a new
> > > > topic branch, i.e., something like
> > > >
> > > >   git checkout -b topic/posix_spawn main
> > > >
> > > > and push it?  If you're not aware of this, the "topic/" prefix is
> > > > required to allow force pushing to the branch.  It's some kind of
> > > > safety net from the gerrit macros activated for a couple of projects
> > > > on sware.
> > >
> > > Done.
> > > https://www.cygwin.com/cgit/newlib-cygwin/log/?h=topic%2Fposix_spawn
> > >
> > > This also includes the patch I recently sent, because I had done half of
> > > that while adding pgroup support.
> >
> > Looks good.  However, shouldn't the hunk adding InterlockedCompareExchange
> > setting the pgid go into its own patch?  That looks more like a bugfix
> > to me...
> 
> I don't think it's a bugfix - previously, this was where the pgid was
> initialized and it was done unconditionally.  Now that I want to set the
> pgid in child_info_spawn::worker, this needs to not overwrite that
> already-set pgid.  (This does not fix the issue where I see a pgid of 0 in
> a spawned process sometimes instead of what it should have inherited from
> the parent, which I assume is a race between the child running and the
> parent finishing up this initialization).

Ok, thanks for the explanation.

Corinna
