From: "Michael A. Chase" <mchase@ix.netcom.com>
To: "DJ Delorie" <dj@delorie.com>, <bkeener@thesoftwaresource.com>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Fri, 11 May 2001 12:43:00 -0000
Message-id: <009901c0da52$5166a9f0$e931273f@ca.boeing.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102332.TAA25548@envy.delorie.com> <VA.00000768.00f859ec@thesoftwaresource.com> <200105110242.WAA26871@envy.delorie.com> <VA.00000769.012ce1e7@thesoftwaresource.com> <200105110313.XAA27108@envy.delorie.com>
X-SW-Source: 2001-q2/msg00244.html

----- Original Message -----
From: "DJ Delorie" <dj@delorie.com>
To: <bkeener@thesoftwaresource.com>
Cc: <cygwin-patches@cygwin.com>
Sent: Thursday, May 10, 2001 20:13
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current
version or Sources only - Part 2


> I don't think the user should be limited to only one cygwin install
> per machine.

If a user is going to have multiple Cygwin installations, they are going to
have to have separate sets of mount points too.  Won't they?

If so, any necessary mount point changes should be done before calling
setup.exe and setup.exe should just have to honor the currently loaded set
of mount points.

I wouldn't expect non-developer users to have multiple Cygwin installations.
Considering how often multiple cygwin1.dll's cause trouble that's a good
thing.

