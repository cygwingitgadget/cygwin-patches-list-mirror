From: DJ Delorie <dj@delorie.com>
To: bkeener@thesoftwaresource.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 19:42:00 -0000
Message-id: <200105110242.WAA26871@envy.delorie.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102332.TAA25548@envy.delorie.com> <VA.00000768.00f859ec@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00238.html

> I think that this is way beyond the bounds of what setup should be
> expected to do and comes back to a little common sense on the part
> of the user.

Setup is a cygwin setup program, not a bash setup program.  If you ask
it to install cygwin in a different place, and don't select anything
but bash, you get a default cygwin installation with just bash.  That
includes the mount table configuration.

Perhaps one day setup will know that some packages, like cygwin
itself, are mandatory, so if you pick a different directory you *will*
get a working cygwin installation, without confusing the user too much
;-)
