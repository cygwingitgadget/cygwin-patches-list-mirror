From: Earnie Boyd <earnie_boyd@yahoo.com>
To: corinna@sourceware.cygnus.com, cygwin-patches@cygwin.com
Subject: Re: src/winsup/cinstall ChangeLog download.cc
Date: Mon, 19 Feb 2001 10:08:00 -0000
Message-id: <3A916118.A043FFBD@yahoo.com>
References: <20010219180219.3323.qmail@sourceware.cygnus.com>
X-SW-Source: 2001-q1/msg00085.html

corinna@sourceware.cygnus.com wrote:
> 
> CVSROOT:        /cvs/src
> Module name:    src
> Changes by:     corinna@sources.redhat.com      2001-02-19 10:02:19
> 
> Modified files:
>         winsup/cinstall: ChangeLog download.cc
> 
> Log message:
>         * download.cc (get_file_size): New function. Eliminates the need
>         to call `stat'.
>         (download_one): Call `get_file_size' instead of `stat'. This
>         workarounds a problem with mingw's `stat' call.
> 

Corinna,

Can you please elaborate on the problem with MinGW's `stat' call?

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

