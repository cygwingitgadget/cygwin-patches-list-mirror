From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "J. Johnston" <jjohnstn@cygnus.com>
Cc: "Joel Sherrill" <joel.sherrill@OARcorp.com>, <cygwin-patches@cygwin.com>, <newlib@sources.redhat.com>
Subject: Re: cygwin/newlib types patchs
Date: Thu, 29 Mar 2001 18:03:00 -0000
Message-id: <00c701c0b8a1$417b77f0$0200a8c0@lifelesswks>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com> <026301c0b255$8982d130$0200a8c0@lifelesswks> <20010321173020.F9775@redhat.com> <029301c0b258$06fb42d0$0200a8c0@lifelesswks> <3ABBA589.74CED71C@cygnus.com> <3AC21396.979DB2C7@OARcorp.com> <3AC21E12.17F10166@OARcorp.com> <3AC227E5.5A31051C@OARcorp.com> <3AC249A8.1ADD0384@cygnus.com> <018a01c0b7d0$f4957510$0200a8c0@lifelesswks> <3AC37051.7807901A@cygnus.com>
X-SW-Source: 2001-q1/msg00270.html

----- Original Message -----
From: "J. Johnston" <jjohnstn@cygnus.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: "Joel Sherrill" <joel.sherrill@OARcorp.com>;
<cygwin-patches@cygwin.com>; <newlib@sources.redhat.com>
Sent: Friday, March 30, 2001 3:26 AM
Subject: Re: cygwin/newlib types patchs


> Robert Collins wrote:
> >
> >
> > Uhmm yes :] I've actually put the cygwin ones in cygwin/types.h, but
as
> > long as it's system specific it doesn't really matter.
> >
>
> So, what are you proposing?  I still contend that removing all the
system pthread
> types into the sys directories is the clean way to implement this and
the best
> long term solution for adding other system pthread implementations in
the future.
> I don't think overriding the entire types header is warranted.
>
> Unless you have a better proposal, I am going to do this so it would
save me the work
> if as part of your change you simply split the pthread types into
sys/pthreadtypes.h and
> put the RTEMS stuff in the RTEMS directory and the Cygwin stuff in the
Cygwin directory.
>
> -- Jeff J.
>

I don't know how rtems is laid out - what I am proposing was
src/newlib/libc/include/sys/types.h includes <cygwin/types.h> (which
only overrides pthreads at the moment)
src/winsup/cygwin/include/cygwin/types.h contains the types that were
conflicting with rtems.

Where should I #include the rtems header from?

Rob



