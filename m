From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: win95 and pshared mutex support for pthreads
Date: Tue, 24 Apr 2001 14:42:00 -0000
Message-id: <20010424234234.C23753@cygbert.vinschen.de>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010424232202.A23753@cygbert.vinschen.de> <20010424173219.C29222@redhat.com>
X-SW-Source: 2001-q2/msg00144.html

On Tue, Apr 24, 2001 at 05:32:19PM -0400, Christopher Faylor wrote:
> On Tue, Apr 24, 2001 at 11:22:02PM +0200, Corinna Vinschen wrote:
> >On Thu, Apr 19, 2001 at 08:38:18PM +1000, Robert Collins wrote:
> >> The code is a little ugly, but it still passes all my testcases.
> >> 
> >> The ABI HAS NOT CHANGED. It may have to support pshared condition
> >> variables properly, but I wanted to get the win95 support submitted.
> >> 
> >> Rob
> >> 
> >> Thu Apr 19 20:22:00 2001  Robert Collins <rbtcollins@hotmail.com>
> >> 
> >>  * password.cc (getpwuid): Check for thread cancellation.
> >>  (getpwuid_r): Ditto.
> >>  (getpwname): Ditto.
> >>  (getpwnam_r): Ditto.
> >
> >Robert,
> >
> >may I ask why your new reentrant functions ignore the pw_gecos
> >field? You know that it's very important when using ntsec?
> >
> >Chris, I assume that it's not a showstopper but I will patch
> >it for 1.3.2.  My upcoming changes to the security code will
> >need reentrant getpwxxx and getgrxxx functions.
> 
> I assume that these are simple changes?  If so, go ahead and check them
> in now.  I can rerun the build for 1.3.1.

Ok, I will include the patches related to the string lengths as well.

Corinna
