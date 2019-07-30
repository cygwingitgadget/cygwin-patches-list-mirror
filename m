Return-Path: <cygwin-patches-return-9531-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19580 invoked by alias); 30 Jul 2019 09:25:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19560 invoked by uid 89); 30 Jul 2019 09:25:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2 autolearn=ham version=3.3.1 spammy=PS, P.S, UD:P.S, pick
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Jul 2019 09:25:20 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id x6U9PIf0085752	for <cygwin-patches@cygwin.com>; Tue, 30 Jul 2019 02:25:19 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Date: Tue, 30 Jul 2019 09:25:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Implement CPU_SET(3) macros
In-Reply-To: <20190726071013.GF11632@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1907300211260.83956@m0.truegem.net>
References: <20190630225904.812-1-mark@maxrnd.com> <20190701073342.GI5738@calimero.vinschen.de> <b84163da-9b09-94bd-3043-7d47a1fffefb@maxrnd.com> <20190725143030.GC11632@calimero.vinschen.de> <6ac71730-75a7-5fa0-bc85-99f00a45c22a@maxrnd.com> <20190726071013.GF11632@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00051.txt.bz2

On Fri, 26 Jul 2019, Corinna Vinschen wrote:
> On Jul 25 14:15, Mark Geisert wrote:
>> Corinna Vinschen wrote:
>>> Hi Mark,
>>>
>>> On Jul  1 01:55, Mark Geisert wrote:
>>>> Corinna Vinschen wrote:
>>>>> On Jun 30 15:59, Mark Geisert wrote:
>>>>>> This patch supplies an implementation of the CPU_SET(3) processor
>>>>>> affinity macros as documented on the relevant Linux man page.
>>>>>> ---
>>>>>>    winsup/cygwin/include/sys/cpuset.h | 62 +++++++++++++++++++++++++++---
>>>>>>    winsup/cygwin/sched.cc             |  8 ++--
>>>>>>    2 files changed, 60 insertions(+), 10 deletions(-)
>>>>>> [...]
>>>>>> +#define CPU_SETSIZE  1024  // maximum number of logical processors tracked
>>>>>> +#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size of processor group
>>>>>> +#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum group number
>>>>>> -#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
>>>>>> -#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
>>>>>> +#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
>>>>>> +#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))
>>>>>
>>>>> I wouldn't do that.  Three problems:
>>>>> [...]
>>>>> There's also the request from Sebastian on the newlib list to
>>>>> consolidate the cpuset stuff from RTEMS and Cygwin into a single
>>>>> definition.
>>>>> [...]
>>>> I've also found that taskset isn't working properly on my build system with
>>>> the new CPU_SET code, though my other testcases are.  So even as submitted,
>>>> and fixed per your comments here, there's a bit more to be done.
>>>>
>>>> ..mark
>>>
>>> any chance to pick this up again?

I've been looking at this suggestion to consolidate the cpuset stuff from 
RTEMS and Cygwin.  There is no location common to both platforms to put 
this stuff other than Newlib's libc directory or maybe a non-sys subdir 
of libc.  If situated there, it could impact other newlib platforms, 
possibly.  It also seems a little messy to me to have to put four include 
files there.. cpuset.h, _cpuset.h, bitset.h, and _bitset.h.  Maybe I'm 
overthinking it.

RTEMS' cpuset.h is built on bitset.h, which is fine but the cpuset.h I 
wrote is self-contained and makes use of gcc builtins rather than C 
library calls for malloc, free, popcount, etc.  Mine is 32/64 agnostic, I 
believe RTEMS is too but I'm not totally sure; it depends on the length 
of 'long' items.

RTEMS' implementation includes some code modules needing to be linked into 
libc while the one I wrote is all in header files with some inline code.

These are all just minor implementation differences but I'm still hung up 
on the question of just where a common implementation could be placed in 
the source tree so both RTEMS and Cygwin can use them but other newlib 
platforms won't be tripped up.

..mark

P.S. IRC would be better for this kind of discussion. I'm waiting for my 
freenode registration to be processed.....
