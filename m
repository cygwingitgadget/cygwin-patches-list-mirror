From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gareth Pearce" <tilps@hotmail.com>, <cygwin-patches@cygwin.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Fri, 09 Nov 2001 15:44:00 -0000
Message-id: <024401c16978$b7c11180$0200a8c0@lifelesswks>
References: <F255rNNOCTlI2N76PQ400005c19@hotmail.com>
X-SW-Source: 2001-q4/msg00181.html

----- Original Message -----
From: "Gareth Pearce" <tilps@hotmail.com>
To: <robert.collins@itdomain.com.au>; <cygwin-patches@cygwin.com>


...
> Would have submited another go ... but what you have done looks great
(A
> more significant change then I would have submited, but then I am in
newbie
> cautious mode), and I am in the middle of a 336meg download of debian

I've put your patch into the categories branch, and into HEAD.

As for being cautious .... I'll accept any patch, big or small, that
a) is inline with the setup.exe goals. If in doubt the issue can be
discussed to it's death on cyg-apps.
b) is coded well. return values checked, snprintf instead of sprintf
etc.
c) is designed well (IOW doesn't make the internal maintenance harder).

I understand not wanting to spend a lot of time on a big patch, just to
get the patch rejected, so discussing the concept first on cyg-apps is
usually a good idea for non-obvious or structural work.

Rob
