From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: oem/ansi codepage support
Date: Fri, 01 Dec 2000 21:02:00 -0000
Message-id: <20001202000129.C4544@redhat.com>
References: <129109438394.20001129174705@logos-m.ru>
X-SW-Source: 2000-q4/msg00033.html

On Wed, Nov 29, 2000 at 05:47:05PM +0300, Egor Duda wrote:
>Hi!
>
>  this    patch    allows    to   specify   CYGWIN=codepage:oem   or
>CYGWIN=codepage:ansi  and  force  cygwin  to use appropriate codepage.
>Default codepage is ansi, as it is currently.
>There's  one  caveat  in  this  patch:  cygwin  performs  switching to
>specified   codepage  after  initializing  the  environment,  so  all
>initializations   performed   before  environ_init()  will  use  ansi
>codepage.   as  far  as  i can see, there's no codepage-dependant code
>in those initializations now, but they may appear in the future.

The patch looks good but isn't there an LC_something environment
variable that is equivalent to this on Linux.

If so, I would like to use that (even though I suggested using the Cygwin
env variable).

cgf
