Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C1B8F3858D39; Thu, 12 Dec 2024 09:37:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C1B8F3858D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733996261;
	bh=hYCSfOpPKwXRB6jxAJ33WcPvxAsr/t9fdjwbuMIJyqE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=yHakHpxQwn9eEjMI8HhWP+uStnT3mTScgDa3Wg6SNF4TC4Coff91QRlroyigF0ldg
	 YnY90Ec5zhFnAZSliI0DlvSp8I1w7z0hMkVjUGeHJzWVAYl1yVD6G7TMKgjNR8tJGQ
	 xqBw0ZC9xuWQzr8hw8Y+RNEgxAPFzbwsZqQm+TDU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 52E1BA80C1A; Thu, 12 Dec 2024 10:37:39 +0100 (CET)
Date: Thu, 12 Dec 2024 10:37:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
Message-ID: <Z1qu43iLH5FNWxag@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
 <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
 <9362a9a5-2ec9-0c89-9d2a-5b5f357857ad@t-online.de>
 <14b59939-ef50-60d8-ac6c-bf6c0afb8dac@t-online.de>
 <8e7d7da6-bdca-7b36-fb7f-497b403a4fc1@t-online.de>
 <Z1ic2vQnjnlcJ2A_@calimero.vinschen.de>
 <ae82e449-65b7-3153-517d-f1b8f107439c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae82e449-65b7-3153-517d-f1b8f107439c@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Both patches pushed.


Thanks,
Corinna


