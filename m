From: Jason Tishler <Jason.Tishler@dothill.com>
To: Norman Vine <nhv@cape.com>
Cc: "'Robert Collins'" <robert.collins@itdomain.com.au>, "'Greg Smith'" <gsmith@nc.rr.com>, cygwin-patches@cygwin.com
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Tue, 26 Jun 2001 07:34:00 -0000
Message-id: <20010626103350.P296@dothill.com>
References: <005001c0fe4c$2e2acb60$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00338.html

Norman,

On Tue, Jun 26, 2001 at 10:27:49AM -0400, Norman Vine wrote:
> Since my last correspondance with Jason I have tested this with
> the 'stock'  Python-2.1 tarball and all seems to be OK

How long does it take to run the regression tests (sans test_poll)?

> I am experiencing an occasional 'hang' in the make process
> this is on WIn2k sp2 and the 'very latest' Cygwin files.
> Usually a 'ctrl-C' will abort the make and a subsequent make
> will  run to completion.  This make behaviour is not isolated to the
> Python build but I have not been able to find a situation that will
> reliably reproduce it.

FWIW, I am experiencing the "hang" under Windows NT 4.0 SP5.  However,
for me, the hang is with Python (with threads) and not make itself.

IIRC, during the make I see two python processes.  After killing the
make, I still see one python process that needs to be manually killed.
Please do a ps before and after you kill the make.  Are you observing
this behavior or something different?

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
