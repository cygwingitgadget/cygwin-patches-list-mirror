From: Jason Tishler <jason@tishler.net>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Fri, 28 Sep 2001 09:36:00 -0000
Message-id: <20010928123825.V1356@dothill.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1D9@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00231.html

Rob,

On Fri, Sep 28, 2001 at 05:48:16PM +1000, Robert Collins wrote:
> Well this patch should make evreything good -  fixing the critical
> section induced race.

At the risk of appearing dense...  Should this patch fix the pthreads hang
trigger by Python's test_threadedtempfile regression test?

Thanks,
Jason
