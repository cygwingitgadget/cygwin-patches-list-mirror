Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id E73F53857C7F
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 06:47:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E73F53857C7F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 10I6lnJI012432
 for <cygwin-patches@cygwin.com>; Sun, 17 Jan 2021 22:47:49 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.20]"
 via SMTP by m0.truegem.net, id smtpdIVsVeK; Sun Jan 17 22:47:43 2021
Subject: Re: [PATCH] Cygwin: Interim malloc speedup
To: cygwin-patches@cygwin.com
References: <20201222045348.10562-1-mark@maxrnd.com>
 <20210111121828.GC59030@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <d75ea761-7243-5f8d-4959-082933b1d223@maxrnd.com>
Date: Sun, 17 Jan 2021 22:47:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20210111121828.GC59030@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 18 Jan 2021 06:47:54 -0000

Hi Corinna,
Happy New Year back at you!  I'm very glad to see you posting again!

Corinna Vinschen via Cygwin-patches wrote:
> Hi Mark,
> 
> Happy New Year!
> 
> On Dec 21 20:53, Mark Geisert wrote:
>> Replaces function-level lock with data-level lock provided by existing
>> dlmalloc.  Sets up to enable dlmalloc's MSPACES, but does not yet enable
>> them due to visible but uninvestigated issues.
>>
>> Single-thread applications may or may not see a performance gain,
>> depending on how heavily it uses the malloc functions.  Multi-thread
>> apps will likely see a performance gain.
[...]
>> diff --git a/winsup/cygwin/cygmalloc.h b/winsup/cygwin/cygmalloc.h
>> index 84bad824c..67a9f3b3f 100644
>> --- a/winsup/cygwin/cygmalloc.h
>> +++ b/winsup/cygwin/cygmalloc.h
[...]
>> +/* These defines tune the dlmalloc implementation in malloc.cc */
>>   # define MALLOC_FAILURE_ACTION	__set_ENOMEM ()
>>   # define USE_DL_PREFIX 1
>> +# define USE_LOCKS 1
> 
> Just enabling USE_LOCKS looks wrong to me.  Before enabling USE_LOCKS,
> you should check how the actual locking is performed.  For non WIN32,
> that will be pthread_mutex_lock/unlock, which may not be feasible,
> because it may break expectations during fork.

I did investigate this before setting it, and I've been running with '#define 
USE_LOCKS 1' for many weeks and haven't seen any memory issues of any kind. 
Malloc multi-thread stress testing, fork() stress testing, Cygwin DLL builds, 
Python and binutils builds, routine X usage; all OK.  (Once I straightened out 
sped-up mkimport to actually do what Jon T suggested, blush.)

> What you may want to do is setting USE_LOCKS to 2, and defining your own
> MLOCK_T/ACQUIRE_LOCK/... macros (in the `#if USE_LOCKS > 1' branch of
> the malloc source, see lines 1798ff), using a type which is non-critical
> during forking, as well as during process initialization.  Win32 fast
> R/W Locks come to mind and adding them should be pretty straight-forward.
> This may also allow MSPACES to work OOTB.

With '#define USE_LOCKS 1' the tangled mess of #if-logic in malloc.cc resolves on 
Cygwin to using pthread_mutex_locks, so that seems to be OK as-is unless what 
you're suggesting is preferable for speed (or MSPACES when I get to that).
>> +# define LOCK_AT_FORK 0
> 
> This looks dangerous.  You're removing the locking from fork entirely
> *and* the lock isn't re-initialized in the child.  This reinitializing
> was no problem before because mallock was NO_COPY, but it's a problem
> now because the global malloc_state _gm_ isn't (and mustn't).  The
> current implementation calling
> 
>    #if LOCK_AT_FORK
>        pthread_atfork(&pre_fork, &post_fork_parent, &post_fork_child);
>    #endif
> 
> should do the trick, assuming the USE_LOCKS stuff is working as desired.

I don't remember what led me to #define LOCK_AT_FORK 0, but in the new light of 
this year it's obviously wrong.  I've #define'd it 1.

>> [...]
>> +#if MSPACES
>> +/* If mspaces (thread-specific memory pools) are enabled, use a thread-
>> +   local variable to store a pointer to the calling thread's mspace.
>> +
>> +   On any use of a malloc-family function, if the appropriate mspace cannot
>> +   be determined, the general (non-mspace) form of the corresponding malloc
>> +   function is substituted.  This is not expected to happen often.
>> +*/
>> +static NO_COPY DWORD tls_mspace; // index into thread's TLS array
>> +
>> +static void *
>> +get_current_mspace ()
>> +{
>> +  if (unlikely (tls_mspace == 0))
>> +    return 0;
>> +
>> +  void *m = TlsGetValue (tls_mspace);
>> +  if (unlikely (m == 0))
>> +    {
>> +      m = create_mspace (MSPACE_SIZE, 0);
>> +      if (!m)
>> +        return 0;
>> +      TlsSetValue (tls_mspace, m);
>> +    }
>> +  return m;
>> +}
>> +#endif
> 
> Please define a new slot in _cygtls keeping the memory address returned
> by create_mspace.  You don't have to call TlsGetValue/TlsSetValue.

Thank you for repeating this suggestion.  I now understand why it's better.

I'm going to delay submitting the v2 patch until I see where the investigation of 
Achim's malloc testcase (running zstd on 1600 files, for instance) leads.  I'm 
about to respond to his thread in cygwin-apps.
Thanks & Regards,

..mark
