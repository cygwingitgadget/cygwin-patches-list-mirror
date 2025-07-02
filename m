Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4EAE2385EC0F; Wed,  2 Jul 2025 12:01:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4EAE2385EC0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751457705;
	bh=yKyKQ4J7la7hijW5JbDtbhYms03urfGyhuey1oQ735o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iuM1ltVikwr9w9lTZPU7Q0P96dPXgjLqwX2vOypJwgb9rQj01CG4ThG2c8CPwmLar
	 Ow3RYnv65QQPZ01IJiSffw/nLcs+ClXnQr6Sj1K1BGHl0VY8JaQLtk3rmFJUP/1zCC
	 Q+7UykQkk8jcar+tTwig6pfEvcB+t44TNbv7LW6M=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 329F8A80CFD; Wed, 02 Jul 2025 14:01:43 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:01:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGUfpy6cTysuyaId@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com>
 <aF6N5Ds7jmadgewV@calimero.vinschen.de>
 <7b118296-1d56-0b42-3557-992338335189@jdrake.com>
 <aGJl0crH02tjTIZs@calimero.vinschen.de>
 <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 30 11:57, Jeremy Drake via Cygwin-patches wrote:
> (I kind of cut up bits of quoting to try to address my
> thoughts/motivations better)
> 
> On Mon, 30 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 27 11:44, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> > >
> > > > Hmmmm.  So we only may dup2/open/close stdin/out/err?  That's not
> > > > exactly what POSIX requires.
> > >
> > > In this fast-path.  Otherwise, it will use the existing fork/exec
> > > implementation in newlib.  Also, close can work for other fds (by setting
> > > them to cloexec for the duration).  Note this is done holding
> > > lock_process, which seems to be the same lock around dtable, so it should
> > > be safe to temporarily muck about with file descriptors in this way.
> > > Probably something else that needs a comment ;)
> >
> > Indeed.  Still, I'm not that happy with this code.  It seems to cater
> > for native child processes in the first place, but Cygwin children are
> > more important and the code should not go out of its way to handle
> > native processes while neglecting cygwin processes.  It should *at
> > least* already point into the direction the code is going to support
> > Cygwin children in the first place.  Does that make sense?
> 
> > Yeah.  I don't have problems to use the fork/exec fallback for stuff
> > which just isn't implemented yet.  I'm just reluctant if the code
> > implements only the border case for native children.
> 
> > What exactly were you trying to accomplish with this patch?
> 
> My original idea was to implement the "least common denominator"
> functionality that would apply to all child processes (cygwin and
> non-cygwin).  This also seems to be what most users of posix_spawn use.
> That's mostly redirecting stdin/out/err.  I wasn't particularly interested
> in getting into the startup code for Cygwin processes, but it turned out I
> had to hook up stderr, and then fchdir (because Cygwin processes will
> ignore the Win32 cwd if the cwdstuff is already populated in the cygheap).

That could be easily handled in child_info_spawn::handle_spawn().  It's
called earlier than dll_crt0_1() which calls cwdstuff::init().

One problem is that you dup and open files in the parent, which are 
supposed to be dup'ed and opened in the child.  That's ok for a native
child, because we can't just hook into the native child process as Linux'
clone3 call does.

But generally it's not ok for Cygwin parent and child.  We have methods
in place to communicate to the child what its supposed to do at startup,
so we can do this right with a bit of tweaking, no?

> Looking at what llvm, rust, make, ninja do they don't seem to have file
> actions for non-stdin/out/err, and only use some pretty easily implemented
> parent-side flags (sigmask, sigdef, pgroup).  I imagine the
> scheduler/schedparam are relatively easy too, but I don't think I've seen
> any of those build tools try to use them so I haven't looked into them.

As I said, not implement is ok, the fallback to fork/exec can handle that,
nothing to worry about.

> It kind of sounds like what you are envisioning is pushing this to a lower
> level, potentially even re-architecting child_info_spawn and related
> startup code (I don't know if handle_spawn would necessarily encapsulate
> everything) in terms of posix_spawn's parameters.  I was not looking to
> get that deep into things.

I don't see this as a deeper level.  It's just the child side of the same
mechanism.  You're adding lots of code to make this work, but for Cygwin
processes it's just in the wrong spot.

> I probably won't be able to get back to really working on this for at
> least a week, but I'm hoping to at least get some comments written today.

It's not really pressing, so it might be a good idea to take a step
back and look at it again relaxed.


Thanks,
Corinna
