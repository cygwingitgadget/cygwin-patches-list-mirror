From: DJ Delorie <dj@delorie.com>
To: bkeener@thesoftwaresource.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 16:32:00 -0000
Message-id: <200105102332.TAA25548@envy.delorie.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102247.SAA25227@envy.delorie.com> <VA.00000767.0059a04d@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00236.html

For a new install, there is *no* mount table, and setup must create
one.  We also enforce /usr/lib->/lib and /usr/bin->/bin because some
programs just won't work otherwise.

The step you object to has nothing to do with installing files, just
creating these initial mount points, or dealing with an install
in a new root.  Example:

Existing:
	/		c:/cygwin
	/usr/src	c:/cygwin/src

Now, if we install cygwin in d:/cygwin, what do we do with the
existing /usr/src mount?  I claim we should replace it with
d:/cygwin/src because it pointed to the old root.  However, consider:

Existing:
	/		c:/cygwin
	/usr/src	e:/src

In this case, I would argue to keep the existing /usr/src mount.

In the case of /usr/bin and /usr/lib, we really do need to make sure
the mount point is correct, or software won't work.
