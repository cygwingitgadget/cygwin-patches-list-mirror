From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@Cygwin.Com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin
Date: Fri, 21 Sep 2001 14:44:00 -0000
Message-id: <3BABB4CA.C36ED3F4@yahoo.com>
References: <3BAB474A.36883B32@yahoo.com> <20010921135147.C32224@redhat.com> <3BAB8D40.D1DF3161@yahoo.com> <20010921152059.A3866@redhat.com> <3BABA188.22A9FCE7@yahoo.com> <20010921171526.E4067@redhat.com>
X-SW-Source: 2001-q3/msg00177.html

Christopher Faylor wrote:
> 
> On Fri, Sep 21, 2001 at 04:22:32PM -0400, Earnie Boyd wrote:
> >Christopher Faylor wrote:
> >>
> >> On Fri, Sep 21, 2001 at 02:56:00PM -0400, Earnie Boyd wrote:
> >> >Did you try `strace -j'?  The valid options work the invalid option
> >> >brings up Dr. Watson.
> >>
> >> Yes.  I tried using options that didn't exist since that is the reason
> >> for the _argv patch.
> >>
> >
> >Strange!?  Differences between NT4 and W2K?  Should I apply the patch?
> 
> I tried this on W2K and Windows 95.  It's odd that it would work on
> both of those.
> 
> I just tried a fresh rebuild from CVS.  It still works fine.  Odd.
> 

You're saying you don't need the patch????!!  You're saying that you
don't get:

BoydE@DU211344 /prj/cygwin/rt/bld/i686-pc-cygwin/winsup/utils
$ make
gcc -L/prj/cygwin/rt/bld/i686-pc-cygwin/winsup
-L/prj/cygwin/rt/bld/i686-pc-cygwin/winsup/cygwin
-L/prj/cygwin/rt/bld/i686-pc-cygwin/winsup/w32api/lib -isystem
/prj/cygwin/rt/src/winsup/include -isystem
/prj/cygwin/rt/src/winsup/cygwin/include -isystem
/prj/cygwin/rt/src/winsup/w32api/include -isystem
/prj/cygwin/rt/src/newlib/libc/sys/cygwin -isystem
/prj/cygwin/rt/src/newlib/libc/sys/cygwin32
-B/prj/cygwin/rt/bld/i686-pc-cygwin/newlib/ -isystem
/prj/cygwin/rt/bld/i686-pc-cygwin/newlib/targ-include -isystem
/prj/cygwin/rt/src/newlib/libc/include -c -nostdinc   -O0 -g -Wall
-Wwrite-strings   -I. -I/prj/cygwin/rt/src/winsup/cygwin/include
-I/prj/cygwin/rt/src/winsup/cygwin
-I/prj/cygwin/rt/src/newlib/libc/sys/cygwin
-I/prj/cygwin/rt/src/newlib/libc/include
-I/prj/cygwin/rt/src/winsup/w32api/include
-I/usr/lib/gcc-lib/i686-pc-cygwin/2.95.3-5//include -c -g -o
./mingw_getopt.o -mno-cygwin -I/prj/cygwin/rt/src/winsup/mingw/include
-I/prj/cygwin/rt/src/winsup/cygwin/include
-I/prj/cygwin/rt/src/winsup/w32api/include
/prj/cygwin/rt/src/winsup/cygwin/lib/getopt.c
/prj/cygwin/rt/src/winsup/cygwin/lib/getopt.c: In function `_vwarnx':
/prj/cygwin/rt/src/winsup/cygwin/lib/getopt.c:114: `__argv' undeclared
(first use in this function)
/prj/cygwin/rt/src/winsup/cygwin/lib/getopt.c:114: (Each undeclared
identifier is reported only once
/prj/cygwin/rt/src/winsup/cygwin/lib/getopt.c:114: for each function it
appears in.)
make: *** [mingw_getopt.o] Error 1

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

