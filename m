From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: Pgsql-Cygwin <pgsql-cygwin@postgresql.org>
Subject: Re: Cygwin PostgreSQL shutdown handling (was Re: Make Cygwin damons easier to use on Win9x.)
Date: Thu, 26 Jul 2001 12:40:00 -0000
Message-id: <20010726154034.A20056@redhat.com>
References: <20010725175126.C11993@redhat.com> <20010726124535.K439@dothill.com>
X-SW-Source: 2001-q3/msg00038.html

On Thu, Jul 26, 2001 at 12:45:35PM -0400, Jason Tishler wrote:
>Although this is most likely unrelated to this patch and caused by
>something else in this snapshot, I am seeing the following error messages
>when using PostgreSQL:
>
>  23606 [main] postmaster 280 close_handle: closing protected handle void sigproc_init ():552(signal_arrived<0x1C0>)
>  76914 [main] postmaster 280 close_handle:  by void fhandler_socket::close_secret_event ():122(secret_event<0x1C0>)
>pq_recvbuf: recv() failed: Not owner
>
>I will try to track down the above and provide more details and/or
>a patch.  But, I thought it better to report the issue instead of
>withholding it until I had a chance to work on it.

I took a look at this.  It seems to be related to a recent change I
made which stopped cygwin from calling DuplicateHandle on every handle
after a fork, to reproduce the close-on-exec status.

The close_secret_event handle wasn't being created with the correct
inheritance type.  I (hopefully) changed this.

I did some rudimentary testing but I can't test it too heavily since
I'm setting up a new system.  My Windows 2000 system got a little
flaky over my vacation.  I think it didn't like being turned off for
so long...

cgf
