From: Joel Sherrill <joel.sherrill@OARcorp.com>
To: "J. Johnston" <jjohnstn@cygnus.com>, Robert Collins <robert.collins@itdomain.com.au>, cygwin-patches@cygwin.com, newlib@sources.redhat.com
Subject: Re: cygwin/newlib types patchs
Date: Wed, 28 Mar 2001 10:06:00 -0000
Message-id: <3AC227E5.5A31051C@OARcorp.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com> <026301c0b255$8982d130$0200a8c0@lifelesswks> <20010321173020.F9775@redhat.com> <029301c0b258$06fb42d0$0200a8c0@lifelesswks> <3ABBA589.74CED71C@cygnus.com> <3AC21396.979DB2C7@OARcorp.com> <3AC21E12.17F10166@OARcorp.com>
X-SW-Source: 2001-q1/msg00262.html

Joel Sherrill wrote:
> 
> Just to make sure I understand .. What you intend to do for
> structure is effectively this:
> 
> #ifdef __RTEMS_INSIDE__
> typedef struct {
>   int is_initialized;
>   void *stackaddr;
>   int stacksize;
>   int contentionscope;
>   int inheritsched;
>   int schedpolicy;
>   struct sched_param schedparam;
> 
>   /* P1003.4b/D8, p. 54 adds cputime_clock_allowed attribute.  */
> #if defined(_POSIX_THREAD_CPUTIME)
>   int  cputime_clock_allowed;  /* see time.h */
> #endif
>   int  detachstate;
> 
> } pthread_attr_t;
> #else /* in user land */
> typedef void * pthread_attr_t;
> #endif
> 
> If this is not the case, then I need to be educated further to make
> an intelligent decision. :)
> 
> --joel

Something just bothered me... from opengroup.org

     #include <pthread.h>
     int pthread_attr_init(pthread_attr_t *attr);

     int pthread_attr_destroy(pthread_attr_t *attr);

Shouldn't I be able to write this code?

{
  pthread_attr_t my_attr;
  pthread_attr_init( &my_attr );
}

The RTEMS implementation assumes that the user is providing the memory
for the structure.  If you change the user view so pthread_attr_t is 
a void *, we break.

On types like pthread_t, RTEMS is really a unsigned 32 bit integer
and we again assume that the user is providing that space.

Not letting the user know the size is broken for us.  I agree that it is
certainly
bad form for them to look inside.

--joel
