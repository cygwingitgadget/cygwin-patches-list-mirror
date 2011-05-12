Return-Path: <cygwin-patches-return-7356-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15611 invoked by alias); 12 May 2011 18:48:50 -0000
Received: (qmail 15556 invoked by uid 22791); 12 May 2011 18:48:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 18:48:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7D99B2C0577; Thu, 12 May 2011 20:48:12 +0200 (CEST)
Date: Thu, 12 May 2011 18:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512184812.GF3020@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <20110512171130.GD3020@calimero.vinschen.de> <4DCC1EB0.7080905@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCC1EB0.7080905@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00122.txt.bz2

On May 12 13:53, Ryan Johnson wrote:
> On 12/05/2011 1:11 PM, Corinna Vinschen wrote:
> >On May 12 18:55, Corinna Vinschen wrote:
> >>On May 12 12:31, Ryan Johnson wrote:
> >>>On 12/05/2011 11:09 AM, Corinna Vinschen wrote:
> >>>>-    void *base;
> >>>>+    unsigned heap_id;
> >>>>+    uintptr_t base;
> >>>>+    uintptr_t end;
> >>>>+    unsigned long flags;
> >>>>    };
> >>>We don't actually need the end pointer: we're trying to match an
> >>No, we need it.  The heaps consist of reserved and committed memory
> >>blocks, as well as of shareable and non-shareable blocks.  Thus you
> >>get multiple VirtualQuery calls per heap, thus you have to check for
> >>the address within the entire heap(*).
> >Btw., here's a good example.  There are three default heaps, One of them,
> >heap 0, is the heap you get with GetProcessHeap ().  I don't know the
> >task of heap 1 yet, but heap 2 is ... something, as well as the stack of
> >the first thread in the process.  It looks like this:
> >
> >   base 0x00020000, flags 0x00008000, granularity     8, unknown     0
> >   allocated     1448, committed    65536, block count 3
> >   Block 0: addr 0x00020000, size  2150400, flags 0x00000002, unknown 0x00010000
> >
> >However, the various calls to VirtualQuery result in this output with
> >my patch:
> >
> >   00020000-00030000 rw-p 00000000 0000:0000 0      [heap 2 default share]
> >   00030000-00212000 ---p 00000000 0000:0000 0      [heap 2 default]
> >   00212000-00213000 rw-s 001E2000 0000:0000 0      [heap 2 default]
> >   00213000-00230000 rw-p 001E3000 0000:0000 0      [heap 2 default]
> >
> >The "something" is the sharable area from 0x20000 up to 0x30000.  The
> >stack is from 0x30000 up to 0x230000.  The first reagion is only
> >reserved, then the guard page, then the committed and used  tack area.
> Hmm. It looks like heap 2 was allocated by mapping the pagefile
> rather than using VirtualAlloc, and the thread's stack was allocated
> from heap 2, which treated the request as a large block and returned
> the result of a call to VirtualAlloc.
> 
> Are the other two heap bases not "default share" then?

Here's what I see for instance in tcsh:

00010000-00020000 rw-p 00000000 0000:0000 0       [heap 1 default share]

00020000-00030000 rw-p 00000000 0000:0000 0       [heap 2 default share]
00030000-00212000 ---p 00000000 0000:0000 0       [heap 2 default]
00212000-00213000 rw-s 001E2000 0000:0000 0       [heap 2 default]
00213000-00230000 rw-p 001E3000 0000:0000 0       [heap 2 default]

002E0000-00310000 rw-p 00000000 0000:0000 0       [heap 0 default grow]
00310000-003E0000 ---p 00030000 0000:0000 0       [heap 0 default grow]

> In any case, coming back to the allocation base issue, heap_info
> only needs to track 0x20000 and 0x30000, because they are the ones
> with offset zero that would trigger a call to
> heap_info::fill_on_match. I argue that heap walking found exactly
> two flags&2 blocks, with exactly those base addresses, making the
> range check in fill_on_match unecessary.

Nope.  As I wrote in my previoous mail and as you can still see in my
quote above, the two virtual memory areas from 0x20000 to 0x30000 and
from 0x30000 to 0x230000 together constitute a single start block in
heap 2.  The OS is a great faker in terms of information returned to
the application, apparently.

> Again, I'll try running your patch instead of my own when I get a
> chance, and see if yours finds regions mine fails to label. However,
> if 0x30000 above really is a large block region, then at least my
> worries about flags&2 were unfounded, which is great news.

0x30000 is not a large block region.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
