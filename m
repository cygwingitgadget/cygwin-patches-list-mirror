From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Setup.exe in a property sheet
Date: Wed, 19 Dec 2001 01:01:00 -0000
Message-ID: <034a01c1886b$a1d53fb0$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKEEPJCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00331.html
Message-ID: <20011219010100.XWgp-ZSvuvHhyFBeismwLcMHpczdkQD9gUJbWpbj5EY@z>

----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>

> I don't think we can do that, at least not everywhere.  The threads
call many
> CRT functions, and MS warns you not to use CreateThread if you're
using the CRT
> in your thread.  Note that the threads are now "backwards" from what
they used
> to be - the UI (which IIRC isn't using much if any CRT) now runs
entirely in the
> main thread, and a few of the do_xxx()'s are split off of that main
thread soas
> to not block the UI updating/responsiveness.

Can you give me a reference? Last I recall, the comment from MS was the
_beginthread and _endthread leak memory and were deprecated.

> > * All classes with an explicit destructor need copy constructors and
> > operator =. (If they aren't used, declare but don't implement).
Reason:
> > synthesised copy constructors and assignment operators will be
wrong.
> > (And yes, this is wrong elsewhere in setup too).
>
> Yeah I know.  Of course there's currently no copying going on, but
it's on my
> todo list for completeness.  I don't understand the destructor
connection
> though...?

It's known as the Big Three Rule. The rule is that if a object needs any
one of the three (destructor, copy con, assignment) it needs all three.
The destructor connection is because the _only_ time an object needs a
non-synthetic destructor is to clean up remote storage/OS objects etc,
and therefore the same cleanup/management is needed on copy/assignment.

> > * varargs and C++ don't mix from what I'm told. (because objects
passed
> > in lose information).
>
> I haven't heard that one.  As I understand it, you're just pushing
bytes onto
> the stack, and in the vararg function it's up to you to figure out
what they
> were supposed to be by whatever means necessary (a cast).  I'm not
sure why any
> code involved in that would care what was being pushed on the stack.

variable length arguments use bitwise copying. Many objects do not
survive bitwise copying (or there would be no need for a copy
constructor). The crash may not occur immediately, but (say) at the
first object access after the destruction of the passed object. Passing
object pointers is less of an issue (for hopefully now clear reasons).

> > It's probably ok for your string class... but I'm
> > not sure why it exists?
>
> Well I'll grant you it's not very fleshed out yet.  The idea first and
foremost
> is to consolidate the LoadString()s and FormatMessage()s into one
easy-to-use
> place; currently such calls are spread around in several places, and
especially
> FormatMessage() is a hassle to deal with.  This class will be derived
from
> std::string when I get gcc to find the $&%^ing header, which will of
course make
> it tremendously more functional.

Yes, it seems to be absent from the winsup tree :}.

> > * To test if something is not needed, comment it out and see if you
get
> > link errors.
>
> Right...?  I don't catch your drift.

You've commented at least one function with "this may not be needed
anymore".

> > * have you run this through indent?
>
> No (is it that obvious? ;-)), and I have to apologize for that.  I
know my
> coding style is rather different *COUGHBETTERHACK* ;-) than the GNU
standard
> style.  Is indent still making hash of C++ code?

Oh yeah. plenty bad, but at least reasonably consistent on many things.

> > * I don't like the PropertyPage semnatics - Why is Create not the
> > constructor?
...

> MyDialogClass dlg(IDD_TEMPLATE, DO_MODAL);
>
> So now in addition to yet another flag you have to deal with, your
dialog lives
> and dies entirely in the constructor, i.e. before the object is even
really
> constructed.  You can't, say, construct it and then show/hide it when
you
> wanted, you can't call any members before the box is up (this applies
to both
> modal and modeless), I just don't think it works well or buys you
anything in
> this sort of application.

Doesn't the same modal issue apply to Create?

> > * The propertysheet/propertypage friend relationship would be good
to
> > have correct.
>
> Indeed, but I'm having trouble figuring out how to do it right.
FWICT, I think
> what I really want to do (friend individual member functions to
another class)
> isn't possible, so I'll probably just friend the entire classes
together, which
> will at least limit the cross-fertilization to two classes.

Sure it's possible.

AFAIK it's not possible to only expose particular functions to friends,
but it's certainly possible to have a one way friendship.

> Ok, sorry. I didn't purposely remove any, and thought they were an
automatic CVS
> deal anyway.

That's ok. The updates are, the creation isn't. Please also add to your
new .cc files.

> > * The ThreeBar refactoring seems incomplete - it is dependent on the
end
> > user functions, rather than the other way around. It seems to me
that
> > the ThreeBar refactor should implement/provide a control but not
create
> > threads for the install process...
>
> Well I'm not about to claim that any of this is complete.  In this
particular
> instance I know exactly what you're saying and I agree, I'm not real
crazy about
> how that works either, and will think on that some more and hopefully
come up
> with a better solution.  But in the meantime we've gotten rid of what
was a
> redundant dialog and template (well the template's still in there but
you know
> what I mean).  Hmm, maybe those copy constructors would help here....
>
> > * I'd rather not see _any_ structs - use class's with all public
members
> > if needed.
>
> ?  Where did I do that?  Oh, right, that little one in the Window
class (or did
> you find more, I try to use structs as little as possible too)?  Just
to be
> pendantic, a C++ struct *is* actually a class with all public members.

Oh yes, they are code equivalent. I'm just a picky b****rd.

> > * is chooser.o going to be equivalent to choose.o? If so then just
> > fiddle choose.o please. I commit my changes quite frequently so we
won't
> > collide much.
> >
> I honestly don't know yet.  As is, it's just a field expedient to
bring up your
> choose.o dialog easily and at the right time.  It would be nice I
think (as of
> this moment anyway) to bring that into the PropSheet as well, but I'm
still
> trying to figure out whether that can work or not (issues such as
resizing etc).
>
...
> cvs would have been pretty badly broken for too long.  Believe me when
I tell
> you I had *zero* fun writing that 10K ChangeLog entry!  But once this
is checked
> in, I'm sure this will be a lot easier.

I know *exactly* what you mean regarding the ChangeLogs. To be honest I
didn't look at yours yet - I figured it was too early in the piece.

Rob
