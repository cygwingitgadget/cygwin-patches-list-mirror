From: Corinna Vinschen <corinna@vinschen.de>
To: cygwin-patches@sources.redhat.com, cygpatch <cygwin-patches@sources.redhat.com>
Subject: Re: testsuite
Date: Mon, 04 Sep 2000 07:50:00 -0000
Message-id: <39B3B6C7.171EFA6@vinschen.de>
References: <13091183334.20000902233519@logos-m.ru> <20000903001332.A14699@cygnus.com> <110160265820.20000903184643@logos-m.ru> <39B3AF2F.28A64A69@vinschen.de> <98245811598.20000904183229@logos-m.ru>
X-SW-Source: 2000-q3/msg00058.html

Egor Duda wrote:
> Monday, 04 September, 2000 Corinna Vinschen corinna@vinschen.de wrote:
> CV> Did anybody see that building testsuite/liblpt.a from top level dir
> CV> fails since the include path to winsup/testsuite/liblpt/include isn't
> CV> propagated then?
> 
> CV> Building in testsuite dir itself works.
> 
> you mean calling "make testsuite/libltp.a" from winsup/ directory?
> 
> i don't know why anybody would need that, but anyway, adding

It's not a question of need. testsuite is build automatically for
example if you start a configure/make from the top level dir. This
isn't winsup but it's ../.. of that (in the build tree).

Corinna

> testsuite/%:
>         @$(MAKE) -C testsuite ${patsubst testsuite/%,%,$@}

Can you send that as patch, please?

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                        mailto:cygwin@sources.redhat.com
Red Hat, Inc.
mailto:vinschen@cygnus.com
