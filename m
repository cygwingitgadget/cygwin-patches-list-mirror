From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Cc: Mumit Khan <khan@xraylith.wisc.EDU>, DJ Delorie <dj@cygnus.com>
Subject: Re: cross compiling patches
Date: Wed, 29 Mar 2000 16:34:00 -0000
Message-id: <20000329193417.A3428@cygnus.com>
References: <38E28DBD.CD799CC1@vinschen.de>
X-SW-Source: 2000-q1/msg00018.html

On Thu, Mar 30, 2000 at 01:11:57AM +0200, Corinna Vinschen wrote:
>Hi Chris,
>
>just to be sure, I sent the patches I made for being able to cross
>compile on my linux box. If you agree, I will commit them. I have
>changed them according to your latest advice.

I changed the Makefile.in in cygwin after you reported the problem so that
patch isn't needed.

On thinking about this a little, it seems that the only changes that
need to be made are in mingw.  Mingw needs the header files and libraries
from winsup/w32api but no other directories should need this.  So, I think
that changing the top-level Makefile is not right.  Can we change the mingw
Makefile instead?

I don't know about the dummy change.  It seems ok to me but I'd like to get
Mumit's ok in case he has some other way in mind.

>One remaining (and yet uncommented) problem is that the second level
>directories
> - libiberty
> - include
>of our cvs repository are not compatible to the current state of
>the net release preview. I think it's due to the fact that
>binutils in the repository is a 199909.. version while the net
>release binutils is the 19990818-1 version.
>
>I only want let this as an aid to memory.

This has already been commented on in the cygwin-developers mailing
list and DJ is looking into this.

cgf
