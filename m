From: Egor Duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@sources.redhat.com>
Subject: Re: testsuite
Date: Mon, 04 Sep 2000 07:33:00 -0000
Message-id: <98245811598.20000904183229@logos-m.ru>
References: <13091183334.20000902233519@logos-m.ru> <20000903001332.A14699@cygnus.com> <110160265820.20000903184643@logos-m.ru> <39B3AF2F.28A64A69@vinschen.de>
X-SW-Source: 2000-q3/msg00057.html

Hi!

Monday, 04 September, 2000 Corinna Vinschen corinna@vinschen.de wrote:

CV> Did anybody see that building testsuite/liblpt.a from top level dir
CV> fails since the include path to winsup/testsuite/liblpt/include isn't
CV> propagated then?

CV> Building in testsuite dir itself works.

you mean calling "make testsuite/libltp.a" from winsup/ directory?

i don't know why anybody would need that, but anyway, adding

testsuite/%:
        @$(MAKE) -C testsuite ${patsubst testsuite/%,%,$@}

to winsup/Makefile.in will do the job

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

