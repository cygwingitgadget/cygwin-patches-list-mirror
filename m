From: Jason Tishler <Jason.Tishler@dothill.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: getsockopt() SO_ERROR optval mapping
Date: Mon, 02 Apr 2001 12:08:00 -0000
Message-id: <20010402150827.G798@dothill.com>
X-SW-Source: 2001-q2/msg00003.html

This patch maps getsockopt() SO_ERROR optval's from their Winsock versions to
their corresponding errno versions.  This prevents strerror(optval) from
generating cryptic messages like:

    error 10061

instead of:

    Connection refused

Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: +1 (732) 264-8770 x235
Dot Hill Systems Corp.               Fax:   +1 (732) 264-8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
