From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: win95 and pshared mutex support for pthreads
Date: Thu, 19 Apr 2001 05:09:00 -0000
Message-id: <20010419080934.C19483@redhat.com>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00119.html

On Thu, Apr 19, 2001 at 08:38:18PM +1000, Robert Collins wrote:
>The code is a little ugly, but it still passes all my testcases.
>
>The ABI HAS NOT CHANGED. It may have to support pshared condition
>variables properly, but I wanted to get the win95 support submitted.
>
>Rob
>
>Thu Apr 19 20:22:00 2001  Robert Collins <rbtcollins@hotmail.com>
>
> * password.cc (getpwuid): Check for thread cancellation.
> (getpwuid_r): Ditto.
> (getpwname): Ditto.
> (getpwnam_r): Ditto.
> * thread.h (pthread_mutex): New constructors for pshared operation.
> (MTinterface): Associative array for pshared mutex's.
> * thread.cc (MTinterface::Init): Initailize pshared mutex array.
> (pthread_cond::BroadCast): Implementation notes.
> (pthread_cond::TimedWait): Remove use of SignalObjectAndWait on non-NT
>systems.
> (pthread_mutex::pthread_mutex(unsigned short)): New function.
> (pthread_mutex::pthread_mutex (pthread_mutex_t *, pthread_mutexattr
>*)):New function.
> (pthread_mutex::pthread_mutex(pthread_mutexattr *)): Fail on pshared
>mutex's.
> (__pthread_mutex_getpshared): New function.
> (__pthread_join): Check for thread cancellation.
> (__pthread_cond_timedwait): Support pshared mutex's.
> (__pthread_cond_wait): Ditto.
> (__pthread_condattr_setpshared): Error on PROCESS_SHARED requests.
> (__pthread_mutex_init): Support pshared mutex's.
> (__pthread_mutex_getprioceiling): Ditto.
> (__pthread_mutex_lock): Ditto.
> (__pthread_mutex_trylock): Ditto.
> (__pthread_mutex_unlock): Ditto.
> (__pthread_mutex_destroy): Ditto.
> (__pthread_mutex_setprioceiling): Ditto.
> (__pthread_mutexattr_setpshared): Support PTHREAD_PROCESS_PSHARED
>requests.

Please check this in.

Thanks,

cgf
