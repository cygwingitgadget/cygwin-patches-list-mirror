From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, "Kazuhiro Fujieda" <fujieda@jaist.ac.jp>
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Wed, 27 Jun 2001 05:02:00 -0000
Message-id: <005301c0ff01$5430ac20$0400a8c0@local>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com> <s1sr8w64yoq.fsf@jaist.ac.jp> <20010627012107.H19058@redhat.com> <s1su212yxwm.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00349.html

perhaps a combination? If the last console handle closes and setsid() has
already been called, || if setsid has been called and then the last console
handle is closed.

Rob
----- Original Message -----
From: "Kazuhiro Fujieda" <fujieda@jaist.ac.jp>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, June 27, 2001 9:17 PM
Subject: Re: Make Cygwin damons easier to use on Win9x.


> >>> On Wed, 27 Jun 2001 01:21:07 -0400
> >>> Christopher Faylor <cgf@redhat.com> said:
>
> > I don't think that there is any simple heuristic for doing this but
> > I suppose that if you walk the fd table and find no open console handles
> > that it would be safe to detach the console after a setsid().
>
> I tried writing such code, but it made sshd unable to detach the
> console. Sshd call setsid() before closing the tty. I will try
> to find out another way, sigh...
> ____
>   | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>   | HOKURIKU  School of Information Science
> o_/ 1990      Japan Advanced Institute of Science and Technology
>
