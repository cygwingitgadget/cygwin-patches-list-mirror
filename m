Return-Path: <SRS0=Byep=SQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 66D32385801B
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 09:12:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 66D32385801B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 66D32385801B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732180364; cv=none;
	b=Ncg5rs44PlczYnYUo6p/7GOQerlY9oZOxH1wWm5dRkmZindKG5j8ziFJT6zm+8ZwbZoIXjLHqx4Zvb6BJZxgo3bliTi1AaI5uKEQ+7Q8UMVnFAoAlWzE5vVKuXMDUuaq+BcU9Al8ezahp9uUAfAD1nFWk0pxTIvxfzg563XP8hE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732180364; c=relaxed/simple;
	bh=q2n7X7ddoyi1PPl/qIsuRcEjkr9SLBA97uBnOTNCZpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=RN5S1VUijFTJfnDUfUVOvJgY1463sm88nrNn+3AiaP73mTWMZW23dW7AVj8XX0YdL4fgsavcb9lJO5OjYYoeKZ6CMBgHA247JZcFfbT4xjLIxSW7Tkpmz/x3GRT/DzPZGz5l3yVsof8Cf3d5gZjmHImeqEPRUAJfZWVuNV0sueA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4AL9Fegw007075
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 01:15:40 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdLK1HzS; Thu Nov 21 01:15:39 2024
Message-ID: <3a16a22f-3f16-4ebb-ac9b-a1ad3a71b1ec@maxrnd.com>
Date: Thu, 21 Nov 2024 01:12:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
To: cygwin-patches@cygwin.com
References: <20241113060354.2185-1-mark@maxrnd.com>
 <ZzsxhLhL_h3xey5h@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <ZzsxhLhL_h3xey5h@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 11/18/2024 4:22 AM, Corinna Vinschen wrote:
> Hi Mark,
> 
> 
> Jon, would you mind to take a look, please?

I appreciate the additional eyes, thanks.

> This looks good to me, just one question...
> 
> On Nov 12 22:03, Mark Geisert wrote:
[...]
>> +    /* Delay a short time so PdhCQD in caller will have data to collect */
>> +    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */
> 
> Is there a reason you specificially chose 16 msecs here?
> 
> I'm asking because the usual clock tick is roughly 15.x msecs.
> Any Sleep() > 0 but < 16 results in a sleep of a single clock tick, i.e.,
> 15 ms.  Occassionally 2 ticks, ~31 msecs, 1 to 5 out of 100 runs.
> 
> If you choose a value of 15 msecs, the probability of a Sleep() taking
> two ticks is much higher and can be 1 out of 2 Sleep().
                     ^^^^^^
                     lower, I think
> 
> If you choose a value of 16 msecs, all Sleep() invocations will run
> at least 2 clock ticks.

This Sleep() is only done once for any program that has called 
getloadavg(); it's in an initialization function.  So it's just one 
delay we're considering here, not anything in a loop.

That said, the idea is to minimize the delay but ensure one scheduler 
tick has occurred before this function returns to its caller that tries 
to read the counters.  I agree with your reasoning that 15ms is better 
than 16ms at limiting the delay to one tick.  Not perfect (due to 
Windows being Windows) but better than 16ms.

I'll make that change in the v3 patch forthcoming.
Thanks & Regards,

..mark
