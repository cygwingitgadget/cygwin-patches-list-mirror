From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Wed, 27 Jun 2001 04:17:00 -0000
Message-id: <s1su212yxwm.fsf@jaist.ac.jp>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com> <s1sr8w64yoq.fsf@jaist.ac.jp> <20010627012107.H19058@redhat.com>
X-SW-Source: 2001-q2/msg00348.html

>>> On Wed, 27 Jun 2001 01:21:07 -0400
>>> Christopher Faylor <cgf@redhat.com> said:

> I don't think that there is any simple heuristic for doing this but
> I suppose that if you walk the fd table and find no open console handles
> that it would be safe to detach the console after a setsid().

I tried writing such code, but it made sshd unable to detach the
console. Sshd call setsid() before closing the tty. I will try
to find out another way, sigh...
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
