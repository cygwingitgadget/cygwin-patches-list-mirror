From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Sun, 30 Dec 2001 19:28:00 -0000
Message-ID: <0a2c01c191ab$3629f8c0$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKAECACIAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00366.html
Message-ID: <20011230192800.KeIMH0IWq5nD2k1CY0JKicZo3DrODthsUzhxBHdFW4M@z>

----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>


>
> site.cc as sent has definitely been run through indent.  It's not
generating the
> "every line is different" problem, and looks fine to the unaided eye.
What's
> not formatted correctly?  There *are* a very large number of additions
and legit
> changes - are you perhaps saying site.cc when you mean window.{cc,h},
which have
> the "every line though identical is different to CVS" problem?

No, I mean site.cc. At the top in save_dialog, there is a new if
construct you've added, and at the end of it is visible
    }
    }

(thats two  curly brackets at the same indent). Where you added the if,
the body thereof hasn't been indented. Running it through indent here
fixed it.

> Yeah.  Well, I would expect templates to cause it choke worse than
this
> actually; there was a time not very long ago when indent usually
generated
> uncompilable C++, even when thrown relatively few curves.

:].

> Like the ChangeLog entry indicates, this is just another small step
towards
> internationalization of the entire app.  TCHAR et al allows that to be
done
> incrementally instead of en masse (somebody at MS must have been
asleep at the
> switch to have gotten that right! ;-)).

Thank you.

> > 2) I don't like what you've done with the 'user URL'. The current
> > implementation allows the user to add 'n' arbitrary URL's, and merge
> > them with the downloaded list. I like the idea of combining the
windows,
> > but the capabilities must stay the same as they are now. (ie on the
> > current CVS code, each time you click on 'other' the new URL is
added to
> > the list, and added to the select URL's.).
>
> It actually still behaves in that same way, but right, it doesn't look
like it,
> nor did I really grasp that that was how it was intended to work.  I
think we
> need both "Add" and "Remove" in that case though.

Eventually, sure. For now, just adding the new URL will do, 'cause the
user can always CTRL-click to deselect any mistaken entries.

> > IOW it's not a boolean
> > user-or-offical choice, it's purely a list of URLs that are known
about
> > and a list of select URL's. The source of the URL is irrelevant.
>
> Well, the list of "known-about" URLs is definitely a two-part thing
though: the
> ones that get downloaded fresh every time you run setup, and the ones
that the
> user added, which I presume would be persistent across runs.  The
first wouldn't
> presumably be subject to "Remove", while the second would pretty much
require
> it, and we'd need to have some way to inform the user of the
difference
> (different colors in the same list box perhaps?).  I'll think on this,
but I get
> your drift - the combo box and radio buttons aren't an appropriate UI
for the
> intended functionality.  Shoot.

The ones that are downloaded fresh will eventually not get downloaded.
See README - it's in there.
Long term what will happen is:
1) A new user downloads the mirror.lst to bootstrap their local list.
2) Special sites - like sources.redhat.com are trimmed.
3) The user adds any sites.
4) The known list is stored on disk, as well as the users selections.
5) The user does an install/download, and _setup.ini_ contains an
additional list of known mirror sites, (and potentially a list of known
dead sites) that gets merged into the known list.
6) On subsequent runs 1) is skipped.

At the moment, 2,3,4 (minus storing the known list) are complete. I
don't see any point in indicating the difference in the list. Think of
apt, or rpm-find. The user should be able to do _anything_ they want to
that list. Remove ALL the sites if they desire (although setup.ini
contained ones would repopulate every run).

As far as UI goes, I think the combobox + a text box for the new site is
fine. But rather than a radio button to choose which is used, have an
Add button to the right of the textbox, and also make Enter in the
textbox trigger an add. Remove can be done by a button 'Delete selected
sites' that does just that.

Rob
