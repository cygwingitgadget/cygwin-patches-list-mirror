From: egor duda <deo@logos-m.ru>
To: Kazuhiro Fujieda <cygwin-patches@cygwin.com>
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Wed, 27 Jun 2001 11:11:00 -0000
Message-id: <151352447582.20010627220840@logos-m.ru>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com> <s1sr8w64yoq.fsf@jaist.ac.jp> <20010627012107.H19058@redhat.com> <s1su212yxwm.fsf@jaist.ac.jp> <005301c0ff01$5430ac20$0400a8c0@local> <s1ssngmylrs.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00358.html

Hi!

Wednesday, 27 June, 2001 Kazuhiro Fujieda fujieda@jaist.ac.jp wrote:

KF> like the following?

KF> 2001-06-27  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

KF>         * syscalls.cc (setsid): Detach process from its console if
KF>         the current controlling tty is the console and already closed.
KF>         * dtable.h (class dtable): Add members to count descriptors
KF>         referring to the console.
KF>         * dtable.cc (dtable::dec_console_fds): New function to detach
KF>         process from its console.
KF>         (dtable::release): Decrement the counter of console descriptors.
KF>         (dtable::build_fhandler): Increment it.
KF>         * exception.cc (ctrl_c_handler): Send SIGTERM to myself when catch
KF>         CTRL_LOGOFF_EVENT.

there's a forced AllocConsole() in cygwin inetd to allow some non-cygwin
applications to be run via ssh or telnet.
see http://sources.redhat.com/ml/cygwin/2001-03/msg00764.html for
details. won't your patch break this?

Maybe we just need some kind of api so that cygwin port of any
particular program can deliberately delete associated console?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
