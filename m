Return-Path: <cygwin-patches-return-2992-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29708 invoked by alias); 17 Sep 2002 10:52:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29681 invoked from network); 17 Sep 2002 10:52:20 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 17 Sep 2002 03:52:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] new mutex implementation 2. posting
In-Reply-To: <1032257204.17674.192.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209171229540.279-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00440.txt.bz2



On Tue, 17 Sep 2002, Robert Collins wrote:

> On Tue, 2002-09-17 at 19:34, Thomas Pfaff wrote:
> >
> > This patch contains a new mutex implementation.
> >
> > The advantages are:
> >
> > - Same code on Win9x and NT. Actual are critical sections used on NT and
> >   kernel mutexes on 9x.
>
> Are you saying it uses critical sections on NT? (i.e. is that MS's
> uinderlying implementation for semaphores?)

I am saying that the current implementatione differ between NT and 9x.
NT uses critical section (for performance reasons i guess), 9x kernel
mutexes because of the lacking TryEnterCriticalSection.

>
> > - Posix compliant error codes.
>
> I thought we where before. Can you be more specific?

I can not see error codes like EPERM, EAGAIN or EDEADLK at positions where
they should be returned.

>
> > - State is preserved after fork as it should.
>
> Likewise, I know this has already been implemented. What was not
> preserved previously?
>

Instead of preservering the state a mutex is recreated after a fork and
the locking state is lost. IMHO a fork save mutex can not be done with
kernel mutexes nor with critical sections.

> > - Supports both errorchecking and recursive mutexes.
>
> This is nice. It shouldn't need a new implementation though. What I mean
> is: lets understand the ramifications first.

IMHO it is impossible on 9x to support errorchecking mutexes with kernel
objects and on NT with critical sections unless you willing to use the
undocumented parts of the CRITICAL_SECTION structure.

And: the actual default mutex type is recursive which is incompatible to
any other pthread implementation that i know.

>
> > - Should be at least as fast as critical sections.
>
> I don't understand how it can be, if semaphores are based on critical
> sections, it can't be faster. Or am I wearing my dumb hat today?
>

One of my goals was to be as fast as a critical section even on 9x.
Instead of a kernel transition in each mutex call it is only needed when
another thread is waiting. Critical sections are about 10 times faster
than kernel mutexes if they are not locked simultanously be 2 or more
threads and they work mostly the same way than my implementation.

Thomas
