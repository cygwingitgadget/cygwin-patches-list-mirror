Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 88C953857C68; Wed, 22 Jan 2025 10:13:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88C953857C68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737540789;
	bh=ZDshdCmVhX2jM5q/JjkAxMkqCZX9jnD1VPOlgFWYYos=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Z1M2GuhR5Q58glPfRhb6ULhgsElPDpCb36H+0lXcGotDzyNuWRoNH0hwL/aRJtnuE
	 CxNbLSiqyl+dcwt2uCpKwUFtGJrzcITZG065VnNqCspwQmwu3PsrIXP6IVHBdogkxP
	 xLIB1ngVZrkClWsMwRoyAsm6kXpMIuOaLNY/ia+g=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E7172A80B66; Wed, 22 Jan 2025 11:13:07 +0100 (CET)
Date: Wed, 22 Jan 2025 11:13:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: Minor updates to load average calculations
Message-ID: <Z5DEs9hhMPmCMqqC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2024q4/012939.html>
 <20250120081914.1219-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120081914.1219-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Jon?  Are yuo going to review this one?

Thanks,
Corinna


On Jan 20 00:18, Mark Geisert wrote:
> Commentary wording now refers to tasks (i.e., threads) rather than
> processes.  This makes it somewhat easier to justify adding two kinds of
> counters together.  After researching what "load average" has meant over
> time, we have what seems like a reasonable implementation, modulo
> Windows differences to Linux.  The best resource I found is:
> https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html
> 
> At end of load_init(), obtain and discard the first measure of the
> counters to deal with the first call always returning error, no data.
> Follow this with a specific short delay so the next measure actually has
> data to report.
> 
> At least one older version of Windows, i.e. Win10 Pro 21H1, has a different
> name/location for the '% Processor Time' counter and is missing the
> 'Processor Queue Length' counter entirely.  Code is changed to support
> both possible locations of the former and treat the missing latter as always
> reporting 0.0.
> 
> A release note is added for 3.5.6.
> 
> Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 4dc982ddf60b (Cygwin: loadavg: improve debugging of load_init)
> 
> ---
>  winsup/cygwin/loadavg.cc    | 50 ++++++++++++++++++++++++++-----------
>  winsup/cygwin/release/3.5.6 |  3 +++
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
> index 127591a2e..1c5e553a9 100644
> --- a/winsup/cygwin/loadavg.cc
> +++ b/winsup/cygwin/loadavg.cc
> @@ -15,17 +15,23 @@
>  
>    A global load average estimate is maintained in shared memory.  Access to that
>    is guarded by a mutex.  This estimate is only updated at most every 5 seconds.
> +  The updates are done by any/all callers of the getloadavg() syscall.
>  
> -  We attempt to count running and runnable processes, but unlike linux we don't
> -  count processes in uninterruptible sleep (blocked on I/O).
> +  We attempt to count running and runnable tasks (i.e., threads), but unlike
> +  Linux we don't count tasks in uninterruptible sleep (blocked on I/O).  There
> +  doesn't seem to be a kernel counter for the latter on Windows.
>  
> -  The number of running processes is estimated as (NumberOfProcessors) * (%
> -  Processor Time).  The number of runnable processes is estimated as
> -  ProcessorQueueLength.
> +  In the following text and code, "PDH" refers to Process Data Helper, a
> +  Windows component that arranges access to kernel counters.
> +
> +  The number of running tasks is estimated as
> +    (the NumberOfProcessors counter) * (the % Processor Time counter).
> +  The number of runnable tasks is taken to be the ProcessorQueueLength counter.
>  
>    Note that PDH will only return data for '% Processor Time' afer the second
>    call to PdhCollectQueryData(), as it's computed over an interval, so the first
> -  attempt to estimate load will fail and 0.0 will be returned.
> +  attempt to estimate load will fail and 0.0 will be returned.  (This nuisance
> +  is now worked-around near the end of load_init() below.)
>  
>    We also assume that '% Processor Time' averaged over the interval since the
>    last time getloadavg() was called is a good approximation of the instantaneous
> @@ -68,8 +74,19 @@ static bool load_init (void)
>      if (status != STATUS_SUCCESS)
>        {
>  	debug_printf ("PdhAddEnglishCounterW(time), status %y", status);
> -	return false;
> +
> +	/* Windows 10 Pro 21H1, and maybe others, use an alternative name */
> +        status = PdhAddEnglishCounterW (query,
> +                        L"\\Processor Information(_Total)\\% Processor Time",
> +                        0, &counter1);
> +        if (status != STATUS_SUCCESS)
> +          {
> +            debug_printf ("PdhAddEnglishCounterW(alt time), status %y", status);
> +            return false;
> +          }
>        }
> +
> +    /* Windows 10 Pro 21H1, and maybe others, are missing this counter */
>      status = PdhAddEnglishCounterW (query,
>  				    L"\\System\\Processor Queue Length",
>  				    0, &counter2);
> @@ -77,7 +94,7 @@ static bool load_init (void)
>      if (status != STATUS_SUCCESS)
>        {
>  	debug_printf ("PdhAddEnglishCounterW(queue length), status %y", status);
> -	return false;
> +	; /* Ignore missing counter, just use zero in later calculations */
>        }
>  
>      mutex = CreateMutex(&sec_all_nih, FALSE, "cyg.loadavg.mutex");
> @@ -87,6 +104,12 @@ static bool load_init (void)
>      }
>  
>      initialized = true;
> +
> +    /* Do the first data collection (which always fails) here, rather than in
> +       get_load(). We wait at least one tick afterward so the collection done
> +       in get_load() is guaranteed to have data to work with. */
> +    (void) PdhCollectQueryData (query); /* ignore errors */
> +    Sleep (15/*ms*/); /* wait for at least one kernel tick to have occurred */
>    }
>  
>    return initialized;
> @@ -101,8 +124,8 @@ static bool get_load (double *load)
>    if (ret != ERROR_SUCCESS)
>      return false;
>  
> -  /* Estimate the number of running processes as (NumberOfProcessors) * (%
> -     Processor Time) */
> +  /* Estimate number of running tasks as
> +     (NumberOfProcessors) * (% Processor Time) */
>    PDH_FMT_COUNTERVALUE fmtvalue1;
>    ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
>    if (ret != ERROR_SUCCESS)
> @@ -110,11 +133,10 @@ static bool get_load (double *load)
>  
>    double running = fmtvalue1.doubleValue * wincap.cpu_count () / 100;
>  
> -  /* Estimate the number of runnable processes using ProcessorQueueLength */
> -  PDH_FMT_COUNTERVALUE fmtvalue2;
> +  /* Estimate the number of runnable tasks as ProcessorQueueLength */
> +  PDH_FMT_COUNTERVALUE fmtvalue2 = { 0 };
>    ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
> -  if (ret != ERROR_SUCCESS)
> -    return false;
> +  /* Ignore any error accessing this counter, just treat as if zero was read */
>  
>    LONG rql = fmtvalue2.longValue;
>  
> diff --git a/winsup/cygwin/release/3.5.6 b/winsup/cygwin/release/3.5.6
> index 4ccf94e38..5322be6d7 100644
> --- a/winsup/cygwin/release/3.5.6
> +++ b/winsup/cygwin/release/3.5.6
> @@ -13,3 +13,6 @@ Fixes:
>  
>  - Add fd validation where needed in mq_* functions.
>    Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257090.html
> +
> +- Minor updates to load average calculations.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> -- 
> 2.45.1
