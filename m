From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 19 Dec 2001 15:11:00 -0000
Message-ID: <071201c188e2$713045e0$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKAEPOCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00338.html
Message-ID: <20011219151100.MmJSOeZheqWhH_mSQBOu49hWuPc54x8ac8o_jSgMinQ@z>

===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Wednesday, December 19, 2001 11:20 PM
Subject: RE: [PATCH] Update - Setup.exe property sheet patch, properly
diffed.
> > :lets assume that chooser will subsume choose, can you please make
the
> > changes direct to choose. (I don't really want a short lived
migration
> > file - it seems pointless). (remember - CVS is smart). If you think
> > there really will be two classes for this (other than the working
inside
> > classes) then leave it as is.
> >
>
> Like I said, I don't know what the answer to this one is.  I do know
that simply
> putting choose in the property sheet will make all the other pages
ridiculously
> huge (they all end up being the size of the biggest one), and is not
an option
> because of that.  If the sheet can be resized programmatically on
Win95 on, I
> can put it in and adjust it that way (which I think would be the best
solution),
> but if not we'll need the two sheets, one basically as a "filler" (as
I have it
> now).  But even if the first way is possible, we're talking
considerably more
> time and work.  What I've got now works at least as good as it did
before WRT
> the chooser, so I see no reason for this to hold up the rest of the
changes.
> And you've already taken me to task on the size and scope of this
patch ;-).

Ok. Well correct me if I'm wrong but the current chooser.h does the
following:
it's a property page of the main window
it call do_chooser.

That's it (high level). All I'm suggesting is that until we know that we
will need a separate chooser (ie we won't just move choose.cc's contents
to chooser.cc) lets just do those two things in choose.cc.

That way if we do need a separate file later, it's not a problem.

I'm not religious on this, which is why I passed the decision to you -
but it sounds like the jury is still out for you as well.

Rob
