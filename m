From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Thu, 27 Sep 2001 14:39:00 -0000
Message-id: <015b01c1479d$1d48c370$01000001@lifelesswks>
References: <20010925114527.23687.qmail@sourceware.cygnus.com> <14472692346.20010927144858@logos-m.ru> <007b01c14743$2a0005b0$01000001@lifelesswks> <12280602580.20010927170049@logos-m.ru> <008301c1475e$afb0c4e0$01000001@lifelesswks> <20010927140440.B32577@redhat.com>
X-SW-Source: 2001-q3/msg00219.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, September 28, 2001 4:04 AM
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...


> On Fri, Sep 28, 2001 at 12:14:13AM +1000, Robert Collins wrote:
> >Ok this is a quick-and-it-couldbe-cleaner patch.
> >
> >It's interim - this weekend I'll make time to roll the logic
throughout
> >thread.cc. The patch doesn't introduce any new issues though, and it
is
> >the correct IMO step to solving the issue(s) I was trying to address
> >with my last lets-break-cygwin patch.
> >
> >I have _no_ idea why it worked at all after I built that .dll :}. The
> >fault for those wanting the grisly details was that I changed the
> >semantics of verifyableobject_isvalid without updating the tests
against
> >the return code. Doh.
> >
> >I'm having some trouble with cvs+ssh with this patch .. though I'm
not
> >sure why. For a little while I though it might be chris's tuesday
> >sleep(1) change, because I was getting strange results from pspec>
I'm
> >not sure though.
>
> Huh?  What is my "sleep(1)" change?  The only change I made on Tuesday
was
> to fhandler_tty_common::ready_for_read.  How would that affect cvs?

Uh, looked at when Rob needed sleep(real) :]. Tues may 22nd - waaaaay
too far back to be of any impact.

> I don't know what pspec is either, so I'm lost.

Sorry, pspec is one of my test suite programs, that is very heavy on
concurrent sleeps. It seemed to be crashing, but for some reason the
actual faulty program was pt , and under make check task manager was
showing the wrong process name - don't ask why!.

However something has changed this week to break cvs+ssh for me. I'll
binary search this today (I'll do a local rollback of the thread code
and then see where it is without any thread changes).

Rob
