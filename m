Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5D2263852103; Thu,  3 Jul 2025 15:11:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D2263852103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751555497;
	bh=eD1sMC4Wq0dkaV/rrAFNsHCq/uEhDjJVIUaGBZtmKzQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rpDXgH3TdXHjcBRAoR3mZSMVCEvr6K9fEeQg1PNrgV2Jgcc5ZN7r2G9WE1cdGYBoZ
	 WP6XtCVSAbsQ9236Xjxut0Tlv2y0hau8sCbpzuwUDT8bk9AKWbnA1gFA69ZKKrgUA0
	 imkhOGpAzOzTuC0VifCg4uOkPNb3wm5LPfYcRvYI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0B8BDA80961; Thu, 03 Jul 2025 17:11:35 +0200 (CEST)
Date: Thu, 3 Jul 2025 17:11:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/6] Cygwin: add ability to pass cwd to child process
Message-ID: <aGadp0iVfBrEKG9G@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <66a1dec3-77a2-6c9f-0388-da2f85489e89@jdrake.com>
 <aGUketWC7RES61Nx@calimero.vinschen.de>
 <fb1daa1c-9201-c245-8caf-a1d2d8d93643@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb1daa1c-9201-c245-8caf-a1d2d8d93643@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  2 10:55, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 2 Jul 2025, Corinna Vinschen wrote:
> > Weeeeell, as discussed in the other thread, and on second thought, maybe
> > this is the right spot to handle all the posix_spawn stuff.
> >
> > But then, it should be in it's own function.  And you don't need
> > moreinfo->cwdfd, because the entire set of actions requested by the
> > posix_spawn caller should run one at a time in that function, so
> > multiple chdir and fchdir actions may be required.
> >
> > I would also suggest to pimp cwdstuff::init() by adding an argument
> > which allows to say
> 
> ... ?

Nothing to worry about.  This one was a thought I had before inspecting
the code in dll_crt0_1 and cwdstuff::init().  I just forgot to remove
it, sorry.

> > Eventually, this code snippet in dll_crt0_1 should probably look like
> > this:
> >
> >   cygheap->cwd.init ();
> >   if (posix_spawn_actions_present)
> >     posix_spawn_run_child_actions (...);
> >
> > Regardless if posix_spawn chdir/fchdir file actions are present or not,
> > in the first place the cwd of the child is the parent's cwd.  The
> > posix_spawn chdir/fchdir file actions run afterwards.
> 
> 
> In https://cygwin.com/pipermail/cygwin-developers/2025-March/012733.html,
> you said
> > For posix_spawn without forking, this complicates matters.  For
> > instance, we don't want having to close FD_CLOEXEC handles in the
> > spawned child because that's a security problem.

I shouldn't blabber so much.

> FD_CLOEXEC sets handles as non-inherited at the Windows level, but for
> posix_spawn_file_actions_addclose is that still a security problem?

Probably not, as far as Cygwin children are concerned.

> Also, it is allowed to posix_spawn_file_actions_adddup2 from a FD_CLOEXEC
> file descriptor, so the parent would have to go through all the file
> actions, work the (f)chdirs to know where to look for relative prog_arg,
> and check adddup2s for FD_CLOEXEC descriptors, set them to not-FD_CLOEXEC
> and record that they were for the child to know to close them (and put
> them back to FL_CLOEXEC after the spawn).  This is already a good part of
> the work being done in the parent in my patch.

I see the problem, but I have no idea how to workaround this problem.
That's what you get for free when doing the fork/exec twist.  I have
to (have time to) think about it.


Corinna