On Dec 11 12:50, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On Dec 10 15:16, Christian Franke wrote:
> > > +  /* Handle SCHED_RESET_ON_FORK flag. */
> > > +  if (myself->sched_reset_on_fork)
> > > +    {
> > > +      bool batch = (myself->sched_policy == SCHED_BATCH);
> > > +      bool idle = (myself->sched_policy == SCHED_IDLE);
> > > +      bool set_prio = false;
> > > +      /* Reset negative nice values to zero. */
> > > +      if (myself->nice < 0)
> > > +	{
> > > +	  child->nice = 0;
> > > +	  set_prio = !idle;
> > > +	}
> > > +      /* Reset realtime policies to SCHED_OTHER. */
> > > +      if (!(myself->sched_policy == SCHED_OTHER || batch || idle))
> > > +	{
> > > +	  child->sched_policy = SCHED_OTHER;
> > > +	  set_prio = true;
> > > +	}
> > > +      /* Adjust Windows priority if required. */
> > > +      if (set_prio)
> > > +	{
> > > +	  HANDLE proc = OpenProcess(PROCESS_SET_INFORMATION |
> > > +				    PROCESS_QUERY_LIMITED_INFORMATION,
> > > +				    FALSE, child->dwProcessId);
> > > +	  if (proc)
> > > +	    {
> > > +	      set_and_check_winprio(proc, nice_to_winprio(child->nice, batch));
> > > +	      CloseHandle(proc);
> > > +	    }
> > > +	}
> > > +    }
> > > +  child->sched_reset_on_fork = false;
> > > +
> > Is it really necessary to go to such length here?  For one thing, we
> > have hchild aka pi.hProcess, which should have all access rights on the
> > child.  Otherwise, the priority of the child process can be set in the
> > dwCreationFlags parameter, called `c_flags' in frok::parent().  See line
> > 215 in fork.cc.
> 
> A new patch setting c_flags directly is attached.
> 
> > In terms of the SCHED_BATCH value, I'm not going to wait much longer.
> > If there's no reply on the newlib list tomorrow, I'll push your patch
> > with SCHED_BATCH set to 6.
> > 
> > 
> > Thanks,
> > Corinna
> > 
> 

> From 89dfe62ddaa162b3eb911a42b635ad2769470cf2 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Wed, 11 Dec 2024 12:48:58 +0100
> Subject: [PATCH] Cygwin: sched_setscheduler: accept SCHED_RESET_ON_FORK flag
> 
> Add SCHED_RESET_ON_FORK to <sys/sched.h>.  If this flag is set, SCHED_FIFO
> and SCHED_RR are reset to SCHED_OTHER and negative nice values are reset to
> zero in each child process created with fork(2).
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  newlib/libc/include/sys/sched.h      |  3 +++
>  winsup/cygwin/fork.cc                | 37 +++++++++++++++++++++++++---
>  winsup/cygwin/local_includes/pinfo.h |  5 ++--
>  winsup/cygwin/pinfo.cc               |  1 +
>  winsup/cygwin/release/3.6.0          |  3 +++
>  winsup/cygwin/sched.cc               | 11 ++++++---
>  winsup/cygwin/spawn.cc               |  1 +
>  7 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/newlib/libc/include/sys/sched.h b/newlib/libc/include/sys/sched.h
> index 6977d3d4a..95509dbf0 100644
> --- a/newlib/libc/include/sys/sched.h
> +++ b/newlib/libc/include/sys/sched.h
> @@ -45,6 +45,9 @@ extern "C" {
>  #if __GNU_VISIBLE
>  #define SCHED_IDLE     5
>  #define SCHED_BATCH    6
> +
> +/* Flag to drop realtime policies and negative nice values on fork(). */
> +#define SCHED_RESET_ON_FORK     0x40000000
>  #endif
>  
>  /* Scheduling Parameters */
> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index 7d976e882..41a533705 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -212,7 +212,37 @@ frok::parent (volatile char * volatile stack_here)
>    bool fix_impersonation = false;
>    pinfo child;
>  
> -  int c_flags = GetPriorityClass (GetCurrentProcess ());
> +  /* Inherit scheduling parameters by default. */
> +  int child_nice = myself->nice;
> +  int child_sched_policy = myself->sched_policy;
> +  int c_flags = 0;
> +
> +  /* Handle SCHED_RESET_ON_FORK flag. */
> +  if (myself->sched_reset_on_fork)
> +    {
> +      bool batch = (myself->sched_policy == SCHED_BATCH);
> +      bool idle = (myself->sched_policy == SCHED_IDLE);
> +      bool set_prio = false;
> +      /* Reset negative nice values to zero. */
> +      if (myself->nice < 0)
> +	{
> +	  child_nice = 0;
> +	  set_prio = !idle;
> +	}
> +      /* Reset realtime policies to SCHED_OTHER. */
> +      if (!(myself->sched_policy == SCHED_OTHER || batch || idle))
> +	{
> +	  child_sched_policy = SCHED_OTHER;
> +	  set_prio = true;
> +	}
> +      if (set_prio)
> +	c_flags = nice_to_winprio (child_nice, batch);
> +    }
> +
> +  /* Always request a priority because otherwise anything above
> +     NORMAL_PRIORITY_CLASS would not be inherited. */
> +  if (!c_flags)
> +    c_flags = GetPriorityClass (GetCurrentProcess ());
>    debug_printf ("priority class %d", c_flags);
>    /* Per MSDN, this must be specified even if lpEnvironment is set to NULL,
>       otherwise UNICODE characters in the parent environment are not copied
> @@ -401,8 +431,9 @@ frok::parent (volatile char * volatile stack_here)
>        goto cleanup;
>      }
>  
> -  child->nice = myself->nice;
> -  child->sched_policy = myself->sched_policy;
> +  child->nice = child_nice;
> +  child->sched_policy = child_sched_policy;
> +  child->sched_reset_on_fork = false;
>  
>    /* Initialize things that are done later in dll_crt0_1 that aren't done
>       for the forkee.  */
> diff --git a/winsup/cygwin/local_includes/pinfo.h b/winsup/cygwin/local_includes/pinfo.h
> index 03e0c4d60..be5d53021 100644
> --- a/winsup/cygwin/local_includes/pinfo.h
> +++ b/winsup/cygwin/local_includes/pinfo.h
> @@ -93,8 +93,9 @@ public:
>    struct rusage rusage_self;
>    struct rusage rusage_children;
>  
> -  int nice;          /* nice value for SCHED_OTHER. */
> -  int sched_policy;  /* SCHED_OTHER, SCHED_FIFO or SCHED_RR. */
> +  int nice;          /* nice value for SCHED_OTHER and SCHED_BATCH. */
> +  int sched_policy;  /* SCHED_OTHER/BATCH/IDLE/FIFO/RR */
> +  bool sched_reset_on_fork;  /* true if SCHED_RESET_ON_FORK flag was set. */
>  
>    /* Non-zero if process was stopped by a signal. */
>    char stopsig;
> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> index 06c966f1e..fecf76eb6 100644
> --- a/winsup/cygwin/pinfo.cc
> +++ b/winsup/cygwin/pinfo.cc
> @@ -103,6 +103,7 @@ pinfo_init (char **envp, int envc)
>        environ_init (NULL, 0);	/* call after myself has been set up */
>        myself->nice = winprio_to_nice (GetPriorityClass (GetCurrentProcess ()));
>        myself->sched_policy = SCHED_OTHER;
> +      myself->sched_reset_on_fork = false;
>        myself->ppid = 1;		/* always set last */
>        debug_printf ("Set nice to %d", myself->nice);
>      }
> diff --git a/winsup/cygwin/release/3.6.0 b/winsup/cygwin/release/3.6.0
> index 11f745b23..d35aa3036 100644
> --- a/winsup/cygwin/release/3.6.0
> +++ b/winsup/cygwin/release/3.6.0
> @@ -61,5 +61,8 @@ What changed:
>    priority is set to IDLE_PRIORITY_CLASS.  If SCHED_FIFO or SCHED_RR is
>    selected, the nice value is preserved and the Windows priority is set
>    according to the realtime priority.
> +  If the SCHED_RESET_ON_FORK flag is set, SCHED_FIFO and SCHED_RR are
> +  reset to SCHED_OTHER and negative nice values are reset to zero in
> +  each child process created with fork(2).
>    Note: Windows does not offer alternative scheduling policies so
>    this could only emulate API behavior.
> diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
> index ec62ea83c..d75a3404f 100644
> --- a/winsup/cygwin/sched.cc
> +++ b/winsup/cygwin/sched.cc
> @@ -162,7 +162,7 @@ sched_getscheduler (pid_t pid)
>        set_errno (ESRCH);
>        return -1;
>      }
> -  return p->sched_policy;
> +  return p->sched_policy | (p->sched_reset_on_fork ? SCHED_RESET_ON_FORK : 0);
>  }
>  
>  /* get the time quantum for pid */
> @@ -425,9 +425,11 @@ int
>  sched_setscheduler (pid_t pid, int policy,
>  		    const struct sched_param *param)
>  {
> +  int new_policy = policy & ~SCHED_RESET_ON_FORK;
>    if (!(pid >= 0 && param &&
> -      (((policy == SCHED_OTHER || policy == SCHED_BATCH || policy == SCHED_IDLE)
> -      && param->sched_priority == 0) || ((policy == SCHED_FIFO || policy == SCHED_RR)
> +      (((new_policy == SCHED_OTHER || new_policy == SCHED_BATCH
> +      || new_policy == SCHED_IDLE) && param->sched_priority == 0)
> +      || ((new_policy == SCHED_FIFO || new_policy == SCHED_RR)
>        && valid_sched_parameters(param)))))
>      {
>        set_errno (EINVAL);
> @@ -442,13 +444,14 @@ sched_setscheduler (pid_t pid, int policy,
>      }
>  
>    int prev_policy = p->sched_policy;
> -  p->sched_policy = policy;
> +  p->sched_policy = new_policy;
>    if (sched_setparam_pinfo (p, param))
>      {
>        p->sched_policy = prev_policy;
>        return -1;
>      }
>  
> +  p->sched_reset_on_fork = !!(policy & SCHED_RESET_ON_FORK);
>    return 0;
>  }
>  
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 7f9f2df64..8016f0864 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -800,6 +800,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	  child->start_time = time (NULL); /* Register child's starting time. */
>  	  child->nice = myself->nice;
>  	  child->sched_policy = myself->sched_policy;
> +	  child->sched_reset_on_fork = false;
>  	  postfork (child);
>  	  if (mode != _P_DETACH
>  	      && (!child.remember () || !child.attach ()))
> -- 
> 2.45.1
> 

