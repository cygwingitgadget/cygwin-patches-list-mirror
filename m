From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: sched* functions, pthread rework
Date: Tue, 20 Mar 2001 18:18:00 -0000
Message-id: <20010320211912.A2946@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79A8@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q1/msg00220.html

On Wed, Mar 21, 2001 at 12:51:11PM +1100, Robert Collins wrote:
>For clarity: the sched* functions are not thread related and should be
>in cygwin1.dll even when it's built non threaded..
> 
>New files: sched.cc, include/semaphore.h, include/sched.h
> 
>Changelog:
>21 Mar 2001 Robert Collins <rbtcollins@hotmail.com>
>    * sched.cc: New file. Implement sched*
>    * include/sched.h: New file. User land includes for sched*.
>    * Makefile.in: Add sched.o
>    * cygwin.din: Add exports for sched*.

(Ok.  You've worn me down.  I made the copyright changes.)

I also added '#ifdef __cplusplus' guards to sched.h and did some
comment reformatting in sched.cc.

Thanks for your contribution, as always.

Applied.

cgf
