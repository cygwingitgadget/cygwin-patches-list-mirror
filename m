From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: win95 and pshared mutex support for pthreads
Date: Sat, 21 Apr 2001 10:11:00 -0000
Message-id: <20010421131139.A25636@redhat.com>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010419080934.C19483@redhat.com> <015401c0c8ca$380e8ac0$0200a8c0@lifelesswks> <00ed01c0ca6e$ff599c50$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00135.html

On Sun, Apr 22, 2001 at 12:26:02AM +1000, Robert Collins wrote:
>committed (with passwd.cc not password.cc :] )

Unfortunately, it looks like there are problems with your checkin:

i686-pc-cygwin-g++ -c -g -O2 -MD -fbuiltin ... thread.cc
/cygnus/src/uberbaum/winsup/cygwin/thread.cc: In member function `void 
   MTinterface::Init(int)':
/cygnus/src/uberbaum/winsup/cygwin/thread.cc:301: `shm_head' undeclared (first 
   use this function)
/cygnus/src/uberbaum/winsup/cygwin/thread.cc:301: (Each undeclared identifier 
   is reported only once for each function it appears in.)
make: *** [thread.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [/cygnus/build/win32/i686-pc-cygwin/winsup/cygwin/new-cygwin1.dll] Error 2

cgf
