Return-Path: <cygwin-patches-return-9385-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13820 invoked by alias); 29 Apr 2019 08:54:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13809 invoked by uid 89); 29 Apr 2019 08:54:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=hacked, primary, learned, Care
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Apr 2019 08:54:37 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x3T8sZK0030912	for <cygwin-patches@cygwin.com>; Mon, 29 Apr 2019 01:54:35 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdxydacQ; Mon Apr 29 01:54:30 2019
Subject: Re: [PATCH v2] Cygwin: Implement sched_[gs]etaffinity()
To: cygwin-patches@cygwin.com
References: <20190429053809.1095-1-mark@maxrnd.com> <20190429082040.GA3383@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <c5a11465-b5a6-1ccc-219a-313f1c06c642@maxrnd.com>
Date: Mon, 29 Apr 2019 08:54:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20190429082040.GA3383@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00092.txt.bz2

Corinna Vinschen wrote:
> Hi Mark,
>

Howdy!  FTR Here's the intro paragraph left out of my patch submission:

Second version of CPU affinity patch set.  Attempts to mimic operation
of Linux affinity functions, both the sched_* and pthread_* varieties.
This v2 version assumes Windows processor groups always have 64 logical
processors.  I'm just trying to get the control structures laid out.  A
later version will deal with smaller-sized processor groups.

> On Apr 28 22:38, Mark Geisert wrote:
>> There are a couple of multi-group affinity operations that cannot be done
>> without heroic measures.  Those are marked with XXX in the code.  Further
>> discussion would be helpful to me.
>>
>> ---
>>  newlib/libc/include/sched.h     |  13 ++
>>  winsup/cygwin/common.din        |   4 +
>>  winsup/cygwin/include/pthread.h |   2 +
>>  winsup/cygwin/sched.cc          | 237 ++++++++++++++++++++++++++++++++
>>  winsup/cygwin/thread.cc         |  19 +++
>>  5 files changed, 275 insertions(+)
>>
>> diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
>> index 1016235bb..a4d3fea6a 100644
>> --- a/newlib/libc/include/sched.h
>> +++ b/newlib/libc/include/sched.h
>> @@ -92,6 +92,19 @@ int sched_yield( void );
>>
>>  #if __GNU_VISIBLE
>>  int sched_getcpu(void);
>> +
>> +#ifdef __CYGWIN__
>
> I don't think we really need that extra ifdef.  #if __GNU_VISIBLE
> bracketing is sufficient.

This mod is to newlib but I figured it's not relevant to non-Cygwin platforms. 
Could you please confirm the __CYGWIN__ bracketing can be removed?

