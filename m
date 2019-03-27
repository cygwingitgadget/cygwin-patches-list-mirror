Return-Path: <cygwin-patches-return-9241-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53564 invoked by alias); 27 Mar 2019 08:27:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53550 invoked by uid 89); 27 Mar 2019 08:27:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=Beyond, CreateFile, fhandler_pipe, createfile
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 08:27:07 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 09:26:56 +0100
Received: from friw0872.wamas.com ([172.28.53.108])	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1h93tf-0007Ei-PB; Wed, 27 Mar 2019 09:26:55 +0100
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>
Date: Wed, 27 Mar 2019 08:27:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190326182824.GB4096@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q1/txt/msg00051.txt.bz2

Hi Corinna,

On 3/26/19 7:28 PM, Corinna Vinschen wrote:
> On Mar 26 19:25, Corinna Vinschen wrote:
>> Hi Michael,
>>
>>
>> Redirected to cygwin-patches...
>>
>>
>> On Mar 26 18:10, Michael Haubenwallner wrote:
>>> Hi Corinna,
>>>
>>> as I do still encounter fork errors (address space needed by <dll> is
>>> already occupied) with dynamically loaded dlls (but unrelated to
>>> replaced dlls), one of them repeating even upon multiple retries,
>>
>> Why didn't rebase fix that?

As far as I understand, rebasing is about touching already installed
dlls as well, which would require to restart all Cygwin processes.
As the problem is about some dll built during a larger build job,
this is not something that feels useful to me.

> 
> Btw., is that 32 or 64 bit?  Both?

I'm on 64bit only, can't say for 32bit.  And while in theory possible,
I'm not after supporting 32bit Cygwin in Gento Prefix at all...

>>>  I'm
>>> coming up with attached patch.
>>>
>>> What do you think about it?
>>
>> I'm not opposed to this patch but I don't quite follow the description.
>> threadinterface->Init only creates three event objects.  From what I can
>> tell, Events are stored in Paged and Nonpaged Pools, so they don't
>> affect the processes VM.  What am I missing?

Honestly, I'm not completely sure whether this patch really does help:
Beyond the Events, there also is CreateNamedPipe and CreateFile used
in fhandler_pipe::create via sigproc_init, and these causing the address
conflicts with some dll actually is nothing more than a wild guess:
While their returned handles are below the conflicting dll address,
who can tell what these API calls do allocate internally?

Thanks!
/haubi/

>>
>>> >From dfc28bcbb7ed55fe33ddb8d15e761b4d5b4815f8 Mon Sep 17 00:00:00 2001
>>> From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
>>> Date: Tue, 26 Mar 2019 17:38:36 +0100
>>> Subject: [PATCH] Cygwin: fork: reserve dynloaded dll areas earlier
>>>
>>> In dll_crt0_0, both threadinterface->Init and sigproc_init allocate
>>> windows object handles using unpredictable memory regions, which may
>>> collide with dynamically loaded dlls when they were relocated.
>>> ---
>>>  winsup/cygwin/dcrt0.cc | 6 ++++++
>>>  winsup/cygwin/fork.cc  | 6 ------
>>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
>>> index 11edcdf0d..fb726a739 100644
>>> --- a/winsup/cygwin/dcrt0.cc
>>> +++ b/winsup/cygwin/dcrt0.cc
>>> @@ -632,6 +632,12 @@ child_info_fork::handle_fork ()
>>>  
>>>    if (fixup_mmaps_after_fork (parent))
>>>      api_fatal ("recreate_mmaps_after_fork_failed");
>>> +
>>> +  /* We need to occupy the address space for dynamically loaded dlls
>>> +     before we allocate any dynamic object, or we may end up with
>>> +     error "address space needed by <dll> is already occupied"
>>> +     for no good reason (seen with some relocated dll). */
>>> +  dlls.reserve_space ();
>>>  }
>>>  
>>>  bool
>>> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
>>> index 74ee9acf4..7e1c08990 100644
>>> --- a/winsup/cygwin/fork.cc
>>> +++ b/winsup/cygwin/fork.cc
>>> @@ -136,12 +136,6 @@ frok::child (volatile char * volatile here)
>>>  {
>>>    HANDLE& hParent = ch.parent;
>>>  
>>> -  /* NOTE: Logically this belongs in dll_list::load_after_fork, but by
>>> -     doing it here, before the first sync_with_parent, we can exploit
>>> -     the existing retry mechanism in hopes of getting a more favorable
>>> -     address space layout next time. */
>>> -  dlls.reserve_space ();
>>> -
>>>    sync_with_parent ("after longjmp", true);
>>>    debug_printf ("child is running.  pid %d, ppid %d, stack here %p",
>>>  		myself->pid, myself->ppid, __builtin_frame_address (0));
>>> -- 
>>> 2.17.0
>>>
>>>
>>
>>>
>>> --
>>> Problem reports:       http://cygwin.com/problems.html
>>> FAQ:                   http://cygwin.com/faq/
>>> Documentation:         http://cygwin.com/docs.html
>>> Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
>>
>>
>> -- 
>> Corinna Vinschen
>> Cygwin Maintainer
> 
> 
> 
