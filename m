From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Console codepage
Date: Wed, 07 Feb 2001 07:25:00 -0000
Message-id: <s1sr91a7bz2.fsf@jaist.ac.jp>
References: <u7l3fv26h.fsf@mail.epost.de> <20010128154852.A20701@redhat.com> <s1sitmu890d.fsf@jaist.ac.jp> <150109183687.20010207180613@logos-m.ru>
X-SW-Source: 2001-q1/msg00055.html

>>> On Wed, 7 Feb 2001 18:06:13 +0300
>>> Egor Duda <deo@logos-m.ru> said:

> i believe that console api on 9x is
> slow   not  because  of char<->unicode translation, but because of the
> way WriteFile() API works on consoles.

I'm worried about GetConsoleOutputCP() and GetConsoleCP(),
but I may be worrying unduly.
Chris, please check in the patch.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
