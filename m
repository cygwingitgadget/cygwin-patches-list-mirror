From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: accept() failed message on kde 1.1.2 ??
Date: Mon, 18 Jun 2001 18:58:00 -0000
Message-id: <20010618215925.A25668@redhat.com>
References: <001501c0f802$79fdc0b0$6e032bb7@BRAMSCHE> <100357399493.20010618190112@logos-m.ru> <78364396524.20010618205749@logos-m.ru>
X-SW-Source: 2001-q2/msg00319.html

On Mon, Jun 18, 2001 at 08:57:49PM +0400, egor duda wrote:
>Hi!
>
>ed> i'd try to figure out some way to fix it.
>
>i think this patch will do.  i still have some reservations about
>non-blocking sockets, but it should definitely help with XFree problems
>Ralf and Robert reported.  Please give it a try and tell if it helps.

Do you want to check this in, Egor?  I didn't look at it enough to
understand what was going on but I trust your judgement.  You can consider
yourself the maintainer of this code if you want.  That means you don't
need my approval to check stuff in there.

I would appreciate a heads up if you are doing anything major, though.

cgf
