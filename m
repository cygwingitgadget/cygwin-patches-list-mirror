From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: improving security of AF_UNIX sockets
Date: Fri, 06 Apr 2001 12:19:00 -0000
Message-id: <20010406141743.A23496@redhat.com>
References: <198204047314.20010404220250@logos-m.ru>
X-SW-Source: 2001-q2/msg00010.html

On Wed, Apr 04, 2001 at 10:02:50PM +0400, egor duda wrote:
>This patch prevents local users from connecting to cygwin-emulated
>AF_UNIX socket if this user have no read rights on socket's file.  it's
>done by adding 128-bit random secret cookie to !<socket>port string in
>file.  later, each processes which is negotiating connection via
>connect() or accept() must signal its peer that it knows this secret
>cookie.

This looks good.  It seems like this would not be backwards compatible
though, right?

I don't know if this is an issue or not.

cgf
