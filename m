Return-Path: <cygwin-patches-return-7348-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24010 invoked by alias); 12 May 2011 16:31:46 -0000
Received: (qmail 23573 invoked by uid 22791); 12 May 2011 16:31:42 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_CP
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 12 May 2011 16:31:27 +0000
Received: (qmail 3118 invoked by uid 107); 12 May 2011 16:31:25 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 12 May 2011 18:31:25 +0200
Message-ID: <4DCC0B5C.4040901@cs.utoronto.ca>
Date: Thu, 12 May 2011 16:31:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de>
In-Reply-To: <20110512150910.GE18135@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00114.txt.bz2

On 12/05/2011 11:09 AM, Corinna Vinschen wrote:
> On May 12 14:10, Corinna Vinschen wrote:
>> On May 11 21:31, Corinna Vinschen wrote:
>>> On May 11 13:46, Ryan Johnson wrote:
>>>> Given that Heap32* has already been reverse-engineered by others,
>>>> the main challenge would involve sorting the set of heap block
>>>> addresses and distilling them down to a set of allocation bases. We
>>>> don't want to do repeated linear searches over 50k+ heap blocks.
>>> While the base address of the heap is available in
>>> DEBUG_HEAP_INFORMATION, I don't see the size of the heap.  Maybe it's in
>>> the block of 7 ULONGs marked as "Reserved"?  It must be somewhere.
>>> Assuming just that, you could scan the list of blocks once and drop
>>> those within the orignal heap allocation.  The remaining blocks are big
>>> blocks which have been allocated by additional calls to VirtualAlloc.
>> After some debugging, I now have the solution. [...]
> Here's a prelimiary patch to fhandler_process.cc which takes everything
> into account I have learned in the meantime.  For instance, there are
> actually heaps marked as shareable.  Please have a look.  What's missing
> is the flag for low-fragmentation heaps, but I'm just hunting for it.
I like it. Detailed comments below.

> +/* Known heap flags */
> +#define HEAP_FLAG_NOSERIALIZE	0x1
> +#define HEAP_FLAG_GROWABLE	0x2
> +#define HEAP_FLAG_EXCEPTIONS	0x4
> +#define HEAP_FLAG_NONDEFAULT	0x1000
> +#define HEAP_FLAG_SHAREABLE	0x8000
> +#define HEAP_FLAG_EXECUTABLE	0x40000
Would it make sense to put those in ntdll.h along with the heap structs 
that use them?

>     struct heap
>     {
>       heap *next;
> -    void *base;
> +    unsigned heap_id;
> +    uintptr_t base;
> +    uintptr_t end;
> +    unsigned long flags;
>     };
We don't actually need the end pointer: we're trying to match an unknown 
allocation base against heap region bases. The code which traverses VM 
allocations should query heap_info at most once per allocation (for 
example, it only looks up the file name of cygwin1.dll once even though 
the latter has 12 entries in /proc/*/maps).

>     heap *heaps;
This is a misnomer now -- it's really a list of heap regions/blocks.

> +		heap *h = (heap *) cmalloc (HEAP_FHANDLER, sizeof (heap));
> +		*h = (heap) {heaps, hcnt, barray[bcnt].Address,
> +			     barray[bcnt].Address + barray[bcnt].Size,
> +			     harray->Heaps[hcnt].Flags};
> +		heaps = h;
Given that the number of heap blocks is potentially large, I think it 
makes sense to build a sorted list. That way, each query examines only 
one heap block (deleting it unless it was above the queried address). I 
have ready-but-unsent a patch which does this to the checked-in version 
of the code. Shall I send it?

> -  char *fill_if_match (void *base, char *dest )
> +  char *fill_if_match (void *base, ULONG type, char *dest )
>     {
> -    long count = 0;
> -    for (heap *h = heaps; h&&  ++count; h = h->next)
> -      if (base == h->base)
> +    for (heap *h = heaps; h; h = h->next)
> +      if ((uintptr_t) base>= h->base&&  (uintptr_t) base<  h->end)
>   	{
> -	  __small_sprintf (dest, "[heap %ld]", count);
> +	  char *p;
> +	  __small_sprintf (dest, "[heap %ld", h->heap_id);
> +	  p = strchr (dest, '\0');
> +	  if (!(h->flags&  HEAP_FLAG_NONDEFAULT))
> +	    p = stpcpy (p, " default");
> +	  if ((h->flags&  HEAP_FLAG_SHAREABLE)&&  (type&  MEM_MAPPED))
> +	    p = stpcpy (p, " share");
> +	  if (h->flags&  HEAP_FLAG_EXECUTABLE)
> +	    p = stpcpy (p, " exec");
> +	  if (h->flags&  HEAP_FLAG_GROWABLE)
> +	    p = stpcpy (p, " grow");
> +	  if (h->flags&  HEAP_FLAG_NOSERIALIZE)
> +	    p = stpcpy (p, " noserial");
> +	  stpcpy (p, "]");
>   	  return dest;
>   	}
>       return 0;
Do you actually encounter requests which fall inside a heap region 
rather than at its start? I have not seen this in my experiments, and if 
you have it is almost certainly a bug in format_process_maps' allocation 
traversal.

Also, are there ever shareable-but-not-mem_mapped segments? If not, we 
could probably remove 'type.'

Ryan
