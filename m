From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "J. Johnston" <jjohnstn@cygnus.com>, "Joel Sherrill" <joel.sherrill@OARcorp.com>
Cc: <cygwin-patches@cygwin.com>, <newlib@sources.redhat.com>
Subject: Re: cygwin/newlib types patchs
Date: Wed, 28 Mar 2001 13:50:00 -0000
Message-id: <018a01c0b7d0$f4957510$0200a8c0@lifelesswks>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com> <026301c0b255$8982d130$0200a8c0@lifelesswks> <20010321173020.F9775@redhat.com> <029301c0b258$06fb42d0$0200a8c0@lifelesswks> <3ABBA589.74CED71C@cygnus.com> <3AC21396.979DB2C7@OARcorp.com> <3AC21E12.17F10166@OARcorp.com> <3AC227E5.5A31051C@OARcorp.com> <3AC249A8.1ADD0384@cygnus.com>
X-SW-Source: 2001-q1/msg00265.html

----- Original Message -----
From: "J. Johnston" <jjohnstn@cygnus.com>
To: "Joel Sherrill" <joel.sherrill@OARcorp.com>
Cc: "Robert Collins" <robert.collins@itdomain.com.au>;
<cygwin-patches@cygwin.com>; <newlib@sources.redhat.com>
Sent: Thursday, March 29, 2001 6:29 AM
Subject: Re: cygwin/newlib types patchs


> Joel Sherrill wrote:
> >
> > Joel Sherrill wrote:
> > >
> > > Just to make sure I understand .. What you intend to do for
> > > structure is effectively this:
> > >
> > > #ifdef __RTEMS_INSIDE__
> > > typedef struct {
> > >   int is_initialized;
> > >   void *stackaddr;
> > >   int stacksize;
> > >   int contentionscope;
> > >   int inheritsched;
> > >   int schedpolicy;
> > >   struct sched_param schedparam;
> > >
> > >   /* P1003.4b/D8, p. 54 adds cputime_clock_allowed attribute.  */
> > > #if defined(_POSIX_THREAD_CPUTIME)
> > >   int  cputime_clock_allowed;  /* see time.h */
> > > #endif
> > >   int  detachstate;
> > >
> > > } pthread_attr_t;
> > > #else /* in user land */
> > > typedef void * pthread_attr_t;
> > > #endif
> > >
> > > If this is not the case, then I need to be educated further to
make
> > > an intelligent decision. :)
> > >
> > > --joel

It started with Chris Faylor asking if we should integrate my changes
into newlib, rather than __CYGWIN__ protecting the existing newlib
content.

My goals are pretty simple: turn the userland _t types into void
pointers, and get the internals included in a file from the "kernel"
land. So the struct schedparam above for example should be in a file in
the rtems build tree, not the newlib tree.

> >
> > Something just bothered me... from opengroup.org
> >
> >      #include <pthread.h>
> >      int pthread_attr_init(pthread_attr_t *attr);
> >
> >      int pthread_attr_destroy(pthread_attr_t *attr);
> >
> > Shouldn't I be able to write this code?
> >
> > {
> >   pthread_attr_t my_attr;
> >   pthread_attr_init( &my_attr );
> > }
> >
> > The RTEMS implementation assumes that the user is providing the
memory
> > for the structure.  If you change the user view so pthread_attr_t is
> > a void *, we break.

Right. The point about not breaking things is that the ABI is stilll ok,
as long as the user hasn't been poking into the structs. The rtems code
has to be changed at the same time to expect (struct pthread attr * *).

> > On types like pthread_t, RTEMS is really a unsigned 32 bit integer
> > and we again assume that the user is providing that space.
> >
> > Not letting the user know the size is broken for us.  I agree that
it is
> > certainly
> > bad form for them to look inside.

pthread_attr_t my_attr will expand to void *my_attr. So they have a
known size. Then the system can alloc_r as needed. The benefits of void*
are threefold:
1) implementation details don't break user programs (ie adding new
capabilities or field.
2) users are much less able to overwrite important thread information
(they have a pointer to a pointer, you can maintain a separate list of
pointers if you desire, and userland memory trashing shouldn't touch
you.
3) users cannot (without _really_ trying), free the system data
unexptectedly!

>
> After thinking a little further on this, IMO it is best to separate
out the pthread types from
> sys/types.h since they are extremely system-specific.  This is how
glibc handles it.  So, we have a
> separate header: sys/pthreadtypes.h which contains the pthread types.
A default header file will
> exist in the libc/include/sys directory, however, each system that
supports pthreads will have its
> own version of sys/pthreadtypes.h in their sys directory which will
override the default.

Uhmm yes :] I've actually put the cygwin ones in cygwin/types.h, but as
long as it's system specific it doesn't really matter.

> If a system wants to hide the internals they can use anonymous field
names or structs simply padded
> to the appropriate size which allows the user-scenario above.  FWIW:
glibc doesn't seem to worry
> about it and exposes the structs.
>
> -- Jeff J.
>

FWIW I just checked openBSD and they do what I'm suggesting.

The reason I came up with the void * need is that cygwin is growing
organically.. field by field, API by API... It'll be a lot of work
adding all the fields, _now_ , and it will break the current ABI. I try
to avoid coding anything that creates a breakable ABI...

Rob
