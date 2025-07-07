Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4AB2D3858D32; Mon,  7 Jul 2025 10:45:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4AB2D3858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751885154;
	bh=+UnhbdsNJpDd8x98WPsAuEFZvKqpf9V9JUvGMkqYKFo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=X4fjEx/ui8FVABey3fNyCMVxBJ0WCHFdA48U7knWizZsebFCSovTAG/T4/PXNxjQ5
	 juxhoxodaod5irXJlDJqzJ10VHhZaCS1Ua84iDiCNtJX9lE3kXs6ecCMlgGHKjMYeS
	 XfxPXzaX6lhumtnP/bV8k8IECqHQyY5DDHoYUILw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F230EA80D01; Mon, 07 Jul 2025 12:45:51 +0200 (CEST)
Date: Mon, 7 Jul 2025 12:45:51 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGulX_0Azb6GI-_C@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <aGJl0crH02tjTIZs@calimero.vinschen.de>
 <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
 <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  4 15:59, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 4 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > On Fri, 4 Jul 2025, Corinna Vinschen wrote:
> > > I see what you mean.  The question of questions is if "as if" only
> > > covers the "performed exactly once" requirement, or if the "as if"
> > > really encompasses all three requirements, i.e.
> > >
> > > - as if the specified sequence of actions was performed exactly once
> > >
> > > - exactly in the context of the spawned process (prior to execution of the new
> > >   process image)
> > >
> > > - exactly in the order in which the actions were added to the object
> > >
> > > in contrast to
> > >
> > > - as if the specified sequence of actions was performed exactly once
> > >
> > > - as if in the context of the spawned process (prior to execution of the new
> > >   process image)
> > >
> > > - as if in the order in which the actions were added to the object
> > >
> > > My understanding (as a non-native speaker) is that "as if" only
> > > covers the "performed exactly once" requirement.  Applying "as if"
> > > to the order requirement doesn't make much sense to me.  And applying "as if"
> > > implicitely to the second requirement, but not to the third, doesn't
> > > make much sense to me either.
> >
> > The "as if" performed exactly once doesn't make a whole lot of sense to me
> > either... To me, the only case where "as if" adds flexibility is the
> > context of the child process.
> >
> > > On top of that you'd have the problem that the man pages of
> > > osix_spawn_file_actions_addclose and posix_spawn_file_actions_addchdir
> > > contradict each other.  This, of course, is always possible.  Only an
> > > RFC to the Austin Group could clarify this.  Maybe we should really do
> > > that.

https://austingroupbugs.net/view.php?id=1935

> > I'm sorry if I'm sounding frustrated.  I am just trying to debate to find
> > the best implementation.  I think that having two versions of processing
> > the file actions is asking for inconsistencies and bugs.  As you point
> > out, non-Cygwin processes are second-class citizens to Cygwin but are more
> > important to MSYS2 and Git for Windows, so I can see bugs in the
> > non-Cygwin case going undiscovered until after a Cygwin release, when
> > MSYS2 and Git for Windows try to integrate it

Maybe I'm just badly uninformed, but wouldn't it make sense to push out
test builds of MSYS2 as well to avoid just that?

> > and exercise the case of a
> > Cygwin GNU make running mingw gcc, or Cygwin bash running mingw git
> > running Cygwin ssh, or any other bizarre combination.
> >
> > I'd be happy to consider a counter implementation.  I think this would
> > have to:
> > 1. exist inside child_info_spawn::worker, because path_conv.iscygexec ()
> > wouldn't be reliable until after av::setup has run and set it based in
> > hook_or_detect_cygwin.
> > 2. process the file actions in the parent to compute the child's cwd, so
> > that a relative program is found relative to the correct cwd.  This has
> > a certain amount of chicken-and-egg because av::setup needs to use this
> > cwd to find relative paths in the #! at least.

Right.  I was wondering if we can't add code which just fakes to run the
directory related file actions to generate an absolute path from there.
It should be possible to come up with a not too big function calling
path_conv() in a loop until all file actions have been scanned.  The
twist is that it would have to assume that all related file actions
succeed.  OTOH, if one of them doesn't succeed, the execve would fail
anyway, isn't it?

> > 3. the malloc/strdup/free in newlib posix_spawn.c needs to be swapped out
> > for cmalloc-based ones so the structures remain available in the child.
> > 4. the posix_spawnattrs_t and posix_spawn_file_actions_t need to be passed
> > to the child (child_info_spawn or the moreinfo member)
> > 5. the process_spawnattr and process_file_actions in newlib posix_spawn.c
> > need to be called from dcrt0.c (probably handle_spawn).
> 
> 6. any existing file descriptors referenced by the file_actions_t (dup2,
> fchdir) need to be made available to the child while they are processed,
> but closed before the child actually runs if they were FD_CLOEXEC.
> 
> Also, I didn't mean to imply that there was any issue with RESETIDS - I
> just didn't feel like it was important to figure out the security
> implications vs just letting fork/exec do its thing.  I'm pretty sure it
> could just deimpersonate & refrain from using CreateProcessAsUserW path.
> I didn't look into it.

All good points.  We should actually see what the Austin Group comes up
with and then we can reconsider.  In the meantime we stick to your current
implementation.  Would you mind to push it on top of main into a new
topic branch, i.e., something like

  git checkout -b topic/posix_spawn main

and push it?  If you're not aware of this, the "topic/" prefix is
required to allow force pushing to the branch.  It's some kind of
safety net from the gerrit macros activated for a couple of projects
on sware.


Thanks,
Corinna
