Return-Path: <cygwin-patches-return-9481-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7308 invoked by alias); 1 Jul 2019 08:55:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7299 invoked by uid 89); 1 Jul 2019 08:55:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=H*MI:sk:2019070, apps, goals, H*i:sk:2019070
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 01 Jul 2019 08:55:39 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x618tccf024961	for <cygwin-patches@cygwin.com>; Mon, 1 Jul 2019 01:55:38 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdJaPDTi; Mon Jul  1 01:55:29 2019
Subject: Re: [PATCH] Cygwin: Implement CPU_SET(3) macros
To: cygwin-patches@cygwin.com
References: <20190630225904.812-1-mark@maxrnd.com> <20190701073342.GI5738@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <b84163da-9b09-94bd-3043-7d47a1fffefb@maxrnd.com>
Date: Mon, 01 Jul 2019 08:55:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190701073342.GI5738@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00001.txt.bz2

Corinna Vinschen wrote:
> Hi Mark,
> 
> On Jun 30 15:59, Mark Geisert wrote:
>> This patch supplies an implementation of the CPU_SET(3) processor
>> affinity macros as documented on the relevant Linux man page.
>> ---
>>   winsup/cygwin/include/sys/cpuset.h | 62 +++++++++++++++++++++++++++---
>>   winsup/cygwin/sched.cc             |  8 ++--
>>   2 files changed, 60 insertions(+), 10 deletions(-)
>>
>> diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
>> index 4857b879d..9c8417b73 100644
>> --- a/winsup/cygwin/include/sys/cpuset.h
>> +++ b/winsup/cygwin/include/sys/cpuset.h
>> @@ -14,20 +14,70 @@ extern "C" {
>>   #endif
>>   
>>   typedef __SIZE_TYPE__ __cpu_mask;
>> -#define __CPU_SETSIZE 1024  // maximum number of logical processors tracked
>> -#define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor group
>> -#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group number
>> +#define CPU_SETSIZE  1024  // maximum number of logical processors tracked
>> +#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size of processor group
>> +#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum group number
>>   
>> -#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
>> -#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
>> +#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
>> +#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))
> 
> I wouldn't do that.  Three problems:
> 
> - The non-underscored definitions should only be exposed #if __GNU_VISIBLE
>    because otherwise they clutter the application namespace.

Ah, I didn't consider that.  Will wrap appropriately.

> - CPU_WORD and CPU_MASK don't exist at all in glibc, so I don't see
>    why you rename __CPUELT and __CPUMASK at all.

Conflicting goals and I made a wrong choice.  I thought leading underscores 
meant "implementation details" and so should not be directly used by apps.  And 
I was trying to distinguish this implementation from glibc's per Eric's comment 
on the newlib list.  I figured these two macros would be useful to app coders so 
renamed them to indicate they can use them.

And then I found taskset uses one or more of the underscored ones... So I'll 
revert this bit.

> - CPU_GROUPMAX does not exist in glibc either. As a non-standard
>    macro it should be kept underscored.

Not in glibc because it's a Windows-related construct.  Will keep underscored.

> Keep (and use) the underscored variations throughout, and only expose
> the non-underscored macro set #if __GNU_VISIBLE.

Got it.  Thanks!

> There's also the request from Sebastian on the newlib list to
> consolidate the cpuset stuff from RTEMS and Cygwin into a single
> definition.  It's not exactly straightforward given the different
> definition of cpuset_t from FreeBSD, but it's probably not very
> complicated either.  Maybe something for after your vaca?

Yes, later if at all :-).  I looked at the FreeBSD 11.0 man page for CPUSET(9), 
as they call it, from
https://www.freebsd.org/cgi/man.cgi?query=cpuset&sektion=9&apropos=0&manpath=FreeBSD+11.0-RELEASE+and+Ports
and see that there's some family resemblance but many differences.  I'll have to 
look at RTEMS' again to see how they combined FreeBSD and Linux variants.

I've also found that taskset isn't working properly on my build system with the 
new CPU_SET code, though my other testcases are.  So even as submitted, and 
fixed per your comments here, there's a bit more to be done.

..mark
