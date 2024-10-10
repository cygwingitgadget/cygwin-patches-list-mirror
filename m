Return-Path: <SRS0=V3JK=RG=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id 7E72B3857B9E
	for <cygwin-patches@cygwin.com>; Thu, 10 Oct 2024 13:17:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7E72B3857B9E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7E72B3857B9E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728566268; cv=none;
	b=r2lV0CTbO0XjcAWNuClPj1q9ZD+HYq33jVhI6OYhKmx8tL0v1Utbj6R2CA8ydmEDAIi33fwPGXIP95TATYb8lEmznTwRUBXtn+28bqth7lH9wrsnKDdyWJnInO4XF3iHZqt1kMojkhBJPXSVsVk4K9tko8wmT+cSchik426Y6X4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728566268; c=relaxed/simple;
	bh=ZoMDSAja5r7Fa7+5oRzu6TylozNwp+tXlBV4d4VjbMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=xeE1zTGoS32a+gp/QqmdQ9Su9HV+cb+13W9sh6nqOaaxUoL8eBog8J66/LLk94YURtN6ekI6XxRinTTP2oqJuYID3gISMnaCMnyDut74LdeSsWgRVuJR5GaBIhbcfZn9wKlhwo8nE3Nw0QmLDAhc6Kfj1Ylu78YVC1uikNuysoc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 34D661A03F0
	for <cygwin-patches@cygwin.com>; Thu, 10 Oct 2024 13:17:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf05.hostedemail.com (Postfix) with ESMTPA id 217912001B
	for <cygwin-patches@cygwin.com>; Thu, 10 Oct 2024 13:17:35 +0000 (UTC)
Message-ID: <0701288f-2882-488a-8fa3-99428b41757e@SystematicSW.ab.ca>
Date: Thu, 10 Oct 2024 07:17:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Minor updates to load average calculations
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20241009051950.3170-1-mark@maxrnd.com>
 <2c0ac3ef-3fa6-41c9-b41d-51248762899d@SystematicSW.ab.ca>
 <0ae76bc9-040b-4109-bebc-eb0efb19d0ba@maxrnd.com>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Autocrypt: addr=Brian.Inglis@Shaw.ca; keydata=
 xjMEXopx9BYJKwYBBAHaRw8BAQdAPq8FIaW+Bz7xnfyJ1gHQyf2EZo5sAwSPy/bRAcLeWl/N
 I0JyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFNoYXcuY2E+wpYEExYIAD4WIQTG63sbl+cr
 2nyOuZiKvQKcH1E27wUCXopx9AIbAwUJCWYBgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
 CRCKvQKcH1E276DmAP91Bt8kfJhKHYb9b2sao2fxwJFsl1GlRi516WKI0OkphQEA+ULITsPs
 blfzSq+GgI7q4LPfRfTLy4Oo3gorlnhnfgnOOAReinH0EgorBgEEAZdVAQUBAQdAepgIsLwm
 GQicfoIBaB9xHp63MQJqVCPbgPzESTg7EEwDAQgHwn0EGBYIACYWIQTG63sbl+cr2nyOuZiK
 vQKcH1E27wUCXopx9AIbDAUJCWYBgAAKCRCKvQKcH1E27+zoAP4u2ivMQBAqaMeLOilqRWgy
 nV2ATImz1p2v1H5P4kBiDwD3caPK1cxU5lijzuSDCjgtIpgF/avHbjA32fxJdIRwAA==
