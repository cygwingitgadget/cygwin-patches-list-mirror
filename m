From: Earnie Boyd <earnie_boyd@yahoo.com>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 17:53:00 -0000
Message-id: <3A81F1C3.70103D7A@yahoo.com>
References: <3A81E0C9.65A57BA9@yahoo.com> <200102080000.TAA02270@envy.delorie.com> <3A81E3BC.BF96D3CB@yahoo.com> <200102080056.TAA02750@envy.delorie.com>
X-SW-Source: 2001-q1/msg00063.html

DJ Delorie wrote:
> 
> > > Is this just to get it to use the local includes, rather than the installed
> > > ones?
> >
> > No.  It won't build without it with the 2.95.2-7 gcc.
> 
> Is this related to the patches Chris just added to gcc to make it find
> the win32 headers by default?n
> 

The patch is reverse of what you state.  w32api will only be found if
-mno-cygwin or -mwin32 are specified.  Are these switches available with
windres?  I didn't try it this way because I thought it best to use the
source headers instead of the installed headers.  However the patch was
initiated by the fact that cinstall couldn't find windows.h.

> > > >       * configure: regenerate.
> > >
> > > Why
> >
> > Possibly, ignorance.  I thought it necessary when changing either
> > Makefile.in or configure.in.  I still don't have that down pat.
> 
> configure.in yes, Makefile.in no.
> 
> Running autoconf creates configure from configure.in
> Running configure (at build time) creates Makefile from Makefile.i

Ok, so remove the configure patch.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
