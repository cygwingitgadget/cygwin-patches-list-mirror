From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: cygwin/newlib types patchs
Date: Wed, 21 Mar 2001 13:18:00 -0000
Message-id: <000b01c0b24c$43e45530$0200a8c0@lifelesswks>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com>
X-SW-Source: 2001-q1/msg00225.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, March 22, 2001 1:15 AM
Subject: Re: cygwin/newlib types patchs


> On Wed, Mar 21, 2001 at 09:05:59AM -0500, Christopher Faylor wrote:
> >On Wed, Mar 21, 2001 at 08:10:00PM +1100, Robert Collins wrote:
> >>This diff was taken from the src/ level (immediately above winsup
and
> >>newlib) - but I've split it into two... however I'm mailing them
> >>together because if only one is applied, cygwin & newlib will no
longer
> >>place nicely together.
> >>
> >>Chris, I hope this is a bit easier on you...
> >>
> >>
> >>newlib ChangeLog:
> >>21 Mar 2001 Robert Collins <rbtcollins@hotmail.com>
> >>    * libc/include/sys/signal.h: Test for __CYGWIN__ as well as
> >>_POSIX_THREADS
> >>    * libc/include/sys/types.h:
> >>      Allow __CYGWIN__ for the POSIX_THREADS types.
> >>      Include <cygwin/types.h> rather than use the _POSIX_THREADS
> >>structs from newlib.
> >
> >This is, again, odd ChangeLog formatting.  The wrapping is weird
> >and the indentation is off.

Let me try again... (another email coming)

> >Anyway, shouldn't we be turning on _POSIX_THREADS in
> >newlib/libc/include/sys/features.h ?  It doesn't seem right to
> >be checking explicitly for both a generic case (_POSIX_THREADS)
> >and a system specific case (__CYGWIN__).  The _POSIX_THREADS
> >definition is there to control this, isn't it?
>
> Or, looking at your other comments, maybe we just need finer grained
> control of what features are defined in features.h for Cygwin.
>
> cgf
>

Well we can't turn on _POSIX_THREADS. And I don't think we should...
a) I've read enough of the spec now to say fairly confidently that
cygwin will not be conformant for a very long time. (Setting the stack
address, setting a guard buffer for the stack...). So turning on
_POSIX_THREADS will be misleading. Autoconf feature tests find all the
functions quite well.
b) the newlib _POSIX_THREADS types are broken IMO. They are reasonable
structures and so forth but for userland includes they should be opaque
to the user, and not a struct but rather a struct pointer to allow
behind the scenes changes without breaking the ABI. (better yet, a void
* for real opaqueness).
c) the newlib includes have things in weird places- the pthreads
#defines should be in pthreads.h not sys/types.

Rob
