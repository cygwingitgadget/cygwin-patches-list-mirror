From: Christopher Faylor <cgf@redhat.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [Fwd: winsup/cygwin ChangeLog include/sys/file.h]
Date: Tue, 08 May 2001 07:08:00 -0000
Message-id: <20010508100633.B23273@redhat.com>
References: <3AF7F604.2B307F35@yahoo.com>
X-SW-Source: 2001-q2/msg00200.html

On Tue, May 08, 2001 at 09:35:00AM -0400, Earnie Boyd wrote:
>Don't forget about newlib's unistd.h!

It's already checked in.  It was checked in either slightly before or slightly
after this change.

cgf

>Earnie.
>-------- Original Message --------
>Subject: winsup/cygwin ChangeLog include/sys/file.h
>Date: 8 May 2001 01:36:51 -0000
>From: cgf@sourceware.cygnus.com
>To: cygwin-cvs@sources.redhat.com
>
>CVSROOT:	/cvs/uberbaum
>Module name:	winsup
>Changes by:	cgf@sources.redhat.com	2001-05-07 18:36:51
>
>Modified files:
>	cygwin         : ChangeLog 
>	cygwin/include/sys: file.h 
>
>Log message:
>	* include/sys/file.h: Revert special X_OK usage.  Just make it a
>constant.
>
>Patches:
> http://sources.redhat.com/cgi-bin/cvsweb.cgi/winsup/cygwin/ChangeLog.diff?cvsroot=uberbaum&r1=1.697&r2=1.698
> http://sources.redhat.com/cgi-bin/cvsweb.cgi/winsup/cygwin/include/sys/file.h.diff?cvsroot=uberbaum&r1=1.5&r2=1.6
>
>_________________________________________________________
>Do You Yahoo!?
>Get your free @yahoo.com address at http://mail.yahoo.com

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
