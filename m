Return-Path: <cygwin-patches-return-6073-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32098 invoked by alias); 18 Apr 2007 14:53:03 -0000
Received: (qmail 32085 invoked by uid 22791); 18 Apr 2007 14:53:03 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Apr 2007 15:53:00 +0100
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1HeBWl-0006tY-3L 	for cygwin-patches@cygwin.com; Wed, 18 Apr 2007 14:52:59 +0000
Message-ID: <462630CA.30974919@dessent.net>
Date: Wed, 18 Apr 2007 14:53:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
References: <462612A9.20E19FEB@dessent.net> <20070418125857.GA4589@trixie.casa.cgf.cx> <20070418130732.GK5799@calimero.vinschen.de> <46261A87.CDE8726C@dessent.net> <20070418132315.GA5262@trixie.casa.cgf.cx> <20070418134252.GL5799@calimero.vinschen.de>
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
X-SW-Source: 2007-q2/txt/msg00019.txt.bz2

Corinna Vinschen wrote:

> I debugged Cygwin native GDB a couple of days ago with code created by
> gcc 4.2.  It turned out that the DWARF2_UNWIND_INFO define set to 0
> resulted in the DW_CFA_offset column missing.  The result is that GDB is
> unable to get the return address on the stack when using the dwarf2
> frame sniffer.  Setting DWARF2_UNWIND_INFO to 1 in gcc/config/i386/cygming.h
> results in gcc emitting the missing DW_CFA_offset column and GDB is happy
> again.  Older gcc's <= 4.0.1 always created the DW_CFA_offset column, so
> GDB is always happy with the created debug info.

Ah, I see.  That makes sense.

> I'm not at all fluent with this stuff.  Is that really important
> for Cygwin?

It's not at all important to cygwin1.dll itself but it could be very
relevant to Cygwin users that want to make use of C++ code that makes
use of exceptions.

Danny Smith said he was preparing to release a gcc 4.2.x for MinGW in
the somewhat-near future, and since he knows the most about all of this
we can wait and see what he decides to do about it.

If it's possible to get Dwarf exceptions working in those few corner
cases, then that would be great; it's much faster than SJLJ and
obviously for the purposes of debug info it's way better.

If it turns out that we'll be sticking with SJLJ EH then I think it
would be reasonable to try to work up a patch that causes DW_CFA_offset
to be set even if not using Dwarf for EH.

Brian
