From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 19 Dec 2001 03:30:00 -0000
Message-ID: <040a01c18880$877afbe0$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKOEPMCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00336.html
Message-ID: <20011219033000.kNPaWFjU703SpY4LM88wGL_AeXvawXH5ZTHzy5ixIL8@z>

Ok, I'll get nitty-gritty now.

ChangeLog presentation:
:The changelog is formatted wrongly - you have extra lines.
:When you have
(foo): Did bar.
(foo): Did barf.
write it as
(foo): Did bar.
Did barf.
:in the main entry you have a tab halfway through the line

Regarding the patch:
:Please remove the #if 0'd items. If its a mistake to remove them, then
we can get them back from CVS.
:Please remove your package_meta.h (sdesc) workaround. It's not the
right answer. (We can discuss what is instead if you like).
:lets assume that chooser will subsume choose, can you please make the
changes direct to choose. (I don't really want a short lived migration
file - it seems pointless). (remember - CVS is smart). If you think
there really will be two classes for this (other than the working inside
classes) then leave it as is.

Cheers,
Rob
