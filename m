From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: gethostbyname/gethostbyaddr patch
Date: Thu, 23 Aug 2001 13:17:00 -0000
Message-id: <20010823161736.A1556@dothill.com>
X-SW-Source: 2001-q3/msg00084.html

The following patch:

    http://www.cygwin.com/ml/cygwin-cvs/2001-q3/msg00100.html

broke gethostbyname() and gethostbyaddr() when the IP address contains
zero components.  For example, my mail server is 24.0.95.227.  When I
connect to it with a Cygwin app, the address actually used is 24.0.0.0.

The root cause is that dup_char_list() does not handle embedded null
characters.  The attached patch is one way to correct this problem.

Jason
