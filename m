Return-Path: <SRS0=B7qI=SW=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
	by sourceware.org (Postfix) with ESMTPS id 2DFAF3857B84
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 09:14:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2DFAF3857B84
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2DFAF3857B84
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732698898; cv=none;
	b=ZEcDEgF7tnqM01EMQ6KTapQBAd2xO11rIL2OTOKP8DIg5yb9vUibA8SHlzShoFv6C54Nt5b0xIx9Iot+z7MnaLB42ks7oPF/gaM6p8bRyKwXxllqOCTLHweZL934vceCgf02FDkqrWu3w4TOk6wi9Gq8Yg0fvBGdamgkhpJJDSg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732698898; c=relaxed/simple;
	bh=KneW0hmq5gRiGui+VzOr77pRzUTgPeFTpz+d2CL+5iE=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=RSDiycrjyzf2YGphPSCcXrl76d3q5TWJDftbqud4tkDemFtAiPMr040oIs33ROoMQOcgMuiMqCSZvtMfO8VyrQgdfEnSJ8+KFAkudSw3pgwgHy0q9Z7Q5IqEOet6CqVYkrm5vkemcZfTgpCJ2gseTb4kYMuYNGAdr/JbBcvfbPw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2DFAF3857B84
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout06.t-online.de (Postfix) with SMTP id 8745C1EC9
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 10:14:51 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tGE8H-10UE3U0; Wed, 27 Nov 2024 10:14:49 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
 <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
 <5d40600d-8929-ebc4-d417-6e8b3221d09e@t-online.de>
 <Z0XFU636aT986Vtn@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <a4acc9e3-8363-b9af-e92e-b3a865b18d20@t-online.de>
Date: Wed, 27 Nov 2024 10:14:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z0XFU636aT986Vtn@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1732698889-337E4998-707BAF2D/0/0 CLEAN NORMAL
X-TOI-MSGID: 5e11f68e-6d03-4373-8a20-8245478f7b97
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov 25 21:20, Christian Franke wrote:
>> Hi Corinna,
>>
>> Corinna Vinschen wrote:
>>> Hi Christian,
>>>
>>> On Nov 25 15:00, Christian Franke wrote:
>>>> Corinna Vinschen wrote:
>>>>> Fixes: ...?
>>>> ... the very first commit (cgf 2001) of sched.cc :-)
>>>>
>>>> New patch attached.
>>>>
>>>>   From e95fc1aceb5287f9ad65c6c078125fecba6c6de9 Mon Sep 17 00:00:00 2001
>>>> From: Christian Franke <christian.franke@t-online.de>
>>>> Date: Mon, 25 Nov 2024 14:51:04 +0100
>>>> Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
>>>>
>>>> Behave like sched_setparam() if the requested policy is identical
>>>> to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
>>>>
>>>> Fixes: 6b2a2aa4af1e ("Add missing files.")
>>> Huh, yeah, this is spot on.  I wonder if it would make sense to change
>>> that to 9a08b2c02eea ("* sched.cc: New file.  Implement sched*.")
>>> though, given that was the patch intended to add sched.cc :)))
>>>
>>> Sorry, but I have to ask two more questions:
>>>
>>> - Isn't returning SCHED_FIFO sched_getscheduler() just as wrong?
>> Definitly. SCHED_FIFO is a non-preemptive(!) real-time policy. Windows does
>> not offer anything like that to userland (AFAIK).
>>
>> https://man7.org/linux/man-pages/man7/sched.7.html
>>
>> I wonder whether there was a use case for this emulation when this module
>> was introduced in 2001.
> Just guessing here, but using one of the RT schedulers was the only way
> to enable changing the priority from user space and using SCHED_FIFO was
> maybe in error.
>
>>>     Shouldn't that be SCHED_OTHER, and sched_setscheduler() should check
>>>     for that instead?  Cygwin in a real-time scenario sounds a bit
>>>     far-fetched...
>> Agree.
>>
>> Note that SCHED_OTHER requires sched_priority == 0, so most of the
>> sched_get/set*() priority related code would no longer make sense then.
> This is the other problem. Changing this to SCHED_OTHER sounds like
> dropping potentially used functionality.  Maybe we should just switch to
> SCHED_RR?

Yes, it at least would be closer to what windows does. It is still 
non-preemptive from the point of view of lower priorities. I don't know 
what the Win32 *_PRIORITY_CLASSes actually do.

As far as I understand the related documentation, a more sophisticated 
emulation (aka fake) of SCHED_* would be:

- Allow to switch between SCHED_OTHER (default) and SCHED_RR with 
sched_setscheduler().

- If SCHED_OTHER is selected, change PRIORITY_CLASS with setpriority() 
and ignore (or fail on?) attempts to change sched_priority with 
sched_setparam().

- If SCHED_RR is selected, ignore setpriority() and change 
PRIORITY_CLASS with sched_setparam().

Possibly not worth the effort...

-- 
Regards,
Christian

