From: Corinna Vinschen <vinschen@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: chroot("/") can't work.
Date: Wed, 29 Nov 2000 14:21:00 -0000
Message-id: <3A25816D.11F44893@redhat.com>
References: <20001129131743.15031.qmail@web117.yahoomail.com> <s1s1yvusc27.fsf@jaist.ac.jp> <3A2577EE.14D8EBFB@redhat.com> <s1szoiiqvgg.fsf@jaist.ac.jp>
X-SW-Source: 2000-q4/msg00030.html

Kazuhiro Fujieda wrote:
> If cyg_root has been set other than an empty string, chroot("/")
> can't set it to an empty string.  The argument is processed by
> normalize_posix_path.

Yes, you're right and you have convinced me. I have just spent a few
moments to try various situations on Cygwin and Linux.

Thanks, I will check in your patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
mailto:vinschen@redhat.com
