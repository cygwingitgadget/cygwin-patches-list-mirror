From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-developers@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 19:28:00 -0000
Message-id: <03be01c1010c$bb97af00$806410ac@local>
References: <06a001c0fc51$7a87e210$0200a8c0@lifelesswks> <20010629114004.A6990@redhat.com> <VA.00000842.01fd0b44@thesoftwaresource.com> <20010629172912.A8991@redhat.com> <032001c100fe$d62310c0$806410ac@local> <20010629205735.K9607@redhat.com> <034701c10106$34f6b6e0$806410ac@local> <036501c10108$b55383c0$806410ac@local> <20010629221309.A11334@redhat.com> <038301c1010a$bab7e840$806410ac@local> <20010629222604.A11444@redhat.com>
X-SW-Source: 2001-q2/msg00379.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
d
> >apply those again. (ie cvs rdiff -r 2.33 -r 2.35 choose.cc )
>
> I'd tried that (or cvs diff, actually).  There are a lot of rejections
> when I do that.

Yeah, things have moved up and down a bit :].

> Do you know the revisions of the files that you had in your sandbox?  I
> had done checkins to two files on 2001-06-25.  I assume that you were
> probably up-to-date with the 2001-06-17 versions of those files
previously,
> right?

I was fully up to date barring the last two checking. (When I merged I got
two new changelog entries. I checked in 2.36 of choose.cc, thus I had 2.33
intact, and got 2.34 and 2.35 merged in badly.

my just sent patch misses a couple of changes, I'm just sorting those out
for you now.

> cgf
>
