From: egor duda <deo@logos-m.ru>
To: Jason Tishler <Jason.Tishler@dothill.com>
Cc: cygwin-patches@cygwin.com, Peter Eisentraut <peter_e@gmx.net>, Pgsql-Ports <pgsql-ports@postgresql.org>
Subject: Re: improving security of AF_UNIX sockets
Date: Fri, 13 Apr 2001 10:27:00 -0000
Message-id: <117633548304.20010413212702@logos-m.ru>
References: <198204047314.20010404220250@logos-m.ru> <20010413112338.N212@dothill.com>
X-SW-Source: 2001-q2/msg00054.html

Hi!

Friday, 13 April, 2001 Jason Tishler Jason.Tishler@dothill.com wrote:

JT> On Wed, Apr 04, 2001 at 10:02:50PM +0400, egor duda wrote:
>>   this patch prevents local users from connecting to cygwin-emulated
>> AF_UNIX socket if this user have no read rights on socket's file.
>> it's done by adding 128-bit random secret cookie to !<socket>port
>> string in file. later, each processes which is negotiating connection
>> via connect() or accept() must signal its peer that it knows this
>> secret cookie.
>> 
>> sendto() and recvfrom() are still insecure, unfortunately.
>> 
>> Comments?

JT> I have tried the above with PostgreSQL and it works as documented.

Actually, before this patch it already worked the same way. At
least for programs that use legitimate socket APIs, nothing should
have been changed. if user tries to open AF_UNIX socket he hasn't
access to, via normal cygwin socket() call, cygwin1.dll returns
EACCESS. It is so for a long time already.

this patch is supposed to prevent malicious local user to connect to
inet socket used for AF_UNIX socket emulation. just run some program
that accept()s on AF_UNIX socket and run 'netstat -a'. You'll see
that new LISTEN'ing port appeared. it's AF_INET socket used for
AF_UNIX socket emulation. Before the patch you could telnet to this
port, perform read and writes even if you don't have access to AF_UNIX
socket file. Sometimes (ssh-agent is a good example), this can
lead to security compromise.

JT> However, see the attached for a comment from one of the PostgreSQL
JT> core developers.

Peter Eisentraut wrote:
PE> Jason Tishler writes:
>> I used 7.1rc4 from Cygwin's contrib and everything seems to work as
>> expected.  The regression tests all passed.  Even the enhanced AF_UNIX
>> security worked as advertised.  If the client (i.e., psql) has read
>> access to the socket file (i.e., /tmp/.s.PGSQL.5432), then it can connect
>> to postmaster.  Otherwise, the client gets a "Permission denied" failure.

PE> Actually, connections to Unix domain sockets are controlled by *write*
PE> access to the socket file.  Maybe Cygwin should change this.

Hmm. Can you point to some references? What operations (socket(), bind(),
connect(), accept()) will fail in case of
1) r-- access
2) -w- access
3) rw- access
to socket file?

JT> Is it possible and/or does it make sense to do as suggested?

Well, i'll try to think it over. References/suggestions as for
implementation of those references/comments are welcome.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

