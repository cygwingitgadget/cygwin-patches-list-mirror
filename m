From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: win95 and pshared mutex support for pthreads
Date: Fri, 20 Apr 2001 09:21:00 -0000
Message-id: <20010420122212.B24172@redhat.com>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010419080934.C19483@redhat.com> <015401c0c8ca$380e8ac0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00127.html

On Thu, Apr 19, 2001 at 10:13:59PM +1000, Robert Collins wrote:
>I don't suppose you could from the patch? My working directory is _much
>much_ worse than the code I got into that patch.

I would rather not.  This is a common problem with maintaining multiple
sandboxes.  I don't want to be a patch monkey if I can avoid it and I
can avoid it if you have checkin privileges.

If this is a problem, I suggest keeping a separate "clean" version of the
winsup directory around where you can apply approved patches.  This is
how people do this in other mailing lists that I'm familiar with.

cgf

>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Thursday, April 19, 2001 10:09 PM
>Subject: Re: win95 and pshared mutex support for pthreads
>
>
>> On Thu, Apr 19, 2001 at 08:38:18PM +1000, Robert Collins wrote:
>> >The code is a little ugly, but it still passes all my testcases.
>> >
>> >The ABI HAS NOT CHANGED. It may have to support pshared condition
>> >variables properly, but I wanted to get the win95 support submitted.
>> >
>> >Rob
>> >
>> >Thu Apr 19 20:22:00 2001  Robert Collins <rbtcollins@hotmail.com>
>> >
>> > * password.cc (getpwuid): Check for thread cancellation.
>> > (getpwuid_r): Ditto.
>> > (getpwname): Ditto.
>> > (getpwnam_r): Ditto.
>> > * thread.h (pthread_mutex): New constructors for pshared operation.
>> > (MTinterface): Associative array for pshared mutex's.
>> > * thread.cc (MTinterface::Init): Initailize pshared mutex array.
>> > (pthread_cond::BroadCast): Implementation notes.
>> > (pthread_cond::TimedWait): Remove use of SignalObjectAndWait on
>non-NT
>> >systems.
>> > (pthread_mutex::pthread_mutex(unsigned short)): New function.
>> > (pthread_mutex::pthread_mutex (pthread_mutex_t *, pthread_mutexattr
>> >*)):New function.
>> > (pthread_mutex::pthread_mutex(pthread_mutexattr *)): Fail on pshared
>> >mutex's.
>> > (__pthread_mutex_getpshared): New function.
>> > (__pthread_join): Check for thread cancellation.
>> > (__pthread_cond_timedwait): Support pshared mutex's.
>> > (__pthread_cond_wait): Ditto.
>> > (__pthread_condattr_setpshared): Error on PROCESS_SHARED requests.
>> > (__pthread_mutex_init): Support pshared mutex's.
>> > (__pthread_mutex_getprioceiling): Ditto.
>> > (__pthread_mutex_lock): Ditto.
>> > (__pthread_mutex_trylock): Ditto.
>> > (__pthread_mutex_unlock): Ditto.
>> > (__pthread_mutex_destroy): Ditto.
>> > (__pthread_mutex_setprioceiling): Ditto.
>> > (__pthread_mutexattr_setpshared): Support PTHREAD_PROCESS_PSHARED
>> >requests.
>>
>> Please check this in.
>>
>> Thanks,
>>
>> cgf
>>

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
