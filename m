From: egor duda <deo@logos-m.ru>
To: Jason Tishler <jason@tishler.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: AF_UNIX relaxed security patch
Date: Thu, 16 Aug 2001 07:37:00 -0000
Message-id: <81251568256.20010816183433@logos-m.ru>
References: <20010816100724.B288@dothill.com>
X-SW-Source: 2001-q3/msg00083.html

Hi!

Thursday, 16 August, 2001 Jason Tishler jason@tishler.net wrote:

JT> I believe that the following patch:

JT>     http://www.cygwin.com/ml/cygwin-cvs/2001-q3/msg00056.html

JT> and specifically this portion:

JT>     http://sources.redhat.com/cgi-bin/cvsweb.cgi/winsup/cygwin/fhandler_socket.cc.diff?cvsroot=uberbaum&r1=1.12&r2=1.13

JT> is preventing PostgreSQL AF_UNIX socket clients from being able to
JT> connect to postmaster when it is running under a different user account.

JT> This lead to the following bug report on the Cygwin mailing list:

JT>     http://sources.redhat.com/ml/cygwin/2001-08/msg00018.html

JT> The attached patch relaxes the security so that this problem is mitigated.
JT> However, I admit to not fully grokking the security ramification of
JT> my change.  Did I open up access to secret_event too much?

no. security is provided by proper permissions on socket file and
randomness of event name. as long as some application _knows_ the name
of event, it should be able to signal it.

a bit more "pedantic" solution is to get security info from socket
file and apply it to event. But, iirc, under win32 one should have a
special permission to obtain security information.

JT>  Is there a better way to fix this problem?

i think this patch is correct. i've checked it in. Thanks for tracking
it down and fixing!

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
