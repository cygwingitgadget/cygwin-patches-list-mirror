Return-Path: <cygwin-patches-return-3713-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28438 invoked by alias); 19 Mar 2003 10:15:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28375 invoked from network); 19 Mar 2003 10:15:19 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 19 Mar 2003 10:15:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
In-Reply-To: <1048067523.5305.132.camel@localhost>
Message-ID: <Pine.WNT.4.44.0303191055370.272-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00362.txt.bz2



On Wed, 19 Mar 2003, Robert Collins wrote:

> On Mon, 2003-03-17 at 19:17, Thomas Pfaff wrote:
> > On Thu, 13 Mar 2003, Cygwin (Robert Collins) wrote:
> >
> > > This:
> > >
> > >    if (1 == InterlockedIncrement ((long *)&lock_counter))
> > >
> > > is not safe. You can only check for equal to 0, less than 0, and greater
> > > than 0 with InterlockedIncrement | Decrement.
> > >
> >
> > The xadd based inline interlocked functions in winbase.h are now enabled
> > by default, so it is valid to test for 1 at this point.
>
> Enabled by default. Sure, as long as they aren't turned off again, or
> someone builds without them to get 386 support... Please, use the
> compatible test, it won't alter the code much. You can test for <0 and
> >0 safely.

The mutex stuff does not work on i386 at all because it requires
InterlockedCompareExchange. The reason to enable the Interlocked stuff in
winbase.h was to keep cygwin running on Win95 that has no implementation
for InterlockedCompareExchange. It simply can't be disabled without
loosing support for Win95/NT3.5. All later Windows versions behave the
same way than the inline ones, therefore it does not matter if the inlines
were disabled again. Sure someone could only enable the inline
InterlockedCompareExchange but why the hell he should do this.

>
> > It looks much cleaner to me to start a counter at 0 not at -1.
> > And the code now supports UINT_MAX instead of INT_MAX waiting
> > threads (even if INT_MAX threads are only academicical i see no reason to
> > add a limit here).
>
> Well there is a limit either way. I don't see any pragmatic difference.

While it might be at least theoretically possible to get INT_MAX threads
running UINT_MAX is really out of the limit on 32-bit.

>
> > > Secondly, IIRC lock_counter should be long, so the (long *) typecasting
> > > isn't needed.
> >
> > IMHO it should be unsigned since it makes no sense to have negative
> > counter values. In practice it doesn't make any difference because there
> > are not greater or smaller equations in the code.
>
> It's about type safety. Please, correct it.

Why not create an InterlockedIncrement|Decrement that takes unsigned long
arguments instead ? This has nothing to do with type safety but with lack
of functions.

Thomas
