From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: --enable-malloc-debugging option to configure
Date: Tue, 24 Apr 2001 07:38:00 -0000
Message-id: <20010424103915.E5814@redhat.com>
References: <51362139489.20010419003044@logos-m.ru> <20010418165156.A30797@redhat.com> <59239676005.20010424101919@logos-m.ru>
X-SW-Source: 2001-q2/msg00140.html

On Tue, Apr 24, 2001 at 10:19:19AM +0400, egor duda wrote:
>Hi!
>
>Thursday, 19 April, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>CF> On Thu, Apr 19, 2001 at 12:30:44AM +0400, egor duda wrote:
>>>Hi!
>>>
>>>  here's the patch to make building cygwin1.dll with MALLOC_DEBUG as
>>>easy as supplying '--enable-malloc-debugging' option to configure.
>>>it also requires a small tweak to newlib. If everything's ok with the
>>>patch I'll send newlib's part to newlib mailing list.
>>>
>>>dlmalloc.tar.gz is a tweaked version of dlmalloc Chris posted in
>>> http://sources.redhat.com/ml/cygwin-developers/2001-03/msg00129.html
>
>CF> This is great.  Please do submit the changes to newlib so that we
>CF> can incorporate this into cygwin.
>
>newlib changes had been checked in. Ok to check in the winsup part?

Please do.

cgf
