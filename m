From: Jason Tishler <Jason.Tishler@dothill.com>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: improving security of AF_UNIX sockets
Date: Fri, 13 Apr 2001 08:23:00 -0000
Message-id: <20010413112338.N212@dothill.com>
References: <198204047314.20010404220250@logos-m.ru>
X-SW-Source: 2001-q2/msg00053.html

Egor,

On Wed, Apr 04, 2001 at 10:02:50PM +0400, egor duda wrote:
>   this patch prevents local users from connecting to cygwin-emulated
> AF_UNIX socket if this user have no read rights on socket's file.
> it's done by adding 128-bit random secret cookie to !<socket>port
> string in file. later, each processes which is negotiating connection
> via connect() or accept() must signal its peer that it knows this
> secret cookie.
> 
> sendto() and recvfrom() are still insecure, unfortunately.
> 
> Comments?

I have tried the above with PostgreSQL and it works as documented.
However, see the attached for a comment from one of the PostgreSQL
core developers.

Is it possible and/or does it make sense to do as suggested?

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: +1 (732) 264-8770 x235
Dot Hill Systems Corp.               Fax:   +1 (732) 264-8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
