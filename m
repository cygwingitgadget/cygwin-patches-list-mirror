From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin half of pthread update
Date: Wed, 11 Apr 2001 20:25:00 -0000
Message-id: <20010411232520.C32524@redhat.com>
References: <03f001c0c2ed$3b89acd0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00035.html

On Thu, Apr 12, 2001 at 11:09:31AM +1000, Robert Collins wrote:
>Ok, this is a bug one. I really really really hope I've got the
>ChangeLog correct!
>
>The standard GPL warning applies to this contrib:
>no warranty.
>All care no responsibility :]

The ChangeLog is a little off.  You don't have to document every export.
Just do something like:

	* cygwin.din: Remove @PTH_ALLOW@ prefixes to pthread functions.  Add
	new pthread exports.

The pthread.cc, sched.cc, thread.cc, thread.h, include/* entries are all
missing the leading '* ' prior to the filenames.

Also don't mention that you ran indent.  IMO, that's irrelevant.

Once you fix up these issues in the ChangeLog, go ahead and "cvs commit"
this.  I just checked and you should already have permission to do this.

I didn't look closely at the patch, but I realized, as I was heading off
to bead, that you were 12 hours out of sync with me, so I should take a
look at what you'd done or we'd lose a day.

If there are issues we can fine tune them tomorrow.

Thanks,
cgf


>Thurs Apr 12 10:02 2001  Robert Collins <rbtcollins@hotmail.com>
>
> * configure.in: Remove PTH_ALLOW.
> * cygwin.din: Remove @PTH_ALLOW@ prefixes to pthread functions.
> (thread_attr_getdetachstate): New export.
> (pthread_attr_getdetachstate): New export.
> (pthread_attr_getinheritsched): New export.
> (pthread_attr_getschedparam): New export.
> (pthread_attr_getschedpolicy): New export.
> (pthread_attr_getscope): New export.
> (pthread_attr_setdetachstate): New export.
> (pthread_attr_setinheritsched): New export.
> (pthread_attr_setschedparam): New export.
> (pthread_attr_setschedpolicy): New export.
> (pthread_attr_setscope): New export.
> (pthread_cancel): New export.
> (pthread_create): New export.
> (pthread_detach): New export.
> (pthread_equal): New export.
> (pthread_exit): New export.
> (pthread_getconcurrency): New export.
> (pthread_getschedparam): New export.
> (pthread_join): New export.
> (pthread_mutex_getprioceiling): New export.
> (pthread_mutex_setprioceiling): New export.
> (pthread_mutexattr_destroy): New export.
> (pthread_mutexattr_getprioceiling): New export.
> (pthread_mutexattr_getprotocol): New export.
> (pthread_mutexattr_getpshared): New export.
> (pthread_mutexattr_gettype): New export.
> (pthread_mutexattr_init): New export.
> (pthread_mutexattr_setprioceiling): New export.
> (pthread_mutexattr_setprotocol): New export.
> (pthread_mutexattr_setpshared): New export.
> (pthread_mutexattr_settype): New export.
> (pthread_once): New export.
> (pthread_setcancelstate): New export.
> (pthread_setcanceltype): New export.
> (pthread_setconcurrency): New export.
> (pthread_setschedparam): New export.
> (pthread_testcancel): New export.
> pthread.cc: New wrapper functions for the above new exports.
> sched.cc (valid_sched_parameters): New function.
> (sched_setparam): Use it.
> (sched_set_thread_priority): New function. Used by pthread_sched*.
> thread.cc (pthread_key_destructor::InsertAfter): New function.
> (pthread_key_destructor::UnlinkNext): New function.
> (pthread_key_destructor::Next): New function.
> (pthread_key_destructor_list::Insert): New function.
> (pthread_key_destructor_list::Remove): New function.
> (pthread_key_destructor_list::Pop): New function.
> (pthread_key_destructor::pthread_key_destructor): New function.
> (pthread_key_destructor_list::IterateNull): New function.
> (MTinterface::Init): Initialise new member.
> (pthread::pthread): Initialise new members.
> (pthread::create): Copy new attributes. Set the new thread priority.
> (pthread_attr::pthread_attr): Initialise new members.
> (pthread_key::pthread_key): Setup destructor function.
> (pthread_key::~pthread_key): Remove destructor function.
> (pthread_mutexattr::pthread_mutexattr): New function.
> (pthread_mutexattr::~pthread_mutexattr): New function.
> (__pthread_once): New function.
> (__pthread_cleanup): New function.
> (__pthread_cancel): New function.
> (__pthread_setcancelstate): New function.
> (__pthread_setcanceltype): New function.
> (__pthread_testcancel): New function.
> (__pthread_attr_getinheritsched): New function.
> (__pthread_attr_getschedparam): New function.
> (__pthread_attr_getschedpolicy): New function.
> (__pthread_attr_getscope): New function.
> (__pthread_attr_setinheritsched): New function.
> (__pthread_attr_setschedparam): New function.
> (__pthread_attr_setschedpolicy): New function.
> (__pthread_attr_setscope): New function.
> (__pthread_exit): Call any key destructors on thread exit.
> (__pthread_join): Use the embedded attr values.
> (__pthread_detach): Use the embedded attr values.
> (__pthread_getconcurrency): New function.
> (__pthread_getschedparam): New function.
> (__pthread_key_create): Pass the destructor on object creation.
> (__pthread_key_delete): Correct incorrect prototype.
> (__pthread_setconcurrency): New function.
> (__pthread_setschedparam): New function.
> (__pthread_cond_timedwait): Support static mutex initialisers.
> (__pthread_cond_wait): Ditto.
> (__pthread_mutex_getprioceiling): New function.
> (__pthread_mutex_lock): Support static mutex initialisers.
> (__pthread_mutex_trylock): Ditto.
> (__pthread_mutex_unlock): Ditto.
> (__pthread_mutex_destroy): Ditto.
> (__pthread_mutex_setprioceiling): New function.
> (__pthread_mutexattr_getprotocol): New function.
> (__pthread_mutexattr_getpshared): New function.
> (__pthread_mutexattr_gettype): New function.
> (__pthread_mutexattr_init): New function.
> (__pthread_mutexattr_destroy): New function.
> (__pthread_mutexattr_setprotocol): New function.
> (__pthread_mutexattr_setprioceiling): New function.
> (__pthread_mutexattr_getprioceiling): New function.
> (__pthread_mutexattr_setpshared): New function.
> (__pthread_mutexattr_settype): New function.
> Remove stubs for non MT_SAFE compilation.
> thread.h: Run indent.
> Remove duplicate #defines.
> Add prototypes for new functions in thread.cc.
> (pthread_key_destructor): New class.
> (pthread_key_destructor_list): New class.
> (pthread_attr): Add new members.
> (pthread): Remove members that are duplicated in the pthread_attr
>class.
> (pthread_mutex_attr): Add new members.
> (pthread_once): New class.
> include/pthread.h: Add prototypes for new functions exported from
>cygwin1.dll.
> Run indent.
> Remove typedefs.
> include/sched.h: Add prototypes for new functions in sched.cc.
> include/cygwin/types.h: Add typedefs from pthread.h
>
>




-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
