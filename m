From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: no passwd in /etc/group
Date: Wed, 18 Apr 2001 07:52:00 -0000
Message-id: <20010418165228.K15005@cygbert.vinschen.de>
References: <125340835285.20010418183539@logos-m.ru>
X-SW-Source: 2001-q2/msg00110.html

On Wed, Apr 18, 2001 at 06:35:39PM +0400, egor duda wrote:
> Hi!
> 
>   if passwd field in any line of /etc/group is empty, getgroups causes
> SIGSEGV. fix attached.

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
