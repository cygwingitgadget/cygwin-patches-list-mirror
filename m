Return-Path: <cygwin-patches-return-7346-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17708 invoked by alias); 12 May 2011 12:10:55 -0000
Received: (qmail 17665 invoked by uid 22791); 12 May 2011 12:10:32 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 12:10:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6984F2C0577; Thu, 12 May 2011 14:10:12 +0200 (CEST)
Date: Thu, 12 May 2011 12:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512121012.GB18135@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110511193107.GF11041@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00112.txt.bz2

On May 11 21:31, Corinna Vinschen wrote:
> On May 11 13:46, Ryan Johnson wrote:
> > Given that Heap32* has already been reverse-engineered by others,
> > the main challenge would involve sorting the set of heap block
> > addresses and distilling them down to a set of allocation bases. We
> > don't want to do repeated linear searches over 50k+ heap blocks.
> 
> While the base address of the heap is available in
> DEBUG_HEAP_INFORMATION, I don't see the size of the heap.  Maybe it's in
> the block of 7 ULONGs marked as "Reserved"?  It must be somewhere.
> Assuming just that, you could scan the list of blocks once and drop
> those within the orignal heap allocation.  The remaining blocks are big
> blocks which have been allocated by additional calls to VirtualAlloc.

After some debugging, I now have the solution.  If you fetch the heap
and heap block information using the RtlQueryProcessDebugInformation
function, you get the list of blocks.  The first block in the list of
blocks has a flag value of 2.  Let's call it a "start block".  This
block contains the information about the address and size of the virtual
memory block reserved for this heap using VirtualAlloc.

Subsequent blocks do not contain address values, but only size values.
The start of the block is counted relative to the start of the previous
block.  All these blocks are "in-use", up to the last block which has
a flag value of 0x100.  This is the free block at the end of the heap.

For fixed-size heaps, that's all.  Growable heaps can have multiple
memory slots reserved with VirtualAlloc.  For these, if there are still
more blocks, the next block in the list after the free block is a start
block with a flag value of 2 again.  Here's the algorithm which prints
only the virtual memory blocks of all heaps:

  typedef struct _HEAPS
  {
    ULONG count;
    DEBUG_HEAP_INFORMATION dhi[1];
  } HEAPS, *PHEAPS;

  typedef struct _HEAP_BLOCK
  {
    ULONG size;
    ULONG flags;
    ULONG unknown;
    ULONG addr;
  } HEAP_BLOCK, *PHEAP_BLOCK;

  PDEBUG_BUFFER buf;
  NTSTATUS status;

  buf = RtlCreateQueryDebugBuffer (0, FALSE);
  if (!buf)
    {
      fprintf (stderr, "RtlCreateQueryDebugBuffer returned NULL\n");
      return 1;
    }
  status = RtlQueryProcessDebugInformation (GetCurrentProcessId (),
					    PDI_HEAPS | PDI_HEAP_BLOCKS,
					    buf);
  if (!NT_SUCCESS (status))
    [...]
  PHEAPS heaps = (PHEAPS) buf->HeapInformation;
  if (!heaps)
    [...]
  for (int heap_id = 0; heap_id < heaps->count; ++heap_id)
    {
      PHEAP_BLOCK blocks = (PHEAP_BLOCK) heaps->dhi[heap_id].Blocks;
      if (!blocks)
	[...]
      uintptr_t addr = 0;
      for (int block_num = 0; block_num < heaps->dhi[heap_id].BlockCount;
	   ++block_num)
	if (blocks[block_num].flags & 2)
	  printf ("addr 0x%08lx, size %8lu"
		  blocks[block_num].addr,
		    blocks[block_num].size);
    }
  RtlDestroyQueryDebugBuffer (buf);

As you can imagine, only the blocks I called the start blocks are
of interest for your struct heap_info.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
