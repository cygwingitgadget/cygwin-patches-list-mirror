From: Earnie Boyd <earnie_boyd@yahoo.com>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 16:51:00 -0000
Message-id: <3A81E3BC.BF96D3CB@yahoo.com>
References: <3A81E0C9.65A57BA9@yahoo.com> <200102080000.TAA02270@envy.delorie.com>
X-SW-Source: 2001-q1/msg00058.html

DJ Delorie wrote:
> 
> >       * Makefile.in: (%.o: %.rc): Specify --include-dir $(w32api_include).
> 
> Is this just to get it to use the local includes, rather than the installed
> ones?
> 

No.  It won't build without it with the 2.95.2-7 gcc.

> >       * configure: regenerate.
> 
> Why

Possibly, ignorance.  I thought it necessary when changing either
Makefile.in or configure.in.  I still don't have that down pat.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
