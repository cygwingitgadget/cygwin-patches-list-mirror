From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Wed, 25 Jul 2001 14:51:00 -0000
Message-id: <20010725175126.C11993@redhat.com>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com> <s1sr8w64yoq.fsf@jaist.ac.jp> <20010627012107.H19058@redhat.com> <s1su212yxwm.fsf@jaist.ac.jp> <005301c0ff01$5430ac20$0400a8c0@local> <s1ssngmylrs.fsf@jaist.ac.jp> <s1szoabcw66.fsf@jaist.ac.jp>
X-SW-Source: 2001-q3/msg00035.html

On Thu, Jul 12, 2001 at 12:39:13AM +0900, Kazuhiro Fujieda wrote:
>I had enjoyed my daemon patch for a while. I found detaching
>the console worked fine and cause no undesirable side effect,
>while the ctrl_c_handler caused an undesirable effect.
>It terminated Cygwin processes running as services on NT/2000
>when an user logged off. So I fixed it.

I'm slowly crawling out of my vacation hole, and had some time to look
at this patch while I was in the middle of multiple phone meetings.

Anyway, I've applied this patch.  I was a little reluctant to change the
behavior of the CTRL_SHUTDOWN_EVENT since it has been like this for some
time.

However, if you want to make an omelette...

Nice patch, by the way.  I like the way you did this, Kazuhiro.

cgf

>2001-07-12  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* syscalls.cc (setsid): Detach process from its console if
>	the current controlling tty is the console and already closed.
>	* dtable.h (class dtable): Add members to count descriptors
>	referring to the console.
>	* dtable.cc (dtable::dec_console_fds): New function to detach
>	process from its console.
>	(dtable::release): Decrement the counter of console descriptors.
>	(dtable::build_fhandler): Increment it.
>	* exception.cc (ctrl_c_handler): Send SIGTERM to myself when catch
>	CTRL_SHUTDOWN_EVENT.
