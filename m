From: "Town, Brad" <btown@ceddec.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: Mouse support
Date: Mon, 04 Dec 2000 07:30:00 -0000
Message-id: <F10D23B02E54D011A0AB0020AF9CEFE988FA80@lynx.ceddec.com>
X-SW-Source: 2000-q4/msg00035.html

Christopher Faylor [ mailto:cgf@redhat.com ] wrote:
> >. Instead of mouse support always being enabled (as it is 
> now), it should be
> >enabled when the console receives \E[?1000h and disabled 
> when the console
> >receives \E[?1000l.  (That's a lower-case 'L'.)
> 
> I think this is a big issue, actually.
> 
> I'd rather not enable this by default because people will be 
> clicking in the
> console window and will see strange characters in their bash 
> shells, won't
> they?

I agree wholeheartedly.  Does anyone have advice on how to add this
properly?  I tried adding a member variable to fhandler_console to flag
whether or not the mouse should be used, but it gets called by a different
instance of fhandler_console.

My enable/disable code works if the mouse flag is a global static variable,
but I don't think that's the Right Thing to Do.  Hints?

> >. Single-clicking and triple-clicking seem to work fine, but 
> for ncurses's
> >"ncurses" program to see a double-click, you need to move the mouse
> >afterward.  I spent the better part of the afternoon looking 
> for the cause,
> >but to no avail.
> 
> Hmm.  Is select not returning correctly, maybe?

That's what I was thinking.  Specifically, I thought the peek_console
routine was acting up with my changes.  I couldn't find anything, though.

I had put temporary "waiting"/"done" syscall_printfs around the
WaitForMultipleEvents in fhandler_console::read.  After single-clicks, it
would go back to waiting.  After double-clicks, it would not.  The screwy
thing is that I'm treating double-clicks just like single-clicks.  I'm at
Witt's End.

Brad Town
