From: "Bradley A. Town" <townba@pobox.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Mouse support
Date: Sat, 16 Dec 2000 08:10:00 -0000
Message-id: <OLEFLDABDIPMDEPMLEMMOECMCAAA.townba@pobox.com>
References: <20001215221335.A13088@redhat.com>
X-SW-Source: 2000-q4/msg00051.html

BTW, for most programs to support using a mouse, the Cygwin user needs to
add an entry to her termcap file and source terminfo file.

/etc/termcap: Km=\E[M
terminfo source: kmous=\E[M (then re-tic)

Brad Town


-----Original Message-----
From: cygwin-patches-owner@sources.redhat.com
[ mailto:cygwin-patches-owner@sources.redhat.com]On Behalf Of Christopher
Faylor
Sent: Friday, December 15, 2000 10:14 PM
To: 'cygwin-patches@cygwin.com'
Subject: Re: Mouse support


On Fri, Dec 15, 2000 at 11:35:15AM -0500, Town, Brad wrote:
>Yeah, this morning (Friday), CVS choked on my changes, too.  Attached are
>some good patches that do the trick.

Patch applied, with a minor change to fhandler_console.cc and some
reformatting of the ChangeLog.

A ChangeLog entry should list the file name once with just the functions
listed below it.  The entries should also be present tense as in "Fix
problem
with foo" rather than "Fixed problem with foo".

Anyway, thanks for the patch.  I've wanted something like this for a long
time.

cgf

