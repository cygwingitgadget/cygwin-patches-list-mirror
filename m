From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin (solution?)
Date: Sat, 22 Sep 2001 07:52:00 -0000
Message-id: <3BACA5AF.2370DFD2@yahoo.com>
References: <20010921200803.A6636@redhat.com> <00c001c142fe$3a92a520$a300a8c0@nhv> <20010921204429.A6761@redhat.com>
X-SW-Source: 2001-q3/msg00185.html

Christopher Faylor wrote:
> 
> On Fri, Sep 21, 2001 at 08:33:40PM -0400, Norman Vine wrote:
> >Christopher Faylor writes:
> >>It just occurred to me that people who haven't been able to build
> >>strace.exe may have an older Makefile that does not incorporate the
> >>changes that I made to Makefile.in which add -I...mingw/include to
> >>the mingw_getopt.o compilation.
> >>
> >>I'm not sure how that could happen since my Makefile is regenerated
> >>automatically if the Makefile.in is newer but it sure sounds like
> >>this is the problem.
> >>
> >>The __argv declarations should be coming from mingw's stdlib.h.  There
> >>should be no way that this needs to declare this explicitly if the
> >>right header file is being included.
> >
> >This is indeed my problem my make is picking up  stdlib.h from newlib
> >and not the from the mingw tree
> 
> Ok.  It looks like this is a problem with the VERBOSE entry in
> Makefile.in.  I only changed one part of the ifdef which outputs less
> information in a build to exclude the newlib directories.
> 
> I've checked in a patch.
> 

Ok, this fixes it.  I have a different issue with RXVT not displaying
the error message for the bad switch but that's a different beast.

> I'm not sure why you were executing the VERBOSE part of the Makefile by
> default but that's a minor bug.  I doubt that anyone besides me really
> wants the non-VERBOSE output anyway.
> 

It's always worked backwords for me as far as I perceive it.  It appears
from the coding of the Makefile that VERBOSE should be set to get the
VERBOSE version of the build.  However, it appears to me that I get
VERBOSE even though VERBOSE isn't specified.  It's not been that
important to me so I've never a round tuit for this.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

