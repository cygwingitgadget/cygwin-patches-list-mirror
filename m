From: Corinna Vinschen <vinschen@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: chroot("/") can't work.
Date: Wed, 29 Nov 2000 13:41:00 -0000
Message-id: <3A2577EE.14D8EBFB@redhat.com>
References: <20001129131743.15031.qmail@web117.yahoomail.com> <s1s1yvusc27.fsf@jaist.ac.jp>
X-SW-Source: 2000-q4/msg00028.html

Kazuhiro Fujieda wrote:
> The current implementation of chroot sets '/' as the root dir
> against chroot("/"). It causes `//usr' by `/usr'. It must set an
> empty string as the root dir in the same way as the previous
> implementation.

Hmmm. I think you're right that the current behaviour is not
really ok but the old behaviour is wrong IMO.

If it's possible to set root to an empty string by calling
chroot("/") this could result in the ability to break out of the
chroot environment. This is not ok. But, hmm, this shouldn't
be possible... 

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
mailto:vinschen@redhat.com
