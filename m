From: Jason Tishler <jason@tishler.net>
To: cygwin-patches@cygwin.com
Cc: Pgsql-Cygwin <pgsql-cygwin@postgresql.org>
Subject: Cygwin PostgreSQL shutdown handling (was Re: Make Cygwin damons easier to use on Win9x.)
Date: Thu, 26 Jul 2001 09:45:00 -0000
Message-id: <20010726124535.K439@dothill.com>
References: <20010725175126.C11993@redhat.com>
X-SW-Source: 2001-q3/msg00037.html

On Wed, Jul 25, 2001 at 05:51:26PM -0400, Christopher Faylor wrote:
> On Thu, Jul 12, 2001 at 12:39:13AM +0900, Kazuhiro Fujieda wrote:
> >I had enjoyed my daemon patch for a while. I found detaching
> >the console worked fine and cause no undesirable side effect,
> >while the ctrl_c_handler caused an undesirable effect.
> >It terminated Cygwin processes running as services on NT/2000
> >when an user logged off. So I fixed it.
> 
> Anyway, I've applied this patch.  I was a little reluctant to change the
> behavior of the CTRL_SHUTDOWN_EVENT since it has been like this for some
> time.

This portion of Kazuhiro's patch obviates the following patch:

    http://www.cygwin.com/ml/cygwin-patches/2001-q3/msg00024.html

I installed the 2001-Jul-25 snapshot and verified that PostgreSQL
shutdowns cleanly and restarts without manual invention when NT reboots.
And there was much rejoicing by Cygwin PostgreSQL users until...

Although this is most likely unrelated to this patch and caused by
something else in this snapshot, I am seeing the following error messages
when using PostgreSQL:

  23606 [main] postmaster 280 close_handle: closing protected handle void sigproc_init ():552(signal_arrived<0x1C0>)
  76914 [main] postmaster 280 close_handle:  by void fhandler_socket::close_secret_event ():122(secret_event<0x1C0>)
pq_recvbuf: recv() failed: Not owner

I will try to track down the above and provide more details and/or
a patch.  But, I thought it better to report the issue instead of
withholding it until I had a chance to work on it.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
