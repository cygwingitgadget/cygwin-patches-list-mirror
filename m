From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: (patch) inet header tweak
Date: Fri, 12 May 2000 18:23:00 -0000
Message-id: <20000512212349.B814@cygnus.com>
References: <200005122306.SAA05340@pluto.xraylith.wisc.edu>
X-SW-Source: 2000-q2/msg00056.html

On Fri, May 12, 2000 at 06:06:39PM -0500, Mumit Khan wrote:
>Change to in.h is self-explanatory. The change to socket.h adds IPv6 
>protocol and address family numbers for future, and also bumps up
>AF_MAX and PF_MAX to 32 for future expansion (I believe the numbers
>are already up to 24 for most systems, and systems like Linux tend
>to have 32 as the ceiling for now).
>
>2000-05-12  Mumit Khan  <khan@xraylith.wisc.edu>
>
>	* include/cygwin/in.h (struct in6_addr): Fix spelling.
>	* include/cygwin/socket.h (AF_INET6, PF_INET6): Define macros.
>	(AF_MAX, PF_MAX): Bump to 32.

Looks fine.

cgf
