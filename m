From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: RE: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Wed, 09 May 2001 21:50:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00224.html

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ]
> Sent: Thursday, May 10, 2001 2:46 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: [patch] setup.exe changes for 
> Redownload/Reinstall Current
> version or Sources only - Part 2
> 
> 
> Sure, setup is assuming that things go to /usr/src.  That's 
> ok.  It just
> should understand what cygwin thinks /usr/src is.

Exactly.
 
> At the very very least it should reset the /usr/src mount 
> point.  Then,
> at least, the source files would show up someplace as far as cygwin
> was concerned.  I don't really like this idea, but it is better than
> nothing.

IIRC setup used to do that. Then there was a heated discussion on
cygwin(-users) and Dj altered setup to preserve existing mount points.

Rob
 
> cgf
> 
