Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 286F73857C7A; Tue, 10 Dec 2024 19:56:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 286F73857C7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733860583;
	bh=ffAFqaZMtTOHsQIiId3Z6OLD67iSmyqWdRfsTMWI40A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=H4lGH1Muu3aIIR87uytq4O3I3b8IgW34j3B1gCF6PqLERrN7bcwVCmTSRtVfCD8dU
	 a7eiHzlbbR7wY6RCegAYyzAiwgBvFmc0AUFe3b0tBeVYxwtcJIDB7TNMcDAZ4BMoRv
	 cFMEZjDajPtbA55uKn6LFcK31+zZ56BKkNOy7RDY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C12E8A8093F; Tue, 10 Dec 2024 20:56:10 +0100 (CET)
Date: Tue, 10 Dec 2024 20:56:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
Message-ID: <Z1ic2vQnjnlcJ2A_@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
 <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
 <9362a9a5-2ec9-0c89-9d2a-5b5f357857ad@t-online.de>
 <14b59939-ef50-60d8-ac6c-bf6c0afb8dac@t-online.de>
 <8e7d7da6-bdca-7b36-fb7f-497b403a4fc1@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e7d7da6-bdca-7b36-fb7f-497b403a4fc1@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Dec 10 15:16, Christian Franke wrote:
> +  /* Handle SCHED_RESET_ON_FORK flag. */
> +  if (myself->sched_reset_on_fork)
> +    {
> +      bool batch = (myself->sched_policy == SCHED_BATCH);
> +      bool idle = (myself->sched_policy == SCHED_IDLE);
> +      bool set_prio = false;
> +      /* Reset negative nice values to zero. */
> +      if (myself->nice < 0)
> +	{
> +	  child->nice = 0;
> +	  set_prio = !idle;
> +	}
> +      /* Reset realtime policies to SCHED_OTHER. */
> +      if (!(myself->sched_policy == SCHED_OTHER || batch || idle))
> +	{
> +	  child->sched_policy = SCHED_OTHER;
> +	  set_prio = true;
> +	}
> +      /* Adjust Windows priority if required. */
> +      if (set_prio)
> +	{
> +	  HANDLE proc = OpenProcess(PROCESS_SET_INFORMATION |
> +				    PROCESS_QUERY_LIMITED_INFORMATION,
> +				    FALSE, child->dwProcessId);
> +	  if (proc)
> +	    {
> +	      set_and_check_winprio(proc, nice_to_winprio(child->nice, batch));
> +	      CloseHandle(proc);
> +	    }
> +	}
> +    }
> +  child->sched_reset_on_fork = false;
> +

Is it really necessary to go to such length here?  For one thing, we
have hchild aka pi.hProcess, which should have all access rights on the
child.  Otherwise, the priority of the child process can be set in the
dwCreationFlags parameter, called `c_flags' in frok::parent().  See line
215 in fork.cc.

In terms of the SCHED_BATCH value, I'm not going to wait much longer.
If there's no reply on the newlib list tomorrow, I'll push your patch
with SCHED_BATCH set to 6.


Thanks,
Corinna
