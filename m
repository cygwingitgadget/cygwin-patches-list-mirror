Return-Path: <SRS0=mCeM=RG=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 586C53858D21
	for <cygwin-patches@cygwin.com>; Thu, 10 Oct 2024 06:12:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 586C53858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 586C53858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728540771; cv=none;
	b=kjv/3Frx49bSJKHJ9q1+IgMajVZi/4ZB80BqRdIhBilmWJM5rjhlmWWXXdxLK3ezwpeN5CqWTDhXCcyaZioC0ePnvwfEO4l49Yh5nECgz2Mm/t2uOFqliaEsJl7iB8EZkKiqOHwvC3PRN1nscGckOZ34MzR9RdJHw0U/D6Qr3ec=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728540771; c=relaxed/simple;
	bh=uzKuZO/I4lTAIQA8lTCx85BaRg1NYLMwsQE689xgJLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=RH8B5ljgi+seuMD2J/mQfRK7f8uqUf6xY605eHVyIrkSGoxUQv7RksIptMVwTz74ZiIs+mLlnbrdtVCq0N1Iq7vgP0ApRhLvTWULVl7M0nmy3AQ/Z6NBGg4IAfvwyYJVJytjSl2Ss/aE6SvYI5tnDNQAM/Dh3HA0rndXfDie+Lk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 49A6GJ4a050862
	for <cygwin-patches@cygwin.com>; Wed, 9 Oct 2024 23:16:19 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdIKL6H1; Wed Oct  9 23:16:09 2024
Message-ID: <0ae76bc9-040b-4109-bebc-eb0efb19d0ba@maxrnd.com>
Date: Wed, 9 Oct 2024 23:12:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Minor updates to load average calculations
To: cygwin-patches@cygwin.com
References: <20241009051950.3170-1-mark@maxrnd.com>
 <2c0ac3ef-3fa6-41c9-b41d-51248762899d@SystematicSW.ab.ca>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <2c0ac3ef-3fa6-41c9-b41d-51248762899d@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On 10/9/2024 9:36 AM, Brian Inglis wrote:
> Clarity suggestions and questions that could perhaps benefit from more 
> comment:
> 
> On 2024-10-08 23:19, Mark Geisert wrote:
[...]
> 
>>     The number of running processes is estimated as 
>> (NumberOfProcessors) * (%
>> -  Processor Time).  The number of runnable processes is estimated as
>> -  ProcessorQueueLength.
>> +  Processor Time).  The number of runnable threads is estimated as
> 
> This looks weird with arbitrary split then indentation; maybe move at 
> least "(%" to next line, maybe also "*", or the whole expression, and 
> maybe add semantic newlines after the sentences:
> 
>  >   The number of running processes is estimated as NumberOfProcessors *
>  >   % Processor Time.  The number of runnable threads is estimated as
> 
>  >   The number of running processes is estimated as
>  >     NumberOfProcessors * % Processor Time.
>  >   The number of runnable threads is estimated as
>  >    ProcessorQueueLength / NumberOfProcessors.
>  >   The instantaneous load ...

There was a construct like this in an inline comment that I caught, but 
I missed this in top commentary.  Your suggestion reads much better.

>> +  (ProcessorQueueLength) / (NumberOfProcessors).  The "instantaneous" 
>> load
>> +  estimate is taken to be the sum of those two numbers.
> 
> Which two are the values summed: running processes + runnable threads?

The sum of the (product expression) and the (division expression).  Not 
exactly what you said, but something related.  I can/will make it clearer.

> 
>> @@ -62,31 +69,46 @@ static bool load_init (void)
>   +    Sleep (15); /* let other procs run; multiple yield()s aren't 
> enough */
> 
> Why so long - why not clock_/nanosleep for just a 16ms tick or even 1ms, 
> as when system has 1ms multimedia timer ticks enabled by e.g. javascript 
> or ntpd, or possibly set <1ms by some games? Effects on other processes 
> may vary by version.

A good question!  This only happens on load_init(), i.e. the first 
access of the counters by whatever program has called the getloadavg() 
syscall.  Right after the counters have been defined there is no data to 
be read.  Some time in the next 15ms there will be data available, 
because Windows updates all counters every 15ms.  We don't know in 
advance when that will be.  We could have a loop checking for data every 
X ms, but given this code is only run on the first access, just waiting 
15ms guarantees data will be available when load_init() returns to its 
caller.  I can/will add commentary to that effect.

I'll make these changes in a v2 patch.  I'm going to hold off on 
submitting that until I hear whether the technical content is OK.
Thanks for the input,

..mark
