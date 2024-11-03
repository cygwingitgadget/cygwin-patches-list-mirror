Return-Path: <SRS0=2IHS=R6=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id EC72A3858D26
	for <cygwin-patches@cygwin.com>; Sun,  3 Nov 2024 09:31:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC72A3858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EC72A3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730626296; cv=none;
	b=gsyUu15H/1GcYoIaIoDrSpiqZETmGDXzNvo4NQDMA4lUTXtd2EumVhNc2JMNxKVQbg6Qd8hfeVcmrQ4oCxg95WbG6hATrnRDWytPTm/6oLBRNOV6gD0HIRx27HBBWnG/bbfivr9v5n6hMf/OSo2di7tkxkvLFp2mbYjXMVtp934=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730626296; c=relaxed/simple;
	bh=re0eN3XGDc85HhPqLp8ZYumPwHAD5HsI3pwATfXjH8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Z0BpAG/VP1FZVTKwYeZYvGGaQ0rMDWix5lH0J1dVAJHY8iGuMZr6qaVYw9BRjr1xujioP+4B/r9Ttfca8o+Xs9aFp+SnvKNEM9Q1saaB242trSzE21LG47AtRt1bfk4kIa9JmHRhtiejzAanAEX1/UwNJUgJJYf+RGD5+n8YGAY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4A39YiZw068249
	for <cygwin-patches@cygwin.com>; Sun, 3 Nov 2024 01:34:44 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpd2zVi9s; Sun Nov  3 01:34:43 2024
Message-ID: <8b57844e-c9fe-4135-99fc-8a1b98be21be@maxrnd.com>
Date: Sun, 3 Nov 2024 01:31:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Minor updates to load average calculations
To: cygwin-patches@cygwin.com
References: <20241009051950.3170-1-mark@maxrnd.com>
 <Zxe9cMw7fNi8qImG@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <Zxe9cMw7fNi8qImG@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 10/22/2024 7:57 AM, Corinna Vinschen wrote:
> Hi Mark,
> 
> On Oct  8 22:19, Mark Geisert wrote:
[...]
>> Some older versions of Windows we still support have a different
> 
> Can you be a bit more specific here, i.e., which Windows versions?

FTR the only example I have is one of my systems running Win10 Pro 21H1. 
  I solicited more input on the main mailing list but got few replies, 
none of which exhibited the issue at hand.

In the v2 patch incoming soon, I've mentioned the problematic Windows 
version in the top matter and in the code comments.

>> location for the '% Processor Time' counter and are missing the
>> 'Processor Queue Length' counter entirely.  Code is changed to support
>> both possible locations of the former and treat the latter as always
>> reporting 0.0.
[..]
>> @@ -101,24 +123,25 @@ static bool get_load (double *load)
>>     if (ret != ERROR_SUCCESS)
>>       return false;
>>   
>> -  /* Estimate the number of running processes as (NumberOfProcessors) * (%
>> -     Processor Time) */
>> +  /* Estimate the number of running processes as
>> +     (NumberOfProcessors) * (% Processor Time) */
>>     PDH_FMT_COUNTERVALUE fmtvalue1;
>>     ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
>>     if (ret != ERROR_SUCCESS)
>>       return false;
>> -
>>     double running = fmtvalue1.doubleValue * wincap.cpu_count () / 100;
>>   
>> -  /* Estimate the number of runnable processes using ProcessorQueueLength */
>> +  /* Estimate the number of runnable threads using ProcessorQueueLength */
>>     PDH_FMT_COUNTERVALUE fmtvalue2;
>> +  fmtvalue2.longValue = 0;
> 
> Make that
> 
>       PDH_FMT_COUNTERVALUE fmtvalue2 = { 0 };
> 
Done.

>>     ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
>>     if (ret != ERROR_SUCCESS)
>> -    return false;
>> +    ; /* don't return false, just treat as if zero was read */
>>   
>> -  LONG rql = fmtvalue2.longValue;
>> +  /* Divide the runnable thread count among NumberOfProcessors */
>> +  double rql = (double) fmtvalue2.longValue / (double) wincap.cpu_count ();
>>   
>> -  *load = rql + running;
>> +  *load = running + rql;
> 
> Not sure I'm understanding this right, but wouldn't a default queue length
> of 1 make more sense?

I don't think so. That would make an idle system show a load of 1/ncpus 
because of the division a couple lines up from the end.
Thanks & Regards,

.mark

