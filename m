Return-Path: <cygwin-patches-return-7358-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 821 invoked by alias); 12 May 2011 19:19:25 -0000
Received: (qmail 809 invoked by uid 22791); 12 May 2011 19:19:24 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 12 May 2011 19:19:10 +0000
Received: (qmail 9310 invoked by uid 107); 12 May 2011 19:19:08 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 12 May 2011 21:19:08 +0200
Message-ID: <4DCC32A9.4050108@cs.utoronto.ca>
Date: Thu, 12 May 2011 19:19:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <20110512171130.GD3020@calimero.vinschen.de> <4DCC1EB0.7080905@cs.utoronto.ca> <20110512184812.GF3020@calimero.vinschen.de>
In-Reply-To: <20110512184812.GF3020@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00124.txt.bz2

On 12/05/2011 2:48 PM, Corinna Vinschen wrote:
> On May 12 13:53, Ryan Johnson wrote:
>> On 12/05/2011 1:11 PM, Corinna Vinschen wrote:
>>> On May 12 18:55, Corinna Vinschen wrote:
>>>> On May 12 12:31, Ryan Johnson wrote:
>>>>> On 12/05/2011 11:09 AM, Corinna Vinschen wrote:
>>>>>> -    void *base;
>>>>>> +    unsigned heap_id;
>>>>>> +    uintptr_t base;
>>>>>> +    uintptr_t end;
>>>>>> +    unsigned long flags;
>>>>>>     };
>>>>> We don't actually need the end pointer: we're trying to match an
>>>> No, we need it.  The heaps consist of reserved and committed memory
>>>> blocks, as well as of shareable and non-shareable blocks.  Thus you
>>>> get multiple VirtualQuery calls per heap, thus you have to check for
>>>> the address within the entire heap(*).
>>> Btw., here's a good example.  There are three default heaps, One of them,
>>> heap 0, is the heap you get with GetProcessHeap ().  I don't know the
>>> task of heap 1 yet, but heap 2 is ... something, as well as the stack of
>>> the first thread in the process.  It looks like this:
>>>
>>>    base 0x00020000, flags 0x00008000, granularity     8, unknown     0
>>>    allocated     1448, committed    65536, block count 3
>>>    Block 0: addr 0x00020000, size  2150400, flags 0x00000002, unknown 0x00010000
>>>
>>> However, the various calls to VirtualQuery result in this output with
>>> my patch:
>>>
>>>    00020000-00030000 rw-p 00000000 0000:0000 0      [heap 2 default share]
>>>    00030000-00212000 ---p 00000000 0000:0000 0      [heap 2 default]
>>>    00212000-00213000 rw-s 001E2000 0000:0000 0      [heap 2 default]
>>>    00213000-00230000 rw-p 001E3000 0000:0000 0      [heap 2 default]
>>>
>>> The "something" is the sharable area from 0x20000 up to 0x30000.  The
>>> stack is from 0x30000 up to 0x230000.  The first reagion is only
>>> reserved, then the guard page, then the committed and used  tack area.
>> Hmm. It looks like heap 2 was allocated by mapping the pagefile
>> rather than using VirtualAlloc, and the thread's stack was allocated
>> from heap 2, which treated the request as a large block and returned
>> the result of a call to VirtualAlloc.
>>
>> Are the other two heap bases not "default share" then?
> Here's what I see for instance in tcsh:
>
> 00010000-00020000 rw-p 00000000 0000:0000 0       [heap 1 default share]
>
> 00020000-00030000 rw-p 00000000 0000:0000 0       [heap 2 default share]
> 00030000-00212000 ---p 00000000 0000:0000 0       [heap 2 default]
> 00212000-00213000 rw-s 001E2000 0000:0000 0       [heap 2 default]
> 00213000-00230000 rw-p 001E3000 0000:0000 0       [heap 2 default]
>
> 002E0000-00310000 rw-p 00000000 0000:0000 0       [heap 0 default grow]
> 00310000-003E0000 ---p 00030000 0000:0000 0       [heap 0 default grow]
>
>> In any case, coming back to the allocation base issue, heap_info
>> only needs to track 0x20000 and 0x30000, because they are the ones
>> with offset zero that would trigger a call to
>> heap_info::fill_on_match. I argue that heap walking found exactly
>> two flags&2 blocks, with exactly those base addresses, making the
>> range check in fill_on_match unecessary.
> Nope.  As I wrote in my previoous mail and as you can still see in my
> quote above, the two virtual memory areas from 0x20000 to 0x30000 and
> from 0x30000 to 0x230000 together constitute a single start block in
> heap 2.  The OS is a great faker in terms of information returned to
> the application, apparently.
OK. I finally understand now. I was assuming the heap would not report 
multiple allocations as a single heap region.

Windows is weird.

Ryan
