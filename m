Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 413D73858D21; Tue, 22 Oct 2024 14:57:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 413D73858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729609074;
	bh=4GHPbpmW/iA+Sp9aSedCbskps3giPGhAHh92xwJlG4g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DLUYrLv0H+xzLBRQ3qApNF2RPbLBHwOwLhVmkXaWvGjfSRfkX4WaQuNeXYON2BUoL
	 uVrVcR8bm1JY5jHpGExZsCk4ZkiEdfFKM5qjRv8NcL8L+C6cCJQWoUOVXkVRXn7tRD
	 Po30oD2pEtJhFZXR4jmSaDOMX+1S/MKulbk8FUG8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 31239A80D05; Tue, 22 Oct 2024 16:57:52 +0200 (CEST)
Date: Tue, 22 Oct 2024 16:57:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com, Mark Liam Brown <brownmarkliam@gmail.com>
Subject: Re: [PATCH] Cygwin: Minor updates to load average calculations
Message-ID: <Zxe9cMw7fNi8qImG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com,
	Mark Liam Brown <brownmarkliam@gmail.com>
References: <20241009051950.3170-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009051950.3170-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Oct  8 22:19, Mark Geisert wrote:
> Commentary wording adjusted to say ProcessorQueueLength counts threads,
> not processes.  Also mention (upcoming) new tool /bin/loadavg.
> 
> In counting runnable threads, divide by NumberOfProcessors to model
> distributing the threads among all processors.  Otherwise one gets e.g.
> PQLs of 20 or more just running a few active X applications.  These PQLs
> vary greatly between kernel stats updates every 15ms, so are very clearly
> short-term loads.  This change helps reduce jitter in load average
> calculations.
> 
> At end of load_init(), obtain and discard the first measure of the
> counters to deal with the first call always returning error, no data.
> Follow this with a short delay so the next measure actually has data to
> report.
> 
> Some older versions of Windows we still support have a different

Can you be a bit more specific here, i.e., which Windows versions?

> location for the '% Processor Time' counter and are missing the
> 'Processor Queue Length' counter entirely.  Code is changed to support
> both possible locations of the former and treat the latter as always
> reporting 0.0.
> 
> Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 4dc982ddf60b (Cygwin: loadavg: improve debugging of load_init)
> 
> ---
>  winsup/cygwin/loadavg.cc | 55 ++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
> index 127591a2e..8e82b3cbd 100644
> --- a/winsup/cygwin/loadavg.cc
> +++ b/winsup/cygwin/loadavg.cc
> @@ -16,16 +16,23 @@
>    A global load average estimate is maintained in shared memory.  Access to that
>    is guarded by a mutex.  This estimate is only updated at most every 5 seconds.
>  
> -  We attempt to count running and runnable processes, but unlike linux we don't
> -  count processes in uninterruptible sleep (blocked on I/O).
> +  Responsibility for updating the global load average is distributed among
> +  all callers of the getloadavg() syscall.  If that is not consistent enough,
> +  the new /bin/loadavg tool has a daemon mode to keep the global load average
> +  updated regardless.
> +
> +  We attempt to count running processes and runnable threads, but unlike
> +  linux we don't count threads in uninterruptible sleep (blocked on I/O).
>  
>    The number of running processes is estimated as (NumberOfProcessors) * (%
> -  Processor Time).  The number of runnable processes is estimated as
> -  ProcessorQueueLength.
> +  Processor Time).  The number of runnable threads is estimated as
> +  (ProcessorQueueLength) / (NumberOfProcessors).  The "instantaneous" load
> +  estimate is taken to be the sum of those two numbers.
>  
>    Note that PDH will only return data for '% Processor Time' afer the second
>    call to PdhCollectQueryData(), as it's computed over an interval, so the first
> -  attempt to estimate load will fail and 0.0 will be returned.
> +  attempt to estimate load will fail and 0.0 will be returned.  This nuisance
> +  is now worked-around near the end of load_init() below.
>  
>    We also assume that '% Processor Time' averaged over the interval since the
>    last time getloadavg() was called is a good approximation of the instantaneous
> @@ -62,31 +69,46 @@ static bool load_init (void)
>  	debug_printf ("PdhOpenQueryW, status %y", status);
>  	return false;
>        }
> +
>      status = PdhAddEnglishCounterW (query,
>  				    L"\\Processor(_Total)\\% Processor Time",
>  				    0, &counter1);
>      if (status != STATUS_SUCCESS)
>        {
>  	debug_printf ("PdhAddEnglishCounterW(time), status %y", status);
> -	return false;
> +
> +	/* Older Windows versions we still support use an alternate name */
           ^^^^^                 ^^^^
           exakt version?        stray

> +	status = PdhAddEnglishCounterW (query,
> +			L"\\Processor Information(_Total)\\% Processor Time",
> +			0, &counter1);
> +	if (status != STATUS_SUCCESS)
> +	  {
> +	    debug_printf ("PdhAddEnglishCounterW(alt time), status %y", status);
> +	    return false;
> +	  }
>        }
> +
> +    /* Older Windows versions we still support sometimes missing this counter */

Ditto

>      status = PdhAddEnglishCounterW (query,
>  				    L"\\System\\Processor Queue Length",
>  				    0, &counter2);
> -
>      if (status != STATUS_SUCCESS)
>        {
>  	debug_printf ("PdhAddEnglishCounterW(queue length), status %y", status);
> -	return false;
> +	; /* don't return false, just use zero later in calculations */
>        }
>  
>      mutex = CreateMutex(&sec_all_nih, FALSE, "cyg.loadavg.mutex");
>      if (!mutex) {
> -      debug_printf("opening loadavg mutexfailed\n");
> +      debug_printf("opening loadavg mutex failed\n");
>        return false;
>      }
>  
>      initialized = true;
> +
> +    /* obtain+discard first sample now; avoids PDH_INVALID_DATA in get_load */
> +    (void) PdhCollectQueryData (query); /* i.o.w. take the error here */
> +    Sleep (15); /* let other procs run; multiple yield()s aren't enough */
>    }
>  
>    return initialized;
> @@ -101,24 +123,25 @@ static bool get_load (double *load)
>    if (ret != ERROR_SUCCESS)
>      return false;
>  
> -  /* Estimate the number of running processes as (NumberOfProcessors) * (%
> -     Processor Time) */
> +  /* Estimate the number of running processes as
> +     (NumberOfProcessors) * (% Processor Time) */
>    PDH_FMT_COUNTERVALUE fmtvalue1;
>    ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
>    if (ret != ERROR_SUCCESS)
>      return false;
> -
>    double running = fmtvalue1.doubleValue * wincap.cpu_count () / 100;
>  
> -  /* Estimate the number of runnable processes using ProcessorQueueLength */
> +  /* Estimate the number of runnable threads using ProcessorQueueLength */
>    PDH_FMT_COUNTERVALUE fmtvalue2;
> +  fmtvalue2.longValue = 0;

Make that

     PDH_FMT_COUNTERVALUE fmtvalue2 = { 0 };

>    ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
>    if (ret != ERROR_SUCCESS)
> -    return false;
> +    ; /* don't return false, just treat as if zero was read */
>  
> -  LONG rql = fmtvalue2.longValue;
> +  /* Divide the runnable thread count among NumberOfProcessors */
> +  double rql = (double) fmtvalue2.longValue / (double) wincap.cpu_count ();
>  
> -  *load = rql + running;
> +  *load = running + rql;

Not sure I'm understanding this right, but wouldn't a default queue length
of 1 make more sense?


Thanks,
Corinna
