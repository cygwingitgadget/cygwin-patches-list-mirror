From: Christopher Faylor <cgf@redhat.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: pthreads works, sorta
Date: Tue, 26 Jun 2001 07:58:00 -0000
Message-id: <20010626105843.A7026@redhat.com>
References: <3B37D1A6.39A2685@nc.rr.com> <03c701c0fdd7$82ddbde0$0200a8c0@lifelesswks> <3B37F19F.C9BCDA23@nc.rr.com> <003d01c0fe1c$1f7e3c80$0200a8c0@lifelesswks> <00ab01c0fe39$41ece8d0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00342.html

On Tue, Jun 26, 2001 at 10:12:22PM +1000, Robert Collins wrote:
>Changelog:
>Tue Jun 26 22:10:00 2001  Robert Collins rbtcollins@hotmail.com
>
>	* thread.cc (pthread_cond::TimedWait): Check for WAIT_TIMEOUT as well
>	as WAIT_ABANDONED.
>	(__pthread_cond_timedwait): Calculate a relative wait from the abstime
>	parameter.

I checked this in.

Also, a general warning:  I just took one of my periodic sweeps through the
source code and eliminated trailing white space from a number of files.

So, it will look like a lot of files have been modified by me.

cgf
