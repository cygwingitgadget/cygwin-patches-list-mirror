From: Robert Collins <robert.collins@itdomain.com.au>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: cygwin daemon/shm
Date: Mon, 17 Sep 2001 15:07:00 -0000
Message-id: <1000764497.1643.8.camel@lifelesswks>
References: <004a01c13ec4$fa3fec90$0200a8c0@lifelesswks> <20010917190150.F10081@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00160.html

On Tue, 2001-09-18 at 03:01, Corinna Vinschen wrote:
> Robert,
> 
> just so that you don't feel alone :-)

Thank you. I was wondering... :}.

> On Mon, Sep 17, 2001 at 01:33:46AM +1000, Robert Collins wrote:
> > In this tarball:
> > * a minor newlib sys/types.h change, based on the ieee recommendations,
> > to make key_t as big an int possible. Note: as the only use for key_t is
> > in non-realtime IPC, this should break precisely one app: cyg_ipc, and
> > anything built on it.
> 
> Can we put that into types.h now already?  Would rebuilding
> cygipc help for the interim?

If we put in into type.h now, every cygipc linked program has to be
rebuilt, and they won't gain anything - when cygwin gets IPC internally
they will need another rebuild. Putting it in synchronously with
cygwin1.dll exporting the ipc/shm functions is te right way to go IMO.

> > 2. Fast
> > Should be, it's aggressively multi threaded, using thread pools for
> > efficiency, and as the pool class has no globals, can be extended to
> > multiple pools for different requests queues if and when it needs that.
> 
> I was more concerned about the speed of one single call of the
> client process, not about over all performance.  I'm thinking
> this is more related to the used TL method.

Ah, yes. Well I haven't benchmarked it, but FWIW my machine seems no
slower with it running.

> > 4. Secure
...
> > addressing the target, thats hardcoded in the class for simplicity...)
> 
> Call me old fashioned but I'm still thinking of using DDE for
> 9x and NT.  Both have it,  it's _probably_ fast since it's
> implemented using shared memory and it has the impersonation
> functionality which is needed for NT.

Ok. I'll move the winsock out of the base class (it should have been
done anyway) and then it's simply a change to the object factory to
choose a different transport. I'll be curious to see what actually
benchmarks faster :]. 

> > Knowing how these things work, I'd like to propose one of the following:
> > a) when 1.3.3-3 or 1.3.4 (the thing with a make death fix/improvement)
> > goes out the door, and we have a little breathing space, this daemon
> > gets committed (subsequent to general file/directory layout discussion
> > and rearrangement as Chris requested). The shm and ipc functions _do
> > not_ get exported from cygwin, or they simply are not included in the
> > commit. (The goal is to add the daemon, not the tty_attach code or the
> > shm code per se).
> 
> Sounds good.  Chris and I agree to treat 1.3.4 as a bugfix release.

Great!.

Rob
