From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: yet another "pedantic" patch
Date: Thu, 13 Sep 2001 10:27:00 -0000
Message-id: <20010913132800.A13789@redhat.com>
References: <11495323718.20010913194455@logos-m.ru>
X-SW-Source: 2001-q3/msg00141.html

On Thu, Sep 13, 2001 at 07:44:55PM +0400, egor duda wrote:
>Hi!
>
>  I've added input parameter checking to some functions so that new
>tests in the testsuite will run smoothly.
>
>Does anybody know why we link with libstdc++? I've removed it and
>everything links and runs ok.

In gcc 3+ builtin_new exists in libstdc++.

cgf
