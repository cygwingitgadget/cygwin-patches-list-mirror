From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: yet another "pedantic" patch
Date: Fri, 14 Sep 2001 13:43:00 -0000
Message-id: <20010914164404.A17411@redhat.com>
References: <11495323718.20010913194455@logos-m.ru> <20010913133424.B13789@redhat.com> <150112180767.20010914002552@logos-m.ru> <20010913163632.D15490@redhat.com> <84197556771.20010915000849@logos-m.ru>
X-SW-Source: 2001-q3/msg00148.html

On Sat, Sep 15, 2001 at 12:08:49AM +0400, egor duda wrote:
>Hi!
>
>Friday, 14 September, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>>>CF> Can I suggest that you modify the check_null_empty_* to pass
>>>CF> in an errno that should be used in the case of an empty string?
>>>
>>>CF> You are special casing checks to force an EINVAL.
>
>>>neither SUSv2 nor posix draft say what symlink should do if first
>>>argument is empty string. actually, posix say that symlink() shouldn't
>>>care for its validity as filesystem object at all, and this can be
>>>treated as if empty string is allowed as symlink value.
>>>So, should we eliminate (topath[0] == '\0') check altogether?
>>>Of course, after verifying that symlink resolution code won't break on
>>>such symlinks.
>
>CF> Yes.  I guess we should eliminate this then.  It will probably require
>CF> another special case check for symlink.
>
>it looks like current symlink code handles empty string in symlink
>contents without any trouble, but i want to give it a bit more
>testing.
>
>>>CF> Hmm.  I wonder if EINVAL is always appropriate for an empty string.
>>>CF> It could just be wrong in check_null_empty_str.
>
>>>otherwise, i think that allowing the caller to specify desired errno
>>>explicitly in call to check_null_empty_str_errno() is a good thing.
>
>i've removed checks that were forcing EINVAL (leaving those that don't
>relate to check_null_empty_*, however)
>
>it turned out that current check_null_empty_* are ok, and there's no
>actual need to add errno parameters to them. only place were empty
>string in parameter is known to cause error is when it's file or
>directory name. in that case ENOENT is pretty adequate, just as EFAULT
>in case of NULL or invalid pointer.

It looks ok except for this:

+  if (check_null_empty_str (topath) == EFAULT)
+    {
+      set_errno (EFAULT);
+      goto done;
+    }
+  if (check_null_empty_str_errno (frompath))
+    goto done;

There is no reason for this duplication is there?  Can't this just be
check_null_empty_str_errno?

cgf
