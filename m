From: Christopher Faylor <cgf@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Patch to syscalls.cc for statfs/df problem
Date: Mon, 12 Mar 2001 10:23:00 -0000
Message-id: <20010312132344.A10214@redhat.com>
References: <20010312095213.B19646@redhat.com> <0GA300HNZGMA0G@pmismtp01.wcomnet.com>
X-SW-Source: 2001-q1/msg00173.html

On Mon, Mar 12, 2001 at 10:01:10AM -0700, Mark Paulus wrote:
>One other small issue.  I apparently can't do a 
>cvs diff -up -r1.88 /tmp/syscalls.cc.  I get the following
>error:
>
>cvs diff:  cannot open CVS/Entries for reading: No such file or directory
>cvs [diff aborted]:  no repository

You can't specify a path name like this unless there is a CVS directory
in /tmp.  You'll have to check out the full CVS sources and then do
a "cvs diff" from the directory containing the checked out sources.

>Unfortunately I am not familliar with CVS.  I have used SCCS and
>RCS, but not CVS.  I have set my CVSROOT env var as described
>on the cvs.html page, but don't know what else to do.
>
>Sorry, and if it's too much trouble to get me up to speed, then let
>me know, and I will live with the df problem.

Have you looked at the "Contributing" link at http://cygwin.com/ ?
It should provide some insight.

cgf
