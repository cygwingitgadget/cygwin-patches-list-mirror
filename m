From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 16:56:00 -0000
Message-id: <200102080056.TAA02750@envy.delorie.com>
References: <3A81E0C9.65A57BA9@yahoo.com> <200102080000.TAA02270@envy.delorie.com> <3A81E3BC.BF96D3CB@yahoo.com>
X-SW-Source: 2001-q1/msg00059.html

> > Is this just to get it to use the local includes, rather than the installed
> > ones?
> 
> No.  It won't build without it with the 2.95.2-7 gcc.

Is this related to the patches Chris just added to gcc to make it find
the win32 headers by default?n

> > >       * configure: regenerate.
> > 
> > Why
> 
> Possibly, ignorance.  I thought it necessary when changing either
> Makefile.in or configure.in.  I still don't have that down pat.

configure.in yes, Makefile.in no.

Running autoconf creates configure from configure.in
Running configure (at build time) creates Makefile from Makefile.in
