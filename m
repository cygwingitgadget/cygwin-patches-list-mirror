From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Wed, 27 Jun 2001 14:59:00 -0000
Message-id: <s1sae2ty46d.fsf@jaist.ac.jp>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com> <s1sr8w64yoq.fsf@jaist.ac.jp> <20010627012107.H19058@redhat.com> <s1su212yxwm.fsf@jaist.ac.jp> <005301c0ff01$5430ac20$0400a8c0@local> <s1ssngmylrs.fsf@jaist.ac.jp> <151352447582.20010627220840@logos-m.ru>
X-SW-Source: 2001-q2/msg00359.html

>>> On Wed, 27 Jun 2001 22:08:40 +0400
>>> egor duda <deo@logos-m.ru> said:

> there's a forced AllocConsole() in cygwin inetd to allow some non-cygwin
> applications to be run via ssh or telnet.
> see http://sources.redhat.com/ml/cygwin/2001-03/msg00764.html for
> details. won't your patch break this?

No, my patch effects such applications as become daemons with
setsid(). Inetd running as a service on WinNT/2k never does so.

Anyway, I failed to notice this change of inetd because
I usually use sshd only.

It causes a problem on Win9x. It makes inetd unable to run
without its console window anymore. Inetd opens a console window
even when it is executed via the `run' utility by Charles Wilson.

On Win9x, the commands mentioned in the archived mail (net and
start) work the same either with or without the AllocConsole().
So there is no need of it on Win9x.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
