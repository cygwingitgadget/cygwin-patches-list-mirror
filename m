From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin (solution?)
Date: Fri, 21 Sep 2001 17:07:00 -0000
Message-id: <20010921200803.A6636@redhat.com>
References: <3BAB474A.36883B32@yahoo.com> <20010921135147.C32224@redhat.com> <3BAB8D40.D1DF3161@yahoo.com> <20010921152059.A3866@redhat.com> <3BABA188.22A9FCE7@yahoo.com> <20010921171526.E4067@redhat.com> <3BABB4CA.C36ED3F4@yahoo.com> <20010921192814.D4475@redhat.com>
X-SW-Source: 2001-q3/msg00181.html

It just occurred to me that people who haven't been able to build
strace.exe may have an older Makefile that does not incorporate the
changes that I made to Makefile.in which add -I...mingw/include to
the mingw_getopt.o compilation.

I'm not sure how that could happen since my Makefile is regenerated
automatically if the Makefile.in is newer but it sure sounds like
this is the problem.

The __argv declarations should be coming from mingw's stdlib.h.  There
should be no way that this needs to declare this explicitly if the
right header file is being included.

Could whomever is having this problem try rebuilding with CVS sources?
Just:

      src=whereever-src/winsup
      bld=whereever-bld/winsup
      cd $src/cygwin/lib
      mv getopt.c getopt.c.saf
      cvs update

      cd $bld/utils
      rm Makefile, mingw_*, strace.exe
      ./config.status
      make strace.exe

cgf
