From: Robert Collins <robert.collins@itdomain.com.au>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: `wincap' instead of `os_being_run' and `iswinnt'
Date: Wed, 12 Sep 2001 15:53:00 -0000
Message-id: <1000335244.31768.39.camel@lifelesswks>
References: <20010912202058.H1285@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00138.html

On Thu, 2001-09-13 at 04:20, Corinna Vinschen wrote:
> I have just checked in a huge patch which changes all code which
> asks for the OS to behave different on different systems.
> 
> The global variables `os_being_run' and `iswinnt' are eliminated.
> 
> Instead we have a new global variable called `wincap' which is
> the only member of class `wincapc'. The definition of that stuff
> is in the new file wincap.h.

Nice. It's the logical extension of what I'd started with the daemon
patch for expediency.

Rob
