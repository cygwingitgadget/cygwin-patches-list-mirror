From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: NT Shutdown Handling Patch
Date: Wed, 18 Jul 2001 13:56:00 -0000
Message-id: <20010718165558.G608@dothill.com>
X-SW-Source: 2001-q3/msg00024.html

The attached patch changes ctrl_c_handler() to send SIGTERM (instead
of SIGHUP) when NT shuts down (or a close event is received).  See the
following for the motivation:

    http://www.cygwin.com/ml/cygwin/2001-07/msg00827.html
    http://www.cygwin.com/ml/cygwin/2001-07/msg01060.html

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
