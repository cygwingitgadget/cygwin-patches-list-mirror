From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: try to enable appropriate privilege before loading user's hive
Date: Tue, 14 Aug 2001 02:23:00 -0000
Message-id: <20010814112347.B17709@cygbert.vinschen.de>
References: <19956432105.20010814122213@logos-m.ru>
X-SW-Source: 2001-q3/msg00079.html

On Tue, Aug 14, 2001 at 12:22:13PM +0400, egor duda wrote:
> Hi!
> 
>   i've noticed that sshd fails to load user's hive even when run from
> LocalSystem account. I wonder if there's somthing wrong in my config
> or we should apply this patch?
> 
> egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19

Thanks for tracking that down. Please check it in,

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
