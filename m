From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-malloc-debugging option to configure
Date: Wed, 18 Apr 2001 13:51:00 -0000
Message-id: <20010418165156.A30797@redhat.com>
References: <51362139489.20010419003044@logos-m.ru>
X-SW-Source: 2001-q2/msg00113.html

On Thu, Apr 19, 2001 at 12:30:44AM +0400, egor duda wrote:
>Hi!
>
>  here's the patch to make building cygwin1.dll with MALLOC_DEBUG as
>easy as supplying '--enable-malloc-debugging' option to configure.
>it also requires a small tweak to newlib. If everything's ok with the
>patch I'll send newlib's part to newlib mailing list.
>
>dlmalloc.tar.gz is a tweaked version of dlmalloc Chris posted in
> http://sources.redhat.com/ml/cygwin-developers/2001-03/msg00129.html

This is great.  Please do submit the changes to newlib so that we
can incorporate this into cygwin.

cgf
