Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AFF28385B516; Thu, 24 Jul 2025 18:17:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AFF28385B516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753381043;
	bh=Wv6skHUZ7HiLQaoJISWxZp9sOWblNKq5T7uoLvBm3sM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=yV22qbdIbfshTtRGzCT8VAtM9G0Qfviu2OLIDhvy0JotPxyBiBbvrq0abhm1myYhw
	 dDi5xcd3SyxhvCIOGbSeJXxcJvmmelPidXi5pgekOi4DufoCAhRaF2enj5Ru1//+TN
	 gyIYwUGeZi69vOMOhvTw5b6ElcNvFQZ2Qw3n/yFI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E9107A80BF6; Thu, 24 Jul 2025 20:17:21 +0200 (CEST)
Date: Thu, 24 Jul 2025 20:17:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
 <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGulX_0Azb6GI-_C@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 12:45, Corinna Vinschen wrote:
> On Jul  4 15:59, Jeremy Drake via Cygwin-patches wrote:
> > On Fri, 4 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 4 Jul 2025, Corinna Vinschen wrote:
> > > > I see what you mean.  The question of questions is if "as if" only
> > > > covers the "performed exactly once" requirement, or if the "as if"
> > > > really encompasses all three requirements, i.e.
> > > >
> > > > - as if the specified sequence of actions was performed exactly once
> > > >
> > > > - exactly in the context of the spawned process (prior to execution of the new
> > > >   process image)
> > > >
> > > > - exactly in the order in which the actions were added to the object
> > > >
> > > > in contrast to
> > > >
> > > > - as if the specified sequence of actions was performed exactly once
> > > >
> > > > - as if in the context of the spawned process (prior to execution of the new
> > > >   process image)
> > > >
> > > > - as if in the order in which the actions were added to the object
> > > >
> > > > My understanding (as a non-native speaker) is that "as if" only
> > > > covers the "performed exactly once" requirement.  Applying "as if"
> > > > to the order requirement doesn't make much sense to me.  And applying "as if"
> > > > implicitely to the second requirement, but not to the third, doesn't
> > > > make much sense to me either.
> > >
> > > The "as if" performed exactly once doesn't make a whole lot of sense to me
> > > either... To me, the only case where "as if" adds flexibility is the
> > > context of the child process.
> > >
> > > > On top of that you'd have the problem that the man pages of
> > > > osix_spawn_file_actions_addclose and posix_spawn_file_actions_addchdir
> > > > contradict each other.  This, of course, is always possible.  Only an
> > > > RFC to the Austin Group could clarify this.  Maybe we should really do
> > > > that.
> 
> https://austingroupbugs.net/view.php?id=1935

Good news:

https://www.austingroupbugs.net/view.php?id=1935#c7229

I'm glad I asked.

tl;dr: The Austin Group just changed all the descriptions in terms of
posix_spawn_actions, so that they are to be performed *as if* they
are running in the child preior to calling execve().

This means, we're free to run alkl desired actions in the parent, as
far as that makes sense.

I still think it might make sense to run some of the actions in the
context of the child's child_info_spawn::handle_spawn() processing,
but we can restart discussing this as we go along.


Corinna
