From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 19:54:00 -0000
Message-id: <20010416225423.A24590@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79BE@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00081.html

On Tue, Apr 17, 2001 at 12:26:29PM +1000, Robert Collins wrote:
>> I don't really understand what the passwd_sem code in security.cc is
>> trying to do.  It seems to short circuit get_id_from_sid in the case
>> where this function is called "simultaneously" from two 
>> different threads?
>> Or is this function somehow called recursively from getpwent?
>
>I believe the recurse goes (witout function names - off top of head)
>fopen->check security->getpwuid->read_etc_password->fopen.
>
>the problem is that 
>a) we can't change passwd_state from uninitialised until _after_ the
>read completes, or calls to getpwuid et al will think it's been read and
>attempt a search.
>b) the recursive loop above will deadlock if it comes back into
>read_etc_password.

So stop it in get_id_from_sid.  If get_id_from_sid sees that it is being
called recursively, exit immediately.

>So we need a variable (not passwd_state) to indicate if we are currently
>in the protected area of read_etc_passwd.
> 
>> If that is the case, then the "passwd_sem" variable could be local to
>> security.cc, couldn't it?  As it is implemented now, it seems like
>> one thread calling getpwent could impact another thread that was
>> calling get_id_from_sid.
>
>It needs to be set in read_etc_passwd because if two threads call
>1 - getpwnam
>2 - fopen(foo)
>
>both calls may result in read_etc_passwd being called, but only one will
>enter the mutex via fopen, the other will enter the mutex via
>read_etc_passwd. Instant deadlock.

>Trylock isn't a solution because then the getpwnam and related functions
>will return without actually having read the database.

Why?  One thread will block, one will read /etc/passwd.  When
/etc/passwd is read, the state is set to something other than
uninitialized and the mutex is released.  The other thread wakes up
sees the thread state change and returns, but /etc/passwd has been
cached so it can use it.  Isn't that the point of the lock/unlock?

>The current code is thread safe because only one thread enters the
>protected code section, and that protected section sets the sem variable
>so that fopen won't recurse back into read_etc_passwd. 

In my experience, whenever you try to use two mechanisms to control
recursion or simultaneous access you are asking for trouble.

>A true semaphore could be used, but as the current one is mutex
>protected there's no point in extra overhead.

Still not convinced.

It still seems like there is potential for error if two threads call
get_id_from_sid.  One may correctly read a UID via getpwuid, one will
short-circuit.  Hmm.  This would be a problem even if we were attempting
to detect recursion via a static variable.

Maybe we need another passwd_state == 'initializing'.

Hmm, again.  We actually have *three* variables controlling how this
operates now, passwd_state, passwd_sem, and etc_passwd_mutex.  IMO,
that's too many.

cgf
