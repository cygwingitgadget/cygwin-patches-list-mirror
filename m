From: Jason Tishler <Jason.Tishler@dothill.com>
To: "'Robert Collins'" <robert.collins@itdomain.com.au>
Cc: Norman Vine <nhv@cape.com>, "'Greg Smith'" <gsmith@nc.rr.com>, cygwin-patches@cygwin.com
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Tue, 26 Jun 2001 07:10:00 -0000
Message-id: <20010626101032.O296@dothill.com>
References: <20010621160246.F138@dothill.com>
X-SW-Source: 2001-q2/msg00337.html

Rob,

On Thu, Jun 21, 2001 at 04:02:46PM -0400, Jason Tishler wrote:
> Norman,
> 
> On Thu, Jun 21, 2001 at 03:14:54PM -0400, Norman Vine wrote:
> > THANK YOU GREG and ROB :-)))
> 
> I would also like to thank Rob for implementing the missing pthreads
> functionality and Greg for helping to isolate and debug these issues.

Unfortunately I was swayed by Norman's exuberance and responded without
actually testing myself.  I now see that Python hangs when trying to
build the standard extension modules during the build (which uses the
newly built python executable).  I will try to supply useful details as
soon as I get a chance.

In off-list email with Norman, it was ascertained that he is not using a
stock Python 2.1 source tree.  Norman, feel free to supply your findings
-- it may be helpful for Rob to track down some of the remain problems.

Nevertheless, I still appreciate Rob and Greg's efforts to fill out
Cygwin's pthreads support.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
