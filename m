From: Mumit Khan <khan@NanoTech.Wisc.EDU>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>, DJ Delorie <dj@cygnus.com>
Subject: Re: cross compiling patches 
Date: Wed, 29 Mar 2000 16:46:00 -0000
Message-id: <200003300046.SAA27482@hp2.xraylith.wisc.edu>
References: <20000329193417.A3428@cygnus.com>
X-SW-Source: 2000-q1/msg00020.html

Chris Faylor <cgf@cygnus.com> writes:
> 
> On thinking about this a little, it seems that the only changes that
> need to be made are in mingw.  Mingw needs the header files and libraries
> from winsup/w32api but no other directories should need this.  So, I think
> that changing the top-level Makefile is not right.  Can we change the mingw
> Makefile instead?
> 
> I don't know about the dummy change.  It seems ok to me but I'd like to get
> Mumit's ok in case he has some other way in mind.

I haven't run into this problem, so I'll look into this tonight after I
update my local tree. I have no problem changing mingw Makefiles or the
configuration files, but let me find out what the real problem is first.

My local net is not being very helpful, but hopefuly it'll be fixed soon.
The usual 'it's someone else's route screwing up ... ' from ISP help desk. 

Regards,
Mumit
