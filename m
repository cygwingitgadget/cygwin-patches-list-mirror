From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Console codepage
Date: Thu, 01 Feb 2001 12:05:00 -0000
Message-id: <s1sitmu890d.fsf@jaist.ac.jp>
References: <u7l3fv26h.fsf@mail.epost.de> <20010128154852.A20701@redhat.com>
X-SW-Source: 2001-q1/msg00046.html

>>> On Sun, 28 Jan 2001 15:48:52 -0500
>>> Christopher Faylor <cgf@redhat.com> said:

> I can't comment on the validity of the patch itself.  I hope that Egor
> or Kazuhiro will do that.

His patch seems fine to me except for its potential overhead.
I'm afraid the overhead becomes sensible on cheap Win9x boxes.
Console APIs are generally slower on 9x than on NT/2000.
Anyway, I believe his patch is essential for users using 8bit
characters.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
