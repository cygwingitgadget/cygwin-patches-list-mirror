From: Corinna Vinschen <corinna@vinschen.de>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: patch to rmdir
Date: Mon, 22 May 2000 09:39:00 -0000
Message-id: <39296125.86F7814@vinschen.de>
References: <3927E038.FF38FB02@vinschen.de> <20000521184132.E1386@cygnus.com> <39290ADA.B1A4ED7A@vinschen.de> <20000522105658.A6307@cygnus.com>
X-SW-Source: 2000-q2/msg00073.html

Chris Faylor wrote:
> [...]
> It's not that hard.  If you get an "EACCESS" and the file is not a
> directory then the errno should be set to ENOTDIR.

Oops, I have thought about that in a too complicated manner.
I will fix that, too. Shall I commit the change(s) immediately
when I'm thru?

Corinna
