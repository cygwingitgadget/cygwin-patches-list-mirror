From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkdir ((char*) -1, 0777) returns ECASECLASH
Date: Fri, 20 Apr 2001 09:40:00 -0000
Message-id: <20010420124121.B24555@redhat.com>
References: <122419105832.20010419162011@logos-m.ru>
X-SW-Source: 2001-q2/msg00130.html

On Thu, Apr 19, 2001 at 04:20:11PM +0400, egor duda wrote:
>Hi!
>
>  instead of EFAULT. Fix attached.

I've checked in a minor variation of this patch.  I just preserved
the same initialization order as was previously used.

Thanks.

cgf
