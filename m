From: DJ Delorie <dj@delorie.com>
To: cgf@cygnus.com
Cc: cygwin-patches@sourceware.cygnus.com, khan@xraylith.wisc.EDU
Subject: Re: cross compiling patches
Date: Wed, 29 Mar 2000 16:42:00 -0000
Message-id: <200003300041.TAA07971@envy.delorie.com>
References: <38E28DBD.CD799CC1@vinschen.de> <20000329193417.A3428@cygnus.com>
X-SW-Source: 2000-q1/msg00019.html

> >One remaining (and yet uncommented) problem is that the second level
> >directories
> > - libiberty
> > - include
> >of our cvs repository are not compatible to the current state of
> >the net release preview. I think it's due to the fact that
> >binutils in the repository is a 199909.. version while the net
> >release binutils is the 19990818-1 version.
> >
> >I only want let this as an aid to memory.
> 
> This has already been commented on in the cygwin-developers mailing
> list and DJ is looking into this.

My current thinking is to remove all the libiberty.a files and other
shared development files (bfd, opcodes) from the three tarballs that
shouldn't have them (gcc, binutils, gdb) as those packages really
shouldn't be exporting those libraries to other packages (yes,
binutils/bfd is an exception, but...).  They are often incompatible
between packages, and there isn't really anything we can do about
them.  Plus, any source package that needs them usually includes the
right version itself.

I did find that the only differences between the *.h files was that
gdb's had CR/LF and binutils's had NL.  Except, that assert from gcc
and from cygwin are totally different but either should work just
fine.

c++filt is another example of two packages owning the same tool.  I
don't know who has the master copy.
