From: Corinna Vinschen <vinschen@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: chroot("/") can't work.
Date: Wed, 29 Nov 2000 05:41:00 -0000
Message-id: <3A250764.24304FB3@redhat.com>
References: <20001129131743.15031.qmail@web117.yahoomail.com>
X-SW-Source: 2000-q4/msg00024.html

Earnie Boyd wrote:
> 
> Is this patch so that you can do `chroot /'?  Why would you want to do that?

That's not the reason for `rootlen > 1'.

The problem is to strip a trailing '/' _except_ when rootlen == 1
which means, root is "/". Stripping the '/' would result in an
empty string then.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
mailto:vinschen@redhat.com
