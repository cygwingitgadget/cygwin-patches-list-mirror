From: Corinna Vinschen <corinna@vinschen.de>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: testsuite
Date: Mon, 04 Sep 2000 07:18:00 -0000
Message-id: <39B3AF2F.28A64A69@vinschen.de>
References: <13091183334.20000902233519@logos-m.ru> <20000903001332.A14699@cygnus.com> <110160265820.20000903184643@logos-m.ru>
X-SW-Source: 2000-q3/msg00055.html

Did anybody see that building testsuite/liblpt.a from top level dir
fails since the include path to winsup/testsuite/liblpt/include isn't
propagated then?

Building in testsuite dir itself works.

Corinna

Egor Duda wrote:
> 
> Hi!
> 
> Sunday, 03 September, 2000 Chris Faylor cgf@cygnus.com wrote:
> 
> CF> On Sat, Sep 02, 2000 at 11:35:19PM +0400, Egor Duda wrote:
> >>  here it is. since 'diff' doesn't work well when files are moved
> >>around,  i'm  sending  all  testsuite/ directory along with patches to
> >>integrate it in current winsup tree.
> 
> CF> Thanks.  I've checked everything in but the change to Makefile.common.
> CF> I didn't see any reason to change the meaning of CFLAGS that drastically.
> 
> ok.  the whole point of doing this change was to allow testsuite build
> to set -Wno-write-strings
> 
> now  i've put 'const' everywhere they're needed, so all should work ok
> with CFLAGS from Makefile.common
> 
> Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
> 
>   ------------------------------------------------------------------------
>                               Name: testsuite-warnings.diff
>    testsuite-warnings.diff    Type: unspecified type (application/octet-stream)
>                           Encoding: base64
> 
>                                    Name: testsuite-warnings.ChangeLog
>    testsuite-warnings.ChangeLog    Type: unspecified type (application/octet-stream)
>                                Encoding: base64

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                        mailto:cygwin@sources.redhat.com
Red Hat, Inc.
mailto:vinschen@cygnus.com
