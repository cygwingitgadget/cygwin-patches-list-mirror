Return-Path: <cygwin-patches-return-7343-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 965 invoked by alias); 11 May 2011 19:32:03 -0000
Received: (qmail 537 invoked by uid 22791); 11 May 2011 19:31:33 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 11 May 2011 19:31:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CAC052C0602; Wed, 11 May 2011 21:31:07 +0200 (CEST)
Date: Wed, 11 May 2011 19:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110511193107.GF11041@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCACB72.6070201@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00109.txt.bz2

On May 11 13:46, Ryan Johnson wrote:
> On 11/05/2011 7:14 AM, Corinna Vinschen wrote:
> >On May 11 01:27, Ryan Johnson wrote:
> >>The second (proc-maps-heaps) adds reporting of Windows heaps (or
> >>their bases, at least). Unfortunately there doesn't seem to be any
> >>efficient way to identify all virtual allocations which a heap owns.
> >There's a call RtlQueryDebugInformation which can fetch detailed heap
> >information, and which is used by Heap32First/Heap32Last.  Using it
> >directly is much more efficient than using the Heap32 functions.  The
> >DEBUG_HEAP_INFORMATION is already in ntdll.h, what's missing is the
> >layout of the Blocks info.  I found the info by googling:
> >
> >   typedef struct _HEAP_BLOCK
> >   {
> >     PVOID addr;
> >     ULONG size;
> >     ULONG flags;
> >     ULONG unknown;
> >   } HEAP_BLOCK, *PHEAP_BLOCK;
> >
> >If this information is searched until the address falls into the just
> >inspected  block of virtual memory, then we would have the information,
> >isn't it?
> The problem is that the reported heap blocks corresponded to
> individual malloc() calls when I tested it (unordered list, most
> sizes < 100B). I really would have preferred a function that returns
> the list of memory regions owned by the heap. They must track that
> information -- I highly HeapDestroy uses these heap blocks to decide
> which memory regions to VirtualFree, but that info seems to live in
> the kernel...

No, it doesn't.  The heap allocation functions are implemented entirely
in user space.  Only virtual memory and shared sections are maintained
by the kernel.

Looking into the MSDN man page for HeapCreate, I'm wondering if this is
really complicated.  HeapCreate just allocates a block of memory using
VirtualAlloc.  Either the Heap is fixed size, then all allocations are
within the given heap memory area, or the heap can grow, then subsequent
(or big-block) allocations can result in another VirtualAlloc.

Having said that, I don't know where this information is stored exactly,
but it must be available in the DEBUG_HEAP_INFORMATION block.  I guess
a bit of experimenting is asked for.

> Given that Heap32* has already been reverse-engineered by others,
> the main challenge would involve sorting the set of heap block
> addresses and distilling them down to a set of allocation bases. We
> don't want to do repeated linear searches over 50k+ heap blocks.

While the base address of the heap is available in
DEBUG_HEAP_INFORMATION, I don't see the size of the heap.  Maybe it's in
the block of 7 ULONGs marked as "Reserved"?  It must be somewhere.
Assuming just that, you could scan the list of blocks once and drop
those within the orignal heap allocation.  The remaining blocks are big
blocks which have been allocated by additional calls to VirtualAlloc.

However, there's a good chance that the entire information about
blocks allocated with VirtualAlloc is kept in the heap's own
datastructures which, again, are undocumented.  I would assume the
start of that heap info is at the heaps base address, but without
more information about the internal structure...

> Also, the cygheap isn't a normal windows heap, is it? I thought it
> was essentially a statically-allocated array (.cygheap) that gets
> managed as a heap. I guess since it's part of cygwin1.dll we already
> do sort of report it...

The cygheap is the last section in the DLL and gets allocated by the
Windows loader.  The memory management is entirely in Cygwin (cygheap.cc).
Cygwin can raise the size of the cygheap, but only if the blocks right
after the existing cygheap are not already allocated.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
