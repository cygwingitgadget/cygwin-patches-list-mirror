From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Setup.exe in a property sheet
Date: Wed, 19 Dec 2001 02:26:00 -0000
Message-ID: <039201c18877$8839f530$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKKEPKCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00334.html
Message-ID: <20011219022600.1rP70BRgu5GoCPazTyMxir8YWSP1SYlzjndGnLppD_4@z>

----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
> > It's known as the Big Three Rule. The rule is that if a object needs
any
> > one of the three (destructor, copy con, assignment) it needs all
three.
> > The destructor connection is because the _only_ time an object needs
a
> > non-synthetic destructor is to clean up remote storage/OS objects
etc,
> > and therefore the same cleanup/management is needed on
copy/assignment.
> >
>
> AH, ok, I get it: if you *need* a non-default copy and/or operator=,
you also
> need a non-default destructor or you're almost assuredly doing
something wrong.
> That sounds like it would make a good compiler warning.

And the converse. If you *need* a non-default destructor, you need the
other two, or...
That said, if you implement a non-default destructor, implement the
other two, as a matter of paranoia and code maintenance. The usual
exceptions (i.e. it's just an ABC) aren't worth the headache when
something changes badly.

> It just goes to prove what I always say, "You learn something every
day if
> you're not careful". ;-)

Always :}.

> >  This class will be derived
> > from
> > > std::string when I get gcc to find the $&%^ing header, which will
of
> > course make
> > > it tremendously more functional.
> >
> > Yes, it seems to be absent from the winsup tree :}.
> >
>
> But I do have it.  I've got it in /usr/include/g++-3/string.  Same
situation
> with the cstdlib that inilex.cc needs but gcc can't find, and yet I'm
apparently
> the only one with problems there.  It's fricken driving me insane in
the
> proverbial membrane.

I've got it in /usr too - but it's not in /usr/src/src/ (where my cygwin
src tree is rooted).

...

> That's just not possible if the modal-ness is all in the constructor.
Now, if
> you really think it's necessary, it's certainly easy enough to do a
constructor
> that would take a template ID and a modal/modeless flag, but I don't
see how you
> can't help but lose the ability to do that stuff inbetween class
instance
> creation and window+message loop creation, and I think that alone is
pretty
> important, let alone the error considerations etc.

The error consideration is (to me) minor, compared to the programming
model & design. The design point you make is good. Leave it as is.

> Just to clarify, did you want me to get this diffed against the latest
before
> you check any of it in?  There's only one or two files that are diffed
against
> non-current HEAD to my knowledge, but I can sure do it, but I'll need
a hint as
> to how I can do a "cvs update" without bringing back a bunch of stuff
that I'll
> need to cut right back out again.  Or am I SOL and I'll just have to
do it by
> hand?

It's a hand job mate.

Update CVS and fix - I have to after other patches go in too ya know :}.
Don't worry about diffing against another directory though: just attach
the new .cc and .h files as-is and only diff the extant files.

Rob
