From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: cygwin daemon/shm
Date: Mon, 17 Sep 2001 15:58:00 -0000
Message-id: <20010918005755.K10081@cygbert.vinschen.de>
References: <004a01c13ec4$fa3fec90$0200a8c0@lifelesswks> <20010917190150.F10081@cygbert.vinschen.de> <1000764497.1643.8.camel@lifelesswks>
X-SW-Source: 2001-q3/msg00161.html

On Tue, Sep 18, 2001 at 08:08:16AM +1000, Robert Collins wrote:
> On Tue, 2001-09-18 at 03:01, Corinna Vinschen wrote:
> > just so that you don't feel alone :-)
> 
> Thank you. I was wondering... :}.

We're still here, just busy...

> > Can we put that into types.h now already?  Would rebuilding
> > cygipc help for the interim?
> 
> If we put in into type.h now, every cygipc linked program has to be
> rebuilt, and they won't gain anything - when cygwin gets IPC internally
> they will need another rebuild. Putting it in synchronously with
> cygwin1.dll exporting the ipc/shm functions is te right way to go IMO.

I agree.

> Ah, yes. Well I haven't benchmarked it, but FWIW my machine seems no
> slower with it running.

You're talking about starting Cygwin processes?  Do they connect
to the server already?

> > Call me old fashioned but I'm still thinking of using DDE for
> > 9x and NT.  Both have it,  it's _probably_ fast since it's
> > implemented using shared memory and it has the impersonation
> > functionality which is needed for NT.
> 
> Ok. I'll move the winsock out of the base class (it should have been
> done anyway) and then it's simply a change to the object factory to
> choose a different transport. I'll be curious to see what actually
> benchmarks faster :]. 

I'll be curious either.  Take the above `_probably_' with a grain of
salt.  It's not supported by experience.  I'm just thinking that the
underlying usage of shared memory gives some hope for speed.  I've
used DDE only once years ago to connect a medical application with Excel.
Speed was not a factor at that time so we didn't make any benchmarks.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
