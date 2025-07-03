Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1735A3852747; Thu,  3 Jul 2025 14:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1735A3852747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751554478;
	bh=ZMmV8P+KxXNQ4nO1iVLqewkYkeCwQ/+TnOWFWNuDx8s=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=C7R+HSsZW+NEwlOYNxexUeWnrEiSMYfHfhKwNFq4Wc849cmwJ1svFrKz2bbgpeZQ9
	 sFMQulRtPUlXQxfKO5oyVFqpSbptC2ffcPSeXUw15IAKqREnMdd3e3FRy0BS9eEgok
	 meLxDwejG1+RtJi5lLCzX/efRuJomiHND/4dSXNE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CCDE3A80CC8; Thu, 03 Jul 2025 16:54:35 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:54:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGaZq6sSSuNCKX59@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com>
 <aF6N5Ds7jmadgewV@calimero.vinschen.de>
 <7b118296-1d56-0b42-3557-992338335189@jdrake.com>
 <aGJl0crH02tjTIZs@calimero.vinschen.de>
 <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  2 22:51, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 2 Jul 2025, Corinna Vinschen wrote:
> 
> > One problem is that you dup and open files in the parent, which are
> > supposed to be dup'ed and opened in the child.  That's ok for a native
> > child, because we can't just hook into the native child process as Linux'
> > clone3 call does.
> >
> > But generally it's not ok for Cygwin parent and child.  We have methods
> > in place to communicate to the child what its supposed to do at startup,
> > so we can do this right with a bit of tweaking, no?
> >
> > > It kind of sounds like what you are envisioning is pushing this to a lower
> > > level, potentially even re-architecting child_info_spawn and related
> > > startup code (I don't know if handle_spawn would necessarily encapsulate
> > > everything) in terms of posix_spawn's parameters.  I was not looking to
> > > get that deep into things.
> >
> > I don't see this as a deeper level.  It's just the child side of the same
> > mechanism.  You're adding lots of code to make this work, but for Cygwin
> > processes it's just in the wrong spot.
> 
> 
> I was thinking about this further this evening, and I think I found a flaw
> that couldn't be readily solved *without* processing the file actions in
> the parent.  We already know and agree that the parent must process the
> chdir and fchdir actions, in order to properly resolve relative path_args
> (and relative #!s for that matter).  However, fchdir takes a file
> descriptor, and the state of the file descriptors depends on the file
> actions before the fchdir.  Therefore, all file actions prior to an fchdir
> must be processed (or at least considered, probably through multiple
> passes of the singly-linked actions queue) in the parent.
> 
> addopen (42, "dir", O_SEARCH|O_DIRECTORY)
> addfchdir (42)
> addclose (42)
> (therefore addopen needs to be considered)
> 
> fd = open ("dir", O_SEARCH|O_DIRECTORY)
> addclose (fd)
> addfchdir (fd)
> needs to fail with EBADF (therefore addclose needs to be considered.)
> 
> fd = open ("dir", O_SEARCH|O_DIRECTORY)
> fd2 = open ("dir2", O_SEARCH|O_DIRECTORY)
> adddup2 (fd2, fd)
> addfchdir (fd)
> needs to chdir to dir2, not dir (therefore dup2 needs to be considered)
> 
> addchdir ("dir")
> addopen (42, "subdir", O_SEARCH|O_DIRECTORY)
> addfchdir (42)
> addclose (42)
> needs to chdir to dir/subdir (so chdir needs to be considered before open).

I see where you are coming from, but there's a twist.  The file actions
are *supposed* to run in the child.

From the POSIX man page of posix_spawn_file_actions_addchdir:

APPLICATION USAGE

  [...] all file actions are processed in sequence in the context of the
  child at a point where the child process is still single-threaded

  [...]

  File actions are performed in a new process created by posix_spawn()
  or posix_spawnp() in the same order that they were added to the file
  actions object.

On Linux it's dead easy.  Posix_spawn uses clone3 with a function
argument.  It first clones the parent, so we're already in the (shallow)
child and then calls the function given to clone3 in the child before
calling execve.  This function performs all the pre-exec actions.
Naturally we have a problem doing it this way...

But, either way, performing these actions in the parent is a problem,
too.

> What scenario would not work properly if the file actions were not done in
> the child?  The main thing I can think of is opening things under

How do you run, say,

  addopen (42, "dir", O_SEARCH|O_DIRECTORY)

without potentially disrupting the actions of another parallel thread,
just reading data from a file attached to fd 42?

How do you run

  addfchdir (42)

without disrupting another thread trying to open a file with relative
path?

> The main thing I can think of is opening things under
> /proc/self, but that would do the wrong thing anyway even if done in the
> child startup (vs the "proper" behavior in a real fork/exec), if you open
> /proc/self/exe.  There is the RESETIDS flag that could implicate that the
> operations need to happen as a different user, but I was definitely not
> planning to handle that flag and letting fork/exec take care of it.

They already handle setuid() stuff.  RESETIDS is probably not very
tricky, but the simplest way is to call seteuid/setegid in the child.


Corinna
