From: "J. Johnston" <jjohnstn@cygnus.com>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: Joel Sherrill <joel.sherrill@OARcorp.com>, cygwin-patches@cygwin.com, newlib@sources.redhat.com
Subject: Re: cygwin/newlib types patchs
Date: Thu, 29 Mar 2001 11:48:00 -0000
Message-id: <3AC37051.7807901A@cygnus.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com> <026301c0b255$8982d130$0200a8c0@lifelesswks> <20010321173020.F9775@redhat.com> <029301c0b258$06fb42d0$0200a8c0@lifelesswks> <3ABBA589.74CED71C@cygnus.com> <3AC21396.979DB2C7@OARcorp.com> <3AC21E12.17F10166@OARcorp.com> <3AC227E5.5A31051C@OARcorp.com> <3AC249A8.1ADD0384@cygnus.com> <018a01c0b7d0$f4957510$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00267.html

Robert Collins wrote:
> 
> ----- Original Message -----
> From: "J. Johnston" <jjohnstn@cygnus.com>
> To: "Joel Sherrill" <joel.sherrill@OARcorp.com>
> Cc: "Robert Collins" <robert.collins@itdomain.com.au>;
> <cygwin-patches@cygwin.com>; <newlib@sources.redhat.com>
> Sent: Thursday, March 29, 2001 6:29 AM
> Subject: Re: cygwin/newlib types patchs
> 
> 
> >
> > After thinking a little further on this, IMO it is best to separate
> out the pthread types from
> > sys/types.h since they are extremely system-specific.  This is how
> glibc handles it.  So, we have a
> > separate header: sys/pthreadtypes.h which contains the pthread types.
> A default header file will
> > exist in the libc/include/sys directory, however, each system that
> supports pthreads will have its
> > own version of sys/pthreadtypes.h in their sys directory which will
> override the default.
> 
> Uhmm yes :] I've actually put the cygwin ones in cygwin/types.h, but as
> long as it's system specific it doesn't really matter.
> 

So, what are you proposing?  I still contend that removing all the system pthread
types into the sys directories is the clean way to implement this and the best
long term solution for adding other system pthread implementations in the future.  
I don't think overriding the entire types header is warranted.

Unless you have a better proposal, I am going to do this so it would save me the work 
if as part of your change you simply split the pthread types into sys/pthreadtypes.h and 
put the RTEMS stuff in the RTEMS directory and the Cygwin stuff in the Cygwin directory.

-- Jeff J.
