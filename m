From: Corinna Vinschen <vinschen@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Mouse support
Date: Mon, 04 Dec 2000 07:50:00 -0000
Message-id: <3A2BBD32.BFA4DA50@redhat.com>
References: <F10D23B02E54D011A0AB0020AF9CEFE988FA80@lynx.ceddec.com>
X-SW-Source: 2000-q4/msg00036.html

"Town, Brad" wrote:
> I tried adding a member variable to fhandler_console to flag
> whether or not the mouse should be used, but it gets called by a different
> instance of fhandler_console.
> 
> My enable/disable code works if the mouse flag is a global static variable,
> but I don't think that's the Right Thing to Do.  Hints?

Sure. Create the member variable again and care for copying it
to the next instance via fhandler_console::dup(). I guess that
should work.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
mailto:vinschen@redhat.com
