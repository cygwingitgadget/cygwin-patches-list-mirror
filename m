Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 426303851A9E; Fri,  4 Jul 2025 08:26:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 426303851A9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751617589;
	bh=iGehrM10kYWzeLIoKPb3oxs9y9VovraWMaRDWHp2Sxg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=C95Pdqd5v8AxZIq0W7/ttfMz1n8hoX1vBeEgCLz31iFnaBm7/OznckUUJ5LT1G27/
	 TzQv7+g++bg3J0natPZ2v1zHd3xmms01zeAs1erdWzJQJbAuUmBI6UVf1MBF+8CYhc
	 MFDhQ54ceLmALpKHLIlvRMATLYd40GcNBbtj9LUU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 025A8A80858; Fri, 04 Jul 2025 10:26:27 +0200 (CEST)
Date: Fri, 4 Jul 2025 10:26:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGeQMtwhTueOa4MT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com>
 <aF6N5Ds7jmadgewV@calimero.vinschen.de>
 <7b118296-1d56-0b42-3557-992338335189@jdrake.com>
 <aGJl0crH02tjTIZs@calimero.vinschen.de>
 <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  3 12:03, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 3 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > On Thu, 3 Jul 2025, Corinna Vinschen wrote:
> > > From the POSIX man page of posix_spawn_file_actions_addchdir:
> > >
> > > APPLICATION USAGE
> > >
> > >   [...] all file actions are processed in sequence in the context of the
> > >   child at a point where the child process is still single-threaded
> > >
> > >   [...]
> > >
> > >   File actions are performed in a new process created by posix_spawn()
> > >   or posix_spawnp() in the same order that they were added to the file
> > >   actions object.
> >
> > The docs I was reading use "as if", to allow implementations where the
> > actions are not actually processed in the child.
> >
> > https://pubs.opengroup.org/onlinepubs/9799919799/functions/posix_spawn_file_actions_addclose.html
> >
> > > A spawn file actions object, when passed to posix_spawn() or
> > > posix_spawnp(), shall specify how the set of open file descriptors in
> > > the calling process is transformed into a set of potentially open file
> > > descriptors for the spawned process. This transformation shall be as if
> > > the specified sequence of actions was performed exactly once, in the
> > > context of the spawned process (prior to execution of the new process
> > > image), in the order in which the actions were added to the object;

I see what you mean.  The question of questions is if "as if" only
covers the "performed exactly once" requirement, or if the "as if"
really encompasses all three requirements, i.e.

- as if the specified sequence of actions was performed exactly once

- exactly in the context of the spawned process (prior to execution of the new
  process image)

- exactly in the order in which the actions were added to the object

in contrast to

- as if the specified sequence of actions was performed exactly once

- as if in the context of the spawned process (prior to execution of the new
  process image)

- as if in the order in which the actions were added to the object

My understanding (as a non-native speaker) is that "as if" only
covers the "performed exactly once" requirement.  Applying "as if"
to the order requirement doesn't make much sense to me.  And applying "as if"
implicitely to the second requirement, but not to the third, doesn't
make much sense to me either.

On top of that you'd have the problem that the man pages of
osix_spawn_file_actions_addclose and posix_spawn_file_actions_addchdir
contradict each other.  This, of course, is always possible.  Only an
RFC to the Austin Group could clarify this.  Maybe we should really do
that.

> > > How do you run, say,
> > >
> > >   addopen (42, "dir", O_SEARCH|O_DIRECTORY)
> > >
> > > without potentially disrupting the actions of another parallel thread,
> > > just reading data from a file attached to fd 42?
> >
> > First, I wouldn't be rushing to optimize the case of file descriptors
> > greater than 2, because I don't see that as a common case.  However, if
> > necessary, I'd do it much the same way as for 0 through 2:
> >
> > hold the lock_process lock
> > perform the open, and assign the returned file descriptor into a mapping
> > of file descriptors for the child.
> > for a Win32 child, implement the lpReserved2 used by msvcrt to specify
> > the fd to handle mapping
> > for a Cygwin child, change the stdin/stdout/stderr child_info_spawn to
> > some mapping structure for move_fd operations to perform in handle_spawn.
> 
> I get the idea that "some mapping structure" in child_info_spawn could
> just be the file actions and attributes from posix_spawn, and instead of
> move_fd process the actions and attributes in handle_spawn.  Why I am
> resisting this is that I don't want to have to do this twice: once in the
> parent as I do now, which must continue to exist for win32 processes AND
> to find the directory to which a relative program path is relative; and do
> it again during Cygwin process startup.  I'm really struggling to see why
> the added complexity of a special path for Cygwin children is necessary
> here.

Yeah, ok, I get that.  I understand that you're frustrated.  Please keep
in mind that, to me, Cygwin processes are the first class citizens,
native processes are second class.  Therefore it would be great to be
able to do it right for Cygwin processes in the first place.

I'm not trying to be unreasonable and inclined to go with your patchset
for a start.  But, to me, considering the Issue 8 descriptions, it
seems we could do more, better for Cygwin processes.

Or maybe not!  But that will probably require more tedious discussions
like this one and throwing ideas back and forth.  It would be a bit
disappointing to be stuck with this and not trying to come up with
funny ideas to workaround obstacles like O_CLOEXEC, POSIX_SPAWN_RESETIDS,
etc.


Corinna
