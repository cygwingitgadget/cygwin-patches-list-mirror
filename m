From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Cc: deo@logos-m.ru
Subject: Re: core dump support for cygwin
Date: Thu, 24 Aug 2000 12:11:00 -0000
Message-id: <20000824150948.A16171@cygnus.com>
References: <1797.000824@logos-m.ru>
X-SW-Source: 2000-q3/msg00042.html

I've added the winsup-specific stuff to the appropriate places.

Note, that you need to study ChangeLog entries a little more.  There
were a couple of problems with yours.  Specifically, your formatting was
non-standard, and, more importantly, you need to make changes to
individual ChangeLogs in the individual directories, not the one in the
winsup directory.

Also, I had to make some changes to the includes that you used and had
to coerce the return value of two GetProcAddress calls.

Anyway, the gdb changes really need to be sent to gdb-patches.  I
haven't looked at them to see if I have any comments, but if I do, the
discussion should take place in that mailing list.

Thanks for contributing this.  This will be a major addition to cygwin's
functionality.

cgf

On Thu, Aug 24, 2000 at 07:08:58PM +0400, Egor Duda wrote:
>these  are  patches   for  gdb  and  winsup  to implement core dumps
>support   in  cygwin.  core  dumps  are  created  by  dumper  utility
>(winsup/utils/dumper.exe)
>
>=====================================================================
>Usage: dumper [-v] [-c filename] pid
>-c filename -- dump core to filename.core
>-d          -- print some debugging info while dumping
>pid         -- win32-pid of process to dump
>=====================================================================
>[snip]
