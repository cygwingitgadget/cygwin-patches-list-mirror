Return-Path: <cygwin-patches-return-9460-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108766 invoked by alias); 25 Jun 2019 08:17:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108643 invoked by uid 89); 25 Jun 2019 08:17:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_SHORT autolearn=ham version=3.3.1 spammy=H*u:6.1, H*UA:6.1
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 08:17:24 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5P8HMKg030043	for <cygwin-patches@cygwin.com>; Tue, 25 Jun 2019 01:17:22 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdxtOw7v; Tue Jun 25 01:17:15 2019
Subject: Re: [PATCH] Cygwin: Fix return value of sched_getaffinity
To: cygwin-patches@cygwin.com
References: <20190625052523.1927-1-mark@maxrnd.com> <20190625073133.GE5738@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <2cf19e65-3248-b25a-7983-e73094482285@maxrnd.com>
Date: Tue, 25 Jun 2019 08:17:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190625073133.GE5738@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00167.txt.bz2

Corinna Vinschen wrote:
> Hi Mark,
> 
> On Jun 24 22:25, Mark Geisert wrote:
>> Return what the documentation says, instead of a misreading of it.
>> ---
>>   winsup/cygwin/sched.cc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
>> index e7b44d319..8f24bf80d 100644
>> --- a/winsup/cygwin/sched.cc
>> +++ b/winsup/cygwin/sched.cc
>> @@ -608,7 +608,7 @@ done:
>>     else
>>       {
>>         /* Emulate documented Linux kernel behavior on successful return */
>> -      status = wincap.cpu_count ();
>> +      status = sizeof (cpu_set_t);
> 
> Wait... what docs are you referring to?  The Linux man page in Fedora 29
> says
> 
>   On success, sched_setaffinity() and sched_getaffinity() return  0.   On
>   error, -1 is returned, and errno is set appropriately.

I've been using http://man7.org/linux/man-pages/man2/sched_setaffinity.2.html
which has the text you quoted under the RETURN VALUE heading, but has the 
following further down the page under the heading "C library/kernel differences":
|        This manual page describes the glibc interface for the CPU affinity
|        calls.  The actual system call interface is slightly different, with
|        the mask being typed as unsigned long *, reflecting the fact that the
|        underlying implementation of CPU sets is a simple bit mask.
|
|        On success, the raw sched_getaffinity() system call returns the
|        number of bytes placed copied into the mask buffer; this will be the
|        minimum of cpusetsize and the size (in bytes) of the cpumask_t data
|        type that is used internally by the kernel to represent the CPU set
|        bit mask.

I see now that that 2nd paragraph has actually been updated since I printed it 
out in April so I'll need to update the patch yet again.

The taskset(1) utility in util-linux actually depends on the kernel return value 
that glibc doesn't return.  On Cygwin there is only one "syscall" interface so I 
have to have sched_getaffinity() return a nonzero value on success like the 
Linux kernel does.

> Also, while at it, would you mind to rearrange the code a bit at this
> point?  I think it's a bit puzzeling that status indicates an error code
> as well as the non-errno return code from this function.  Kind of like
> this:
> 
>    if (status)
>      {
>        set_errno (status)
>        return -1;
>      }
>    return 0;

Sure, no problem.  If you're OK with my rationale above I'll submit a revised 
patch with this adjustment included.

..mark
