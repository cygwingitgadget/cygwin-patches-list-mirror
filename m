Return-Path: <cygwin-patches-return-2837-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18621 invoked by alias); 16 Aug 2002 09:32:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18606 invoked from network); 16 Aug 2002 09:32:21 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 16 Aug 2002 02:32:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Interlocked functions
In-Reply-To: <20020815202936.GB21949@redhat.com>
Message-ID: <Pine.WNT.4.44.0208161059380.256-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00285.txt.bz2



On Thu, 15 Aug 2002, Christopher Faylor wrote:

> On Thu, Aug 15, 2002 at 09:38:52PM +0200, Thomas Pfaff wrote:
> >
> >With my mutex implementation i ran into the problem that the
> >InterlockedCompareExchange call ist not available on Win95.
> >
> >IMHO there exist 3 possibilities:
> >
> >Do not apply my mutexes :-(
> >Drop support for WIN95.
> >Create assembler versions of the interlocked functions. Now the code will
> >not on run on old i386 machines. This is my favourite solution.
> >
> >Chris has alreay created inline functions for Interlocked... in winbase.h,
> >i have added an ilockcmpexch and converted them into real functions in a
> >new file called winbase.c because i had some trouble with O2 optimization
> >and the inline functions.
>
> Argh.  So, you lose all of the inline optimization.  It sounds like you
> have to play with your implementation some more.
>
> The linux kernel manages to work fine with -O2 optimization.  There is no
> reason why we can't do the same.

This is surely true, but the problems that i had were not obvious and
reproducable.
It works most of the time but then the process started eating the cpu or
it crashed after ilockexch. I guess that a register has been modified that
shouldn't get modified but i couldn't see an error in my declarations.
You can be sure that i have tried very hard to get the inline versions
working.
Since the c functions are at least as fast as calling the real
Interlockeds in kernel32.dll i see no reason why not use them and play
with inline functions later.
I will try to divide the fork patch into smaller blocks first before i
will spend more time with inline assembler HowTos.

Thomas