>
>> +static int
>> +whichgroup (size_t sizeof_set, const cpu_set_t *set)
>> +{
>> +  //XXX code assumes __get_cpus_per_group() is fixed at 64
>
> I don't understand this comment.  It could also return 48 or 36
> or any other value <= 64.  Care to explain?
>
> Oh and please keep in mind that 32 bit systems only support 32 CPUs, not
> 64 (sizeof(KAFFINITY) == 4 on 32 bit).  I don't think this has much
> influence on the code, if any, but it might be worthwhile to check the
> code on any assumptions about the size of the affinity mask.

OK on 32 vs 64.  This XXX comment is to remind me to support the smaller 
processor groups before final patch submission.  We have been discussing this 
but I don't think I made it clear I'm considering the "big bitmask" set (like 
Linux uses) and how processor groups subdivide it.  It's an array of cpu_set_t 
(== uint64_t) but when subscripted by group number, it's an array of G-bit 
quantities, where G can be 48 or 36 or ...  Ergo, some bit-aligned reads and 
stores will be needed.

>
>> +	  // There is no GetThreadAffinityMask() function, so simulate one by
>> +	  // iterating through CPUs trying to set affinity, which returns the
>> +	  // previous affinity.  On success, restore original affinity.
>> +	  // This strategy is due to Damon on StackOverflow.
>
> Can you please use /* ... */ style comments?  // style comments should
> only be used for short, single-line comments after an expression.

OK, got the general rule now.  Will fix.

> Also, while there's no GetThreadAffinityMask() function, there is
> an equivalent NT level function which allows to fetch the thread
> affinity without having to manipulate it:
>
>   THREAD_BASIC_INFORMATION tbi;
>   KAFFINITY affinity_mask;
>
>   NtQueryInformationThread (thread_handle, ThreadBasicInformation,
> 			    &tbi, sizeof tbi, NULL);
>   affinity_mask = tbi.AffinityMask;
>
> All required definitions already exist in ntdll.h and are used in
> fhandler_process.cc, just for another purpose.

Very good.  I'll use that.

>> +int
>> +sched_getaffinity (pid_t pid, size_t sizeof_set, cpu_set_t *set)
>> +{
>> +  HANDLE process = 0;
>> +  int status = 0;
>> +
>> +  //XXX code assumes __get_cpus_per_group() is fixed at 64
>> +  pinfo p (pid ? pid : getpid ());
>> +  if (p)
>> +    {
>> +      process = pid && pid != myself->pid ?
>> +                OpenProcess (PROCESS_QUERY_LIMITED_INFORMATION, FALSE,
>> +                             p->dwProcessId) : GetCurrentProcess ();
>> +      KAFFINITY procmask;
>> +      KAFFINITY sysmask;
>> +
>> +      if (!GetProcessAffinityMask (process, &procmask, &sysmask))
>> +        {
>> +oops:
>> +          status = geterrno_from_win_error (GetLastError (), EPERM);
>> +          goto done;
>> +        }
>> +      memset (set, 0, sizeof_set);
>> +      if (wincap.has_processor_groups ())
>> +        {
>> +          USHORT groupcount = CPU_GROUPMAX;
>> +          USHORT grouparray[CPU_GROUPMAX];
>> +
>> +          if (!GetProcessGroupAffinity (process, &groupcount, grouparray))
>> +            goto oops;
>
> Uhm... that's a bit ugly, imho.  Rather than just jumping wildly to
> another spot in the middle of the same function, create a matching label
> at the end of the function.  Or, in a simple case like this one, just
> call geterrno_from_win_error here and goto done.

Sure, will do the call here.  Re the goto, I thought I had learned somewhere 
that if one must use a goto, it's better to goto a label already seen than some 
indeterminate distance forward in the code.  No biggie.

>> +          if (groupcount == 1)
>> +	    set[grouparray[0]] = procmask;
>> +	  else
>> +            status = ENOSYS;//XXX multi-group code TBD...
>> +	    // There is no way to assemble the complete process affinity mask
>> +	    // without querying at least one thread per group in grouparray,
>> +	    // and we don't know which group a thread is in without querying
>> +	    // it, so must query all threads.  I'd call that a heroic measure.
>
> I don't understand.  GetProcessAffinityMask() exists.  Am I missing
> something?  Also, if you don't like GetProcessAffinityMask(), there's an
> equivalent NT function to NtQueryInformationThread:

It exists, but if the process you're querying is a multi-group process, the mask 
is returned as all zeroes.  The func only works for single-group processes.  I 
even use it for such a little earlier in this code.

That doc I referenced in my last submission talks about how support for >64 
logical processors was hacked into Windows to allow pre-existing code to 
continue to work.  The down-side of the hackwork is that one has to manually 
place threads into processor groups other than the one selected by Windows to 
run the primary thread.  You can't change the processor group of the process.

>   PROCESS_BASIC_INFORMATION pbi;
>   KAFFINITY affinity_mask;
>
>   NtQueryInformationProcess (process_handle, ProcessBasicInformation,
> 			     &pbi, sizeof pbi, NULL);
>   affinity_mask = pbi.AffinityMask;

This unfortunately has the same limitation.  It can only return 64 bits of info, 
though a multi-group process might have affinity (through its threads) to more 
than 64 logical processors.

>> +        }
>> +      else
>> +        set[0] = procmask;
>> +    }
>> +  else
>> +    status = ESRCH;
>> +
>> +done:
>> +  if (process && process != GetCurrentProcess ())
>> +    CloseHandle (process);
>> +
>> +  return status;
>> +}
>> +[...]
>
> Other than that, the code looks good to me.
>
>
> Thanks,
> Corinna
>
