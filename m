From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Mon, 31 Dec 2001 03:06:00 -0000
Message-ID: <006f01c191eb$24df7190$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKOECACIAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00368.html
Message-ID: <20011231030600.W48zDBVCG6n2RXFsOPDSpEDvFXp7AWCfNhkh1QF7f1s@z>

----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
> Ah, ok.  If you already hadn't noticed, indent's "Midas Touch" is
doing that to
> me in every file I send to you (dives for cover ;-)).

:] Lol.

> Actually, it looks like it's not just me either; take a look at this
from
> log.cc/log_save:
>
> This may or may not look OK to you, but what's happening is that it's
mixing
> tabs and spaces for some reason: "for" is spaced, "if" is tabbed.
With tabs==4
> spaces, they'll line right up.

Hmm, For me indent replaces 8 spaces with a tab. I believe thats the
default in the absence of environment and command line options.

> "Here" being indent 2.2.7 on Linux, or on Cygwin?  I just changed my
Cygwin

Cygwin. I've never observed a difference between linux and cygwin indent
to date.

> I'll copy this to the cygwin list in the hope it will help Charles and
anybody
> else struggling with this.
> >
>
> Without thinking about it too hard, this sounds both very cool and a
potential
> nightmare.  What happens if a "malicious mirror" somehow makes it onto
the
> distributed list and starts spreading trojans or something?

MD5 package verification + GPG signing by the maintainer would solve
that :}. And yes that's in my master plan, but it needs careful thought,
and plenty of cygwin-apps discussion first. Also, the malicious mirror
scenario is present today - via mirrors.lst. If the distributed
setup.ini's containing mirrors is seen as a serious problem (in the
interim absence of the signing solution) then we can simply have the
cached mirror list refreshed from the sources.redhat site every x days.
Please note that if any official mirror were to diddle setup.ini's
mirror list, then they could just replace packages with trojans anyway.

> > As far as UI goes, I think the combobox + a text box for the new
site is
> > fine. But rather than a radio button to choose which is used, have
an
> > Add button to the right of the textbox, and also make Enter in the
> > textbox trigger an add. Remove can be done by a button 'Delete
selected
> > sites' that does just that.
> >
>
> Yeah, that's what I'm thinking (and working on) right now.  How about
an "Are
> you sure you want to add <Insert URL here>?" MessageBox at least until
"Remove"
> is implemented (assuming "Remove" is more work than I want to do for
this
> patch)?

Nyahh. Don't bother - that list could handle many many garbage entries
without giving the user trouble.

Rob
