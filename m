From: Tom Lane <tgl@sss.pgh.pa.us>
To: Peter Eisentraut <peter_e@gmx.net>
Cc: egor duda <cygwin-patches@cygwin.com>, Jason Tishler <Jason.Tishler@dothill.com>, Pgsql-Ports <pgsql-ports@postgresql.org>
Subject: Re: [PORTS] Re: improving security of AF_UNIX sockets 
Date: Fri, 13 Apr 2001 20:17:00 -0000
Message-id: <12628.987218220@sss.pgh.pa.us>
References: <Pine.LNX.4.30.0104140350200.945-100000@peter.localdomain>
X-SW-Source: 2001-q2/msg00060.html

Peter Eisentraut <peter_e@gmx.net> writes:
> If there's no 'w' then connect() will fail with ECONNREFUSED on Linux 2.2.
> [ and several other systems document EACCES as the error code ]

FWIW: HPUX 10.20 doesn't document this error condition at all on the
connect(2) man page, but some quick experimentation shows that indeed
write access to the socket is necessary and sufficient to make a
connection.  (And EACCES is what you get if you ain't got it.)

			regards, tom lane
