Return-Path: <SRS0=Byep=SQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 716C63857BA5
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 10:35:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 716C63857BA5
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 716C63857BA5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732185308; cv=none;
	b=x81N5oHqMT8Bqn5bf42N3xQulxiKMLBR3bTzxigSMjb9FExkQdGYyc746W//N26v+BHb1T5QYCu3lZEO52gdEW73AXLpFxB2nR7RWNIht98OjiOD8huZu8ZO0sqtmsaKrv3jEnK2vTtL1nqCeFuSdxLPoQTho26e092RBQ8LRlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732185308; c=relaxed/simple;
	bh=BJ2AlyRiEgLavjIqmnsPoDnouPXt+5AI/wY8if5inaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=fXGjKMmKjWWd3R5mFbbnVlETbo5Ut69vfD3DTJjbc1N3jGbXrKe7NEFC84jVWR/bR67i8wj4V0P4tMChB9jnApCgyboLbhS/ZBv6aC7/gIgH01pnIIp9vHZ5JXVASMohabQB1A9Vj7vIpw/c89zBwbxOBcrqV7gn29WGbwjy0GU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 716C63857BA5
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4ALAc5ZK016198;
	Thu, 21 Nov 2024 02:38:05 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdwmJTBt; Thu Nov 21 02:37:57 2024
Message-ID: <0f3c12f6-0993-4d84-b7a9-b7919ba30a44@maxrnd.com>
Date: Thu, 21 Nov 2024 02:35:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
References: <20241113060354.2185-1-mark@maxrnd.com>
 <15e5a068-433b-4009-8cd2-e678a1249e9a@dronecode.org.uk>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <15e5a068-433b-4009-8cd2-e678a1249e9a@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On 11/18/2024 12:58 PM, Jon Turney wrote:
> On 13/11/2024 06:03, Mark Geisert wrote:
> 
> Thanks very much for looking into this problem.
> 
> Sorry about the inordinate time it's take for me to look at this.

No worries, I understand.

>> Commentary wording adjusted to say ProcessorQueueLength counts threads,
>> not processes.  Also mention (upcoming) new tool /bin/loadavg.  The
>> release note for Cygwin 3.5.5 is updated.
>>
>> In counting runnable threads, divide by NumberOfProcessors to model
>> distributing the threads among all processors.  Otherwise one gets e.g.
>> PQLs of 20 or more just running a few lively X applications.  These PQLs
>> vary greatly between kernel stats updates every 16ms, so are very clearly
>> short-term loads.  This change helps reduce jitter in load average
>> calculations.
> 
> Hmm... I'm not sure what's right here.
> 
> My original language is sloppy, as we are calculating the number of 
> active, and queued threads, not processes.
> 
> But after your change, we're clearly adding two different measurements 
> together (active threads + queued processes), which doesn't seem right.

I was going to refer to them as apples and oranges, but ^U'd myself.

> I'd have to go back an look at what loadavg is supposed to measure, and 
> how it traditionally, and on linux, has worked.
> 
> (on first thought, it seems unlikely that if you have an N-core system, 
> and a single process with N threads is occupying them all, that the 
> steady-state loadavg is 1, not N; but if you have N single-threaded 
> processes the steady-state loadavg is N...)

Good idea for the research.  I kind of intuitively ended up with the 
load average number meaning how many CPUs-worth of work is being done.

>> At end of load_init(), obtain and discard the first measure of the
>> counters to deal with the first call always returning error, no data.
>> Follow this with a short delay so the next measure actually has data to
>> report.
>>
>> At least one older version of Windows, i.e. Win10 Pro 21H1, has a 
>> different
> 
> This is newer than the Windows version I initially wrote this on (in 
> 2017, gosh, so um... probably Windows 8.1 or an early Windows 10).
> 
> So, um.. are you sure you've got the time-ordering correct here?
> 
> OTOH, my original code still works on Win10 Home 22H2 here, so IDK 
> what's going on here.

Oh I don't claim that versions <=Q are different from >Q, just that I 
happen to have a machine with version Q and it's different.  I used 
SysInternals tool [I don't remember] to explore the namespace.

[...]
>> +
>> +    /* Delay a short time so PdhCQD in caller will have data to 
>> collect */
>> +    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not 
>> enough */
> 
> These two comments seem in opposition to each other.
> 
> It seems that the claim is we need to wait at least one scheduler tick 
> for the data to be valid (so more than 15ms)

But it is more than 15ms.  I don't understand.  (But Corinna convinced 
me in her review it should be 15ms rather than 16ms.  I will update.)

>>     }
>>     return initialized;
>> @@ -101,24 +128,25 @@ static bool get_load (double *load)
>>     if (ret != ERROR_SUCCESS)
>>       return false;
>> -  /* Estimate the number of running processes as (NumberOfProcessors) 
>> * (%
>> -     Processor Time) */
>> +  /* Estimate the number of running processes as
>> +     (NumberOfProcessors) * (% Processor Time) */
> 
> I could do without rewrapping comments so I can more clearly see the 
> code changes, unless the claim is that this improves legibility.

Legibility it is.  Another reviewer barfed over the hanging "%" at EOL.

>>     PDH_FMT_COUNTERVALUE fmtvalue1;
>>     ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, 
>> &fmtvalue1);
>>     if (ret != ERROR_SUCCESS)
>>       return false;
>> -
>>     double running = fmtvalue1.doubleValue * wincap.cpu_count () / 100;
>> -  /* Estimate the number of runnable processes using 
>> ProcessorQueueLength */
>> -  PDH_FMT_COUNTERVALUE fmtvalue2;
>> +  /* Estimate the number of runnable threads as
>> +     (ProcessorQueueLength) / (NumberOfProcessors) */
>> +  PDH_FMT_COUNTERVALUE fmtvalue2 = { 0 };
>>     ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, 
>> &fmtvalue2);
>>     if (ret != ERROR_SUCCESS)
>> -    return false;
>> +    ; /* don't return false, just treat as if zero was read */
> 
> "ignore any error accessing this counter, just treat as if zero was read"

OK, will update.

>> -  LONG rql = fmtvalue2.longValue;
>> +  /* Divide the runnable thread count among NumberOfProcessors */
>> +  double rql = (double) fmtvalue2.longValue / (double) 
>> wincap.cpu_count ();
>> -  *load = rql + running;
>> +  *load = running + rql;
> 
> Um, I'm struggling to see what the effect is of this last change.

It puts the '+' operands in the same order they are calculated.  This is 
not a hillock I'm prepared to die on.  I'll revert it.
Thanks for the review,

..mark
