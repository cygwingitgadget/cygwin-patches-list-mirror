From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sourceware.cygnus.com
Cc: deo@logos-m.ru
Subject: Re: getgroups() SUSv2 compliance
Date: Tue, 29 Aug 2000 12:00:00 -0000
Message-id: <200008291900.PAA30759@envy.delorie.com>
X-SW-Source: 2000-q3/msg00045.html

>	* grp.cc (getgroups): fail with EINVAL if array is not large
>	enough to hold all supplementary group IDs.

Applied.  I don't suppose you could add a testcase for that, could
you?  It would have to fail without your patch, and pass with it, to
ensure we don't break this in the future.
