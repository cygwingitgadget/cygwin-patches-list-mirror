From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: case-sensitiveness of environment problem
Date: Tue, 17 Apr 2001 11:09:00 -0000
Message-id: <20010417140927.E25644@redhat.com>
References: <27138147024.20010416101728@logos-m.ru> <20010417100306.C31974@redhat.com> <50254646181.20010417183909@logos-m.ru> <20010417122239.A25694@redhat.com> <129262643781.20010417205227@logos-m.ru>
X-SW-Source: 2001-q2/msg00107.html

On Tue, Apr 17, 2001 at 08:52:27PM +0400, egor duda wrote:
>Hi!
>
>Tuesday, 17 April, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>>>>>  if cygwin environment contains both 'Path' and 'PATH', creating
>>>>>windows environment from it causes crash due to reallocating memory
>>>>>object which is externally referenced. this patch fixes that.
>>>>>
>>>>>i feel that we need a bit more tweaking with environment to deal with
>>>>>it case-insensitiveness under win32.
>>>
>>>CF> I don't think that this is due to case insensitivity as much as someone
>>>CF> supplying a non-malloced PATH string.
>>>
>>>it is. suppose we have cygwin environment containing
>>>
>>>Path=/bin
>>>PATH=/bin:/usr/bin:/usr/local/bin:/home/user/bla/bla/bla
>
>CF> You're right.  I really should have looked at the code more closely.
>
>CF> I think we can solve this trivially by making getwinenv perform a
>CF> case-sensitive comparison, though, can't we?  I think it probably should
>CF> be case-sensitive anyway.
>
>probably. but what if someone runs something nasty like this?
>
>extern char** environ;
>
>char* x[]= { "FOO=bar",
>             "foo=BAR",
>             "FOO=very-long-environment-value-used-only-for-testing-purposes",
>             0 };
>char* arg[] = { "/bin/env", 0 };
>
>int
>main (int argc, char** argv)
>{
>  environ = x;
>  execvp ( arg[0], arg );
>}
>
>i think external reference is a bad idea anyway.

I've always thought that if someone plays with environ they get what they pay
for anyway.

cgf
