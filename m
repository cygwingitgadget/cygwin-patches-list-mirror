From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygpatch <cygwin-patches@sources.redhat.com>
Subject: Re: preliminary patch3 for i18n: eliminate calls to wcstombs.
Date: Fri, 21 Jul 2000 15:14:00 -0000
Message-id: <s1sittz3ze0.fsf@jaist.ac.jp>
References: <s1sn1jb45yi.fsf@jaist.ac.jp> <20000721155529.B26237@cygnus.com> <3978B222.BFBF3CA8@cygnus.com>
X-SW-Source: 2000-q3/msg00025.html

>>> On Fri, 21 Jul 2000 22:27:14 +0200
>>> Corinna Vinschen <vinschen@cygnus.com> said:

> However, using defines instead of the `magic' 256 is definitely a
> good idea.

We can use MAX_PATH as the largest number among MAX_PATH,
MAX_HOST_NAME+2, MAX_COMPUTER_NAME+MAX_USER_NAME+3; and allocate
`buf' only once. Do you prefer to do so?
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
