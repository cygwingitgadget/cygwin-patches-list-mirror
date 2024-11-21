Return-Path: <SRS0=Byep=SQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 6B6F83857810
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 10:52:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6B6F83857810
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6B6F83857810
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732186329; cv=none;
	b=a4hOq6txb9f/2EWsaHlS88dGSfhShkfh48cotMkoEkp8boBYI6jxKXmSzgJBzyMVlhMd1cEsVCfgTnzATtK2/s2y/gvPpMcszl0lUeLvVr4ufdjsgSqhT2O22A1mUdfhXw23Tawq13eICbzvAX3t0zcGmMbxSUgwmEZRpWQiE+w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732186329; c=relaxed/simple;
	bh=J610isUQWDbCwuoigfdf6r0d1gkZpNsTXAov9rq8qmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=LmmwID733hR/I6Ic6/qtph9eTPWwMoc5VzpYKZOrfNBrKMzVd/mWae6T509KSFxzvMmxSS2cy989AOu1ddo21YU2bAM+5NIqZa/WAd2wzIBOSjtVsfTOz+W+ELuG2CEjpsH0NyidxF5bDmGZmg4lomW1wXCUlwbotvmdx8mG4PQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6B6F83857810
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4ALAt6NU018400
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 02:55:06 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdQ7zLGr; Thu Nov 21 02:54:56 2024
Message-ID: <a9f666d5-aec0-4bd1-a69f-c13464397882@maxrnd.com>
Date: Thu, 21 Nov 2024 02:52:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
To: cygwin-patches@cygwin.com
References: <20241113060354.2185-1-mark@maxrnd.com>
 <ZzsxhLhL_h3xey5h@calimero.vinschen.de>
 <3a16a22f-3f16-4ebb-ac9b-a1ad3a71b1ec@maxrnd.com>
 <Zz7-pdtxYgOCr6p7@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <Zz7-pdtxYgOCr6p7@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/21/2024 1:34 AM, Corinna Vinschen wrote:
> On Nov 21 01:12, Mark Geisert wrote:
>> Hi Corinna,
>>
>> On 11/18/2024 4:22 AM, Corinna Vinschen wrote:
>>> Hi Mark,
>>>
>>>
>>> Jon, would you mind to take a look, please?
>>
>> I appreciate the additional eyes, thanks.
>>
>>> This looks good to me, just one question...
>>>
>>> On Nov 12 22:03, Mark Geisert wrote:
>> [...]
>>>> +    /* Delay a short time so PdhCQD in caller will have data to collect */
>>>> +    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */
>>>
>>> Is there a reason you specificially chose 16 msecs here?
>>>
>>> I'm asking because the usual clock tick is roughly 15.x msecs.
>>> Any Sleep() > 0 but < 16 results in a sleep of a single clock tick, i.e.,
>>> 15 ms.  Occassionally 2 ticks, ~31 msecs, 1 to 5 out of 100 runs.
>>>
>>> If you choose a value of 15 msecs, the probability of a Sleep() taking
>>> two ticks is much higher and can be 1 out of 2 Sleep().
>>                      ^^^^^^
>>                      lower, I think
> 
> No, higher.  In a low load scenario
> 
> Sleep (1)  -->  < 5% will take two or more clock ticks
> Sleep (15) -->  up to 50 % will take two or more clock ticks
> Sleep (16) -->  100% will take two or more clock ticks

Ah, now I see what you mean.  So to maximize the probability it's only 
one tick, use "Sleep(1)".  Still that's not a guarantee it's one tick.
Have I got that right?
Thanks,

..mark
