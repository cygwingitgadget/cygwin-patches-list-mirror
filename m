Return-Path: <cygwin-patches-return-7350-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23903 invoked by alias); 12 May 2011 16:56:04 -0000
Received: (qmail 23749 invoked by uid 22791); 12 May 2011 16:55:42 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 16:55:23 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A780E2C0577; Thu, 12 May 2011 18:55:20 +0200 (CEST)
Date: Thu, 12 May 2011 16:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512165520.GB3020@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCC0B5C.4040901@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00116.txt.bz2

On May 12 12:31, Ryan Johnson wrote:
> On 12/05/2011 11:09 AM, Corinna Vinschen wrote:
> >On May 12 14:10, Corinna Vinschen wrote:
> >>On May 11 21:31, Corinna Vinschen wrote:
> >>>On May 11 13:46, Ryan Johnson wrote:
> >>>>Given that Heap32* has already been reverse-engineered by others,
> >>>>the main challenge would involve sorting the set of heap block
> >>>>addresses and distilling them down to a set of allocation bases. We
> >>>>don't want to do repeated linear searches over 50k+ heap blocks.
> >>>While the base address of the heap is available in
> >>>DEBUG_HEAP_INFORMATION, I don't see the size of the heap.  Maybe it's in
> >>>the block of 7 ULONGs marked as "Reserved"?  It must be somewhere.
> >>>Assuming just that, you could scan the list of blocks once and drop
> >>>those within the orignal heap allocation.  The remaining blocks are big
> >>>blocks which have been allocated by additional calls to VirtualAlloc.
> >>After some debugging, I now have the solution. [...]
> >Here's a prelimiary patch to fhandler_process.cc which takes everything
> >into account I have learned in the meantime.  For instance, there are
> >actually heaps marked as shareable.  Please have a look.  What's missing
> >is the flag for low-fragmentation heaps, but I'm just hunting for it.
> I like it. Detailed comments below.
> 
> >+/* Known heap flags */
> >+#define HEAP_FLAG_NOSERIALIZE	0x1
> >+#define HEAP_FLAG_GROWABLE	0x2
> >+#define HEAP_FLAG_EXCEPTIONS	0x4
> >+#define HEAP_FLAG_NONDEFAULT	0x1000
> >+#define HEAP_FLAG_SHAREABLE	0x8000
> >+#define HEAP_FLAG_EXECUTABLE	0x40000
> Would it make sense to put those in ntdll.h along with the heap
> structs that use them?

Sure.

> >    struct heap
> >    {
> >      heap *next;
> >-    void *base;
> >+    unsigned heap_id;
> >+    uintptr_t base;
> >+    uintptr_t end;
> >+    unsigned long flags;
> >    };
> We don't actually need the end pointer: we're trying to match an

No, we need it.  The heaps consist of reserved and committed memory
blocks, as well as of shareable and non-shareable blocks.  Thus you
get multiple VirtualQuery calls per heap, thus you have to check for
the address within the entire heap(*).

> >    heap *heaps;
> This is a misnomer now -- it's really a list of heap regions/blocks.

I don't think so.  The loop stores only the blocks which constitute
the original VirtualAlloc'ed memory regions.  They are not the real
heap blocks returned by Heap32First/Heap32Next.  These are filtered
out by checking for flags & 2 (**).

> >+		heap *h = (heap *) cmalloc (HEAP_FHANDLER, sizeof (heap));
> >+		*h = (heap) {heaps, hcnt, barray[bcnt].Address,
> >+			     barray[bcnt].Address + barray[bcnt].Size,
> >+			     harray->Heaps[hcnt].Flags};
> >+		heaps = h;
> Given that the number of heap blocks is potentially large, I think

Not really.  See (**).  3 heaps -> 3 blocks, or only slightly more
if a growable heap got expanded.

> Do you actually encounter requests which fall inside a heap region
> rather than at its start?

Yes, see (*).  And have a look into the output of my code in
contrast to what's printed by the currently version from CVS.

>  I have not seen this in my experiments,
> and if you have it is almost certainly a bug in format_process_maps'
> allocation traversal.

No, see (*).

> Also, are there ever shareable-but-not-mem_mapped segments?

Yes, there are.  2 of the 3 default heaps are marked as shareable, but
one of them is only partially shared.  Of course I don't understand the
reason behind this and how this is accomplished, given that the user
code can't even set a flag "shareable" at HeapCreate time.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
