Return-Path: <SRS0=dYbq=67=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 47D193858D39
	for <cygwin-patches@cygwin.com>; Tue,  7 Mar 2023 08:09:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 47D193858D39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 32789dxq001918
	for <cygwin-patches@cygwin.com>; Tue, 7 Mar 2023 00:09:39 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 76-217-4-51.lightspeed.irvnca.sbcglobal.net(76.217.4.51), claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdqM2BJ3; Tue Mar  7 00:09:33 2023
Subject: Re: type mismatch on cpuset.h
To: cygwin-patches@cygwin.com
References: <41f9bb68-d5e0-58d7-701f-a84b9db6b9a9@gmail.com>
 <ZAWqmGwaqbDtwNF8@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <cbc6009b-6aa0-69bd-e264-05e616f3721e@maxrnd.com>
Date: Tue, 7 Mar 2023 00:09:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <ZAWqmGwaqbDtwNF8@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

[Redirected here from the main mailing list...]

Hi Corinna,

Corinna Vinschen via Cygwin wrote:
> Hi Mark,
> 
> On Mar  6 07:57, Marco Atzeri via Cygwin wrote:
>> Hi,
>>
>> building latest gdal I noticed a type mismatch, that forced me to build
>> with "-fpermissive"
>>
>> on /usr/include/sys/cpuset.h
>>
>>   #define CPU_ALLOC(num)      __builtin_malloc (CPU_ALLOC_SIZE(num))
>>
>>
>> but on
>> https://linux.die.net/man/3/cpu_alloc
>>
>>   cpu_set_t *CPU_ALLOC(int num_cpus)
>>
>>
>> so void* versus cpu_set_t*
> 
> Marco is correct.  cpuset.h was your pet project a while back.  Would
> you like to pick it up?  Maybe we should convert all the macros into
> type-safe inline functions, or macros calling type-safe (inline)
> functions, as on Linux as well as on BSD?

As far as I can tell from online docs, the CPU_SET(3) macros are still macros on 
Linux, though they are documented with prototypes as if they were functions.  I 
don't immediately see a need to change our cpuset.h for this.

I'm also uncertain what exactly you mean by "type-safe" in this context.  Could 
you please give me an example for one of the macros?

I desk-checked all the macros vs their prototypes and I believe CPU_ALLOC that 
Marco ran into is the only faulty one.  It could be fixed with a cast.  CPU_FREE's 
result is void so I should make sure __builtin_free() corresponds. 
CPU_ALLOC_SIZE's result is size_t and I believe the macro is correct as-is because 
it is an expression using untyped integers and sizeof()s, the latter are 
size_t-returning.

The other few macros that return results return int, and those are precisely the 
ones whose inline code uses an int variable to accumulate a result.

If there is some other consideration I'm not seeing, e.g. readability, please let 
me know.  Otherwise I don't really see a need for changes here (modulo casting 
return values properly where needed).

..mark
