From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: yet another "pedantic" patch
Date: Thu, 13 Sep 2001 13:36:00 -0000
Message-id: <20010913163632.D15490@redhat.com>
References: <11495323718.20010913194455@logos-m.ru> <20010913133424.B13789@redhat.com> <150112180767.20010914002552@logos-m.ru>
X-SW-Source: 2001-q3/msg00145.html

On Fri, Sep 14, 2001 at 12:25:52AM +0400, egor duda wrote:
>Hi!
>
>Thursday, 13 September, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>CF> On Thu, Sep 13, 2001 at 07:44:55PM +0400, egor duda wrote:
>>>  I've added input parameter checking to some functions so that new
>>>tests in the testsuite will run smoothly.
>>>
>>>Does anybody know why we link with libstdc++? I've removed it and
>>>everything links and runs ok.
>
>CF> Can I suggest that you modify the check_null_empty_* to pass
>CF> in an errno that should be used in the case of an empty string?
>
>CF> You are special casing checks to force an EINVAL.
>
>neither SUSv2 nor posix draft say what symlink should do if first
>argument is empty string. actually, posix say that symlink() shouldn't
>care for its validity as filesystem object at all, and this can be
>treated as if empty string is allowed as symlink value.
>So, should we eliminate (topath[0] == '\0') check altogether?
>Of course, after verifying that symlink resolution code won't break on
>such symlinks.

Yes.  I guess we should eliminate this then.  It will probably require
another special case check for symlink.

>CF> Hmm.  I wonder if EINVAL is always appropriate for an empty string.
>CF> It could just be wrong in check_null_empty_str.
>
>otherwise, i think that allowing the caller to specify desired errno
>explicitly in call to check_null_empty_str_errno() is a good thing.

Ok.

cgf
