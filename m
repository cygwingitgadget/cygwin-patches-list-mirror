From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: improving security of AF_UNIX sockets
Date: Fri, 06 Apr 2001 17:01:00 -0000
Message-id: <20010406200121.A24663@redhat.com>
References: <198204047314.20010404220250@logos-m.ru> <20010406141743.A23496@redhat.com> <6836779856.20010406234047@logos-m.ru>
X-SW-Source: 2001-q2/msg00012.html

On Fri, Apr 06, 2001 at 11:40:47PM +0400, egor duda wrote:
>Hi!
>
>Friday, 06 April, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>CF> On Wed, Apr 04, 2001 at 10:02:50PM +0400, egor duda wrote:
>>>This patch prevents local users from connecting to cygwin-emulated
>>>AF_UNIX socket if this user have no read rights on socket's file.  it's
>>>done by adding 128-bit random secret cookie to !<socket>port string in
>>>file.  later, each processes which is negotiating connection via
>>>connect() or accept() must signal its peer that it knows this secret
>>>cookie.
>
>CF> This looks good.  It seems like this would not be backwards compatible
>CF> though, right?
>
>CF> I don't know if this is an issue or not.
>
>it won't be an issue because contents of AF_UNIX sockets are not
>"persistent", they are being created anew on every bind(). in
>this sense they're unlike symlinks -- we don't care about what was
>written to the socket file before.
>
>the only possible incompatibility can appear if some application is
>reading an interpreting socket file contents directly, bypassing
>normal cygwin mechanism. i've never heard of such applications, and
>even if they exist, they're certainly fundamentally wrong.

That's what I thought.  Go ahead and check this in.  I appreciate your
thinking about this.

cgf
