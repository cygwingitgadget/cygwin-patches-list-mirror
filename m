From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 19 Dec 2001 19:31:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKMEAECIAA.g.r.vansickle@worldnet.att.net>
References: <071201c188e2$713045e0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00339.html
Message-ID: <20011219193100.VbI8ocjbS33CuqYilrnbVTYTY-TU6j-hQyfrbMncUjA@z>

[snip]

> Ok. Well correct me if I'm wrong but the current chooser.h does the
> following:
> it's a property page of the main window
> it call do_chooser.
>
> That's it (high level). All I'm suggesting is that until we know that we
> will need a separate chooser (ie we won't just move choose.cc's contents
> to chooser.cc) lets just do those two things in choose.cc.
>
> That way if we do need a separate file later, it's not a problem.
>
> I'm not religious on this, which is why I passed the decision to you -
> but it sounds like the jury is still out for you as well.
>
> Rob

Ah, OK, I almost completely misunderstood you there.  Makes sense now; will do
barring any unforseen craziness, which I don't forsee.

--
Gary R. Van Sickle
Brewer.  Patriot.
