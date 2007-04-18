Return-Path: <cygwin-patches-return-6069-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3153 invoked by alias); 18 Apr 2007 13:18:04 -0000
Received: (qmail 3139 invoked by uid 22791); 18 Apr 2007 13:18:04 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Apr 2007 14:18:02 +0100
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1HeA2p-0006br-T1 	for cygwin-patches@cygwin.com; Wed, 18 Apr 2007 13:17:59 +0000
Message-ID: <46261A87.CDE8726C@dessent.net>
Date: Wed, 18 Apr 2007 13:18:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
References: <462612A9.20E19FEB@dessent.net> <20070418125857.GA4589@trixie.casa.cgf.cx> <20070418130732.GK5799@calimero.vinschen.de>
Content-Type: text/plain; charset=us-ascii
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
X-SW-Source: 2007-q2/txt/msg00015.txt.bz2

Christopher Faylor wrote:

> Thanks for doing this.  Please check in.  Can we switch to dwarf-2 by
> default in the cygwin makefile(s)?

I thought about that, but the problem is anything you do to *FLAGS in
winsup/cygwin won't affect flags used in the other dirs like libiberty
or newlib, and so unless you set CXXFLAGS and CFLAGS when you do
toplevel configure, you'll end up with a mish-mash of some stabs and
some DW2 in the .dbg file.

Corinna Vinschen wrote:

> As long as we use a 3.x or 4.0.x gcc it should be ok.  Later gcc's
> explicitely switch off the generation of a DW_CFA_offset column in the
> .debug_frame CIE header information, which breaks backtracing in GDB.

Hmm, I think I read something about that on the gcc list.  Is this just
a case of gcc switching to doing TheActualRightThing and gdb not having
being updated yet?

> There's an explicit
> 
> #define DWARF2_UNWIND_INFO 0
> 
> in gcc/config/i386/cygming.h right now.  The accompanying comment is

Aren't we talking about two different things here?  That's for unwinding
during exception handling, but you can still leave that at 0 (and use
--enable-sjlj-exceptions) and still get the benefit of -gdwarf-2 for
gdb's consumption.

Brian
