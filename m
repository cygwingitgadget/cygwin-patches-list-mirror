From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>, Mumit Khan <khan@NanoTech.Wisc.EDU>
Subject: Re: cross compiling patches
Date: Thu, 30 Mar 2000 17:59:00 -0000
Message-id: <20000330205925.A30386@cygnus.com>
References: <200003300046.SAA27482@hp2.xraylith.wisc.edu> <38E30C2A.7B962DE8@vinschen.de> <38E3D5F2.15B2E3A0@vinschen.de> <20000330192529.A29634@cygnus.com>
X-SW-Source: 2000-q1/msg00027.html

On Thu, Mar 30, 2000 at 07:25:29PM -0500, Chris Faylor wrote:
>Ok.  I just checked and the top-level Makefile.in in the winsup version
>of CVS is missing some changes that should be in the gcc version.  I'll
>take a look at the difference between the two repositories and submit
>an appropriate patch to Makefile.in.

I've checked in those changes.  Sorry, Corinna.  You were right.  The only
way to do this was from the top-level and the sad thing is that I had already
come to that conclusion and made the appropriate changes elsewhere.

cgf
