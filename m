From: Matt <matt@use.net>
To: <cygwin-patches@sources.redhat.com>
Subject: cinstall Makefile.in patch
Date: Wed, 09 May 2001 01:34:00 -0000
Message-id: <Pine.NEB.4.30.0105090130300.18125-200000@cesium.clock.org>
X-SW-Source: 2001-q2/msg00207.html

2001-05-09  Matt Hargett <matt@use.net>

	* Makefile.in: Remove *.rc from clean.


--

Doing a make clean in the cinstall directory removed res.rc, which must
then be checked out again. I thought this was fixed before?


--
http://www.clock.org/~matt
