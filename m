From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin/newlib types patchs
Date: Wed, 21 Mar 2001 06:05:00 -0000
Message-id: <20010321090559.F3149@redhat.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00222.html

On Wed, Mar 21, 2001 at 08:10:00PM +1100, Robert Collins wrote:
>This diff was taken from the src/ level (immediately above winsup and
>newlib) - but I've split it into two... however I'm mailing them
>together because if only one is applied, cygwin & newlib will no longer
>place nicely together.
>
>Chris, I hope this is a bit easier on you...
>
>
>newlib ChangeLog:
>21 Mar 2001 Robert Collins <rbtcollins@hotmail.com>
>    * libc/include/sys/signal.h: Test for __CYGWIN__ as well as
>_POSIX_THREADS
>    * libc/include/sys/types.h:
>      Allow __CYGWIN__ for the POSIX_THREADS types.
>      Include <cygwin/types.h> rather than use the _POSIX_THREADS
>structs from newlib.

This is, again, odd ChangeLog formatting.  The wrapping is weird
and the indentation is off.

Anyway, shouldn't we be turning on _POSIX_THREADS in
newlib/libc/include/sys/features.h ?  It doesn't seem right to
be checking explicitly for both a generic case (_POSIX_THREADS)
and a system specific case (__CYGWIN__).  The _POSIX_THREADS
definition is there to control this, isn't it?

cgf
