From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: chroot("/") can't work.
Date: Wed, 29 Nov 2000 14:12:00 -0000
Message-id: <s1szoiiqvgg.fsf@jaist.ac.jp>
References: <20001129131743.15031.qmail@web117.yahoomail.com> <s1s1yvusc27.fsf@jaist.ac.jp> <3A2577EE.14D8EBFB@redhat.com>
X-SW-Source: 2000-q4/msg00029.html

>>> On Wed, 29 Nov 2000 22:41:02 +0100
>>> Corinna Vinschen <vinschen@redhat.com> said:

> If it's possible to set root to an empty string by calling
> chroot("/") this could result in the ability to break out of the
> chroot environment. This is not ok. But, hmm, this shouldn't
> be possible... 

If cyg_root has been set other than an empty string, chroot("/")
can't set it to an empty string.  The argument is processed by
normalize_posix_path.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
