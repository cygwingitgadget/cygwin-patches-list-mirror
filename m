From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Wed, 18 Jul 2001 05:34:00 -0000
Message-id: <s1szoa24dro.fsf@jaist.ac.jp>
References: <20010717221042.A426@dothill.com> <20010718130154.E730@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00017.html

>>> On Wed, 18 Jul 2001 13:01:54 +0200
>>> Corinna Vinschen <cygwin-patches@cygwin.com> said:

> All: Would that be ok to change or would you like to keep the current
>      behaviour?

I'd like to keep the current behaviour.  I know some UNIX
applications unlink temporary files just after open to ensure
that their disk space are reclimed when the processes terminate.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  Center for Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
