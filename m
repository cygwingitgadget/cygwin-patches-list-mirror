From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: sched_* functions
Date: Sat, 17 Mar 2001 19:46:00 -0000
Message-id: <20010317224653.A6751@redhat.com>
References: <018c01c0af5c$fe559ed0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00203.html

On Sun, Mar 18, 2001 at 02:39:08PM +1100, Robert Collins wrote:
>Don't fall out of your chair chris, here's a second contribution...
>again, probably not perfect right out of the gate, but it works quite
>well.

I'm interested in this patch but the ChangeLog needs work.  Please read
the Contributing link on the Cygwin web page and make suitable corrections.
The problems you had with this ChangeLog are the same as your previous
submission.

cgf

>Changelog:
>
>18 Mar 2001 Robert Collins <rbtcollins@hotmail.com>
>    *  cygwin/sched.cc: new file, exported wrappers for __sched*
>    * cygwin/schedule.cc: new file, implements __sched*
>    * cygwin/schedule.h: new file, prototypes for __sched*
>    * cygwin/include/sched.h: , new file, user land includes for sched*
>    * cygwin/Makefile.in: added sched.o and schedule.o
>    * cygwin/cygwin.din: added exports for sched*
>    * cygwin/external.cc: export the inital windows thread id.
>    * cygwin/fork.cc: record the inital thread id for created process's.
>    * cygwin/pinfo.cc: record the inital thread id for the first cygwin
>process.
>    * cygwin/pinfo.h: allocate space to store the main thread Id for
>process's.
>    * cygwin/include/sys/cygwin.h: allocate space for exporting the main
>thread id for process's.
>    * w32api/include/winbase.h: Added prototype for OpenThread.
>    * w32api/lib/kernel32.def: Added export for OpenThread.
>
>
>I've attached the new files
>    *  cygwin/sched.cc (note the CC)
>    * cygwin/schedule.cc
>    * cygwin/schedule.h
>    * cygwin/include/sched.h
