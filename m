From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: yet another "pedantic" patch
Date: Sat, 15 Sep 2001 14:24:00 -0000
Message-id: <20010915172457.J28425@redhat.com>
X-SW-Source: 2001-q3/msg00150.html

On Sat, Sep 15, 2001 at 11:54:24PM +0400, egor duda wrote:
>Hi!
>
>Saturday, 15 September, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>CF> It looks ok except for this:
>
>CF> +  if (check_null_empty_str (topath) == EFAULT)
>CF> +    {
>CF> +      set_errno (EFAULT);
>CF> +      goto done;
>CF> +    }
>CF> +  if (check_null_empty_str_errno (frompath))
>CF> +    goto done;
>
>CF> There is no reason for this duplication is there?  Can't this just be
>CF> check_null_empty_str_errno?
>
>ah, right. i was thinking for some reason that check_null_empty_str_errno()
>returns true/false.

Huh.  I missed the 'topath/frompath' but it sounds like you interpreted
my comment as if was actually intelligent and fixed something.

Please check this in.

Thanks very much for doing this.

cgf
