Return-Path: <cygwin-patches-return-3716-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19073 invoked by alias); 19 Mar 2003 11:04:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18892 invoked from network); 19 Mar 2003 11:04:20 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 19 Mar 2003 11:04:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
In-Reply-To: <1048069469.5299.148.camel@localhost>
Message-ID: <Pine.WNT.4.44.0303191200260.241-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00365.txt.bz2



On Wed, 19 Mar 2003, Robert Collins wrote:

> On Wed, 2003-03-19 at 21:15, Thomas Pfaff wrote:
>
> > > > > Secondly, IIRC lock_counter should be long, so the (long *) typecasting
> > > > > isn't needed.
> > > >
> > > > IMHO it should be unsigned since it makes no sense to have negative
> > > > counter values. In practice it doesn't make any difference because there
> > > > are not greater or smaller equations in the code.
> > >
> > > It's about type safety. Please, correct it.
> >
> > Why not create an InterlockedIncrement|Decrement that takes unsigned long
> > arguments instead ? This has nothing to do with type safety but with lack
> > of functions.
>
> * make unsigned variants of the interlockedIncrement|Decrement that will
> throw (not C++, rather a processor exception) overflow or underflow as
> appropriate.

???
I do not think that this required and i do not think that a processor
exception will be thrown if you have longs.

Anyway, if you insists in it i will change the type to long but i still
disagree

Thomas
