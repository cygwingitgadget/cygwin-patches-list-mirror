From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 17:29:00 -0000
Message-id: <3A81F6A4.BC89B7A@yahoo.com>
References: <3A81E0C9.65A57BA9@yahoo.com> <200102080000.TAA02270@envy.delorie.com> <3A81E3BC.BF96D3CB@yahoo.com> <200102080056.TAA02750@envy.delorie.com> <20010207201149.A20901@redhat.com>
X-SW-Source: 2001-q1/msg00061.html

Christopher Faylor wrote:
> 
> On Wed, Feb 07, 2001 at 07:56:25PM -0500, DJ Delorie wrote:
> >>>Is this just to get it to use the local includes, rather than the
> >>>installed ones?
> >>
> >>No.  It won't build without it with the 2.95.2-7 gcc.
> >
> >Is this related to the patches Chris just added to gcc to make it find
> >the win32 headers by default?n
> 
> Possibly.  I don't know if I screwed up 2.95.2-7 or not for the non-cross
> case.
> 

This goes to the if -mwin32 isn't specified then the /usr/include/w32api
will not be included.

BTW, I just remembered.  The rest of the Makefile.in uses the source
includes and not the installed includes so this patch would make it
consistent anyway.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
