Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8B5BE4B9DB52; Fri, 13 Feb 2026 19:30:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8B5BE4B9DB52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1771011009;
	bh=CRHesGGzwPuouAgW5XKp6yu56FaMa5ggtIgmCecfzQA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fLvvzdmW1wK2ZrYA//Zgm6yxvAimmPwldzsxVhnxqm0LrtjoaOCS1AF5XHkZlxmqc
	 Wqy9BIiXlNnCjqrTNaoww65rk0hDodJNsBHTkO/UURTJjjbApDvtiUBzu2x1l8Iha4
	 Q3S/gLgy4d425AiHjIPGqJrvJQDExF5u4U76uEMY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8F6B9A81C4F; Fri, 13 Feb 2026 20:30:07 +0100 (CET)
Date: Fri, 13 Feb 2026 20:30:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Rewrite rlimits using OS job objects
Message-ID: <aY97v9UZOl12UOeK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

Ping?

Anybody willing to review?


Thanks,
Corinna


On Jan 26 12:13, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> The only implementation of an RLIMIT using Windows job objects,
> RLIMIT_AS, doesn't really work as desired.  The way it uses nested jobs
> fails if a soft limit is supposed to be raised again, thus working
> rather like a hard limit only.
> 
> This patch series takes a new approach.
> 
> Considering two kinds of rlimits, soft and hard limits, and two kinds of
> scopes, per-process and per-user.  Especially the per-user scope is kind
> of tricky when implementing this as job objects.  For all practical
> purposes, we can only include Cygwin processes and native subprocesses
> into per-user jobs, and only Cygwin processes into per-process jobs.
> 
> So here's what this patch is doing now:
> 
> When a new Cygwin process tree is started, the root process of that tree
> creates two per-user nested jobs, one for the hard limits, the next one
> for the soft limits.  The per-user job objects are globally defined.
> Processes can become job members across multiple Windows sessions.  If
> another Cygwin process tree is started, the root process of that tree
> finds that the per-user jobs already exist and just assignes itself to
> both jobs.
> 
> The same happens after a user context switch changing the real uid, i. e.,
> in spawn/exec when calling CreateProcessAsUser.
> 
> User limits are just set in those job objects across the board.
> 
> Per-process limits are implemented by adding two more job objects for
> hard and soft limit and assigning the process to these jobs.  These job
> objects are session local and they are only created when the process
> calls setrlimit.  They are setup so that child processes breakaway from
> these jobs automatically.  The job objects are not inherited, but
> recreated on fork/exec per PID for child processes.  This localizes the
> rlimits to a process and changes to per-process rlimits in a parent
> process don't affect the per-process limits in an already started child,
> only in children forked or execed later on.
> 
> I hope I explained this sufficiently.
> 
> For the time being, we have exactly one per-process limit, RLIMIT_AS,
> and exactly one new(!) per-user limit, RLIMIT_NPROC.
> 
> Questions and comments welcome!
> 
> 
> Corinna
> 
> 
> 
> Corinna Vinschen (3):
>   Cygwin: getrlimit/setrlimit: generalize setting rlimits
>   Cygwin: getrlimit/setrlimit: implement RLIMIT_NPROC
>   Cygwin: improve PCA workaround
> 
>  winsup/cygwin/dcrt0.cc                    |   4 +
>  winsup/cygwin/fork.cc                     |  16 ++
>  winsup/cygwin/globals.cc                  |   1 +
>  winsup/cygwin/include/cygwin/version.h    |   3 +-
>  winsup/cygwin/include/sys/resource.h      |   3 +-
>  winsup/cygwin/local_includes/child_info.h |  10 +-
>  winsup/cygwin/local_includes/cygheap.h    |   1 -
>  winsup/cygwin/local_includes/ntdll.h      |   1 +
>  winsup/cygwin/resource.cc                 | 303 ++++++++++++++++++----
>  winsup/cygwin/spawn.cc                    |  44 +---
>  10 files changed, 300 insertions(+), 86 deletions(-)
> 
> -- 
> 2.52.0
