From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: case-sensitiveness of environment problem
Date: Tue, 17 Apr 2001 09:22:00 -0000
Message-id: <20010417122239.A25694@redhat.com>
References: <27138147024.20010416101728@logos-m.ru> <20010417100306.C31974@redhat.com> <50254646181.20010417183909@logos-m.ru>
X-SW-Source: 2001-q2/msg00103.html

On Tue, Apr 17, 2001 at 06:39:09PM +0400, egor duda wrote:
>Hi!
>
>Tuesday, 17 April, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>>>  if cygwin environment contains both 'Path' and 'PATH', creating
>>>windows environment from it causes crash due to reallocating memory
>>>object which is externally referenced. this patch fixes that.
>>>
>>>i feel that we need a bit more tweaking with environment to deal with
>>>it case-insensitiveness under win32.
>
>CF> I don't think that this is due to case insensitivity as much as someone
>CF> supplying a non-malloced PATH string.
>
>it is. suppose we have cygwin environment containing
>
>Path=/bin
>PATH=/bin:/usr/bin:/usr/local/bin:/home/user/bla/bla/bla

You're right.  I really should have looked at the code more closely.

I think we can solve this trivially by making getwinenv perform a
case-sensitive comparison, though, can't we?  I think it probably should
be case-sensitive anyway.

>CF> Your patch doesn't look right, since it is storing the environ string in
>CF> an alloca'ed buffer.  Since alloca is stack based, won't the buffer be
>CF> overwritten once the function returns?
>
>this buffer is temporary and used internally in winenv. all data is
>copied to 'envblock' later.

Sigh.  You're right again.  I use alloca a few lines below this.  Sorry
for the noise.

cgf
