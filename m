Return-Path: <cygwin-patches-return-7329-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20830 invoked by alias); 11 May 2011 11:15:39 -0000
Received: (qmail 20729 invoked by uid 22791); 11 May 2011 11:15:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 11 May 2011 11:14:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 57B002C0577; Wed, 11 May 2011 13:14:55 +0200 (CEST)
Date: Wed, 11 May 2011 11:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110511111455.GC11041@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCA1E59.4070800@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00095.txt.bz2

On May 11 01:27, Ryan Johnson wrote:
> The second (proc-maps-heaps) adds reporting of Windows heaps (or
> their bases, at least). Unfortunately there doesn't seem to be any
> efficient way to identify all virtual allocations which a heap owns.

There's a call RtlQueryDebugInformation which can fetch detailed heap
information, and which is used by Heap32First/Heap32Last.  Using it
directly is much more efficient than using the Heap32 functions.  The
DEBUG_HEAP_INFORMATION is already in ntdll.h, what's missing is the
layout of the Blocks info.  I found the info by googling:

  typedef struct _HEAP_BLOCK
  {
    PVOID addr;
    ULONG size;
    ULONG flags;
    ULONG unknown;
  } HEAP_BLOCK, *PHEAP_BLOCK;

If this information is searched until the address falls into the just
inspected  block of virtual memory, then we would have the information,
isn't it?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
