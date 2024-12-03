Return-Path: <SRS0=vp5K=S4=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id 191D53858D33
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 15:23:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 191D53858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 191D53858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733239413; cv=none;
	b=LaguCdyCdX9+Tqg5RpNix6sV4EaEULVWC8fJx7Mbw3rAdtx+MeeIgnylmtZItuo3LGFM+i5P/SH7QgGuvtQyNcAjfcUycQthun3Ne7De00eCsgfKcOiVNA2oLwDHU8SipRFf2V+ovppibY+vX+RjfdZ8IRnSspaW0dfK2yCoQoM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733239413; c=relaxed/simple;
	bh=M3R77ghPymTSHVHHUkojHe3xJ9IVP5bj4r+ri8VUBqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:DKIM-Signature; b=VNKrgQlMFeo03fG5ScW52BdeMlMc5hiF/Kc6AVDWNsEbePx224Npuw3sRXJk3KrGxbQyBmizkLZezp1twxwfCNCDRWhSugHbUn9n8I/EQBfU5v7jQAEw+01z1oF+RDTKNE4upaf3O9EQJlAagNs+hvPZ1E1Uvt/+9ZXOuNz7Jng=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 191D53858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=B+epBxJP
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A3D6012095C
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 15:23:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id B5E0218
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 15:23:18 +0000 (UTC)
Message-ID: <cb5f0aa9-82f7-4a1f-9788-05b05162923a@SystematicSW.ab.ca>
Date: Tue, 3 Dec 2024 08:23:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
 <c6f21ed2-679d-4a89-a8a3-b0b1e9d1714f@SystematicSW.ab.ca>
 <80e1716d-d268-e5cd-b9ff-484aa5dcc344@t-online.de>
 <Z08EFs_LTnjKL6xr@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <Z08EFs_LTnjKL6xr@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5E0218
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout08
X-Stat-Signature: u97fnte41ah9m81xiwpjqa91t368yexk
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+S9UKtunHROUtZHoQ1GUXWXuyy0ysWzRA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:to:references:from:in-reply-to:content-type:content-transfer-encoding; s=he; bh=uVnG3T+YAe2xOH4pI/HQ+tpfDGatkKP/dmh6znTgmiY=; b=B+epBxJP1pgCOIZlCLIsbmmLo8KGVQ0KVp429/1mVRGwsgmaSZOr5pPg4LGc6x3qEf56A7L/nGsw78MvEPKozyI/2Y+nHKc4s6Wm/QJeiGExI+fIpaiiivGFPOzjw+dNrhrsfPCC1n/17NgIj5w8uHTEt7Bl5IUvDtTOgpxr8Q6Bf2ZpJ8oHUFG7TffVSfG5Gm76u7ujVOrFwIi5ir1WTuIfGgLmtV+hDqhctU2zCfV1sVevzi3rAagFJOlVjd3g04bl+wRFxb/2f01vcFPnzx5vYSIUAoZ8RGHOYVaDjOhm1gYBJBPPGyYYJbiBVcKAteQxye0HsW1sykAKR+pITA==
X-HE-Tag: 1733239398-436936
X-HE-Meta: U2FsdGVkX18e4puAlB5ed7p6gUqYnVF3stlKkmyWr/jRTKvdoMNDOw4nSf17xch64Ay23oLK6ORxDjAe4iMBwNqeul7ttFJV1fCB3VCWEE0RhHDEg/1ACdOCAk0L2gCURLMDKCXYnBMkLYTDdbV/+SI36VJfeV8yxedWw2EviT/uaRqY85sCw6BMXAll4UUDIR7PLZpuiVnRGCyPimOa/KYBGFo2UuKxgJPFQKf17uQzMHAXIe3iqtZgh+esxW+CRIZVdhI6z23XB6CaMEsMPy0db4kCOVkl8/EMl+FcfJ8ROVcaEbjxnXRJrh2wAaHmqhdLv45GdwSZY33JMxFQ51A93AoBJwTrVsuMMTOwJ2r8JZjNPYrSGLr/He068tShBFtBzRe/l8UADFY7Es5O1g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-12-03 06:13, Corinna Vinschen wrote:
> On Dec  3 10:20, Christian Franke wrote:
>> Brian Inglis wrote:
>>> On 2024-12-02 11:28, ASSI wrote:
>>>> Christian Franke writes:
>>>>> +    nice value   sched_priority Windows priority class
>>>>> +     12...19      1....6          IDLE_PRIORITY_CLASS
>>>>> +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
>>>>> +     -4....3     13...18          NORMAL_PRIORITY_CLASS
>>>>> +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
>>>>> +    -13..-19     25...30          HIGH_PRIORITY_CLASS
>>>>> +         -20     31...32          REALTIME_PRIORITY_CLASS
>>>>
>>>> That mapping looks odd… care to explain why the number of nice values
>>>> and sched_priorities doesn't match up for each priority class? 39
>>>> possible values for one can't match to 32 for the other of course, but
>>>> which ones are skipped and why?
>>>
>>> See also miscfuncs.cc which maps nice<->winprio with a 40 entry table,
>>> and cygwin-doc proc(5) or cygwin-ug-net/proc.html which explains the
>>> mapping to scheduler priorities and policies.
>>
>> No *_PRIORITY_CLASS is mentioned in current newlib-cygwin/winsup/doc/*.

>>> Also relevant may be man-pages-posix sched.h(0p), man-pages-linux
>>> sched(7) and proc_pid_stat(5).
>>>
>>> You may also wish to consider whether SCHED_SPORADIC should be somewhat
>>> supported for POSIX compatibility, and SCHED_IDLE, SCHED_BATCH,
>>> SCHED_DEADLINE for Linux compatibility?
>>
>> SCHED_IDLE: Ignore nice value and set IDLE_PRIORITY_CLASS ?
> 
> Would make sense, I guess.
> 
>> SCHED_BATCH: Reduced mapping, e.g. nice=0 -> BELOW_NORMAL_PRIORITY_CLASS ?
> 
> Sounds good.
> 
>> SCHED_SPORADIC, SCHED_DEADLINE: ?
> 
> We can't model SCHED_DEADLINE in Windows.
> 
>> The current newlib/libc/include/sys/sched.h only defines SCHED_OTHER,
>> SCHED_FIFO, SCHED_RR and SCHED_SPORADIC. The latter is guarded by
>> _POSIX_SPORADIC_SERVER which is only set for RTEMS (#ifdef __rtems__) in
>> features.h.
> 
> SCHED_SPORADIC is a bit of a problem.  It requires extension of the
> sched_param struct with values we're not able to handle.

=> SCHED_IDLE?
Could be something like a background process on a real time system?

> Also, SCHED_SPORADIC doesn't exist in Linux either, so why bother.

	https://pubs.opengroup.org/onlinepubs/9799919799/

sched.h Change History:

"Sporadic server members are added to the sched_param structure, and the 
SCHED_SPORADIC scheduling policy is added for alignment with IEEE Std 1003.1d-1999."

It's been in POSIX since at least Issue 6 thru 8, with no changes in last go 
round, so presumably it exists and is used on some major platform(s)?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
