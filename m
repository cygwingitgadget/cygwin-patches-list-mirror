From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Outstanding issues with current DLL?
Date: Mon, 19 Mar 2001 10:10:00 -0000
Message-id: <20010319131048.I18807@redhat.com>
References: <3AA7E05A.BF9F2535@yahoo.com> <20010310184508.A16745@redhat.com> <3AAFF6E9.DFBF2C8@yahoo.com> <20010317180414.A22971@redhat.com> <115297467.20010318180906@logos-m.ru> <20010318121519.F12880@redhat.com> <437795639.20010318203634@logos-m.ru> <20010318124713.L12880@redhat.com> <639192998.20010318205951@logos-m.ru> <16776811979.20010319205814@logos-m.ru>
X-SW-Source: 2001-q1/msg00212.html

On Mon, Mar 19, 2001 at 08:58:14PM +0300, Egor Duda wrote:
>Hi!
>
>Sunday, 18 March, 2001 Egor Duda deo@logos-m.ru wrote:
>
>ED> Sunday, 18 March, 2001 Christopher Faylor cgf@redhat.com wrote:
>CF>> So, rxvt tries to exit but hangs waiting for bash to go away -- which
>CF>> it never does?  I would have thought that the closing of the parent
>CF>> pty would cause bash to disappear.
>
>ED> ah,  i  see  now.  this  indeed looks like a bug in my code. before my
>ED> patches,  process  which  reads from slave tty polled the pipe, so, it
>ED> saw  when  pipe  from master to slave is abandoned, and send SIGHUP to
>ED> itself. now it's not the case. i think i know how to fix it.
>
>Here's the patch. I think it solves rxvt-close-with-X-button problem.

Looks good. Please check this in.

cgf
