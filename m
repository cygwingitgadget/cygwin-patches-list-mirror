From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Wed, 09 May 2001 21:47:00 -0000
Message-id: <20010510004557.E12136@redhat.com>
References: <VA.00000757.0015edd1@thesoftwaresource.com> <20010508000842.A3591@redhat.com> <VA.0000075e.0034f511@thesoftwaresource.com> <200105100406.AAA16006@envy.delorie.com> <VA.00000763.0002f264@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00223.html

On Thu, May 10, 2001 at 12:23:21AM -0400, Brian Keener wrote:
>DJ Delorie wrote:
>> installs its own.  We expect people to let setup manage their machine.
>> Chris should just let setup manage his machine :-)
>
>Good Lord - don't you folks ever sleep.

Not lately, unfortunately.

>I'm off to bed I'm pooped - but that is what I thought as well was that
>setup assumed certain things to be in certain places just as we assume
>that all source files will contain the string '-src' to find the source
>packages.  I really don't see how setup will know that a /src or a
>/usr/src or any derivative of that as a mount point or not should be
>used or not used.  Seems to me it has to have some givens as to where
>files belong *or* we use another dialog and ask the user where he wants
>the source just as we ask about root.

Sure, setup is assuming that things go to /usr/src.  That's ok.  It just
should understand what cygwin thinks /usr/src is.

At the very very least it should reset the /usr/src mount point.  Then,
at least, the source files would show up someplace as far as cygwin
was concerned.  I don't really like this idea, but it is better than
nothing.

cgf
