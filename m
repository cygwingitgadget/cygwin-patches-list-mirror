From: Christopher Faylor <cgf@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: New terminal capability in fhandler_console.cc
Date: Fri, 30 Mar 2001 07:46:00 -0000
Message-id: <20010330104728.E12718@redhat.com>
References: <20010330131541.P16622@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00272.html

On Fri, Mar 30, 2001 at 01:15:41PM +0200, Corinna Vinschen wrote:
>Hi,
>
>I've just checked in a patch to fhandler_console.cc which adds a
>terminal capability to the windows console.
>
>ESC [ ? 47 h	==   Save screen content
>ESC [ ? 47 l    ==   Restore screen content
>
>This allows adding the termcap capabilities `ti' and `te' to the
>"cygwin" terminal entry in the same way as they are defined for
>xterm:
>
>	:te=\E[2J\E[?47l\E8:ti=\E7\E[?47h:
>
>That enables vim to restore the old screen content after quitting
>the same way in a console window as it does in a xterm window.

Nice.  I'm constantly surprised when vim doesn't act this way.

How about implementing "insert a character" for your next trick?

Then, we're getting dangerously close to vt100 functionality, I think.

cgf
