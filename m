From: Jason Tishler <Jason.Tishler@dothill.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Wed, 18 Jul 2001 05:19:00 -0000
Message-id: <20010718081915.A431@dothill.com>
References: <20010718130154.E730@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00015.html

Corrina,

On Wed, Jul 18, 2001 at 01:01:54PM +0200, Corinna Vinschen wrote:
> IMO, that's rather late in the function to handle a nonexistant file.
> I checked in a different solution which handles it more at the 
> beginning of _unlink().

Agreed.  I almost submitted a patch that dealt with this issue upfront
too, but the 1.122 version also handled this issue late and the 1.123
version seemed to have a yank and put error so I opted for the minimal
perturbation approach.

> Thanks for tracking it down, though.

You're welcome -- thanks for checking in a better fix.

Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
