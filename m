Return-Path: <SRS0=f6sa=SU=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 252E23858C52
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 20:20:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 252E23858C52
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 252E23858C52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732566027; cv=none;
	b=OtkfVdM3RIEDqNmIIfdId+EH3ZBe8b+A59En9KLnp12qD8SGDL0DYeqbzi7qim2Nx2ZCeeu3S68kP6XZd69g1CQTknE4j2Ip/arl6Hlo01Yo3pAsatjL3vhYxpX5ZCCA++BIj1rYCz8sVXUHMGnwSWUbRVGezvTPAQx+2T5lizs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732566027; c=relaxed/simple;
	bh=EOPA1CciK96jkxznmzk8xbQYM2rCDOXbLRyIJJhfS5s=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=iqExkrBViapLRj1YPz6tsSGOuvJNXGy8HB/OvPCsMv5QrwPfLF4yr4Q+Hq5xYtKAVccGZVtVKKajIGAVhEwiZ7xVE00DHbmlvn61ZJ8Z5n7vKrK99FsXK3vxXLpqUQhEkmb+wO7XpuzOTMRxDEY5xC/HgsurEN53PXwnSEhFZjo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 252E23858C52
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
	by mailout10.t-online.de (Postfix) with SMTP id 272CE8E4
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 21:20:23 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd81.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tFfZD-34XW6q0; Mon, 25 Nov 2024 21:20:19 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
 <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <5d40600d-8929-ebc4-d417-6e8b3221d09e@t-online.de>
Date: Mon, 25 Nov 2024 21:20:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1732566019-DCFEFD18-DECD427D/0/0 CLEAN NORMAL
X-TOI-MSGID: 6dd3c349-737c-4b31-9242-7b0de535709d
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Corinna Vinschen wrote:
> Hi Christian,
>
> On Nov 25 15:00, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> Fixes: ...?
>> ... the very first commit (cgf 2001) of sched.cc :-)
>>
>> New patch attached.
>>
>>  From e95fc1aceb5287f9ad65c6c078125fecba6c6de9 Mon Sep 17 00:00:00 2001
>> From: Christian Franke <christian.franke@t-online.de>
>> Date: Mon, 25 Nov 2024 14:51:04 +0100
>> Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
>>
>> Behave like sched_setparam() if the requested policy is identical
>> to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
>>
>> Fixes: 6b2a2aa4af1e ("Add missing files.")
> Huh, yeah, this is spot on.  I wonder if it would make sense to change
> that to 9a08b2c02eea ("* sched.cc: New file.  Implement sched*.")
> though, given that was the patch intended to add sched.cc :)))
>
> Sorry, but I have to ask two more questions:
>
> - Isn't returning SCHED_FIFO sched_getscheduler() just as wrong?

Definitly. SCHED_FIFO is a non-preemptive(!) real-time policy. Windows 
does not offer anything like that to userland (AFAIK).

https://man7.org/linux/man-pages/man7/sched.7.html

I wonder whether there was a use case for this emulation when this 
module was introduced in 2001.


>    Shouldn't that be SCHED_OTHER, and sched_setscheduler() should check
>    for that instead?  Cygwin in a real-time scenario sounds a bit
>    far-fetched...

Agree.

Note that SCHED_OTHER requires sched_priority == 0, so most of the 
sched_get/set*() priority related code would no longer make sense then.

A related interesting snippet which I don't understand:
sys/sched.h:
#if defined(__CYGWIN__)
#define SCHED_OTHER    3
#else
#define SCHED_OTHER    0
#endif

> - Don't you want this patch in 3.5.5?  I'd merge the other patch
>    into 3.5.5 anyway...

OK.

-- 
Regards,
Christian

