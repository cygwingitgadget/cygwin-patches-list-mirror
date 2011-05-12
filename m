Return-Path: <cygwin-patches-return-7353-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4365 invoked by alias); 12 May 2011 17:53:20 -0000
Received: (qmail 4355 invoked by uid 22791); 12 May 2011 17:53:18 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_RW,TW_WX
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 12 May 2011 17:53:03 +0000
Received: (qmail 32215 invoked by uid 107); 12 May 2011 17:53:01 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 12 May 2011 19:53:01 +0200
Message-ID: <4DCC1E7C.2060804@cs.utoronto.ca>
Date: Thu, 12 May 2011 17:53:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de>
In-Reply-To: <20110512165520.GB3020@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00119.txt.bz2

On 12/05/2011 12:55 PM, Corinna Vinschen wrote:
>>>     struct heap
>>>     {
>>>       heap *next;
>>> -    void *base;
>>> +    unsigned heap_id;
>>> +    uintptr_t base;
>>> +    uintptr_t end;
>>> +    unsigned long flags;
>>>     };
>> We don't actually need the end pointer: we're trying to match an
> No, we need it.  The heaps consist of reserved and committed memory
> blocks, as well as of shareable and non-shareable blocks.  Thus you
> get multiple VirtualQuery calls per heap, thus you have to check for
> the address within the entire heap(*).
The code which queries heap_info already deals with allocations that 
take multiple VirtualQuery calls to traverse, and only calls into 
heap_info for the base of any given allocation. These bases are 
identified because they have the same value for both mb.AllocationBase 
and mb.BaseAddress (except with unallocated regions, for which 
AllocationBase is undefined). This is how I compute the reported 
offsets. Further, adjacent regions having the same base and whose 
permissions resolve to the same rwxp bits are coalesced and reported as 
a single region. For example, several parts of a rebased dll will have 
copy-on-write regions (those where no rewrites took place), but these 
are collapsed because rwxp can't express copy-on-write (dlls can have up 
to 2x more VirtualQuery calls than is reflected in the output of 
/proc/*/maps).

In other words, it shouldn't matter how the heap has sliced up a given 
region, as long as the base address of each region is properly 
identified by some heap block having non-zero flags&2 (see caveat 
below). If no such block exists, then the code in 
heap_info::fill_if_match would need to test whether [heap_base,heap_end) 
overlaps [alloc_base,alloc_end) because alloc_base will never fall 
inside any block on the list.

CAVEAT: According to MSDN's documentation for HeapWalk, "a heap consists 
of one or more regions of virtual memory, each with a unique region 
index." During heap walking, wFlags is set to PROCESS_HEAP_REGION 
whenever "the heap element is located at the beginning of a region of 
contiguous virtual memory in use by the heap." However, "large block 
regions" (those allocated directly via VirtualAlloc) do not set the 
PROCESS_HEAP_REGION flag. If this PROCESS_HEAP_REGION flag corresponds 
to your (flags & 2), then we won't report any large blocks (however, 
it's documented to have the value 0x0001, with 0x0002 being 
PROCESS_HEAP_UNCOMMITTED_RANGE).

>>>     heap *heaps;
>> This is a misnomer now -- it's really a list of heap regions/blocks.
> I don't think so.  The loop stores only the blocks which constitute
> the original VirtualAlloc'ed memory regions.  They are not the real
> heap blocks returned by Heap32First/Heap32Next.  These are filtered
> out by checking for flags&  2 (**).
Sorry, I cut too much context out of the diff. That's heap_info::heaps, 
which indeed refers to heap regions which we identified by checking 
flags&2 (that's why it needs the heap_id inside it now, where it didn't 
before) (++)

>>> +		heap *h = (heap *) cmalloc (HEAP_FHANDLER, sizeof (heap));
>>> +		*h = (heap) {heaps, hcnt, barray[bcnt].Address,
>>> +			     barray[bcnt].Address + barray[bcnt].Size,
>>> +			     harray->Heaps[hcnt].Flags};
>>> +		heaps = h;
>> Given that the number of heap blocks is potentially large, I think
> Not really.  See (**).  3 heaps ->  3 blocks, or only slightly more
> if a growable heap got expanded.
See (++). When I point my essentially-identical version of the code at 
emacs, it reports 8 heaps, each with 2-4 regions. The list traversed by 
fill_on_match has ~20 entries.

>> Do you actually encounter requests which fall inside a heap region
>> rather than at its start?
> Yes, see (*).  And have a look into the output of my code in
> contrast to what's printed by the currently version from CVS.
I'll have to test out the patch -- my local version which checks only 
allocation bases reports additional regions (those not part of the 
original heap allocation), but if there are yet other regions which I'm 
missing and yours finds then I'll stand corrected about (++).

>>   I have not seen this in my experiments,
>> and if you have it is almost certainly a bug in format_process_maps'
>> allocation traversal.
> No, see (*).
>
>> Also, are there ever shareable-but-not-mem_mapped segments?
> Yes, there are.  2 of the 3 default heaps are marked as shareable, but
> one of them is only partially shared.  Of course I don't understand the
> reason behind this and how this is accomplished, given that the user
> code can't even set a flag "shareable" at HeapCreate time.
Hmm. Weird. I'll respond further after testing your patch and comparing 
its output against my local version of the same code.

Ryan
