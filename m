Return-Path: <cygwin-patches-return-7336-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31061 invoked by alias); 11 May 2011 17:46:45 -0000
Received: (qmail 31050 invoked by uid 22791); 11 May 2011 17:46:44 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 17:46:29 +0000
Received: (qmail 16432 invoked by uid 107); 11 May 2011 17:46:27 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 19:46:27 +0200
Message-ID: <4DCACB72.6070201@cs.utoronto.ca>
Date: Wed, 11 May 2011 17:46:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de>
In-Reply-To: <20110511111455.GC11041@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00102.txt.bz2

On 11/05/2011 7:14 AM, Corinna Vinschen wrote:
> On May 11 01:27, Ryan Johnson wrote:
>> The second (proc-maps-heaps) adds reporting of Windows heaps (or
>> their bases, at least). Unfortunately there doesn't seem to be any
>> efficient way to identify all virtual allocations which a heap owns.
> There's a call RtlQueryDebugInformation which can fetch detailed heap
> information, and which is used by Heap32First/Heap32Last.  Using it
> directly is much more efficient than using the Heap32 functions.  The
> DEBUG_HEAP_INFORMATION is already in ntdll.h, what's missing is the
> layout of the Blocks info.  I found the info by googling:
>
>    typedef struct _HEAP_BLOCK
>    {
>      PVOID addr;
>      ULONG size;
>      ULONG flags;
>      ULONG unknown;
>    } HEAP_BLOCK, *PHEAP_BLOCK;
>
> If this information is searched until the address falls into the just
> inspected  block of virtual memory, then we would have the information,
> isn't it?
The problem is that the reported heap blocks corresponded to individual 
malloc() calls when I tested it (unordered list, most sizes < 100B). I 
really would have preferred a function that returns the list of memory 
regions owned by the heap. They must track that information -- I highly 
HeapDestroy uses these heap blocks to decide which memory regions to 
VirtualFree, but that info seems to live in the kernel...

Given that Heap32* has already been reverse-engineered by others, the 
main challenge would involve sorting the set of heap block addresses and 
distilling them down to a set of allocation bases. We don't want to do 
repeated linear searches over 50k+ heap blocks.

Also, the cygheap isn't a normal windows heap, is it? I thought it was 
essentially a statically-allocated array (.cygheap) that gets managed as 
a heap. I guess since it's part of cygwin1.dll we already do sort of 
report it...

Ryan
