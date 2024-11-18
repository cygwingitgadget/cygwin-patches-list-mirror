Return-Path: <SRS0=6I6Q=SN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id EBA033858C35
	for <cygwin-patches@cygwin.com>; Mon, 18 Nov 2024 20:58:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EBA033858C35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EBA033858C35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731963537; cv=none;
	b=JaLPAcVWbd7ZVjaSuFLopEfz1qaugico0rGfA2aoObVvB9moK6DHWmCFu9ylwjYx9WpuRUylt/aSxk3goWo8O0danM1sI63qyG1m20TL+F0f9koeq3JVkLLIRxkcAps7OhesOTugGUu0PMLN/HmUHmzMnlj1RohdHEtUjybagZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731963537; c=relaxed/simple;
	bh=4Yv6Jfu8BEzI4gq++VDcKXhboQOgI6oGBUy0LEfxTIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=mXDvLeZcAfOAPd+1Wqf740JphIKAVVNSONv5cbTKGF2ma0/Lp0w3O9d6Yn4xK1kpAM2kPqwEhnrqqOCmqjuXROnx4l/ZNFv2tx88d2L7tMLBzwiC2tguCv/AiskSRzAnT8JfYbCNGeN7iWWzSlazYtnIASsfw/gfVr+RMrw4s5Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EBA033858C35
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6722B002022725EC
X-Originating-IP: [81.152.101.74]
X-OWM-Source-IP: 81.152.101.74
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddugeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduhedvrddutddurdejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduhedvrddutddurdejgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehvddquddtuddqjeegrdhrrghnghgvkeduqdduhedvrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhrtghpthhtohep
	tgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehmrghrkhesmhgrgihrnhgurdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.152.101.74) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6722B002022725EC; Mon, 18 Nov 2024 20:58:52 +0000
Message-ID: <15e5a068-433b-4009-8cd2-e678a1249e9a@dronecode.org.uk>
Date: Mon, 18 Nov 2024 20:58:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
To: Mark Geisert <mark@maxrnd.com>
References: <20241113060354.2185-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20241113060354.2185-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/11/2024 06:03, Mark Geisert wrote:

Thanks very much for looking into this problem.

Sorry about the inordinate time it's take for me to look at this.

> Commentary wording adjusted to say ProcessorQueueLength counts threads,
> not processes.  Also mention (upcoming) new tool /bin/loadavg.  The
> release note for Cygwin 3.5.5 is updated.
> 
> In counting runnable threads, divide by NumberOfProcessors to model
> distributing the threads among all processors.  Otherwise one gets e.g.
> PQLs of 20 or more just running a few lively X applications.  These PQLs
> vary greatly between kernel stats updates every 16ms, so are very clearly
> short-term loads.  This change helps reduce jitter in load average
> calculations.

Hmm... I'm not sure what's right here.

My original language is sloppy, as we are calculating the number of 
active, and queued threads, not processes.

But after your change, we're clearly adding two different measurements 
together (active threads + queued processes), which doesn't seem right.

I'd have to go back an look at what loadavg is supposed to measure, and 
how it traditionally, and on linux, has worked.

(on first thought, it seems unlikely that if you have an N-core system, 
and a single process with N threads is occupying them all, that the 
steady-state loadavg is 1, not N; but if you have N single-threaded 
processes the steady-state loadavg is N...)

> At end of load_init(), obtain and discard the first measure of the
> counters to deal with the first call always returning error, no data.
> Follow this with a short delay so the next measure actually has data to
> report.
> 
> At least one older version of Windows, i.e. Win10 Pro 21H1, has a different

This is newer than the Windows version I initially wrote this on (in 
2017, gosh, so um... probably Windows 8.1 or an early Windows 10).

So, um.. are you sure you've got the time-ordering correct here?

OTOH, my original code still works on Win10 Home 22H2 here, so IDK 
what's going on here.

