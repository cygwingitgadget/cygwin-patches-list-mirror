From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: Re: Set argv[0] in the win32 style for non-Cygwin applications.
Date: Wed, 27 Sep 2000 06:32:00 -0000
Message-id: <s1sg0mmgduk.fsf@jaist.ac.jp>
References: <s1sog1chnr4.fsf@jaist.ac.jp> <20000925112318.A9745@cygnus.com>
X-SW-Source: 2000-q3/msg00101.html

>>> On Mon, 25 Sep 2000 11:23:19 -0400
>>> Chris Faylor <cgf@cygnus.com> said:

> This is a good idea (and I think the code used to do this) but it should
> probably just always force the first argument into Windows format.  A cygwin
> app will always use the argv array and a non-cygwin app will always use the
> argument list, so...

I misunderstood how the iscygexec method works. I believed it
should examine whether a file is a cygwin app. I expected too
much of it without reading the code. It isn't so easy.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
