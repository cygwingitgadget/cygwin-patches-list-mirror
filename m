From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: poll() patch
Date: Fri, 07 Sep 2001 08:01:00 -0000
Message-id: <20010907110236.A788@dothill.com>
X-SW-Source: 2001-q3/msg00109.html

The attached patch prevents Cygwin from hanging in poll() (well really
select) when only invalid file descriptors are specified.  With the
patch applied, Cygwin's poll() now behaves the same as the one on Red
Hat 7.1 Linux.

The third attachment is a small test program that demonstrates the
problem.

For those interested in Python, this was the root cause to the test_poll
hang.

Thanks,
Jason
