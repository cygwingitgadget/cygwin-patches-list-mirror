Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 00A39385481D; Mon, 30 Jun 2025 10:24:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 00A39385481D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751279060;
	bh=6OOhEa67HYGXtAqjZYN3u5rcDLV11acgu9bPNS6BijM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cMT59rVtkhxRiHY1W0CwepqjkznstmOriQvSFJNnVN82DuQa4PufrhWNOLOfEFiu3
	 UDVpSQkTlZgRC6+C8pmZm3u47GjDi/Eg/tq130/V7xIu5zyB/l97wrFzh6qxAemlPL
	 ZBTypLUdRvEyH5AGgcvREi9NZoXrT7CPn9g1KyOI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DB64FA80B7A; Mon, 30 Jun 2025 12:24:17 +0200 (CEST)
Date: Mon, 30 Jun 2025 12:24:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGJl0crH02tjTIZs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com>
 <aF6N5Ds7jmadgewV@calimero.vinschen.de>
 <7b118296-1d56-0b42-3557-992338335189@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b118296-1d56-0b42-3557-992338335189@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 11:44, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 26 16:59, Jeremy Drake via Cygwin-patches wrote:
> > > Currently just file actions open/close/dup2 are supported in the fast
> > > path.
> >
> > I'm wondering about that a bit, see below.
> >
> > Also, ETOOSHORTCOMMITMESSAGE
> 
> +1
> 
> > > +	      case __posix_spawn_file_actions_entry::FAE_DUP2:
> > > +		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
> > > +		  goto closes;
> >
> > Hmmmm.  So we only may dup2/open/close stdin/out/err?  That's not
> > exactly what POSIX requires.
> 
> In this fast-path.  Otherwise, it will use the existing fork/exec
> implementation in newlib.  Also, close can work for other fds (by setting
> them to cloexec for the duration).  Note this is done holding
> lock_process, which seems to be the same lock around dtable, so it should
> be safe to temporarily muck about with file descriptors in this way.
> Probably something else that needs a comment ;)

Indeed.  Still, I'm not that happy with this code.  It seems to cater
for native child processes in the first place, but Cygwin children are
more important and the code should not go out of its way to handle
native processes while neglecting cygwin processes.  It should *at
least* already point into the direction the code is going to support
Cygwin children in the first place.  Does that make sense?

> > I understand that this is because CreateProcess or better, Windows, only
> > defines three handles which can be unambiguously connected to descriptor
> > numbers, but theoretically, this restriction should only apply to
> > non-Cygwin executables.
> 
> I was thinking maybe the lpReserved2 for non-Cygwin executables could be
> the MSVCRT file descriptor list that would let other file descriptors be
> passed.

Sounds like a good idea.

> But that's above and beyond what I was hoping to accomplish with
> this patch.

What exactly were you trying to accomplish with this patch?

> > Actually, I think this code path should really only be used with
> > non-native executables.  With Cygwin executables, all the actions should
> > be performed in the child process.  This is basically a job for
> > child_info_spawn::handle_spawn() in dcrt0.cc.
> 
> Possibly.  My thought process was to implement what could be done reliably
> for all executables in a 'fast-path' and leave the more complicated cases
> to the existing fork/exec case where the actions would be performed in the
> child.
> 
> To do the actions in the child with a spawn rather than a fork/exec, it
> might be able to use cmalloc instead of malloc for allocating the file
> actions (and spawnattrs?) and passing the pointers in the child info.
> Then the child could do the same processing of actions as are done
> post-fork in the newlib code.

Sounds like a good idea to me.

> I don't know how this would coordinate with
> the newlib code (if it would require moving all of that into cygwin
> proper),

We're already hooking into the newlib posix_spawn, we can probably
continue to do so.

> and the case of dup2ing cloexec fds would need to be dealt with.
> That's beyond the scope of what I was trying to accomplish here, but seems
> like another good optimization that could be done.

Yeah.  I don't have problems to use the fork/exec fallback for stuff
which just isn't implemented yet.  I'm just reluctant if the code
implements only the border case for native children.

> > With only one exception: if the executable path is relative, create an
> > absolute path by emulating (but not actually executing) the chdir/fchdir
> > calls inside the file_action object.
> 
> Are you suggesting the relative executable path case should be handled in
> do_posix_spawn rather than in child_info_spawn::worker?

No, that's irrelvant at this point.  I'm just saying that albeit the
file actions itself should be executed in the child, the parent still
has to evaluate the absolute executable path for CreateProcess from the
file actions.

I was vaguely thinking of a function iterating through the file actions,
checking the (f)chdir actions and creating the child's eventual CWD
without touching the parents cygheap->cwd.

find_exec etc. will have to use that cwd rather than the parents cwd to
find the executable actions have to generate the executable path
relative to that dir.


Thanks,
Corinna
