Return-Path: <cygwin-patches-return-6071-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17251 invoked by alias); 18 Apr 2007 13:38:45 -0000
Received: (qmail 17153 invoked by uid 22791); 18 Apr 2007 13:38:44 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Apr 2007 14:38:41 +0100
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1HeAMo-0006ew-MS 	for cygwin-patches@cygwin.com; Wed, 18 Apr 2007 13:38:38 +0000
Message-ID: <46261F5E.F7837797@dessent.net>
Date: Wed, 18 Apr 2007 13:38:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
References: <462612A9.20E19FEB@dessent.net> <20070418125857.GA4589@trixie.casa.cgf.cx> <20070418130732.GK5799@calimero.vinschen.de> <46261A87.CDE8726C@dessent.net> <20070418132315.GA5262@trixie.casa.cgf.cx>
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
X-SW-Source: 2007-q2/txt/msg00017.txt.bz2

Christopher Faylor wrote:

> So, maybe a top-level configure option would be useful?  At the very least
> we can get rid of the -gstabs specific use in configure.

Oh, I didn't know there was anything that specifically mentions -gstabs
in there, just that if you don't set {C,CXX}FLAGS yourself autoconf uses
"-g -O2".  To me it seems  simple enough for now just to require:

.../toplev/configure CXXFLAGS="-gdwarf-2 -O2" CFLAGS="-gdwarf-2 -O2"

And then at some point in the future, release updated gcc packages where
-g equals -gdwarf-2 rather than -gstabs (but still without touching any
of the exception handling stuff.)

> >Aren't we talking about two different things here?  That's for unwinding
> >during exception handling, but you can still leave that at 0 (and use
> >--enable-sjlj-exceptions) and still get the benefit of -gdwarf-2 for
> >gdb's consumption.
> 
> IIRC, this is turned on because of funkiness with exception unwinding in
> DLLs.

I think there were/are two issues:

1. throw/catch unwinding across DLL boundaries currently works but
requires MinGW/Cygwin-local patches that were never championed/accepted
upstream because they were too ugly (and I think Danny said this area
has changed enough in 4.x that they don't forward port at all.)  The
pain here might have been related to the fact that currently all target
libraries are static (libgcc, libstdc++, etc) which means there are 'n'
copies of the libgcc code in memory instead of just one in a DLL.  So we
need shared target libs, then this becomes simpler.

2. Dwarf-2 EH unwinding through a "foreign" frame causes problems, one
example of which is where your code is registered with a Win32 API as a
callback and you want to throw from inside that callback.  When the
unwinder goes up the stack there is one or more frames inside of
USER32.DLL or NTDLL.DLL or something and it gets lost.  This is the one
that is somewhat intractible and would cause us to either foresake that
use pattern or stick with SJLJ.  Or maybe somebody will have a bright
idea.

Brian
