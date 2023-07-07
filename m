Return-Path: <SRS0=7Azx=CZ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 1643E3853D32
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 10:13:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1643E3853D32
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 367AF1qM081894
	for <cygwin-patches@cygwin.com>; Fri, 7 Jul 2023 03:15:01 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdBJIVgV; Fri Jul  7 03:14:55 2023
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <465f8863-6559-e061-684a-a2a812e9c4c6@maxrnd.com>
Date: Fri, 7 Jul 2023 03:13:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Corinna Vinschen wrote:
> On Jul  7 00:41, Mark Geisert wrote:
>> The current version of <sys/cpuset.h> cannot be compiled by Clang due to
>> the use of __builtin* functions.  Their presence here was a dubious
>> optimization anyway, so their usage has been converted to standard
>> library functions.  A popcnt (population count of 1 bits in a word)
>> function is provided here because there isn't one in the standard library
>> or elsewhere in the Cygwin DLL.
> 
> And clang really doesn't provide it?  That's unfortunate.
> 
> Do you really think it's not worth to use it if it's available?

I don't know for sure.  I'd guess the popcnt op should be optimized if available; 
the others probably don't need it.

> You could workaround it like this:
> 
>> +/* Modern CPUs have popcnt* instructions but the need here is not worth
>> + * worrying about builtins or inline assembler for different compilers. */
>> +static inline int
>> +__maskpopcnt (__cpu_mask mask)
>> +{
> #if (__GNUC__ >= 4)
>       return __builtin_popcountl (mask);
> #else
>> +  int res = 0;
>> +  unsigned long ulmask = (unsigned long) mask;
>> +
>> +  while (ulmask != 0)
>> +    {
>> +      if (ulmask & 1)
>> +        ++res;
>> +      ulmask >>= 1;
>> +    }
>> +  return res;
> #endif
>> +}
>> +

The first version of the patch (unsubmitted) worked something like that, though it 
was a chore figuring out how to tell the difference between gcc and clang.  clang 
#defines __GNUC__ (?!) for example.  I ended up using __GNUC_PREREQ__ with the 
hope clang version numbers stay lower than gcc version numbers.  Has to be a 
better way than that.

On the other hand, one compilation with clang or clang++, I forget which, and with 
some optimization flag, recognized the 'while' loop in that function and turned it 
into the Hackers Delight algorithm for popcnt in ~20 instructions and no loop.

TL;DR let me ponder this over the weekend.
Thanks for listening,

..mark

