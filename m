From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Cc: Mumit Khan <khan@NanoTech.Wisc.EDU>
Subject: Re: cross compiling patches
Date: Thu, 30 Mar 2000 16:25:00 -0000
Message-id: <20000330192529.A29634@cygnus.com>
References: <200003300046.SAA27482@hp2.xraylith.wisc.edu> <38E30C2A.7B962DE8@vinschen.de> <38E3D5F2.15B2E3A0@vinschen.de>
X-SW-Source: 2000-q1/msg00026.html

On Fri, Mar 31, 2000 at 12:32:18AM +0200, Corinna Vinschen wrote:
>Corinna Vinschen wrote:
>> 
>> Mumit Khan wrote:
>> >
>> > Chris Faylor <cgf@cygnus.com> writes:
>> > >
>> > > On thinking about this a little, it seems that the only changes that
>> > > need to be made are in mingw.  Mingw needs the header files and libraries
>> > > from winsup/w32api but no other directories should need this.  So, I think
>> > > that changing the top-level Makefile is not right.  Can we change the mingw
>> > > Makefile instead?
>> 
>> I wonder if there is another trap waiting in this case but let's see. I
>> will
>> try it today.
>
>Ok, I have checked this out and it's not enough to change only the mingw
>Makefile.in:
>
>- In the top level Makefile.in the path to $$s/winsup/cygwin/include is
>  needed to compile libiberty. It's missing `io.h' else. I wouldn't
>change
>  this in the libiberty/Makefile.in because of the current version
>problem.

Ok.  I just checked and the top-level Makefile.in in the winsup version
of CVS is missing some changes that should be in the gcc version.  I'll
take a look at the difference between the two repositories and submit
an appropriate patch to Makefile.in.

>- In winsup/cygwin/Makefile.in `cygrun.exe' has to be compiled with
>  $(COMPILE_CC) because the linker stage results in the error
>  `-lcygwin not found.' 

Are you saying that the change I made to winsup/cygwin/Makefile.in
doesn't solve this?  cygrun.o *is* being compiled via COMPILE_CC.

cgf
