From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jason Tishler" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Sat, 29 Sep 2001 02:44:00 -0000
Message-id: <038301c148cb$7cf7a550$01000001@lifelesswks>
References: <20010928123825.V1356@dothill.com>
X-SW-Source: 2001-q3/msg00233.html

----- Original Message -----
From: "Jason Tishler" <jason@tishler.net>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Sent: Saturday, September 29, 2001 2:38 AM
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog
thread.cc thread.h ...


> Rob,
>
> On Fri, Sep 28, 2001 at 05:48:16PM +1000, Robert Collins wrote:
> > Well this patch should make evreything good -  fixing the critical
> > section induced race.
>
> At the risk of appearing dense...  Should this patch fix the pthreads
hang
> trigger by Python's test_threadedtempfile regression test?

I've checked in my completed code. I -cannot- tickle this bug via my
test suite at all now. (I found that one of my test scripts was slightly
buggy in that it made an incorrect assumption - it was passing when this
bug was tickled - correcting that let me hit this bug nearly every time
:]).

So please, give it a go and see how it fares.

Rob
