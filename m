From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jason Tishler" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Fri, 28 Sep 2001 11:20:00 -0000
Message-id: <003a01c1484a$68e7b540$01000001@lifelesswks>
References: <20010928123825.V1356@dothill.com>
X-SW-Source: 2001-q3/msg00232.html

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

Well, if the problem with the test_threadedtempfile is what I thought it
was, yes.

The patch does need to be combined with the other fixup patch to have
any effect though :].

Rob
