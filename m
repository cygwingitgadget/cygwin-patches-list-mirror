From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jan Nieuwenhuizen" <janneke@gnu.org>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Sat, 15 Dec 2001 23:40:00 -0000
Message-ID: <105201c18604$ea001670$0200a8c0@lifelesswks>
References: <m3bshtmxhb.fsf@appel.lilypond.org> <878764062.20011128173421@nyckelpiga.de> <m37ks9lgxi.fsf@appel.lilypond.org> <4434079433.20011129221637@familiehaase.de> <m3oflgy98n.fsf@appel.lilypond.org> <9517228633.20011203135833@familiehaase.de> <m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu> <m33d2pam3l.fsf@appel.lilypond.org> <00d501c17d93$1936c990$0200a8c0@lifelesswks> <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org>
X-SW-Source: 2001-q4/msg00320.html
Message-ID: <20011215234000.lJePWLuappebxbD5PMzIp3FnAcGTjPWyQky2UZ7_4f8@z>

===
----- Original Message -----
From: "Jan Nieuwenhuizen" <janneke@gnu.org>


> "Robert Collins" <robert.collins@itdomain.com.au> writes:
>
> > I suspect that that is actually by design.Look at revision 1.2 of
> > desktop.cc and it has the same ,'s causing separate lines.
> So maybe it was very late when the code was designed :-)  Removing
...
> > I don't really have an opinion on whats right here,
>
> Ok.  I like having just a one-line prompt.

See my other emails. Lets leave this to the side, it's orthogonal to the
remove script work you've done.

> > but FWIW my prompt always appears on one line

I'm wrong here, it's on two lines, I'm just losing the plot :}. I
actually like the two line approach.

> Remaining nits fixed in patch below.  Btw, some nits are so small,
> imo, that you're free to just say: Removed/fixed than going throught
> the mail/reply dance, if that's more convenient for you.

Hm, lets see :}


> Greetings,
> Jan.
>
>
> > Please put all changes related to a single file in one place.
>
> Ah, ok.  That was because I see it as separate patches, and kept
> chronicity.

Which doesn't make sense (to me) as you would need multiple change log
entries to really preserve that.

> > > * Makefile.in (CFLAGS): Remove -Werror to allow build of w32api
> > > headers
> >
> > This will not be accepted. if w32api is broken, revert it to an
older
> > date
>
> Removed [, but I don't quite understand.  That is, I understand this
> is the wrong fix, but I can't go and submit patches with global
> impact; or hold my patch up and go diving into w32api first?  Where I
> come from, it's: Thou shalt not check in something that doesn't
> compile.]

Right. Well setup compiled before w32api got broken. I've said it twice
now: revert your w32api (which is what's broken) and setup will build
cleanly.

Fixing w32api again is important, and can be address'd in parallel.
Anyone that wants to build setup.exe will have motivation to fix w32api
:].

> * install.cc (do_install): Run script initialisation.  Typo fix.

This is still wrong :}.
The Typo fix is not part of the do_install function - so it goes like
    * install.cc: Typo fix.

and then we have the do_install changes which are entered liek
    (do_install): Run script initialisation.

giving us
    * install.cc: Typo fix.
    (do_install): Run script initialisation.

Which was the example I provided.

I'm accepting this patch as is given your disclaimer above so don't
worry about another round circuit.

I'll apply it within the next 24 hours.

Rob
