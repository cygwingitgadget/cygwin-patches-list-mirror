From: Mark Paulus <mark.paulus@wcom.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Patch to syscalls.cc for statfs/df problem
Date: Mon, 12 Mar 2001 09:04:00 -0000
Message-id: <0GA300HNZGMA0G@pmismtp01.wcomnet.com>
References: <20010312095213.B19646@redhat.com>
X-SW-Source: 2001-q1/msg00171.html

Thanks for the reply.  However (Please be gentle
with my, this is my first foray into the "alternative" 
universe of public domain software development/
enhancement....)

I am currently working with the Cygwin 1.1.8-2 source
code tree provide by the setup program.  Therefore the
patch I created was from that version.  (And that was some
fun to work with.  Under WinME, the links are created
correctly for config.in, config.guess, etc in the 
i586-pc-cygwin directory.  Once I figured that out, and 
manually created the links, then it started working, but 
not all the directories made, so I had to manually traverse
into the libiberty and newlib directories and call make.
Once I did that, then I could build the winsup/cygwin
stuff.  It appears that there is some amount of difference 
between the latest revision of syscalls.cc in CVS
and the syscalls.cc in 1.1.8-2.  

One other small issue.  I apparently can't do a 
cvs diff -up -r1.88 /tmp/syscalls.cc.  I get the following
error:

cvs diff:  cannot open CVS/Entries for reading: No such file or directory
cvs [diff aborted]:  no repository

Unfortunately I am not familliar with CVS.  I have used SCCS and
RCS, but not CVS.  I have set my CVSROOT env var as described
on the cvs.html page, but don't know what else to do.

Sorry, and if it's too much trouble to get me up to speed, then let
me know, and I will live with the df problem.



On Mon, 12 Mar 2001 09:52:13 -0500, Christopher Faylor wrote:

>On Mon, Mar 12, 2001 at 07:39:05AM -0700, Mark Paulus wrote:
>>Should I submit it via this forum again?
>
>Yes.
>
>>And, if so, should I diff against the original code, or against my
>>latest patch?
>
>You should always diff against the current CVS version.
>
>cgf


