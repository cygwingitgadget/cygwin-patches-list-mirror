From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: "correct" stack trace in gdb
Date: Sun, 29 Apr 2001 20:10:00 -0000
Message-id: <20010429231106.A26455@redhat.com>
References: <189167092696.20010426101930@logos-m.ru>
X-SW-Source: 2001-q2/msg00175.html

On Thu, Apr 26, 2001 at 10:19:30AM +0400, egor duda wrote:
>several people complained in mailing list recently that when they're
>"error_start"ing gdb or dumper to analyze crashes, they see "incorrect"
>stack traces -- without the frame of function which had actually
>crashed.  this patch is supposed to fix this problem, but it has a
>drawback of stripping handle_exception() and try_to_debug() frames from
>stack trace.

I just checked in a relatively simple patch which I think accomplishes
everything in cygwin.  It keeps looping in the exception handler until
gdb starts up.  This is a little unfriendly to the system but it seems
to work ok.

I even tried it on Windows 95.

The benefit of this is that if you do a "thread 1" gdb will be stopped
on the specific instruction that caused the problem.  Or, if it isn't
a "continue" will get you there.

In the process of doing this, I removed all of the attempts at
synchronization except the "keep_looping" busy loop.  The busy loop is
only used when Cygwin wants to call the debugger for its own purposes,
not when there is an exception.

I also changed the stack dump logic a little so that the stack dump
should be a little more accurate now.

Ironically, all of this was prompted by problems with my recent path
scanning logic.  I got a SIGSEGV while testing a configure script and,
as usual, I couldn't figure out exactly where the problem occurred
thanks to the usual problem of missing frame pointers in Windows
functions.

cgf
