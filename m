From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sources.redhat.com>
Subject: Re: testsuite
Date: Mon, 04 Sep 2000 07:29:00 -0000
Message-id: <39B3B1D4.8177A5A5@vinschen.de>
References: <13091183334.20000902233519@logos-m.ru> <20000903001332.A14699@cygnus.com> <110160265820.20000903184643@logos-m.ru> <39B3AF2F.28A64A69@vinschen.de>
X-SW-Source: 2000-q3/msg00056.html

Corinna Vinschen wrote:
> 
> Did anybody see that building testsuite/liblpt.a from top level dir
> fails since the include path to winsup/testsuite/liblpt/include isn't
> propagated then?
> 
> Building in testsuite dir itself works.

Uhm, if that isn't clear, I'm _not_ talking about building in the
source tree but in the according binary build tree.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                        mailto:cygwin@sources.redhat.com
Red Hat, Inc.
mailto:vinschen@cygnus.com
