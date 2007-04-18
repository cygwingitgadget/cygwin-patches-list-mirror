Return-Path: <cygwin-patches-return-6072-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18767 invoked by alias); 18 Apr 2007 13:43:00 -0000
Received: (qmail 18745 invoked by uid 22791); 18 Apr 2007 13:42:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 18 Apr 2007 14:42:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E76236D47FD; Wed, 18 Apr 2007 15:42:52 +0200 (CEST)
Date: Wed, 18 Apr 2007 13:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
Message-ID: <20070418134252.GL5799@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <462612A9.20E19FEB@dessent.net> <20070418125857.GA4589@trixie.casa.cgf.cx> <20070418130732.GK5799@calimero.vinschen.de> <46261A87.CDE8726C@dessent.net> <20070418132315.GA5262@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070418132315.GA5262@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00018.txt.bz2

On Apr 18 09:23, Christopher Faylor wrote:
> On Wed, Apr 18, 2007 at 06:17:59AM -0700, Brian Dessent wrote:
> >Christopher Faylor wrote:
> >
> >> Thanks for doing this.  Please check in.  Can we switch to dwarf-2 by
> >> default in the cygwin makefile(s)?
> >
> >I thought about that, but the problem is anything you do to *FLAGS in
> >winsup/cygwin won't affect flags used in the other dirs like libiberty
> >or newlib, and so unless you set CXXFLAGS and CFLAGS when you do
> >toplevel configure, you'll end up with a mish-mash of some stabs and
> >some DW2 in the .dbg file.
> 
> So, maybe a top-level configure option would be useful?  At the very least
> we can get rid of the -gstabs specific use in configure.
> 
> >Corinna Vinschen wrote:
> >
> >> As long as we use a 3.x or 4.0.x gcc it should be ok.  Later gcc's
> >> explicitely switch off the generation of a DW_CFA_offset column in the
> >> .debug_frame CIE header information, which breaks backtracing in GDB.
> >
> >Hmm, I think I read something about that on the gcc list.  Is this just
> >a case of gcc switching to doing TheActualRightThing and gdb not having
> >being updated yet?

GDB's frame unwinding works fine, *iff* the DW_CFA_offset column is
present.

> >> There's an explicit
> >> 
> >> #define DWARF2_UNWIND_INFO 0
> >> 
> >> in gcc/config/i386/cygming.h right now.  The accompanying comment is
> >
> >Aren't we talking about two different things here?  That's for unwinding
> >during exception handling, but you can still leave that at 0 (and use
> >--enable-sjlj-exceptions) and still get the benefit of -gdwarf-2 for
> >gdb's consumption.

Don't ask me about exception handling :}

I debugged Cygwin native GDB a couple of days ago with code created by
gcc 4.2.  It turned out that the DWARF2_UNWIND_INFO define set to 0
resulted in the DW_CFA_offset column missing.  The result is that GDB is
unable to get the return address on the stack when using the dwarf2
frame sniffer.  Setting DWARF2_UNWIND_INFO to 1 in gcc/config/i386/cygming.h
results in gcc emitting the missing DW_CFA_offset column and GDB is happy
again.  Older gcc's <= 4.0.1 always created the DW_CFA_offset column, so
GDB is always happy with the created debug info.

> IIRC, this is turned on because of funkiness with exception unwinding in
> DLLs.

I'm not at all fluent with this stuff.  Is that really important
for Cygwin?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
