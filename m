From: "Norman Vine" <nhv@cape.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: winsup/cygwin/lib/getopt.c -mno-cygwin (solution?)
Date: Fri, 21 Sep 2001 17:28:00 -0000
Message-id: <00c001c142fe$3a92a520$a300a8c0@nhv>
References: <20010921200803.A6636@redhat.com>
X-SW-Source: 2001-q3/msg00182.html

Christopher Faylor writes:
>
>It just occurred to me that people who haven't been able to build
>strace.exe may have an older Makefile that does not incorporate the
>changes that I made to Makefile.in which add -I...mingw/include to
>the mingw_getopt.o compilation.
>
>I'm not sure how that could happen since my Makefile is regenerated
>automatically if the Makefile.in is newer but it sure sounds like
>this is the problem.
>
>The __argv declarations should be coming from mingw's stdlib.h.  There
>should be no way that this needs to declare this explicitly if the
>right header file is being included.

This is indeed my problem my make is picking up  stdlib.h from newlib
and not the from the mingw tree

>Could whomever is having this problem try rebuilding with CVS sources?
>Just:
>
>      src=whereever-src/winsup
>      bld=whereever-bld/winsup
>      cd $src/cygwin/lib
>      mv getopt.c getopt.c.saf
>      cvs update
>
>      cd $bld/utils
>      rm Makefile, mingw_*, strace.exe
>      ./config.status
>      make strace.exe
>

Sure thing

Here is my configure command line
../src/configure \
--enable-shared \
--prefix=/usr \
--target=i686-pc-cygwin \
--host=i686-pc-cygwin \
--enable-haifa \
--exec-prefix=/usr \
--libdir=/usr/lib \
--libexecdir=/usr/sbin \
--sysconfdir=/etc

Here is my make comandline
make tooldir=/usr

$ make strace.exe
gcc -L/src/cygwin/obj/i686-pc-cygwin/winsup
-L/src/cygwin/obj/i686-pc-cygwin/winsup/cygwin
-L/src/cygwin/obj/i686-pc-cygwin/winsup/w32api/lib
-isystem /src/cygwin/src/winsup/include
-isystem /src/cygwin/src/winsup/cygwin/include
-isystem /src/cygwin/src/winsup/w32api/include
-isystem /src/cygwin/src/newlib/libc/sys/cygwin
-isystem /src/cygwin/src/newlib/libc/sys/cygwin32
-B/src/cygwin/obj/i686-pc-cygwin/newlib/
-isystem /src/cygwin/obj/i686-pc-cygwin/newlib/targ-include
-isystem /src/cygwin/src/newlib/libc/include
-c -nostdinc   -g -O2 -Wall -Wwrite-strings
-I. -I/src/cygwin/src/winsup/cygwin/include
-I/src/cygwin/src/winsup/cygwin
-I/src/cygwin/src/newlib/libc/sys/cygwin
-I/src/cygwin/src/newlib/libc/include
-I/src/cygwin/src/winsup/w32api/include
-I/usr/lib/gcc-lib/i686-pc-cygwin/2.95.3-5//include
-c -o ./mingw_getopt.o -mno-cygwin
-I/src/cygwin/src/winsup/mingw/include
-I/src/cygwin/src/winsup/cygwin/include
-I/src/cygwin/src/winsup/w32api/include
/src/cygwin/src/winsup/cygwin/lib/getopt.c
/src/cygwin/src/winsup/cygwin/lib/getopt.c: In function `_vwarnx':
/src/cygwin/src/winsup/cygwin/lib/getopt.c:114: `__argv' undeclared (first
use in this function)
/src/cygwin/src/winsup/cygwin/lib/getopt.c:114: (Each undeclared identifier
is reported only once
/src/cygwin/src/winsup/cygwin/lib/getopt.c:114: for each function it appears
in.)
make: *** [mingw_getopt.o] Error 1

Cheers

Norman
