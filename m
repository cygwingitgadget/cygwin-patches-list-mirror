From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: case-sensitiveness of environment problem
Date: Tue, 17 Apr 2001 07:02:00 -0000
Message-id: <20010417100306.C31974@redhat.com>
References: <27138147024.20010416101728@logos-m.ru>
X-SW-Source: 2001-q2/msg00098.html

On Mon, Apr 16, 2001 at 10:17:28AM +0400, egor duda wrote:
>Hi!
>
>  if cygwin environment contains both 'Path' and 'PATH', creating
>windows environment from it causes crash due to reallocating memory
>object which is externally referenced. this patch fixes that.
>
>i feel that we need a bit more tweaking with environment to deal with
>it case-insensitiveness under win32.

I don't think that this is due to case insensitivity as much as someone
supplying a non-malloced PATH string.

Your patch doesn't look right, since it is storing the environ string in
an alloca'ed buffer.  Since alloca is stack based, won't the buffer be
overwritten once the function returns?

cgf
