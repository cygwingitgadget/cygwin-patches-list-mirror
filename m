From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: pthread_cond_timedwait, etc
Date: Mon, 04 Jun 2001 07:11:00 -0000
Message-id: <20010604101129.A9187@redhat.com>
References: <3B1B504C.8090808@141monkeys.org> <010201c0ecda$526e7450$0200a8c0@lifelesswks> <012601c0ece3$120f5560$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00278.html

On Mon, Jun 04, 2001 at 08:42:31PM +1000, Robert Collins wrote:
>----- Original Message -----
>From: "Robert Collins" <robert.collins@itdomain.com.au>
>
>> this may be an artifact of a particularly horrendous patch I had to
>> generate at one point. That does look buggy to me. Patch coming
>shortly.
>
>Patch attached at the end of the email. Thanks for catching that.
>pthread_cond_wait was also bust.
>
>> We could ignore it and return.. I'll try and get time to
>> check the spec and see if that's the expected behaviour. If it is,
>> consider that error a useful diagnostic for your code :].
>
>pthread_cond_broadcast is meant to never have an error, except when the
>condvariable is invalid. The attached patch fixs that little bit of
>bitrot as well. It snuck in from my test _verbose_ test code, and should
>have been trimmed back a little :]. You probably have code calling
>pthread_cond_broadcast to ensure that no threads are waiting when you
>exit the program.
>
>
>Changelog
>Mon Jun  4 20:39:00 2001  Robert Collins <rbtcollins@hotmail.com>
>
> * thread.cc (pthread_cond::Broadcast): Don't print error messages
> on invalid mutexs - user programs are allowed to call
> pthread_cond_broadcast like that.
> __pthread_cond_timedwait: Initialise themutex properly.
> __pthread_cond_wait: Initialise themutex properly.

Applied (after some ChangeLog tweaking).  Thanks.

cgf
