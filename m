From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch for incorporating internationalizing facilities
Date: Wed, 28 Jun 2000 15:10:00 -0000
Message-id: <s1sn1k5o3t6.fsf@jaist.ac.jp>
References: <s1sr99ho8cf.fsf@jaist.ac.jp> <395A676F.F78E67A6@cygnus.com> <20000628171354.A31411@cygnus.com>
X-SW-Source: 2000-q2/msg00119.html

>>> On Wed, 28 Jun 2000 17:13:54 -0400
>>> Chris Faylor <cgf@cygnus.com> said:

> I don't understand the reason for using strtol rather than
> atoi either.

I have no reasonable reason.  The current implementation of
strtol uses locale-depend macros. I wanted to check where strtol
was used in Cygwin correctly before I dealt with this problem.
`atoi' disturbed my work at the time, so I hated it and replaced
it with `strtol'.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
