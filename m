From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Mark Paulus <mark.paulus@wcom.com>
Cc: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Patch to syscalls.cc for statfs/df problem
Date: Mon, 12 Mar 2001 10:13:00 -0000
Message-id: <3AAD11C9.326A6378@yahoo.com>
References: <0GA300HNZGMA0G@pmismtp01.wcomnet.com>
X-SW-Source: 2001-q1/msg00172.html

Mark Paulus wrote:
> 
> Thanks for the reply.  However (Please be gentle
> with my, this is my first foray into the "alternative"
> universe of public domain software development/
> enhancement....)
> 

This isn't PD software, it is GPL software.

> I am currently working with the Cygwin 1.1.8-2 source
> code tree provide by the setup program.  Therefore the
> patch I created was from that version.  (And that was some
> fun to work with.  Under WinME, the links are created
> correctly for config.in, config.guess, etc in the
> i586-pc-cygwin directory.  Once I figured that out, and
> manually created the links, then it started working, but
> not all the directories made, so I had to manually traverse
> into the libiberty and newlib directories and call make.
> Once I did that, then I could build the winsup/cygwin
> stuff.  It appears that there is some amount of difference
> between the latest revision of syscalls.cc in CVS
> and the syscalls.cc in 1.1.8-2.
> 

To build Cygwin you must do so in a separate directory from the src
directory.  It is covered in the FAQ.

> One other small issue.  I apparently can't do a
> cvs diff -up -r1.88 /tmp/syscalls.cc.  I get the following
> error:
> 
> cvs diff:  cannot open CVS/Entries for reading: No such file or directory
> cvs [diff aborted]:  no repository
> 
> Unfortunately I am not familliar with CVS.  I have used SCCS and
> RCS, but not CVS.  I have set my CVSROOT env var as described
> on the cvs.html page, but don't know what else to do.
> 

You need to follow the CVS checkout directions posted at
http://cygwin.com/cvs.html first.  Then make your changes to
winsup/cygwin/syscalls.cc.  Then do the `cvs diff -up syscalls.cc' from
that directory.  Note, do not copy your changed 1.1.8-2 version of
syscalls.cc to src/winsup/cygwin, you need to merge your changes with
the other changes that exist.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

