From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: accept() failed message on kde 1.1.2 ??
Date: Tue, 19 Jun 2001 07:28:00 -0000
Message-id: <1484452882.20010619182637@logos-m.ru>
References: <001501c0f802$79fdc0b0$6e032bb7@BRAMSCHE> <100357399493.20010618190112@logos-m.ru> <78364396524.20010618205749@logos-m.ru> <20010618215925.A25668@redhat.com>
X-SW-Source: 2001-q2/msg00320.html

Hi!

Tuesday, 19 June, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> On Mon, Jun 18, 2001 at 08:57:49PM +0400, egor duda wrote:
>>i think this patch will do.  i still have some reservations about
>>non-blocking sockets, but it should definitely help with XFree problems
>>Ralf and Robert reported.  Please give it a try and tell if it helps.

CF> Do you want to check this in, Egor?  I didn't look at it enough to
CF> understand what was going on but I trust your judgement.  You can consider
CF> yourself the maintainer of this code if you want.  That means you don't
CF> need my approval to check stuff in there.

ok. since i don't have installed XFree, i'd like to get confirmation
from Ralf and Robert first. if this patch fixes those problems they've
seen, i check it in.

CF> I would appreciate a heads up if you are doing anything major, though.

of course.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
