From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gareth Pearce" <tilps@hotmail.com>, <cygwin-patches@cygwin.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Fri, 09 Nov 2001 15:25:00 -0000
Message-id: <01f401c16975$ffdc43c0$0200a8c0@lifelesswks>
References: <F255rNNOCTlI2N76PQ400005c19@hotmail.com>
X-SW-Source: 2001-q4/msg00179.html

----- Original Message -----
From: "Gareth Pearce" <tilps@hotmail.com>
> >
>
> Would have submited another go ... but what you have done looks great
(A
> more significant change then I would have submited, but then I am in
newbie
> cautious mode), and I am in the middle of a 336meg download of debian
> unstable updates on a slow modem... (dual boot system so no windows
for the
> next day or 2 for me...) - the trials of being too busy to run apt-get
> upgrade for a couple of months...

Debian rocks doesn't it :]. However my patch never gets triggered by the
state machine, so it doesn't work. (Thus my 'potential' comment in the
changelog).

AFAICT reason that happens is that the installed info, and thus
installed_ix is TRUST_UNKNOWN. I'm really not sure what to do to get it
to allow 'keep'. So I'm going to back out my patch, and put your older
one in - I'll live with the inevitable 'why does it show skip and not
keep for package foo'.

Rob
