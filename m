From: Peter Eisentraut <peter_e@gmx.net>
To: egor duda <cygwin-patches@cygwin.com>
Cc: Jason Tishler <Jason.Tishler@dothill.com>, Pgsql-Ports <pgsql-ports@postgresql.org>
Subject: Re: improving security of AF_UNIX sockets
Date: Fri, 13 Apr 2001 18:57:00 -0000
Message-id: <Pine.LNX.4.30.0104140350200.945-100000@peter.localdomain>
References: <117633548304.20010413212702@logos-m.ru>
X-SW-Source: 2001-q2/msg00059.html

egor duda writes:

> PE> Actually, connections to Unix domain sockets are controlled by *write*
> PE> access to the socket file.  Maybe Cygwin should change this.
>
> Hmm. Can you point to some references? What operations (socket(), bind(),
> connect(), accept()) will fail in case of
> 1) r-- access
> 2) -w- access
> 3) rw- access
> to socket file?

If there's no 'w' then connect() will fail with ECONNREFUSED on Linux 2.2.
(At least this is what PostgreSQL tells me, I didn't bother tracking it
down at the source level.)  Note that the glibc documentation until
recently claimed that read permission was what mattered, but this was
never the case and has been removed after I pointed it out.  (This tells
you how well known this actually is.)  Unfortunately, now it doesn't say
anything about this.

FreeBSD 4.3's connect(2) man page documents EACCESS as the error code if
"Write access to the named socket is denied."

On Solaris 8, connect(3XNET) says

"The connect() function may fail if:

    EACCES    Search permission is denied for a component of the path
              prefix; or write access to the named socket is denied."

On Irix 6.5, unix(7F) has

: Normal filesystem
: access-control mechanisms are also applied when referencing pathnames;
: e.g., the destination of a connect(2) or sendto(2) must be writable.

And last but not least, The Single UNIX Â® Specification, Version 2
(a.k.a., Unix98):

"The connect() function may fail if:

      [EACCES]
            Search permission is denied for a component of the path
            prefix; or write access to the named socket is denied."

(Hmm, somebody was copying here.)

-- 
Peter Eisentraut      peter_e@gmx.net       http://yi.org/peter-e/
