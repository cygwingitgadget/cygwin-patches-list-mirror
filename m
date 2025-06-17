Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6BE0F3852FDB; Tue, 17 Jun 2025 09:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6BE0F3852FDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750152172;
	bh=zeU12bMBFzbmCUE1VZHxutQvAGjOTiSGSgsKFaTFLMQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JoQ6MnfBndjPbEPwpz3iXYZS0EzzKA0VB7i0j/fg4Rt1MhTVpIPflEQqtUmpu2C3i
	 0G1JqvoJ9+6DwhvsEBLccuOepBjBxXiLHTdCmhYuhtrgaV17A0BpBHbWza5PxchOUn
	 brLTfUL1SbcCMorPmqxTOSnbfgV1dysUxK1/mwh0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 15E14A80961; Tue, 17 Jun 2025 11:22:50 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:22:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 3/3] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aFEz6oQu8oE3tWFp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com>
 <3baf10c3-c393-1b04-c9d3-651c8eac9d28@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3baf10c3-c393-1b04-c9d3-651c8eac9d28@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On May 30 16:18, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 29 May 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> > +  /* TODO: possibly implement spawnattr flags:
> > +     POSIX_SPAWN_RESETIDS
> > +     POSIX_SPAWN_SETPGROUP
> > +     POSIX_SPAWN_SETSCHEDPARAM
> > +     POSIX_SPAWN_SETSCHEDULER
> > +     POSIX_SPAWN_SETSIGDEF
> > +     POSIX_SPAWN_SETSIGMASK */
> 
> It looks like sigmask is already passed as part of child_info, but I don't
> know if there's a good way to override it other than adding yet another
> parameter to child_info_spawn::worker.  It took me a while to figure out
> where it was getting set at all: child_info_spawn::worker calls the 'set'
> method, which does a placement new over the existing 'this' pointer,
> invoking the constructors.
> 
> 
> > +	      case __posix_spawn_file_actions_entry::FAE_DUP2:
> > +		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
> > +		  goto closes;
> > +		fds[fae->fae_newfildes] = dup (fae->fae_fildes);
> > +		oldflags[fae->fae_newfildes] = fcntl (fae->fae_newfildes,
> > +						      F_GETFD, 0);
> > +		fcntl (fae->fae_newfildes, F_SETFD, FD_CLOEXEC);
> > +		break;
> 
> Minor bug-fix here
> 
> 3:  713b610be3 ! 3:  999681b451 Cygwin: add fast-path for posix_spawn(p)
>     @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
>      +        case __posix_spawn_file_actions_entry::FAE_DUP2:
>      +          if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
>      +            goto closes;
>     -+          fds[fae->fae_newfildes] = dup (fae->fae_fildes);
>     ++          if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
>     ++              fds[fae->fae_fildes] != -1)
>     ++            fds[fae->fae_newfildes] = dup (fds[fae->fae_fildes]);
>     ++          else
>     ++            fds[fae->fae_newfildes] = dup (fae->fae_fildes);
>      +          oldflags[fae->fae_newfildes] = fcntl (fae->fae_newfildes,
>      +                                                F_GETFD, 0);
>      +          fcntl (fae->fae_newfildes, F_SETFD, FD_CLOEXEC);
> 
> > +	      /* TODO: FAE_(F)CHDIR */
> 
> I am not seeing how the posix cwd is passed to a spawned child.  Windows
> handles the cwd itself, but for cases where the cwd is virtual (say under
> /proc) there must be a way to pass a cwd that Windows doesn't know
> about...

The cwd is part of the cygheap. Inheritance works by having different
inheritance flags which specify how the data is propagated and copying
data in the cygheap selectively.  The cwdstuff is part of the cygheap
header which is always inherted by all children.  Does that help?

Thanks,
Corinna
