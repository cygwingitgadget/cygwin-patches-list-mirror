From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: cfree from newlib is linked instead of "cygheap" cfree
Date: Wed, 06 Sep 2000 14:21:00 -0000
Message-id: <20000906172101.A4043@cygnus.com>
References: <178102785918.20000906213200@logos-m.ru>
X-SW-Source: 2000-q3/msg00069.html

On Wed, Sep 06, 2000 at 09:32:00PM +0400, Egor Duda wrote:
>class child_info uses cfree in it's destructor, assuming this will be
>cfree for cygheap.  Nevertheless, in spawn.cc compiler uses cfree from
>newlib, when ciresrv variable in spawn_guts get freed.  this,
>obviously, causes crash.  how about this patch?

This was actually solvable by reorganizing the headers.  I've done that
plus making sure that most of the newlib headers define the exported
functions correctly plus ensuring that cfree is not built plus ensuring
that the non-cygwin version of the cfree function is not used.

Thanks for the heads up.

cgf
