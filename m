From: Jason Tishler <jason@tishler.net>
To: cygwin-patches@cygwin.com
Cc: Pgsql-Cygwin <pgsql-cygwin@postgresql.org>
Subject: Re: [CYGWIN] Re: Cygwin PostgreSQL shutdown handling (was Re: Make Cygwin damons easier to use on Win9x.)
Date: Mon, 30 Jul 2001 05:29:00 -0000
Message-id: <20010730082939.B642@dothill.com>
References: <20010727123905.U439@dothill.com>
X-SW-Source: 2001-q3/msg00040.html

Chris,

On Fri, Jul 27, 2001 at 12:39:05PM -0400, Jason Tishler wrote:
> On Thu, Jul 26, 2001 at 03:40:34PM -0400, Christopher Faylor wrote:
> > The close_secret_event handle wasn't being created with the correct
> > inheritance type.  I (hopefully) changed this.
> 
> I will test this as soon as a new snapshot is generated.  I'm trying to
> leave my CVS sandbox in a state that can reproduce the threaded Cygwin
> Python issue, so I'd like to hold off on a cvs update right now.

I just tested the 2001-Jul-28 snapshot and the above problem appears to
be fixed.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
