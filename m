From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: interrupted sleep returns wrong value
Date: Fri, 15 Sep 2000 13:28:00 -0000
Message-id: <20000915162737.A6331@cygnus.com>
References: <37298513830.20000915232401@logos-m.ru>
X-SW-Source: 2000-q3/msg00095.html

On Fri, Sep 15, 2000 at 11:24:01PM +0400, Egor Duda wrote:
>Hi!
>
>  SUSv2 says:
>
>    If sleep() returns because the requested time has elapsed, the value
>    returned will be 0. If sleep() returns because of premature arousal due to
>    delivery of a signal, the return value will be the "unslept" amount (the
>    requested time minus the time actually slept) in seconds.
>
>attached patch accomplish this.

This looks good.  Please check it in.

cgf
