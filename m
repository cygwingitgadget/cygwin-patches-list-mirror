From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: yet another "pedantic" patch
Date: Thu, 13 Sep 2001 10:32:00 -0000
Message-id: <182101754975.20010913213206@logos-m.ru>
References: <11495323718.20010913194455@logos-m.ru> <20010913132800.A13789@redhat.com>
X-SW-Source: 2001-q3/msg00142.html

Hi!

Thursday, 13 September, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> On Thu, Sep 13, 2001 at 07:44:55PM +0400, egor duda wrote:
>>Hi!
>>
>>  I've added input parameter checking to some functions so that new
>>tests in the testsuite will run smoothly.
>>
>>Does anybody know why we link with libstdc++? I've removed it and
>>everything links and runs ok.

CF> In gcc 3+ builtin_new exists in libstdc++.

ok, point taken. how about the rest?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
