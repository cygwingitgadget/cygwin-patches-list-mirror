From: Chris Faylor <cgf@cygnus.com>
To: Egor Duda <deo@logos-m.ru>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: error_start patch
Date: Tue, 04 Jul 2000 12:08:00 -0000
Message-id: <20000704150841.A2846@cygnus.com>
References: <2891.000522@logos-m.ru>
X-SW-Source: 2000-q3/msg00009.html

On Mon, May 22, 2000 at 09:24:02PM +0400, Egor Duda wrote:
>Below is a patch to prevent cygwin's JIT debugger (specified via
>'error_start') from being spawned recursively, in case when debugger
>throws exception itself.  It also allows to notify the debugee
>that  we've    done    with   debugging   and  it  can  exit in peace.
>debugger can post event named
>
>"cygwin_error_start_event_<debugee_win32_pid>"
>
>instead of
>
>(gdb) set keep_looping=0
>(gdb) c

Applied.  And, only a month or so late. :-)

cgf
