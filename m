From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cut and paste problem with cygwin 1.3.1
Date: Thu, 26 Apr 2001 11:20:00 -0000
Message-id: <20010426142044.B6609@redhat.com>
References: <3AE76EC4.EF0FFA66@lucent.com> <20010425222146.D3536@redhat.com> <3AE79346.6E761199@bbn.com> <20010425232756.A4338@redhat.com> <33191091635.20010426165929@logos-m.ru>
X-SW-Source: 2001-q2/msg00168.html

If you've reproduced it and this patch fixes it, then please check
this in.

I wonder why I can't duplicate it...

cgf

On Thu, Apr 26, 2001 at 04:59:29PM +0400, egor duda wrote:
>Hi!
>
>Thursday, 26 April, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>>>> I tried both CYGWIN=tty and CYGWIN=notty and had similar experiences with
>>>> both.
>>>
>>>Cat worked for me as well.  vi on the other hand froze up when I tried
>>>pasting more than three lines.  I think I was able to paste larger
>>>quantities to vi before.
>
>CF> No problems with vi, either.
>
>i've reproduced it. it looks like bug in my tty_slave changes. hope
>this patch helps.
>
>2001-04-26  Egor Duda  <deo@logos-m.ru>
>
>        * tty.cc (tty::make_pipes): Set to_slave pipe mode to non-blocking.
>        * fhandler_tty.cc (fhandler_pty_master::accept_input): If pipe buffer
>        is full, give slave a chance to read data.
>
>Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19



-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
