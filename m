From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe in a property sheet
Date: Wed, 19 Dec 2001 02:19:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKKEPKCHAA.g.r.vansickle@worldnet.att.net>
References: <034a01c1886b$a1d53fb0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00333.html
Message-ID: <20011219021900.Aqfw3OONj_y7qJw3cb15GsLPyUA9LpUdA4NObLAVCp0@z>

> From: cygwin-patches-owner@cygwin.com
> [ mailto:cygwin-patches-owner@cygwin.com]On Behalf Of Robert Collins

[snip]

> Can you give me a reference? Last I recall, the comment from MS was the
> _beginthread and _endthread leak memory and were deprecated.
>

The November Platform SDK says this under CreateThread():

"A thread that uses functions from the C run-time libraries should use the
beginthread and endthread C run-time functions for thread management rather than
CreateThread and ExitThread. Failure to do so results in small memory leaks when
ExitThread is called."

So it looks like they've not only not deprecated them, they've removed the
underscores! ;-)  But I don't know, it most certainly would not be the first
time MS's right hand didn't know what the left hand was doing, but didn't like
the looks of it.

[snip]

> > Yeah I know.  Of course there's currently no copying going on, but
> it's on my
> > todo list for completeness.  I don't understand the destructor
> connection
> > though...?
>
> It's known as the Big Three Rule. The rule is that if a object needs any
> one of the three (destructor, copy con, assignment) it needs all three.
> The destructor connection is because the _only_ time an object needs a
> non-synthetic destructor is to clean up remote storage/OS objects etc,
> and therefore the same cleanup/management is needed on copy/assignment.
>

AH, ok, I get it: if you *need* a non-default copy and/or operator=, you also
need a non-default destructor or you're almost assuredly doing something wrong.
That sounds like it would make a good compiler warning.

It just goes to prove what I always say, "You learn something every day if
you're not careful". ;-)

[snip]

> variable length arguments use bitwise copying. Many objects do not
> survive bitwise copying (or there would be no need for a copy
> constructor). The crash may not occur immediately, but (say) at the
> first object access after the destruction of the passed object. Passing
> object pointers is less of an issue (for hopefully now clear reasons).
>

Ok, I can see that that could in at least some cases cause problems.  I'll have
to think on that more though, it seems to me that in a printf()-type of
situation, you're really passing the varargs as const, so if you're casting to
const inside the vararg function... oof, I hope I'm not learning again ;-).

[snip]

>  This class will be derived
> from
> > std::string when I get gcc to find the $&%^ing header, which will of
> course make
> > it tremendously more functional.
>
> Yes, it seems to be absent from the winsup tree :}.
>

But I do have it.  I've got it in /usr/include/g++-3/string.  Same situation
with the cstdlib that inilex.cc needs but gcc can't find, and yet I'm apparently
the only one with problems there.  It's fricken driving me insane in the
proverbial membrane.

> > > * To test if something is not needed, comment it out and see if you
> get
> > > link errors.
> >
> > Right...?  I don't catch your drift.
>
> You've commented at least one function with "this may not be needed
> anymore".
>

Oh, yep.  Last minute hack.  We'll get 'er in ship shape before the shape ships.

> > > * have you run this through indent?
> >
> > No (is it that obvious? ;-)), and I have to apologize for that.  I
> know my
> > coding style is rather different *COUGHBETTERHACK* ;-) than the GNU
> standard
> > style.  Is indent still making hash of C++ code?
>
> Oh yeah. plenty bad, but at least reasonably consistent on many things.
>

Ugh.  Maybe I'll play around with it and see if it can't just adjust the
indenting without scrambling everything, and kern the rest by hand.

> > > * I don't like the PropertyPage semnatics - Why is Create not the
> > > constructor?
> ...
>
> > MyDialogClass dlg(IDD_TEMPLATE, DO_MODAL);
> >
> > So now in addition to yet another flag you have to deal with, your
> dialog lives
> > and dies entirely in the constructor, i.e. before the object is even
> really
> > constructed.  You can't, say, construct it and then show/hide it when
> you
> > wanted, you can't call any members before the box is up (this applies
> to both
> > modal and modeless), I just don't think it works well or buys you
> anything in
> > this sort of application.
>
> Doesn't the same modal issue apply to Create?
>

No.  Say I wanted to do something like this:

	MyDialog dlg;

	dlg.LoadDialogWithData();

	dlg.CreateModal(); // or dlg.DoModal() or whatever we want to call it

That's just not possible if the modal-ness is all in the constructor.  Now, if
you really think it's necessary, it's certainly easy enough to do a constructor
that would take a template ID and a modal/modeless flag, but I don't see how you
can't help but lose the ability to do that stuff inbetween class instance
creation and window+message loop creation, and I think that alone is pretty
important, let alone the error considerations etc.

[snip]

> > Indeed, but I'm having trouble figuring out how to do it right.
> FWICT, I think
> > what I really want to do (friend individual member functions to
> another class)
> > isn't possible, so I'll probably just friend the entire classes
> together, which
> > will at least limit the cross-fertilization to two classes.
>
> Sure it's possible.
>
> AFAIK it's not possible to only expose particular functions to friends,
> but it's certainly possible to have a one way friendship.
>

Right, no, it's the first part there that I was thinking about.

> > Ok, sorry. I didn't purposely remove any, and thought they were an
> automatic CVS
> > deal anyway.
>
> That's ok. The updates are, the creation isn't. Please also add to your
> new .cc files.
>

Will do.

[snip]

> > cvs would have been pretty badly broken for too long.  Believe me when
> I tell
> > you I had *zero* fun writing that 10K ChangeLog entry!  But once this
> is checked
> > in, I'm sure this will be a lot easier.
>
> I know *exactly* what you mean regarding the ChangeLogs. To be honest I
> didn't look at yours yet - I figured it was too early in the piece.
>

It's only going to get bigger Rob; like the t-shirt says, "Procrastinate NOW!".
;-)

Just to clarify, did you want me to get this diffed against the latest before
you check any of it in?  There's only one or two files that are diffed against
non-current HEAD to my knowledge, but I can sure do it, but I'll need a hint as
to how I can do a "cvs update" without bringing back a bunch of stuff that I'll
need to cut right back out again.  Or am I SOL and I'll just have to do it by
hand?

> Rob
>

--
Gary R. Van Sickle
Brewer.  Patriot.
