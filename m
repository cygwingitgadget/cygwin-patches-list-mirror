From: Robert Collins <robert.collins@itdomain.com.au>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: Egor's daemon
Date: Wed, 12 Sep 2001 15:29:00 -0000
Message-id: <1000333801.31770.17.camel@lifelesswks>
References: <1000295535.30404.67.camel@lifelesswks> <20010912115511.A17668@redhat.com> <1000310370.30375.141.camel@lifelesswks> <20010912121322.A17887@redhat.com> <6611059312.20010912202029@logos-m.ru>
X-SW-Source: 2001-q3/msg00137.html

On Thu, 2001-09-13 at 02:20, egor duda wrote:

> CF> If it is using non-exported functions from cygwin then we have to design
> CF> how the two entities communicate with each other.
> 
> daemon itself doesn't use non-exported functions. Actually, it doesn't
> use cygwin1.dll at all -- it should be built with -mno-cygwin

"didn't" :]. I altered it to link to cygwin1.dll for a couple of
reasons.
1) Things like syslog are immediately available for us.
2) We get a little bit of reassurance on the marshalling side that
things will be built the same.
3) I wanted to use AF_UNIX sockets as a transport layer, (because with
SSPI they can do inmpersonation for NT) and duplicating that code from
cygwin1.dll and attempting to be compatible through any and all changes
didn't make sense to me. 

Rob

