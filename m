Return-Path: <cygwin-patches-return-3030-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3440 invoked by alias); 23 Sep 2002 12:45:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3391 invoked from network); 23 Sep 2002 12:45:40 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 23 Sep 2002 05:45:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] new mutex implementation 2. posting
In-Reply-To: <1032660183.10933.150.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209231440230.294-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00478.txt.bz2



On Sun, 22 Sep 2002, Robert Collins wrote:

> On Sat, 2002-09-21 at 01:47, Christopher Faylor wrote:
> > I haven't been following very closely.  Is the reason why we are not using
> > critical sections that TryEnterCriticalSection isn't available anywhere?
> > If so, then we can probably fix that with some assembly programming.
>
> Thats a factor, yes.
>
> > Critical sections are *so* much faster than mutexes or semaphores that
> > it makes sense to use them if possible.
> >
> > Or, maybe we're talking about something else entirely...
>
> Well there are two things. Thomas's work gives use recursive and error
> checking mutexes, which aren't currently supported. He also points out
> that semaphores leverage critical sections on NT, so should be ~ in
> speed.
>

???

I said that my implementation works similar as critical sections (or Chris
mutos).

Thomas
