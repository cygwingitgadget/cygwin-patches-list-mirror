From: DJ Delorie <dj@delorie.com>
To: mark.paulus@wcom.com
Cc: cygwin-patches@cygwin.com
Subject: Re: Patch to syscalls.cc for statfs/df problem
Date: Mon, 12 Mar 2001 10:25:00 -0000
Message-id: <200103121825.NAA25184@envy.delorie.com>
References: <0GA300HNZGMA0G@pmismtp01.wcomnet.com>
X-SW-Source: 2001-q1/msg00174.html

> One other small issue.  I apparently can't do a 
> cvs diff -up -r1.88 /tmp/syscalls.cc.  I get the following
> error:
> 
> cvs diff:  cannot open CVS/Entries for reading: No such file or directory
> cvs [diff aborted]:  no repository

The first thing you need to do if you're using cvs is check out the
cvs version of the sources.  This creates a "working directory" that
includes information that cvs uses to keep track of what your changes
are.

If you want to compare a non-cvs source tree with cvs, you'll have to
check out a cvs tree elsewhere on your local drive and do a local
diff.
