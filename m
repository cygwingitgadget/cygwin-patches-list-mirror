From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Tue, 26 Jun 2001 22:20:00 -0000
Message-id: <20010627012107.H19058@redhat.com>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com> <s1sr8w64yoq.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00345.html

On Wed, Jun 27, 2001 at 08:19:01AM +0900, Kazuhiro Fujieda wrote:
>>>> On Tue, 26 Jun 2001 10:49:09 -0400
>>>> Christopher Faylor <cgf@redhat.com> said:
>
>> I don't think it is appropriate to detach the console after a call to
>> setsid().  I have tested this on UNIX recently and I believe that a
>> program can continue to write to a tty after calling setsid().
>
>Yes, you are right. But almost all programs calling setsid() try to
>become daemons, so close their tty before calling setsid() and don't
>write them tty anymore.

I ran into a program the other day that was not a daemon and still
assumed that it could write to the tty.

>Anyway, should I add some more code checking whether a program close
>its tty before detaching the console? Or find out another timing 
>detaching the console?

I don't think that there is any simple heuristic for doing this but
I suppose that if you walk the fd table and find no open console handles
that it would be safe to detach the console after a setsid().

cgf