Organization: Systematic Software
In-Reply-To: <0ae76bc9-040b-4109-bebc-eb0efb19d0ba@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 217912001B
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: pnnjji3jps7zpfsskdu743tyrz9fghkw
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18Bee84vSmwmKqlQO7cSThSimkHEP0++cw=
X-HE-Tag: 1728566255-126428
X-HE-Meta: U2FsdGVkX1+3zZ8X+vUVgeXGwydSbkSKi5QPCxsPoA8uiu+ESCXrMbiddcz1Bs9334EgH1MJdzeytT/YMa9rBVQuSf21rDnxGR6DO/+CQl8SROYyUWMS3A4N/jkBSI6DD0r5bNEP6cRy0Yz7YYs7SOblbVdrvZrGHfsb+YQsKOWvG/yOG2HALS15Ox6gz6snphe/Oi7GRkq2ZUcEPAnbe2eBavrKRuwNSThd5QgV9/+eP9nbyLcuvtjIOiPPX1Crv2sOuqZd23NuwiyERxPN/xN5BHtZw3VF2EhrJcp2yAr3LFfl09hcGuE3pVfsqZGfIPjLdCDQj634jwzycaH6/0AJjnS0ung8
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-10-10 00:12, Mark Geisert wrote:
> Hi Brian,
> 
> On 10/9/2024 9:36 AM, Brian Inglis wrote:
>> Clarity suggestions and questions that could perhaps benefit from more comment:
>>
>> On 2024-10-08 23:19, Mark Geisert wrote:
> [...]
>>
>>>     The number of running processes is estimated as (NumberOfProcessors) * (%
>>> -  Processor Time).  The number of runnable processes is estimated as
>>> -  ProcessorQueueLength.
>>> +  Processor Time).  The number of runnable threads is estimated as
>>
>> This looks weird with arbitrary split then indentation; maybe move at least 
>> "(%" to next line, maybe also "*", or the whole expression, and maybe add 
>> semantic newlines after the sentences:
>>
>>  >   The number of running processes is estimated as NumberOfProcessors *
>>  >   % Processor Time.  The number of runnable threads is estimated as
>>
>>  >   The number of running processes is estimated as
>>  >     NumberOfProcessors * % Processor Time.
>>  >   The number of runnable threads is estimated as
>>  >    ProcessorQueueLength / NumberOfProcessors.
>>  >   The instantaneous load ...
> 
> There was a construct like this in an inline comment that I caught, but I missed 
> this in top commentary.  Your suggestion reads much better.
> 
>>> +  (ProcessorQueueLength) / (NumberOfProcessors).  The "instantaneous" load
>>> +  estimate is taken to be the sum of those two numbers.
>>
>> Which two are the values summed: running processes + runnable threads?
> 
> The sum of the (product expression) and the (division expression).  Not exactly 
> what you said, but something related.  I can/will make it clearer.
> 
>>
>>> @@ -62,31 +69,46 @@ static bool load_init (void)
>>   +    Sleep (15); /* let other procs run; multiple yield()s aren't enough */
>>
>> Why so long - why not clock_/nanosleep for just a 16ms tick or even 1ms, as 
>> when system has 1ms multimedia timer ticks enabled by e.g. javascript or ntpd, 
>> or possibly set <1ms by some games? Effects on other processes may vary by 
>> version.
> 
> A good question!  This only happens on load_init(), i.e. the first access of the 
> counters by whatever program has called the getloadavg() syscall.  Right after 
> the counters have been defined there is no data to be read.  Some time in the 
> next 15ms there will be data available, because Windows updates all counters 
> every 15ms.  We don't know in advance when that will be.  We could have a loop 
> checking for data every X ms, but given this code is only run on the first 
> access, just waiting 15ms guarantees data will be available when load_init() 
> returns to its caller.  I can/will add commentary to that effect.

The official rate is 64Hz 15.625ms, but as I said, some programs increase that 
rate, although some are now being more conservative when systems are on battery, 
and limiting that request to ~2x 125Hz 8ms e.g. Chrome.
So you are probably better requesting to Sleep(16/*ms*/) to ensure the minimum 
update interval is exceeded by a small margin; and please document the expected 
time interval units dimensions, as these kinds of functions use various units, 
reasons, and expectations, as the underlying behaviour and its effects seem to 
change every version, especially low values like Sleep(1/*ms*/) which may vary 
from ~2-~15, and documentation lags and may be limited, requiring testing.

For example, IIRC, GetSystemTimePreciseAsFileTime has a resolution of about CPU 
clock/1024, or 1024 rdtsc units, so 3.5GHz -> 3.5MHz, probably to reduce 
variation from CPU clock frequency wander, so you can interpolate very high 
accuracy UTC stamps with bounded error.

> I'll make these changes in a v2 patch.  I'm going to hold off on submitting that 
> until I hear whether the technical content is OK.

LGTM but others have better technical background on internals.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
