From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: cygwin daemon/shm
Date: Mon, 17 Sep 2001 10:01:00 -0000
Message-id: <20010917190150.F10081@cygbert.vinschen.de>
References: <004a01c13ec4$fa3fec90$0200a8c0@lifelesswks>
X-SW-Source: 2001-q3/msg00158.html

Robert,

just so that you don't feel alone :-)

On Mon, Sep 17, 2001 at 01:33:46AM +1000, Robert Collins wrote:
> In this tarball:
> * a minor newlib sys/types.h change, based on the ieee recommendations,
> to make key_t as big an int possible. Note: as the only use for key_t is
> in non-realtime IPC, this should break precisely one app: cyg_ipc, and
> anything built on it.

Can we put that into types.h now already?  Would rebuilding
cygipc help for the interim?

> 2. Fast
> Should be, it's aggressively multi threaded, using thread pools for
> efficiency, and as the pool class has no globals, can be extended to
> multiple pools for different requests queues if and when it needs that.

I was more concerned about the speed of one single call of the
client process, not about over all performance.  I'm thinking
this is more related to the used TL method.

> 4. Secure
> The transport layer includes core impersonation functions. For winsock
> we can use the GSSAPI to get impersonation capability, if anyone wants
> to make NT use sockets rather than pipes, but by abstracting the

*shudder*

> transport, there was no problem using different base layers.
> Alternatives such as DDE for 95, or pipes+shared memory on NT are also
> easy, I believe the abstraction covers everything of import. (except
> addressing the target, thats hardcoded in the class for simplicity...)

Call me old fashioned but I'm still thinking of using DDE for
9x and NT.  Both have it,  it's _probably_ fast since it's
implemented using shared memory and it has the impersonation
functionality which is needed for NT.

> Knowing how these things work, I'd like to propose one of the following:
> a) when 1.3.3-3 or 1.3.4 (the thing with a make death fix/improvement)
> goes out the door, and we have a little breathing space, this daemon
> gets committed (subsequent to general file/directory layout discussion
> and rearrangement as Chris requested). The shm and ipc functions _do
> not_ get exported from cygwin, or they simply are not included in the
> commit. (The goal is to add the daemon, not the tty_attach code or the
> shm code per se).

Sounds good.  Chris and I agree to treat 1.3.4 as a bugfix release.

> b) we branch cygwin, and checkin the daemon, shm the lot. (Subsequent to
> the same layout discussion as in a) ). That then gets examined and
> tweaked, and if-and-when folk are happy bits of it get merged to HEAD.
> (I.e. the daemon might come in first, with no functions. and then we add
> foo/bar..)

Nah, let's just wait until 1.3.4 is out of the door.

> In case you are wondering why I got off my chuff and did this? I was in
> danger of falling into the "gee this would be nice" mode again, and
> though I'd get out of danger.

Wow!  I grudge you :-))

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
