Return-Path: <SRS0=gc88=CV=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4954A38582A3
	for <cygwin-patches@cygwin.com>; Mon,  3 Jul 2023 09:27:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4954A38582A3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3639SbE6069465
	for <cygwin-patches@cygwin.com>; Mon, 3 Jul 2023 02:28:37 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdB7SuXX; Mon Jul  3 02:28:31 2023
Subject: Re: [PATCH] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
To: cygwin-patches@cygwin.com
References: <20230703061730.5147-1-mark@maxrnd.com>
 <b5d4a958-cab1-ab8f-d268-0be51e4ebf34@Shaw.ca>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <ec36ad41-7a70-b0bb-83fe-12fb6e905b3c@maxrnd.com>
Date: Mon, 3 Jul 2023 02:27:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <b5d4a958-cab1-ab8f-d268-0be51e4ebf34@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,BODY_8BITS,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

Brian Inglis wrote:
> On 2023-07-03 00:17, Mark Geisert wrote:
>> Three modifications to include/sys/cpuset.h:
>> * Change C++-style comments to C-style also supported by C++
>> * Change "inline" to "__inline" on code lines
>> * Don't declare loop variables on for-loop init clauses
>>
>> Tested by first reproducing the reported issue with home-grown test
>> programs by compiling with gcc option "-std=c89", then compiling again
>> using the modified <sys/cpuset.h>. Other "-std=" options tested too.
>>
>> Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
>> Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")
>>
>> ---
>>   winsup/cygwin/include/sys/cpuset.h | 47 ++++++++++++++++--------------
>>   winsup/cygwin/release/3.4.7        |  3 ++
>>   2 files changed, 28 insertions(+), 22 deletions(-)
>>
>> diff --git a/winsup/cygwin/include/sys/cpuset.h 
>> b/winsup/cygwin/include/sys/cpuset.h
>> index d83359fdf..01576b041 100644
>> --- a/winsup/cygwin/include/sys/cpuset.h
>> +++ b/winsup/cygwin/include/sys/cpuset.h
>> @@ -14,9 +14,9 @@ extern "C" {
>>   #endif
>>   typedef __SIZE_TYPE__ __cpu_mask;
>> -#define __CPU_SETSIZE 1024  // maximum number of logical processors tracked
>> -#define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor group
>> -#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group number
>> +#define __CPU_SETSIZE 1024  /* maximum number of logical processors tracked */
>> +#define __NCPUBITS (8 * sizeof (__cpu_mask))  /* max size of processor group */
>> +#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  /* maximum group number */
>>   #define __CPUELT(cpu)  ((cpu) / __NCPUBITS)
>>   #define __CPUMASK(cpu) ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
>> @@ -32,21 +32,21 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
>>   /* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
>>      Allocations are padded such that full-word operations can be done easily. */
>>   #define CPU_ALLOC_SIZE(num) __cpuset_alloc_size (num)
> 
> Does this patch need __inline defined e.g.
> 
>    +#include <sys/cdefs.h>
> 
> did you perhaps include this directly in your test cases?
> 
>> -static inline size_t
>> +static __inline size_t
> ...

No, not directly.  The test case with the shortest list of #includes has:
#define _GNU_SOURCE
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/cpuset.h>
#include <sched.h>

So it's apparently defined by one of those or some sub-include.  But indeed it's 
not safe to depend on that so I will try harder to figure out what other 
occurrences of __inline in the Cygwin source tree are depending on for the definition.
Thanks,

..mark
