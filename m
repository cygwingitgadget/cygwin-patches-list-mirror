From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Cc: Markus Hoenicka <Markus.Hoenicka@uth.tmc.edu>
Subject: AF_UNIX relaxed security patch
Date: Thu, 16 Aug 2001 07:07:00 -0000
Message-id: <20010816100724.B288@dothill.com>
X-SW-Source: 2001-q3/msg00082.html

I believe that the following patch:

    http://www.cygwin.com/ml/cygwin-cvs/2001-q3/msg00056.html

and specifically this portion:

    http://sources.redhat.com/cgi-bin/cvsweb.cgi/winsup/cygwin/fhandler_socket.cc.diff?cvsroot=uberbaum&r1=1.12&r2=1.13

is preventing PostgreSQL AF_UNIX socket clients from being able to
connect to postmaster when it is running under a different user account.

This lead to the following bug report on the Cygwin mailing list:

    http://sources.redhat.com/ml/cygwin/2001-08/msg00018.html

The attached patch relaxes the security so that this problem is mitigated.
However, I admit to not fully grokking the security ramification of
my change.  Did I open up access to secret_event too much?  Is there a
better way to fix this problem?

Thanks,
Jason
