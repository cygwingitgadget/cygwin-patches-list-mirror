From: "Town, Brad" <btown@ceddec.com>
To: "'cygpatch'" <cygwin-patches@cygwin.com>
Subject: RE: Mouse support
Date: Mon, 04 Dec 2000 08:06:00 -0000
Message-id: <F10D23B02E54D011A0AB0020AF9CEFE988FA81@lynx.ceddec.com>
X-SW-Source: 2000-q4/msg00037.html

Corinna Vinschen [ mailto:vinschen@redhat.com ] wrote:
> "Town, Brad" wrote:
> > I tried adding a member variable to fhandler_console to flag
> > whether or not the mouse should be used, but it gets called 
> by a different
> > instance of fhandler_console.
> > 
> > My enable/disable code works if the mouse flag is a global 
> static variable,
> > but I don't think that's the Right Thing to Do.  Hints?
> 
> Sure. Create the member variable again and care for copying it
> to the next instance via fhandler_console::dup(). I guess that
> should work.

Hmm.  I had tried that, but it didn't work.  I'm guessing that it's because
the console is duped before the mouse is enabled; enabling the mouse within
the "main" fhandler_console instance doesn't enable it in the "foreground"
fhandler_console instance.  (I'm probably way off in both my understanding
and my terminology here.)

What should the behavior be?  Should enabling the mouse in one console
instance enable it in all?  After all, there really is only one console,
right?  Or should it enable it in the "foreground" fhandler_console
instance?

With the global-flag code, hitting ^Z during a mouse-enabled ncurses program
disables the mouse, and typing "fg" in bash reenables it.  Maybe a global
flag isn't the wrong way to go.  (Sure feels like it, though.)

Brad
