From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: chroot("/") can't work.
Date: Wed, 29 Nov 2000 13:28:00 -0000
Message-id: <s1s1yvusc27.fsf@jaist.ac.jp>
References: <20001129131743.15031.qmail@web117.yahoomail.com>
X-SW-Source: 2000-q4/msg00027.html

>>> On Wed, 29 Nov 2000 05:17:43 -0800 (PST)
>>> Earnie Boyd <earnie_boyd@yahoo.com> said:

> Is this patch so that you can do `chroot /'?  Why would you want to do that?
> Cheers,

The current implementation of chroot sets '/' as the root dir
against chroot("/"). It causes `//usr' by `/usr'. It must set an
empty string as the root dir in the same way as the previous
implementation.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
