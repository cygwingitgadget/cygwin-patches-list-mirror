From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: yet another "pedantic" patch
Date: Thu, 13 Sep 2001 10:34:00 -0000
Message-id: <20010913133424.B13789@redhat.com>
References: <11495323718.20010913194455@logos-m.ru>
X-SW-Source: 2001-q3/msg00143.html

On Thu, Sep 13, 2001 at 07:44:55PM +0400, egor duda wrote:
>Hi!
>
>  I've added input parameter checking to some functions so that new
>tests in the testsuite will run smoothly.
>
>Does anybody know why we link with libstdc++? I've removed it and
>everything links and runs ok.

Can I suggest that you modify the check_null_empty_* to pass
in an errno that should be used in the case of an empty string?

You are special casing checks to force an EINVAL.

Hmm.  I wonder if EINVAL is always appropriate for an empty string.
It could just be wrong in check_null_empty_str.

Thanks for doing this due diligence.

cgf