> name/location for the '% Processor Time' counter and is missing the
> 'Processor Queue Length' counter entirely.  Code is changed to support
> both possible locations of the former and treat the latter as always
> reporting 0.0.
> 
> Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: de7f13aa9ace (Cygwin: loadavg: improve debugging of load_init)
> 
> ---
>   winsup/cygwin/loadavg.cc    | 70 ++++++++++++++++++++++++++-----------
>   winsup/cygwin/release/3.5.5 |  3 ++
>   2 files changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
> index 127591a2e..37da077fb 100644
> --- a/winsup/cygwin/loadavg.cc
> +++ b/winsup/cygwin/loadavg.cc
> @@ -16,16 +16,26 @@
>     A global load average estimate is maintained in shared memory.  Access to that
>     is guarded by a mutex.  This estimate is only updated at most every 5 seconds.
>   
> -  We attempt to count running and runnable processes, but unlike linux we don't
> -  count processes in uninterruptible sleep (blocked on I/O).
> -
> -  The number of running processes is estimated as (NumberOfProcessors) * (%
> -  Processor Time).  The number of runnable processes is estimated as
> -  ProcessorQueueLength.
> +  Responsibility for updating the global load average is distributed among
> +  all callers of the getloadavg() syscall.  If the user finds that that is not
> +  consistent enough (e.g., 'uptime' reporting nonsense load averages), they can
> +  use the new /bin/loadavg tool, which has a daemon mode to keep the global
> +  load average updated consistently.
> +
> +  We attempt to count running processes and runnable threads, but unlike
> +  linux we don't count threads in uninterruptible sleep (blocked on I/O).
> +
> +  The number of running processes is estimated as
> +    (NumberOfProcessors) * (% Processor Time).
> +  The number of runnable threads is estimated as
> +    (ProcessorQueueLength) / (NumberOfProcessors).
> +  The "instantaneous" load estimate is taken to be the sum of the results of
> +  those two expressions.
>   
>     Note that PDH will only return data for '% Processor Time' afer the second
>     call to PdhCollectQueryData(), as it's computed over an interval, so the first
> -  attempt to estimate load will fail and 0.0 will be returned.
> +  attempt to estimate load will fail and 0.0 will be returned.  (This nuisance
> +  is now worked-around near the end of load_init() below.)
>   
>     We also assume that '% Processor Time' averaged over the interval since the
>     last time getloadavg() was called is a good approximation of the instantaneous
> @@ -62,31 +72,48 @@ static bool load_init (void)
>   	debug_printf ("PdhOpenQueryW, status %y", status);
>   	return false;
>         }
> +
>       status = PdhAddEnglishCounterW (query,
>   				    L"\\Processor(_Total)\\% Processor Time",
>   				    0, &counter1);
>       if (status != STATUS_SUCCESS)
>         {
>   	debug_printf ("PdhAddEnglishCounterW(time), status %y", status);
> -	return false;
> +
> +	/* Windows 10 Pro 21H1, and maybe others, use an alternate name */
> +	status = PdhAddEnglishCounterW (query,
> +			L"\\Processor Information(_Total)\\% Processor Time",
> +			0, &counter1);
> +	if (status != STATUS_SUCCESS)
> +	  {
> +	    debug_printf ("PdhAddEnglishCounterW(alt time), status %y", status);
> +	    return false;
> +	  }
>         }
> +
> +    /* Windows 10 Pro 21H1, and maybe others, are missing this counter */
>       status = PdhAddEnglishCounterW (query,
>   				    L"\\System\\Processor Queue Length",
>   				    0, &counter2);
> -
>       if (status != STATUS_SUCCESS)
>         {
>   	debug_printf ("PdhAddEnglishCounterW(queue length), status %y", status);
> -	return false;
> +	; /* don't return false, just use zero later in calculations */
>         }
>   
>       mutex = CreateMutex(&sec_all_nih, FALSE, "cyg.loadavg.mutex");
>       if (!mutex) {
> -      debug_printf("opening loadavg mutexfailed\n");
> +      debug_printf("opening loadavg mutex failed\n");
>         return false;
>       }
>   
>       initialized = true;
> +
> +    /* obtain+discard first sample now; avoids PDH_INVALID_DATA in get_load */
> +    (void) PdhCollectQueryData (query); /* i.o.w. take the error here */
> +
> +    /* Delay a short time so PdhCQD in caller will have data to collect */
> +    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */

These two comments seem in opposition to each other.

It seems that the claim is we need to wait at least one scheduler tick 
for the data to be valid (so more than 15ms)

>     }
>   
>     return initialized;
> @@ -101,24 +128,25 @@ static bool get_load (double *load)
>     if (ret != ERROR_SUCCESS)
>       return false;
>   
> -  /* Estimate the number of running processes as (NumberOfProcessors) * (%
> -     Processor Time) */
> +  /* Estimate the number of running processes as
> +     (NumberOfProcessors) * (% Processor Time) */

I could do without rewrapping comments so I can more clearly see the 
code changes, unless the claim is that this improves legibility.

>     PDH_FMT_COUNTERVALUE fmtvalue1;
>     ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
>     if (ret != ERROR_SUCCESS)
>       return false;
> -
>     double running = fmtvalue1.doubleValue * wincap.cpu_count () / 100;
>   
> -  /* Estimate the number of runnable processes using ProcessorQueueLength */
> -  PDH_FMT_COUNTERVALUE fmtvalue2;
> +  /* Estimate the number of runnable threads as
> +     (ProcessorQueueLength) / (NumberOfProcessors) */
> +  PDH_FMT_COUNTERVALUE fmtvalue2 = { 0 };
>     ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
>     if (ret != ERROR_SUCCESS)
> -    return false;
> +    ; /* don't return false, just treat as if zero was read */

"ignore any error accessing this counter, just treat as if zero was read"

>   
> -  LONG rql = fmtvalue2.longValue;
> +  /* Divide the runnable thread count among NumberOfProcessors */
> +  double rql = (double) fmtvalue2.longValue / (double) wincap.cpu_count ();
>   
> -  *load = rql + running;
> +  *load = running + rql;

Um, I'm struggling to see what the effect is of this last change.

>     return true;
>   }
>   
> @@ -147,8 +175,8 @@ void loadavginfo::update_loadavg ()
>     if (!get_load (&active_tasks))
>       return;
>   
> -  /* Don't recalculate the load average if less than 5 seconds has elapsed since
> -     the last time it was calculated */
> +  /* Don't recalculate the load average if less than 5 seconds has elapsed
> +     since the last time it was calculated */
>     time_t curr_time = time (NULL);
>     int delta_time = curr_time - last_time;
>     if (delta_time < 5) {
> diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
> index 2ca4572db..a83ea7d8a 100644
