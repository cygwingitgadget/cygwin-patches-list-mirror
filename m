From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Setup.exe in a property sheet
Date: Wed, 19 Dec 2001 01:15:00 -0000
Message-ID: <035e01c1886d$a5d9c610$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKEEPJCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00332.html
Message-ID: <20011219011500.7MrqJCHTV0hLs49Hj1k8XUJlf7ZppbygL-eF-_G-YkU@z>

===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Wednesday, December 19, 2001 7:42 PM
Subject: RE: [PATCH] Setup.exe in a property sheet


> > Ok, first glance:
> >
> > You've diffed across versions - please update both the clean dir and
> > your working dir for the next patch. Thats a major reason the patch
is
> > so big.
> >
> > * please use win32 thread API calls, not _beginthread et al.
>
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

This:
A thread that uses functions from the C run-time libraries should use
the _beginthread and _endthread C run-time functions for thread
management rather than CreateThread and ExitThread. Failure to do so
results in small memory leaks when ExitThread is called.

Is the reference I remember. Up to you at the end of the day. I think
it's a shame mingw still suffers from this.

Rob
