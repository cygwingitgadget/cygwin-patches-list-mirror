From: Jason Tishler <Jason.Tishler@dothill.com>
To: Norman Vine <nhv@cape.com>
Cc: "'Robert Collins'" <robert.collins@itdomain.com.au>, "'Greg Smith'" <gsmith@nc.rr.com>, cygwin-patches@cygwin.com
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Thu, 21 Jun 2001 13:02:00 -0000
Message-id: <20010621160246.F138@dothill.com>
References: <002401c0fa86$74d12880$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00325.html

Norman,

On Thu, Jun 21, 2001 at 03:14:54PM -0400, Norman Vine wrote:
> THANK YOU GREG and ROB :-)))

I would also like to thank Rob for implementing the missing pthreads
functionality and Greg for helping to isolate and debug these issues.

> I have not done exhaustive testing yet but..... 
> It appears that with this patch 
> Python threading WORKS !!

How long does it take to run the Python regression tests with threading
enabled?

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
