From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "egor duda" <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Thu, 27 Sep 2001 03:55:00 -0000
Message-id: <007b01c14743$2a0005b0$01000001@lifelesswks>
References: <20010925114527.23687.qmail@sourceware.cygnus.com> <14472692346.20010927144858@logos-m.ru>
X-SW-Source: 2001-q3/msg00207.html

----- Original Message -----
From: "egor duda" <deo@logos-m.ru>
To: <cygwin-patches@cygwin.com>
Cc: "Robert Collins" <robert.collins@itdomain.com.au>
Sent: Thursday, September 27, 2001 8:48 PM
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...


> Hi!
>
> Tuesday, 25 September, 2001 rbcollins@sourceware.cygnus.com
rbcollins@sourceware.cygnus.com wrote:
>
> rscc> Modified files:
> rscc>         winsup/cygwin  : ChangeLog thread.cc thread.h
> rscc>         winsup/cygwin/include: pthread.h
>
> rscc> Log message:
> rscc>         Tue Sep 25 21:25:00 2001  Robert Collins
<rbtcollins@hotmail.com>
>
> rscc>         * thread.cc (pthread_cond::BroadCast): Use address with
verifyable_object_isvalid().
> rscc>         (pthread_cond::Signal): Ditto.
>
> [...]
>
> Robert, i have problems with your last patch. at program startup
> read_etc_passwd() is called recursively and second call blocks at
> pthread_mutex_lock()

Huh, strange. I ran with the .dll for some time with no trouble, and am
about to switch to it in this environment as well.

> did you run 'make check' with it?

I don't have a dejagnu environment. I did run make check with my
pthreads code.

Rob
