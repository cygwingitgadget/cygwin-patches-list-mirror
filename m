Return-Path: <cygwin-patches-return-9528-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20646 invoked by alias); 25 Jul 2019 21:15:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20636 invoked by uid 89); 25 Jul 2019 21:15:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2 autolearn=ham version=3.3.1 spammy=H*UA:6.1, H*u:6.1
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 25 Jul 2019 21:15:41 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x6PLFd8x071899	for <cygwin-patches@cygwin.com>; Thu, 25 Jul 2019 14:15:39 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdACQUEZ; Thu Jul 25 14:15:34 2019
Subject: Re: [PATCH] Cygwin: Implement CPU_SET(3) macros
To: cygwin-patches@cygwin.com
References: <20190630225904.812-1-mark@maxrnd.com> <20190701073342.GI5738@calimero.vinschen.de> <b84163da-9b09-94bd-3043-7d47a1fffefb@maxrnd.com> <20190725143030.GC11632@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <6ac71730-75a7-5fa0-bc85-99f00a45c22a@maxrnd.com>
Date: Thu, 25 Jul 2019 21:15:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190725143030.GC11632@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00048.txt.bz2

Corinna Vinschen wrote:
> Hi Mark,
> 
> On Jul  1 01:55, Mark Geisert wrote:
>> Corinna Vinschen wrote:
>>> On Jun 30 15:59, Mark Geisert wrote:
>>>> This patch supplies an implementation of the CPU_SET(3) processor
>>>> affinity macros as documented on the relevant Linux man page.
>>>> ---
>>>>    winsup/cygwin/include/sys/cpuset.h | 62 +++++++++++++++++++++++++++---
>>>>    winsup/cygwin/sched.cc             |  8 ++--
>>>>    2 files changed, 60 insertions(+), 10 deletions(-)
>>>> [...]
>>>> +#define CPU_SETSIZE  1024  // maximum number of logical processors tracked
>>>> +#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size of processor group
>>>> +#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum group number
>>>> -#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
>>>> -#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
>>>> +#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
>>>> +#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))
>>>
>>> I wouldn't do that.  Three problems:
>>> [...]
>>> There's also the request from Sebastian on the newlib list to
>>> consolidate the cpuset stuff from RTEMS and Cygwin into a single
>>> definition.
>>> [...]
>> I've also found that taskset isn't working properly on my build system with
>> the new CPU_SET code, though my other testcases are.  So even as submitted,
>> and fixed per your comments here, there's a bit more to be done.
>>
>> ..mark
> 
> any chance to pick this up again?

Hi; yes, certainly. I'm back but ill. It may be a week or so before I have an 
update/fix. Top of my list of pending items that require concentration ;-).

..mark
