From: Christopher Faylor <cgf@redhat.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Mouse support
Date: Fri, 01 Dec 2000 20:55:00 -0000
Message-id: <20001201235439.A4544@redhat.com>
References: <F10D23B02E54D011A0AB0020AF9CEFE988FA6E@lynx.ceddec.com>
X-SW-Source: 2000-q4/msg00032.html

On Thu, Nov 30, 2000 at 04:35:08PM -0500, Town, Brad wrote:
>Attached are patches that enable xterm-style mouse event reporting for
>console windows.
>
>To use mouse event reporting, make sure your console windows do not have
>QuickEdit mode enabled.
>
>To enable ncurses support for the mouse, add "kmous=\E[M" to your source
>terminfo file and re-tic.  I've tested it with ncurses's main test program
>"ncurses" and "knights" (an ncurses test program) as supplied by the Cygwin
>ncurses distribution.
>
>Issues:
>. Instead of mouse support always being enabled (as it is now), it should be
>enabled when the console receives \E[?1000h and disabled when the console
>receives \E[?1000l.  (That's a lower-case 'L'.)

I think this is a big issue, actually.

I'd rather not enable this by default because people will be clicking in the
console window and will see strange characters in their bash shells, won't
they?

>. Single-clicking and triple-clicking seem to work fine, but for ncurses's
>"ncurses" program to see a double-click, you need to move the mouse
>afterward.  I spent the better part of the afternoon looking for the cause,
>but to no avail.

Hmm.  Is select not returning correctly, maybe?

cgf
