From: Jason Tishler <Jason.Tishler@dothill.com>
To: cygwin-patches@cygwin.com
Subject: Re: getsockopt() SO_ERROR optval mapping
Date: Mon, 02 Apr 2001 13:49:00 -0000
Message-id: <20010402164904.K798@dothill.com>
References: <20010402150827.G798@dothill.com> <20010402162019.A5358@redhat.com>
X-SW-Source: 2001-q2/msg00005.html

Chris,

On Mon, Apr 02, 2001 at 04:20:19PM -0400, Christopher Faylor wrote:
> On Mon, Apr 02, 2001 at 03:08:27PM -0400, Jason Tishler wrote:
> >This patch maps getsockopt() SO_ERROR optval's from their Winsock versions to
> >their corresponding errno versions.
> 
> Thanks for the patch.  I'd rather keep the errno processing localized,
> though.
> 
> Does this patch accomplish the same thing?

Yes, in a much better way than mine.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: +1 (732) 264-8770 x235
Dot Hill Systems Corp.               Fax:   +1 (732) 264-8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
