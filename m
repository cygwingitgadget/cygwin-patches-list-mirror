From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Fri, 04 May 2001 01:50:00 -0000
Message-id: <20010504105031.X24200@cygbert.vinschen.de>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de> <9258490099.20010503171417@logos-m.ru> <20010503110333.A4579@redhat.com> <20010503110454.B4579@redhat.com> <177268099516.20010503195427@logos-m.ru> <20010503131150.C4579@redhat.com> <96322539597.20010504110148@logos-m.ru>
X-SW-Source: 2001-q2/msg00190.html

On Fri, May 04, 2001 at 11:01:48AM +0400, egor duda wrote:
> Hi!
> i think it's enough to have one entropy_source per process. i've also
> removed calls to random(), since it's not good if random sequence is
> changed when application calls bind(). Take 3.
> 
> Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

Hi Egor,

that looks fine with me. If Chris has no objections, please check it in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
