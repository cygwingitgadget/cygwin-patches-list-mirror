From: Earnie Boyd <earnie_boyd@yahoo.com>
To: corinna@sourceware.cygnus.com, cygwin-patches@cygwin.com
Subject: Re: src/winsup Makefile.common ChangeLog
Date: Wed, 21 Feb 2001 16:00:00 -0000
Message-id: <3A9456C7.2677485F@yahoo.com>
References: <20010221214650.16935.qmail@sourceware.cygnus.com>
X-SW-Source: 2001-q1/msg00102.html

corinna@sourceware.cygnus.com wrote:
> 
> CVSROOT:        /cvs/src
> Module name:    src
> Changes by:     corinna@sources.redhat.com      2001-02-21 13:46:49
> 
> Modified files:
>         winsup         : Makefile.common ChangeLog
> 
> Log message:
>         * Makefile.common: Add `-fvtable-thunks' to COMPILE_CXX.
> 


Are you positive about this patch?  I thought that problems existed
unless all libraries were compiled -fvtable-thunks.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

