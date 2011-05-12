Return-Path: <cygwin-patches-return-7355-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13803 invoked by alias); 12 May 2011 18:43:25 -0000
Received: (qmail 13676 invoked by uid 22791); 12 May 2011 18:43:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 18:42:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0F8D62C0577; Thu, 12 May 2011 20:42:34 +0200 (CEST)
Date: Thu, 12 May 2011 18:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512184233.GE3020@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <4DCC1E7C.2060804@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCC1E7C.2060804@cs.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00121.txt.bz2

On May 12 13:53, Ryan Johnson wrote:
> On 12/05/2011 12:55 PM, Corinna Vinschen wrote:
> >>>    struct heap
> >>>    {
> >>>      heap *next;
> >>>-    void *base;
> >>>+    unsigned heap_id;
> >>>+    uintptr_t base;
> >>>+    uintptr_t end;
> >>>+    unsigned long flags;
> >>>    };
> >>We don't actually need the end pointer: we're trying to match an
> >No, we need it.  The heaps consist of reserved and committed memory
> >blocks, as well as of shareable and non-shareable blocks.  Thus you
> >get multiple VirtualQuery calls per heap, thus you have to check for
> >the address within the entire heap(*).
> The code which queries heap_info already deals with allocations that
> take multiple VirtualQuery calls to traverse, and only calls into
> heap_info for the base of any given allocation. 

However, at least heap 2 consists of multiple allocated memory areas,
which are separately VirtualAlloc'ed or NtMapViewOfSection'ed.  Therefore
the first VirtualQuery returns AllocationBase = BaseAddress = 0x20000
and the next VirtualQuery returns AllocationBase = BaseAddress = 0x30000.
However, all the memory from 0x20000 up to 0x230000 constitutes a single
start block in heap 2!

> CAVEAT: According to MSDN's documentation for HeapWalk, "a heap
> consists of one or more regions of virtual memory, each with a
> unique region index." During heap walking, wFlags is set to
> PROCESS_HEAP_REGION whenever "the heap element is located at the
> beginning of a region of contiguous virtual memory in use by the
> heap." However, "large block regions" (those allocated directly via
> VirtualAlloc) do not set the PROCESS_HEAP_REGION flag. If this
> PROCESS_HEAP_REGION flag corresponds to your (flags & 2), then we
> won't report any large blocks (however, it's documented to have the
> value 0x0001, with 0x0002 being PROCESS_HEAP_UNCOMMITTED_RANGE).

I created a test application with several heaps and I create large
blocks in two of them.  They also have the flags&2 value set.  The
problem for heap walk is to identify blocks with a valid address.  Keep
in mind that all subsequent blocks within an allocated heap area do
*not* have an addres, but only a size, with address == 0.  You only get
their address by iterating from the start block to the block you're
looking for and adding up all sizes of the blocks up to there.

Consequentially a start block of another VirtualAlloc'ed area needs a
marker that the address is valid.  That marker is the flags value 2.
Which is kind of weird, actually, since the existence of a non-0 address
in the block should have been enough of a hint that this is a start
block...

As for the big blocks, they are apparently identified by the value in
the "Unknown" member of the DEBUG_HEAP_BLOCK structure.  Here's what I
figured out so far as far as "Unknown" is concerned:

   0x1000  All normal heaps
   0x3000  The process default heap (heap 0)
   0xc000  A low-frag heap
  0x10000  Heap 2, perhaps the meaning is "stack"?
  0x32000  Subsequently allocated block of a growable heap
 0x1e9000  Large block

I don't claim to understand the values, especially the reason for
setting several bits.

> >>>    heap *heaps;
> >>This is a misnomer now -- it's really a list of heap regions/blocks.
> >I don't think so.  The loop stores only the blocks which constitute
> >the original VirtualAlloc'ed memory regions.  They are not the real
> >heap blocks returned by Heap32First/Heap32Next.  These are filtered
> >out by checking for flags&  2 (**).
> Sorry, I cut too much context out of the diff. That's
> heap_info::heaps, which indeed refers to heap regions which we
> identified by checking flags&2 (that's why it needs the heap_id
> inside it now, where it didn't before) (++)

So you think something like heap_chunks is better?

> >>>+		heap *h = (heap *) cmalloc (HEAP_FHANDLER, sizeof (heap));
> >>>+		*h = (heap) {heaps, hcnt, barray[bcnt].Address,
> >>>+			     barray[bcnt].Address + barray[bcnt].Size,
> >>>+			     harray->Heaps[hcnt].Flags};
> >>>+		heaps = h;
> >>Given that the number of heap blocks is potentially large, I think
> >Not really.  See (**).  3 heaps ->  3 blocks, or only slightly more
> >if a growable heap got expanded.
> See (++). When I point my essentially-identical version of the code
> at emacs, it reports 8 heaps, each with 2-4 regions. The list
> traversed by fill_on_match has ~20 entries.

Oh, ok.  From my POV 20 is not a large number.  Ordering might take
more time than scanning.  I don't think it's worth the effort.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
