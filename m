From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: Serial programming
Date: Wed, 23 May 2001 07:51:00 -0000
Message-id: <20010523165125.Y10118@cygbert.vinschen.de>
References: <3B0BAE8D.EC08D1F8@certum.pl>
X-SW-Source: 2001-q2/msg00263.html

On Wed, May 23, 2001 at 02:35:25PM +0200, Jacek Trzcinski wrote:
> Hi,
> I have created patch to serial device which implements ioctl function
> allowing
> manipulate RTS and DTR line and reading modem lines. I will send it when
> I sign copyright
> assignment form.
> I didn't do two things in my patch about I would like discuss here.
> First remarks I shared
> with Corinna Vinschen and She suggested send e-mail here.
> 
> 1) To read input queue there should be use constant
> FIONREAD (information taken from different sources) but cygwin occupy it
> for
> socket software !(it is macro). Constant TIOCINQ I have taken from linux
> where it is equal FIONREAD(FIONREAD is not occupied in linux like in
> cygwin). As Corinna remarked, this macro
> expands to a constant expression but including asm/socket.h in serial
> programming seems to make not much sense. She suggested (I support her)
> to create asm/ioctls.h file like in Linux.

However, to be least intrusive we could also include <asm/socket.h>
in sys/termios.h to accomodate applications needs and to be able
to define TIOCINQ as FIONREAD. That doesn't look nice, though.

> 2) Next matter concerns device name convention. In cygwin one may use
> /dev/com1 or /dev/ttyS1 and so on. (what for is utilizing /dev/comx
> devices I do not
> know - it is not portable to linux).
> I think also that number of devices should start from 0 not from 1 thus
> devices shold be
> numbered /dev/ttyS0, /dev/ttyS1 and so on like in linux because again it
> is not portable.
> Somebody who had access to /dev/ttyS0 in linux will have not in cygwin !

I'm not quite sure about this point. A linux programmer has to port
his application anyway, but existing ported applications using
/dev/ttyS1,S2,... would suddenly break. I don't think it's worth
that.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
