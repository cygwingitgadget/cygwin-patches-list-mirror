From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: cygwin/newlib types patchs
Date: Wed, 21 Mar 2001 14:24:00 -0000
Message-id: <026301c0b255$8982d130$0200a8c0@lifelesswks>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com>
X-SW-Source: 2001-q1/msg00230.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, March 22, 2001 9:06 AM
Subject: Re: cygwin/newlib types patchs


> On Thu, Mar 22, 2001 at 08:16:57AM +1100, Robert Collins wrote:
> >Well we can't turn on _POSIX_THREADS. And I don't think we should...
> >a) I've read enough of the spec now to say fairly confidently that
> >cygwin will not be conformant for a very long time. (Setting the
stack
> >address, setting a guard buffer for the stack...). So turning on
> >_POSIX_THREADS will be misleading. Autoconf feature tests find all
the
> >functions quite well.
> >b) the newlib _POSIX_THREADS types are broken IMO. They are
reasonable
> >structures and so forth but for userland includes they should be
opaque
> >to the user, and not a struct but rather a struct pointer to allow
> >behind the scenes changes without breaking the ABI. (better yet, a
void
> >* for real opaqueness).
> >c) the newlib includes have things in weird places- the pthreads
> >#defines should be in pthreads.h not sys/types.
>
> Ok.  I didn't know this.  I wonder how much should be handled by
fixing
> newlib, though?  If there are changes that make things more conformant
> then they should go in newlib.  I am sure that the newlib maintainers
> would like to fix things if they're out of whack.
>
> cgf
>

I'm happy if the effort I put in can be put to more that one use. I do
have limited cycles though (I'm sure I've heard you say this :] ).

On the technical side the newlib maintainers are facing the same problem
I did with pthreads (Changing at this date may break ABI and or existing
#if code. Secondly they may have users who have used the fact that the
userland includes allowed access to the internal elements of the *_t
types. (Which is a bad thing). I understand newlib exists because
proprietary software can be linked to it when it's sold under the second
licence... so the maintainers may well have contractual issues crop up
if they start fixing these things up.

Rob
