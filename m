From: Jason Tishler <Jason.Tishler@dothill.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: setlogmask() patch
Date: Sun, 21 Jan 2001 19:48:00 -0000
Message-id: <20010121225155.A1272@dothill.com>
X-SW-Source: 2001-q1/msg00035.html

See attach for (trivial) patch and ChangeLog entry to add back
setlogmask() to Cygwin.  Note that I followed the other syslog exports
and exported setlogmask() as _setlogmask() too.  I don't know if this
was correct.

To apply the patch, use the following:

    $ cd src/winsup/cygwin
    $ # save attached patch to /tmp
    $ patch </tmp/setlogmask.patch

Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: +1 (732) 264-8770 x235
Dot Hill Systems Corp.               Fax:   +1 (732) 264-8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
