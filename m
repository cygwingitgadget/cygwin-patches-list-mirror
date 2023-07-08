Return-Path: <SRS0=9nkE=C2=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 930853858C52
	for <cygwin-patches@cygwin.com>; Sat,  8 Jul 2023 20:59:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 930853858C52
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 368L0o1m041955
	for <cygwin-patches@cygwin.com>; Sat, 8 Jul 2023 14:00:50 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpd1m7qym; Sat Jul  8 14:00:49 2023
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
 <073cd700-c727-ee29-017e-df8d86a1db59@Shaw.ca>
 <1f7d3254-234e-378f-a852-63ca5d7ca01f@Shaw.ca>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <589a2704-d690-60f4-4818-687233699c4c@maxrnd.com>
Date: Sat, 8 Jul 2023 13:59:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <1f7d3254-234e-378f-a852-63ca5d7ca01f@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Brian Inglis wrote:
> On 2023-07-07 12:54, Brian Inglis wrote:
>> On 2023-07-07 03:44, Corinna Vinschen wrote:
>>> Hi Mark,
>>>
>>> On Jul  7 00:41, Mark Geisert wrote:
>>>> The current version of <sys/cpuset.h> cannot be compiled by Clang due to
>>>> the use of __builtin* functions.  Their presence here was a dubious
>>>> optimization anyway, so their usage has been converted to standard
>>>> library functions.  A popcnt (population count of 1 bits in a word)
>>>> function is provided here because there isn't one in the standard library
>>>> or elsewhere in the Cygwin DLL.
>>>
>>> And clang really doesn't provide it?  That's unfortunate.
>>>
>>> Do you really think it's not worth to use it if it's available?
>>>
>>> You could workaround it like this:
>>>
>>>> +/* Modern CPUs have popcnt* instructions but the need here is not worth
>>>> + * worrying about builtins or inline assembler for different compilers. */
>>>> +static inline int
>>>> +__maskpopcnt (__cpu_mask mask)
>>>> +{
>>> #if (__GNUC__ >= 4)
>>>       return __builtin_popcountl (mask);
> 
> Missed the difference in spelling, but clang supports the same builtin functions 
> __builtin_popcount{,l,ll} et. al. or provides *optimized* inline functions if not 
> directly available as an instruction on the architecture.

Clang in its current version 16.0.x has __builtin_popcount*, but not in the 
ancient version 8.0.1 that is currently packaged for Cygwin.  I think that's what 
was behind Jon's earlier comment that perhaps we should remove clang from Cygwin 
unless/until somebody can adopt and maintain an up-to-date version.  :-(.

..mark
