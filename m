From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "egor duda" <cygwin-patches@cygwin.com>
Subject: Re: PTHREAD_COND_INITIALIZER
Date: Mon, 24 Sep 2001 15:01:00 -0000
Message-id: <0f4701c14544$8d21cda0$0200a8c0@lifelesswks>
References: <19733505618.20010924193924@logos-m.ru>
X-SW-Source: 2001-q3/msg00191.html

Hi Egor,
Thanks for that.

It's not quite right yet though....
In pthread.h,
* PTHREAD_COND_INITIALIZER must be a never valid address, that is
unlikely to occur randomly - 0 won't work. (See
PTHREAD_MUTEX_INITIALIZER).
* I'm still not sure of the appropriateness of the clean_up routine
typedef change, it should go in as a separate patch regardless.

In thread.cc, you have introduced many deference potential invalid
memory issues.

No dereferencing of * parameters should occur until a
verifyable_object_isvalid () call is made on them. As you can see that
function checks for address space allocation and for the INITIALIZER
macro's, and for the correct contect according to a magic cookie.

ie this is bad:
+ if (*cond != PTHREAD_COND_INITIALIZER &&
+ verifyable_object_isvalid (*cond, PTHREAD_COND_MAGIC))
return EBUSY;

whereas adding PTHREAD_COND_INITIALIZER to verifyable_object_isvalid
won't introduce this issue.

pthread_cond_construct is a (to me) unneeded function, thats what the
object constructor is for. Finally reusing the verifyyobject call will
result in less os overhead (in calls to IsBadWritePtr).

Can I suggest you look at the implementation of
PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER should be nearly
identical.
(ie the new code in each function is only two lines:

int
__pthread_mutex_lock (pthread_mutex_t *mutex)
{
  if (!verifyable_object_isvalid (*themutex, PTHREAD_MUTEX_MAGIC))
    return EINVAL;
== new code ==
  if (*mutex == PTHREAD_MUTEX_INITIALIZER)
    __pthread_mutex_init (mutex, NULL);
== /new code ==
  (*themutex)->Lock ();
  return 0;
}

And finally, can you create a simple (able to be included in my GPL'd
pthread test suite) testcase to test the COND_INITIALIZER? If you have
the time to create boundary tests as well, that's even better, but a
core test is needed IMO. I'll run the whole suite for regression
checking (unless you want to :} ).

Rob

----- Original Message -----
From: "egor duda" <deo@logos-m.ru>
To: <cygwin-patches@cygwin.com>
Sent: Tuesday, September 25, 2001 1:39 AM
Subject: PTHREAD_COND_INITIALIZER


> Hi!
>
>   attached is a patch which adds support for PTHREAD_COND_INITIALIZER.
> please don't be fooled by
>
> -__pthread_cond_destroy (pthread_cond_t *cond)
> +__pthread_cond_construct (pthread_cond_t *cond)
>
> lines, it's 'diff', not me :)
>
> egor.            mailto:deo@logos-m.ru icq 5165414 fidonet
2:5020/496.19
