From: "J. Johnston" <jjohnstn@cygnus.com>
To: Joel Sherrill <joel.sherrill@OARcorp.com>
Cc: Robert Collins <robert.collins@itdomain.com.au>, cygwin-patches@cygwin.com, newlib@sources.redhat.com
Subject: Re: cygwin/newlib types patchs
Date: Wed, 28 Mar 2001 12:29:00 -0000
Message-id: <3AC249A8.1ADD0384@cygnus.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com> <026301c0b255$8982d130$0200a8c0@lifelesswks> <20010321173020.F9775@redhat.com> <029301c0b258$06fb42d0$0200a8c0@lifelesswks> <3ABBA589.74CED71C@cygnus.com> <3AC21396.979DB2C7@OARcorp.com> <3AC21E12.17F10166@OARcorp.com> <3AC227E5.5A31051C@OARcorp.com>
X-SW-Source: 2001-q1/msg00263.html

Joel Sherrill wrote:
> 
> Joel Sherrill wrote:
> >
> > Just to make sure I understand .. What you intend to do for
> > structure is effectively this:
> >
> > #ifdef __RTEMS_INSIDE__
> > typedef struct {
> >   int is_initialized;
> >   void *stackaddr;
> >   int stacksize;
> >   int contentionscope;
> >   int inheritsched;
> >   int schedpolicy;
> >   struct sched_param schedparam;
> >
> >   /* P1003.4b/D8, p. 54 adds cputime_clock_allowed attribute.  */
> > #if defined(_POSIX_THREAD_CPUTIME)
> >   int  cputime_clock_allowed;  /* see time.h */
> > #endif
> >   int  detachstate;
> >
> > } pthread_attr_t;
> > #else /* in user land */
> > typedef void * pthread_attr_t;
> > #endif
> >
> > If this is not the case, then I need to be educated further to make
> > an intelligent decision. :)
> >
> > --joel
> 
> Something just bothered me... from opengroup.org
> 
>      #include <pthread.h>
>      int pthread_attr_init(pthread_attr_t *attr);
> 
>      int pthread_attr_destroy(pthread_attr_t *attr);
> 
> Shouldn't I be able to write this code?
> 
> {
>   pthread_attr_t my_attr;
>   pthread_attr_init( &my_attr );
> }
> 
> The RTEMS implementation assumes that the user is providing the memory
> for the structure.  If you change the user view so pthread_attr_t is
> a void *, we break.
> 
> On types like pthread_t, RTEMS is really a unsigned 32 bit integer
> and we again assume that the user is providing that space.
> 
> Not letting the user know the size is broken for us.  I agree that it is
> certainly
> bad form for them to look inside.
> 

After thinking a little further on this, IMO it is best to separate out the pthread types from
sys/types.h since they are extremely system-specific.  This is how glibc handles it.  So, we have a
separate header: sys/pthreadtypes.h which contains the pthread types.  A default header file will
exist in the libc/include/sys directory, however, each system that supports pthreads will have its
own version of sys/pthreadtypes.h in their sys directory which will override the default.

If a system wants to hide the internals they can use anonymous field names or structs simply padded
to the appropriate size which allows the user-scenario above.  FWIW: glibc doesn't seem to worry
about it and exposes the structs.  

-- Jeff J.
