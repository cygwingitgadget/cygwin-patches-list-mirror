From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Just checked in two patches
Date: Mon, 29 May 2000 17:51:00 -0000
Message-id: <20000529205142.A7669@cygnus.com>
X-SW-Source: 2000-q2/msg00089.html

I just checked in some patches to augment Cygwin's handling of autoloading
DLLs.  This will enable us to, relatively easily, start using functions that
are only implemented in newer versions of libraries like those found in W2K.

I was going to hold off on doing this, but I had to make some changes to the
low level path handling code to fix the problem reported by David Bolen in
the cygwin mailing list and I didn't feel like trying to weed out the autoload
changes from the path handling changes.

cgf
