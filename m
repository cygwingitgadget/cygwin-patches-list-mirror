From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup Makefile.common ChangeLog
Date: Wed, 21 Feb 2001 17:46:00 -0000
Message-id: <3A946F83.32D78837@yahoo.com>
References: <20010221214650.16935.qmail@sourceware.cygnus.com> <3A9456C7.2677485F@yahoo.com> <20010221200320.B7330@redhat.com>
X-SW-Source: 2001-q1/msg00104.html

Christopher Faylor wrote:
> 
> On Wed, Feb 21, 2001 at 07:01:11PM -0500, Earnie Boyd wrote:
> >corinna@sourceware.cygnus.com wrote:
> >>
> >> CVSROOT:        /cvs/src
> >> Module name:    src
> >> Changes by:     corinna@sources.redhat.com      2001-02-21 13:46:49
> >>
> >> Modified files:
> >>         winsup         : Makefile.common ChangeLog
> >>
> >> Log message:
> >>         * Makefile.common: Add `-fvtable-thunks' to COMPILE_CXX.
> >>
> >
> >
> >Are you positive about this patch?  I thought that problems existed
> >unless all libraries were compiled -fvtable-thunks.
> 
> Huh.  I just asked Corinna to discuss this here to see if anyone had
> any idea if this would cause problems.  It sounds like it might be
> a potential speedup for cygwin, though?
> 

Based on previous posts, either in cygwin, cygwin-developers, or
mingw-users I remember Mumit saying that all libraries must be built
using -fvtable-thunks and that C++ (or the libstdc++.a) doesn't yet
handle it correctly.  Just today, I read a message from Mumit that said
maybe stdc++3.0 will handle it.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

