From: Robert Collins <robert.collins@itdomain.com.au>
To: nhv@cape.com
Cc: cygwin-patches@cygwin.com
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire streamas a  header
Date: Tue, 27 Nov 2001 18:27:00 -0000
Message-ID: <1006914349.637.4.camel@lifelesswks>
References: <004801c177ab$13c9f4c0$a300a8c0@nhv>
X-SW-Source: 2001-q4/msg00274.html
Message-ID: <20011127182700.2vBJm4QArqDC6efEdmDdw5kI1qKu__tk4cgYqtW0TAs@z>

On Wed, 2001-11-28 at 12:21, Norman Vine wrote:
> FWIW
> I believe that Standard C requires NULL to be defined in <stddef.h>
> http://www.ccs.ucsd.edu/c/stddef.html/#NULL

Thanks Norman..

===
NULL

#define NULL <either 0, 0L, or (void *)0> [0 in C++]

The macro yields a null pointer constant that is usable as an address
constant expression.
===

Rob
