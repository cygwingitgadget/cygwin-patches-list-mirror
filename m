From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: New terminal capability in fhandler_console.cc
Date: Fri, 30 Mar 2001 03:15:00 -0000
Message-id: <20010330131541.P16622@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00271.html

Hi,

I've just checked in a patch to fhandler_console.cc which adds a
terminal capability to the windows console.

ESC [ ? 47 h	==   Save screen content
ESC [ ? 47 l    ==   Restore screen content

This allows adding the termcap capabilities `ti' and `te' to the
"cygwin" terminal entry in the same way as they are defined for
xterm:

	:te=\E[2J\E[?47l\E8:ti=\E7\E[?47h:

That enables vim to restore the old screen content after quitting
the same way in a console window as it does in a xterm window.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
