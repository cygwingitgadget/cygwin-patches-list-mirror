From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: Re: a weird behavior on a command prompt.
Date: Wed, 13 Sep 2000 17:50:00 -0000
Message-id: <s1swvgfiys4.fsf@jaist.ac.jp>
References: <s1s66o0jnd3.fsf@jaist.ac.jp> <20000913142841.C17331@cygnus.com> <s1s3dj4je7c.fsf@jaist.ac.jp> <20000913155221.A26441@cygnus.com> <s1szolchw0p.fsf@jaist.ac.jp> <200009132036.QAA29721@envy.delorie.com>
X-SW-Source: 2000-q3/msg00090.html

>>> On Wed, 13 Sep 2000 16:36:12 -0400
>>> DJ Delorie <dj@delorie.com> said:

> It's entirely predictable in cygwin, because we know we'll be using
> the strcpy from newlib.

I've guessed cygwin uses the builtin strcpy from gcc.
Anyway, we can specify the implementation of strcpy,
so it's certainly predictable.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
