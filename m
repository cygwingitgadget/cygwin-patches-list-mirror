From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: getgroups() SUSv2 compliance
Date: Wed, 30 Aug 2000 00:11:00 -0000
Message-id: <80166852691.20000830110923@logos-m.ru>
References: <200008291900.PAA30759@envy.delorie.com>
X-SW-Source: 2000-q3/msg00046.html

Hi!

Tuesday, 29 August, 2000 DJ Delorie dj@delorie.com wrote:

>>       * grp.cc (getgroups): fail with EINVAL if array is not large
>>       enough to hold all supplementary group IDs.

DD> Applied.  I don't suppose you could add a testcase for that, could
DD> you?  It would have to fail without your patch, and pass with it, to
DD> ensure we don't break this in the future.

definitely. actually this one _was_ found as a result of testcase from
sgi's  testsuite  i've  mentioned yesterday. currently i'm wrapping it
into dejagnu.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

