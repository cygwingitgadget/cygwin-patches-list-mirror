From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: rootdir
Date: Thu, 16 Mar 2000 11:36:00 -0000
Message-id: <38D137A6.DF2ADC5E@vinschen.de>
References: <38D0E4C2.5F8DA404@vinschen.de> <20000316112658.A22419@cygnus.com> <38D1108D.593F9C71@vinschen.de> <20000316121257.A23537@cygnus.com> <38D12124.53280E68@vinschen.de> <38D130B0.E8B37262@vinschen.de> <20000316141619.A26451@cygnus.com>
X-SW-Source: 2000-q1/msg00010.html

Chris Faylor wrote:
> [...]
> >Shouldn't this be:
> >
> >        backslashify (pathbuf, dst, trailing_slash_p); /* just convert
> >*/
> 
> I think you're right.  It seems to solve the problem.  Thanks!  I wonder
> if this accounts for other inexplicable behavior, like possibly Michael's
> find problems.
> 
> Go ahead and check this change in along with the rest of your changes
> but minus the rootdir() change (of course).

Ok, I will. I've already tested it as well and changed this in my
local sources. The rootdir patch is completely discarded again.

Corinna
