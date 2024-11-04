Return-Path: <SRS0=kWoq=R7=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 0A9243858C3A
	for <cygwin-patches@cygwin.com>; Mon,  4 Nov 2024 02:02:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0A9243858C3A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0A9243858C3A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730685806; cv=none;
	b=VOrUTEsS5LWpq2CucSAhjUSaDyy75pbZvdMjM4+7g0xaIXE/3ByqWOAlLkUVis/iBw+eX29v/c9A9cDmwzM6i+EcQUu8UODfxnYN34P0xNSqRb6KFukhAZhqUiALIt7MWZo6AX1j1l92lEVjAUSg6GrsmAwXblKMNZHTetfD1Mg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730685806; c=relaxed/simple;
	bh=q00jU8xBUBjOl4V6NmGCpY5RZofh+4ng10GEvshQ/uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=jEv88DyH3n7VDMy+83oaH3NlUVJWrnkeiRn2V0NIfrQHUHCIGoVMfkkZiSl1PTDaiwLm3t9jMq84vjc9iIOoN1IQdsB2TPFfrbpdvDu4usa9M3nOMyFPljTdP3YrccxkfP5ouYMVt4wBSkZqRSBRyJRKrw6bCxaM2PzfuHVzFQA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4A425FeS085735
	for <cygwin-patches@cygwin.com>; Sun, 3 Nov 2024 18:05:15 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpd90WPIX; Sun Nov  3 18:05:14 2024
Message-ID: <63c03788-6b71-44b3-abc3-5de29e79971e@maxrnd.com>
Date: Sun, 3 Nov 2024 18:02:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On 11/3/2024 3:15 AM, Christian Franke wrote:
> Mark Geisert wrote:
>> Hi Corinna,
>>
>> On 10/22/2024 7:45 AM, Corinna Vinschen wrote:
[...]
>>> Even if the old prototype was wrong, we probably have to keep it for
>>> backward compatibility.  As unlikely as it seems, but there may be
>>> binaries out there actually using the old prototype.
>>>
>>> We can discuss this probability, but assuming we want to keep backward
>>> compat at all cost, we would have to
>>
>> No need to discuss. I'm happy keeping backward compatibility.
>>
>>> - create a new function like pthread_sigqueue_with_correct_prototype 
>>> (heh)
>>>
>>> - Add this function to cygwin.din as exported symbol
>>>
>>> - Add a matching entry to NEW_FUNCTIONS in Makefile.am, e.g.,
>>>
>>>      pthread_sigqueue=pthread_sigqueue_with_correct_prototype,
>>>
>>> - Implement either pthread_sigqueue_with_correct_prototype calling
>>>    pthread_sigqueue or vice versa, whatever makese more sense.
>>
>> I appreciate your redirecting me towards an acceptable solution. I've 
>> re-implemented the fix as you've indicated but there's one thing I 
>> cannot figure out. (BTW I implemented a new 
>> pthread_sigqueue_portable() calling existing pthread_sigqueue().)
>>
>> In cygwin/include/pthread.h, should both function names appear or just 
>> pthread_sigqueue? If the latter, which version of prototype? It seems 
>> problematic: We want the include file to have the new, portable, 
>> prototype for pthread_sigqueue() don't we? Doesn't that require that 
>> the original pthread_sigqueue() be renamed to something else and have 
>> it call the new pthread_sigqueue()? Maybe that changes one or more of 
>> the steps you wrote above?
> 
> If backward compatibility with existing binaries using 
> pthread_sigqueue() is desired, I would suggest:
> - Keep functionality and export symbol of the existing pthread_sigqueue().
> - Use a different export symbol for the new function.
> - By default, map the pthread_sigqueue() call to the new symbol.
> - Invent a #define that allows to use the old function.
> 
> pthread.h:
> ...
> // TODO: Add some comment explaining this hack :-)
> int _pthread_sigqueue_with_id(pthread_t, int, const union sigval);
> 
> #ifdef _CYGWIN_USE_OLD_PTHREAD_SIGQUEUE
> int pthread_sigqueue (pthread_t *, int, const union sigval)
>    __attribute__((__warning__("Using old version of pthread_sigqueue()")));
> #else
> int pthread_sigqueue (pthread_t, int, const union sigval)
>    __asm__("_pthread_sigqueue_with_id");
> #endif

Yes, this or something like it would seem to work. The issue to be 
solved also looks like something Cygwin API version bumps are for.
I await Corinna's input.
Thanks & Regards,

..mark
