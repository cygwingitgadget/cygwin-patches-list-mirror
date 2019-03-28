Return-Path: <cygwin-patches-return-9253-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84827 invoked by alias); 28 Mar 2019 09:17:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84813 invoked by uid 89); 28 Mar 2019 09:17:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=adress, adapt
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 09:17:09 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 10:17:06 +0100
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1h9R9l-0002Az-ED; Thu, 28 Mar 2019 10:17:05 +0100
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com>
Date: Thu, 28 Mar 2019 09:17:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q1/txt/msg00063.txt.bz2


On 3/28/19 9:34 AM, Michael Haubenwallner wrote:
> On 3/27/19 10:16 AM, Corinna Vinschen wrote:
>> On Mar 27 09:26, Michael Haubenwallner wrote:
>>> On 3/26/19 7:28 PM, Corinna Vinschen wrote:
>>>> On Mar 26 19:25, Corinna Vinschen wrote:
>>>>> On Mar 26 18:10, Michael Haubenwallner wrote:
>>>>>> Hi Corinna,

>>
>>>> Btw., is that 32 or 64 bit?  Both?
>>>
>>> I'm on 64bit only, can't say for 32bit.  And while in theory possible,
>>> I'm not after supporting 32bit Cygwin in Gento Prefix at all...
>>
>> If so, then I'm really curious how many DLLs are affected and why this
>> occurs on 64 bit.
>>
>> As you know, 64 bit has a defined memory layout.  Binutils ld is
>> supposed to base the DLLs to a pseudo-random address in the area between
>> 0x4:00000000 and 0x6:00000000.  This area is occupied by un-rebased DLLs
>> only.  8 Gigs is a *lot* of space for DLLs.
>>
>> That also means that the DLLs should not at all collide with windows
>> objects (typically reserved in the lesser 2 Gigs area), unless they
>> collide with themselves.  At least that's the idea.
>>
>> Can you check what addresses the freshly built DLLs are based on by LD?
>> Is there a chance that the algorithm used in LD is too dumb?
> 
> I've also added system_printf to dll_list::reserve_space() when a dynloaded
> dll was relocated, and each new address was below 0x0:01000000. The attached
> output also contains the preferred address, above 0x4:00000000 each.
> 
>>
>> Or, hmm.  Is there a chance that newer Windows loads dynamically loaded
>> DLLs whereever it likes, ignoring the base address, ASLR-like, even
>> if the DLL is marked as non-ASLR-aware?  But then again, we should have
>> a lot more complaints on the list...
> 
> I've done this test on Windows Server 2012R2, but the problem exists on
> 2016 and 2019 as well (I'm not testing with other Windows versions).
> 
>>>>>>  I'm
>>>>>> coming up with attached patch.
>>>>>>
>>>>>> What do you think about it?
>>>>>
>>>>> I'm not opposed to this patch but I don't quite follow the description.
>>>>> threadinterface->Init only creates three event objects.  From what I can
>>>>> tell, Events are stored in Paged and Nonpaged Pools, so they don't
>>>>> affect the processes VM.  What am I missing?
>>>
>>> Honestly, I'm not completely sure whether this patch really does help:
>>> Beyond the Events, there also is CreateNamedPipe and CreateFile used
>>> in fhandler_pipe::create via sigproc_init, and these causing the address
>>> conflicts with some dll actually is nothing more than a wild guess:
>>> While their returned handles are below the conflicting dll address,
>>> who can tell what these API calls do allocate internally?
>>
>> The handles are not addresses.  If the sigproc_init stuff collides,
>> I only see two chances for that, the process-local read/write buffers
>> of the signal pipe, and the stack of the read_sig thread.
>>
>> If this patch helps your situation, we can pull it in and test it,
>> but I think your situation asks for more debugging along the lines
>> of the DLL rebasing above.
> 
> With this patch collisions seem gone, yet the relocations do happen.

Ehm... collisions still do happen, but less often at least,
so this patch does help in my situation.

As it is not some other dll being loaded at the colliding adress: any
idea how to find out _what_ is allocated there (in the forked child),
to find out whether we can reserve these areas even more early?

What if we adapt the initial dlopen call to disallow relocation into
such low address space?

Beyond that, I'm going to learn about rebase --oblivious, thanks Achim!

/haubi/
