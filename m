From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 19 Dec 2001 04:27:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKAEPOCHAA.g.r.vansickle@worldnet.att.net>
References: <040a01c18880$877afbe0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00337.html
Message-ID: <20011219042700.q7SBk5hO9TzI93Ks0d4xj4SLjoHsLWgouVWsJTyrKWY@z>

> From: cygwin-patches-owner@cygwin.com
> [ mailto:cygwin-patches-owner@cygwin.com]On Behalf Of Robert Collins
> Sent: Wednesday, December 19, 2001 5:30 AM
> To: Gary R. Van Sickle; cygwin-patches@sourceware.cygnus.com
> Subject: Re: [PATCH] Update - Setup.exe property sheet patch, properly
> diffed.
>
>
> Ok, I'll get nitty-gritty now.
>
> ChangeLog presentation:
> :The changelog is formatted wrongly - you have extra lines.
> :When you have
> (foo): Did bar.
> (foo): Did barf.
> write it as
> (foo): Did bar.
> Did barf.

I see one instance of that, is that correct?

> :in the main entry you have a tab halfway through the line
>

Not any more. ;-)

> Regarding the patch:
> :Please remove the #if 0'd items. If its a mistake to remove them, then
> we can get them back from CVS.

Alright.

> :Please remove your package_meta.h (sdesc) workaround. It's not the
> right answer. (We can discuss what is instead if you like).

Alright.  I see that upset or whatever's feeding it has been fixed, so that
should no longer be necessary for what I'm concentrating on right now.

> :lets assume that chooser will subsume choose, can you please make the
> changes direct to choose. (I don't really want a short lived migration
> file - it seems pointless). (remember - CVS is smart). If you think
> there really will be two classes for this (other than the working inside
> classes) then leave it as is.
>

Like I said, I don't know what the answer to this one is.  I do know that simply
putting choose in the property sheet will make all the other pages ridiculously
huge (they all end up being the size of the biggest one), and is not an option
because of that.  If the sheet can be resized programmatically on Win95 on, I
can put it in and adjust it that way (which I think would be the best solution),
but if not we'll need the two sheets, one basically as a "filler" (as I have it
now).  But even if the first way is possible, we're talking considerably more
time and work.  What I've got now works at least as good as it did before WRT
the chooser, so I see no reason for this to hold up the rest of the changes.
And you've already taken me to task on the size and scope of this patch ;-).

> Cheers,
> Rob
>

--
Gary R. Van Sickle
Brewer.  Patriot.
