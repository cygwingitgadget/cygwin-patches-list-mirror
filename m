From: Corinna Vinschen <corinna@vinschen.de>
To: Mumit Khan <khan@NanoTech.Wisc.EDU>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: cross compiling patches
Date: Thu, 30 Mar 2000 00:41:00 -0000
Message-id: <38E30C2A.7B962DE8@vinschen.de>
References: <200003300046.SAA27482@hp2.xraylith.wisc.edu>
X-SW-Source: 2000-q1/msg00024.html

Mumit Khan wrote:
> 
> Chris Faylor <cgf@cygnus.com> writes:
> >
> > On thinking about this a little, it seems that the only changes that
> > need to be made are in mingw.  Mingw needs the header files and libraries
> > from winsup/w32api but no other directories should need this.  So, I think
> > that changing the top-level Makefile is not right.  Can we change the mingw
> > Makefile instead?

I wonder if there is another trap waiting in this case but let's see. I
will
try it today.

> > I don't know about the dummy change.  It seems ok to me but I'd like to get
> > Mumit's ok in case he has some other way in mind.
> 
> I haven't run into this problem, so I'll look into this tonight after I
> update my local tree. I have no problem changing mingw Makefiles or the
> configuration files, but let me find out what the real problem is first.

The problem is the `subdirs' rule in Makefile.in:

	SUBDIRS := @SUBDIRS@
	...
	subdirs: force
		@for i in $(SUBDIRS); do \
		...

When configuring, SUBDIRS is computed to an empty list. The result is
dependent of the used /bin/sh: If it's `bash' then the for statement
results in an error message. Unfortunately the default /bin/sh on some
linux systems (and on my Cygwin system, too :-) is bash.

Corinna
