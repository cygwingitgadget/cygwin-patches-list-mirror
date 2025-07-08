Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BED76385DC0A; Tue,  8 Jul 2025 07:46:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BED76385DC0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751960763;
	bh=ie3BxZ2danfx5YmeneADOvXXYGPvc8WaOXsnhfPX1QU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pdXIWsKbbcSv82SH81B9UBH+6TjIK5Nv1eLTN9fv4z1badVTm/oYdH2DcS3eM4HqZ
	 +76RCZDQt1rgv8t0GBJG7lf5o7gnS604oiPeO4EqEN7URVVufpq8KMg8Vu/tU6v6Ar
	 vcy6ocSeadvjZVYXSSKEObKBaPFmLWJC3IELd5rg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 888FCA809E4; Tue, 08 Jul 2025 09:46:01 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:46:01 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGzMuWoj4Jk6bDxQ@calimero.vinschen.de>
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
 <104e960f-852b-cf0b-76c8-ec950e4cf564@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <104e960f-852b-cf0b-76c8-ec950e4cf564@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 14:43, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 7 Jul 2025, Corinna Vinschen wrote:
> 
> > On Jul  4 15:59, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 4 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > > > On Fri, 4 Jul 2025, Corinna Vinschen wrote:
> > > > > I see what you mean.  The question of questions is if "as if" only
> > > > > covers the "performed exactly once" requirement, or if the "as if"
> > > > > really encompasses all three requirements, i.e.
> > > > >
> > > > > - as if the specified sequence of actions was performed exactly once
> > > > >
> > > > > - exactly in the context of the spawned process (prior to execution of the new
> > > > >   process image)
> > > > >
> > > > > - exactly in the order in which the actions were added to the object
> > > > >
> > > > > in contrast to
> > > > >
> > > > > - as if the specified sequence of actions was performed exactly once
> > > > >
> > > > > - as if in the context of the spawned process (prior to execution of the new
> > > > >   process image)
> > > > >
> > > > > - as if in the order in which the actions were added to the object
> > > > >
> > > > > My understanding (as a non-native speaker) is that "as if" only
> > > > > covers the "performed exactly once" requirement.  Applying "as if"
> > > > > to the order requirement doesn't make much sense to me.  And applying "as if"
> > > > > implicitely to the second requirement, but not to the third, doesn't
> > > > > make much sense to me either.
> > > >
> > > > The "as if" performed exactly once doesn't make a whole lot of sense to me
> > > > either... To me, the only case where "as if" adds flexibility is the
> > > > context of the child process.
> > > >
> > > > > On top of that you'd have the problem that the man pages of
> > > > > osix_spawn_file_actions_addclose and posix_spawn_file_actions_addchdir
> > > > > contradict each other.  This, of course, is always possible.  Only an
> > > > > RFC to the Austin Group could clarify this.  Maybe we should really do
> > > > > that.
> >
> > https://austingroupbugs.net/view.php?id=1935
> 
> I noticed a bit that you quoted that I hadn't noticed before
> additionally, when the new process image is executed, any
>   file descriptor (from this new set) which has its FD_CLOEXEC flag set
>   shall be closed (see posix_spawn()).
> 
> The "from this new set" is not handled properly in my implementation, and
> I'm pretty sure not from the existing newlib implementation: I copied what
> it was doing, which was to clear the FD_SETFD flag after open.  That
> would be wrong, if faced with an addopen with the O_CLOEXEC flag set.
> This is obviously a stupid thing for a caller to do...

the POSIX posix_spawn man page has a 4 steps list how to process
the file actions with step 4: close all FD_CLOEXEC descriptors.

I wonder if that doesn't make some sense, e.g.

  addopen (&fact, 42, "somedir", O_CLOEXEC);
  addfchdir (42);

but then again, you could just add an addclose(42) and you would have the
same effect.

Well, *shrug*, as long as we can do it right.

But yeah, I don't see anywhere in the POSIX docs that the addopen
descriptors have the FD_CLOEXEC flag removed automatically.  They
are supposed to be closed instead, FWIW.

A fix to newlib's posix_spawn might make sense.


Corinna
