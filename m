From: Jason Tishler <jason@tishler.net>
To: cygwin-patches@cygwin.com
Cc: Pgsql-Cygwin <pgsql-cygwin@postgresql.org>
Subject: Re: Cygwin PostgreSQL shutdown handling (was Re: Make Cygwin damons easier to use on Win9x.)
Date: Fri, 27 Jul 2001 09:39:00 -0000
Message-id: <20010727123905.U439@dothill.com>
References: <20010726154034.A20056@redhat.com>
X-SW-Source: 2001-q3/msg00039.html

Chris,

On Thu, Jul 26, 2001 at 03:40:34PM -0400, Christopher Faylor wrote:
> On Thu, Jul 26, 2001 at 12:45:35PM -0400, Jason Tishler wrote:
> >Although this is most likely unrelated to this patch and caused by
> >something else in this snapshot, I am seeing the following error messages
> >when using PostgreSQL:
> >
> >  23606 [main] postmaster 280 close_handle: closing protected handle void sigproc_init ():552(signal_arrived<0x1C0>)
> >  76914 [main] postmaster 280 close_handle:  by void fhandler_socket::close_secret_event ():122(secret_event<0x1C0>)
> >pq_recvbuf: recv() failed: Not owner
> >
> >I will try to track down the above and provide more details and/or
> >a patch.  But, I thought it better to report the issue instead of
> >withholding it until I had a chance to work on it.
> 
> I took a look at this.  It seems to be related to a recent change I
> made which stopped cygwin from calling DuplicateHandle on every handle
> after a fork, to reproduce the close-on-exec status.
> 
> The close_secret_event handle wasn't being created with the correct
> inheritance type.  I (hopefully) changed this.

I will test this as soon as a new snapshot is generated.  I'm trying to
leave my CVS sandbox in a state that can reproduce the threaded Cygwin
Python issue, so I'd like to hold off on a cvs update right now.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
