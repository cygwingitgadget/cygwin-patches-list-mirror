From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: Set argv[0] in the win32 style for non-Cygwin applications.
Date: Mon, 25 Sep 2000 08:24:00 -0000
Message-id: <20000925112318.A9745@cygnus.com>
References: <s1sog1chnr4.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00100.html

On Mon, Sep 25, 2000 at 05:36:15PM +0900, Kazuhiro Fujieda wrote:
>The following patch will be useful, when a Cygwin application
>launch non-Cygwin applications such as examine argv[0].
>
>ChangeLog:
>Mon Sep 25 17:33:29 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* spawn.cc (spawn_guts): Set argv[0] in the win32 style for
>	non-Cygwin applications.

This is a good idea (and I think the code used to do this) but it should
probably just always force the first argument into Windows format.  A cygwin
app will always use the argv array and a non-cygwin app will always use the
argument list, so...

Thanks for catching this.

Btw, there are still memory leaks in the cygwin heap mechanism, especially with
regard to exec.  I'm mulling over methods for eliminating them.
cgf
