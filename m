Return-Path: <cygwin-patches-return-1603-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20015 invoked by alias); 19 Dec 2001 08:48:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20001 invoked from network); 19 Dec 2001 08:48:21 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe in a property sheet
Date: Wed, 07 Nov 2001 06:07:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKEEPJCHAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <023601c18857$c37d36e0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/txt/msg00135.txt.bz2

> Ok, first glance:
>
> You've diffed across versions - please update both the clean dir and
> your working dir for the next patch. Thats a major reason the patch is
> so big.
>
> * please use win32 thread API calls, not _beginthread et al.

I don't think we can do that, at least not everywhere.  The threads call many
CRT functions, and MS warns you not to use CreateThread if you're using the CRT
in your thread.  Note that the threads are now "backwards" from what they used
to be - the UI (which IIRC isn't using much if any CRT) now runs entirely in the
main thread, and a few of the do_xxx()'s are split off of that main thread soas
to not block the UI updating/responsiveness.

> * All classes with an explicit destructor need copy constructors and
> operator =. (If they aren't used, declare but don't implement). Reason:
> synthesised copy constructors and assignment operators will be wrong.
> (And yes, this is wrong elsewhere in setup too).

Yeah I know.  Of course there's currently no copying going on, but it's on my
todo list for completeness.  I don't understand the destructor connection
though...?

> * varargs and C++ don't mix from what I'm told. (because objects passed
> in lose information).

I haven't heard that one.  As I understand it, you're just pushing bytes onto
the stack, and in the vararg function it's up to you to figure out what they
were supposed to be by whatever means necessary (a cast).  I'm not sure why any
code involved in that would care what was being pushed on the stack.

> It's probably ok for your string class... but I'm
> not sure why it exists?

Well I'll grant you it's not very fleshed out yet.  The idea first and foremost
is to consolidate the LoadString()s and FormatMessage()s into one easy-to-use
place; currently such calls are spread around in several places, and especially
FormatMessage() is a hassle to deal with.  This class will be derived from
std::string when I get gcc to find the $&%^ing header, which will of course make
it tremendously more functional.

> * To test if something is not needed, comment it out and see if you get
> link errors.

Right...?  I don't catch your drift.

> * have you run this through indent?

No (is it that obvious? ;-)), and I have to apologize for that.  I know my
coding style is rather different *COUGHBETTERHACK* ;-) than the GNU standard
style.  Is indent still making hash of C++ code?

> * the #if 0...#endifs should go. Delete the code or document why it's
> not deleted.

They're in the process of going, and I did document this in the ChangeLog
(albeit that's not the right place).  I'm keeping some of that around until I'm
sure I have the logic carried over properly.

> * I don't like the PropertyPage semnatics - Why is Create not the
> constructor?

I don't like constructors that have a significant chance of failing, i.e. that
do much more than simply get the instance into a consistent state, and try to
avoid them whenever I can.  The issue is that when a constructor fails, its only
recourse is to throw an exception and let the caller catch it and deal with it
(assuming he doesn't want whatever the default abort handler does), and at that
point you've more than burned up any convenience you may have gained by
combining the constructor and initializer.  A separate Create() can still throw
an exception if it wants to, but can also return a 'failed' status, which IMO is
just as good and easier to catch and take whatever action you deem appropriate.

Now in the particular case of these dialog-like things, we've actually got more
than one way to initialize them: modal and modeless.  A constructor that popped
up a modal dialog box, say, sounds like a mess to me; your entire box would have
to be something like this:

	MyDialogClass dlg(IDD_TEMPLATE, DO_MODAL);

So now in addition to yet another flag you have to deal with, your dialog lives
and dies entirely in the constructor, i.e. before the object is even really
constructed.  You can't, say, construct it and then show/hide it when you
wanted, you can't call any members before the box is up (this applies to both
modal and modeless), I just don't think it works well or buys you anything in
this sort of application.

> * The propertysheet/propertypage friend relationship would be good to
> have correct.

Indeed, but I'm having trouble figuring out how to do it right.  FWICT, I think
what I really want to do (friend individual member functions to another class)
isn't possible, so I'll probably just friend the entire classes together, which
will at least limit the cross-fertilization to two classes.

> * please keep CVSID's in source files. They aren't used in the code, but
> I find them useful for review.

Ok, sorry. I didn't purposely remove any, and thought they were an automatic CVS
deal anyway.

> * The ThreeBar refactoring seems incomplete - it is dependent on the end
> user functions, rather than the other way around. It seems to me that
> the ThreeBar refactor should implement/provide a control but not create
> threads for the install process...

Well I'm not about to claim that any of this is complete.  In this particular
instance I know exactly what you're saying and I agree, I'm not real crazy about
how that works either, and will think on that some more and hopefully come up
with a better solution.  But in the meantime we've gotten rid of what was a
redundant dialog and template (well the template's still in there but you know
what I mean).  Hmm, maybe those copy constructors would help here....

> * I'd rather not see _any_ structs - use class's with all public members
> if needed.

?  Where did I do that?  Oh, right, that little one in the Window class (or did
you find more, I try to use structs as little as possible too)?  Just to be
pendantic, a C++ struct *is* actually a class with all public members.

> * is chooser.o going to be equivalent to choose.o? If so then just
> fiddle choose.o please. I commit my changes quite frequently so we won't
> collide much.
>

I honestly don't know yet.  As is, it's just a field expedient to bring up your
choose.o dialog easily and at the right time.  It would be nice I think (as of
this moment anyway) to bring that into the PropSheet as well, but I'm still
trying to figure out whether that can work or not (issues such as resizing etc).

> Lastly, I think it would be a good idea (if possible) to do the
> refactoring bit-by-bit in future. i.e. factor in the Window class and
> the threeline progress bar. Then the class conversion for the pages.
> etc. That just reduces the risk of a huge commit.
>

I agree completely, and that was in fact my original intent.  As things went on
though, I just couldn't see how that would really be possible or practical; the
cvs would have been pretty badly broken for too long.  Believe me when I tell
you I had *zero* fun writing that 10K ChangeLog entry!  But once this is checked
in, I'm sure this will be a lot easier.

> Rob
>
>

--
Gary R. Van Sickle
Brewer.  Patriot.
