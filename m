From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 16:00:00 -0000
Message-id: <200102080000.TAA02270@envy.delorie.com>
References: <3A81E0C9.65A57BA9@yahoo.com>
X-SW-Source: 2001-q1/msg00057.html

> 	* Makefile.in: (%.o: %.rc): Specify --include-dir $(w32api_include).

Is this just to get it to use the local includes, rather than the installed
ones?

> 	* configure: regenerate.

Why?
