From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Tue, 26 Jun 2001 16:19:00 -0000
Message-id: <s1sr8w64yoq.fsf@jaist.ac.jp>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com>
X-SW-Source: 2001-q2/msg00344.html

>>> On Tue, 26 Jun 2001 10:49:09 -0400
>>> Christopher Faylor <cgf@redhat.com> said:

> I don't think it is appropriate to detach the console after a call to
> setsid().  I have tested this on UNIX recently and I believe that a
> program can continue to write to a tty after calling setsid().

Yes, you are right. But almost all programs calling setsid() try to
become daemons, so close their tty before calling setsid() and don't
write them tty anymore.

Anyway, should I add some more code checking whether a program close
its tty before detaching the console? Or find out another timing 
detaching the console?
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
