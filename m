From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: poll() patch
Date: Fri, 07 Sep 2001 10:18:00 -0000
Message-id: <20010907191840.I17245@cygbert.vinschen.de>
References: <20010907110236.A788@dothill.com>
X-SW-Source: 2001-q3/msg00110.html

On Fri, Sep 07, 2001 at 11:02:37AM -0400, Jason Tishler wrote:
> The attached patch prevents Cygwin from hanging in poll() (well really
> select) when only invalid file descriptors are specified.  With the
> patch applied, Cygwin's poll() now behaves the same as the one on Red
> Hat 7.1 Linux.
> 
> The third attachment is a small test program that demonstrates the
> problem.
> 
> For those interested in Python, this was the root cause to the test_poll
> hang.
> 
> Thanks,
> Jason

Good catch. Applied.

Thanks Jason,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
