From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 10:00:00 -0000
Message-id: <000701c0d972$7889a680$9332273f@ca.boeing.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com>
X-SW-Source: 2001-q2/msg00229.html

Unless setup.exe is (re)building the mount table, I'd prefer to see
setup.exe honor the Cygwin mount points.

Perhaps the text box that specifies the installation directory should be
disabled if a mount table is found unless a "Replace Mount Points" or "New
Installation" radio button is selected in that dialog box.
--
Mac :})
Give a hobbit a fish and he'll eat fish for a day.
Give a hobbit a ring and he'll eat fish for an age.
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, May 09, 2001 21:55
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current
version or Sources only - Part 2


> On Thu, May 10, 2001 at 02:42:22PM +1000, Robert Collins wrote:
> >> -----Original Message-----
> >> From: Christopher Faylor [ mailto:cgf@redhat.com ]
> >> Sent: Thursday, May 10, 2001 2:46 PM
> >> To: cygwin-patches@cygwin.com
> >> Subject: Re: [patch] setup.exe changes for
> >> Redownload/Reinstall Current
> >> version or Sources only - Part 2
> >>
> >>At the very very least it should reset the /usr/src mount point.  Then,
> >>at least, the source files would show up someplace as far as cygwin was
> >>concerned.  I don't really like this idea, but it is better than
> >>nothing.
> >
> >IIRC setup used to do that.  Then there was a heated discussion on
> >cygwin(-users) and Dj altered setup to preserve existing mount points.
>
> Yes, I thought I remembered this, too.

