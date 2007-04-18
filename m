Return-Path: <cygwin-patches-return-6070-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6490 invoked by alias); 18 Apr 2007 13:23:24 -0000
Received: (qmail 6475 invoked by uid 22791); 18 Apr 2007 13:23:23 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-70-61-13.bstnma.fios.verizon.net (HELO cgf.cx) (72.70.61.13)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Apr 2007 14:23:17 +0100
Received: by cgf.cx (Postfix, from userid 201) 	id DC3F213C037; Wed, 18 Apr 2007 09:23:15 -0400 (EDT)
Date: Wed, 18 Apr 2007 13:23:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
Message-ID: <20070418132315.GA5262@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <462612A9.20E19FEB@dessent.net> <20070418125857.GA4589@trixie.casa.cgf.cx> <20070418130732.GK5799@calimero.vinschen.de> <46261A87.CDE8726C@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46261A87.CDE8726C@dessent.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00016.txt.bz2

On Wed, Apr 18, 2007 at 06:17:59AM -0700, Brian Dessent wrote:
>Christopher Faylor wrote:
>
>> Thanks for doing this.  Please check in.  Can we switch to dwarf-2 by
>> default in the cygwin makefile(s)?
>
>I thought about that, but the problem is anything you do to *FLAGS in
>winsup/cygwin won't affect flags used in the other dirs like libiberty
>or newlib, and so unless you set CXXFLAGS and CFLAGS when you do
>toplevel configure, you'll end up with a mish-mash of some stabs and
>some DW2 in the .dbg file.

So, maybe a top-level configure option would be useful?  At the very least
we can get rid of the -gstabs specific use in configure.

>Corinna Vinschen wrote:
>
>> As long as we use a 3.x or 4.0.x gcc it should be ok.  Later gcc's
>> explicitely switch off the generation of a DW_CFA_offset column in the
>> .debug_frame CIE header information, which breaks backtracing in GDB.
>
>Hmm, I think I read something about that on the gcc list.  Is this just
>a case of gcc switching to doing TheActualRightThing and gdb not having
>being updated yet?
>
>> There's an explicit
>> 
>> #define DWARF2_UNWIND_INFO 0
>> 
>> in gcc/config/i386/cygming.h right now.  The accompanying comment is
>
>Aren't we talking about two different things here?  That's for unwinding
>during exception handling, but you can still leave that at 0 (and use
>--enable-sjlj-exceptions) and still get the benefit of -gdwarf-2 for
>gdb's consumption.

IIRC, this is turned on because of funkiness with exception unwinding in
DLLs.

cgf
