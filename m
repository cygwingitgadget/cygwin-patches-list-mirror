From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Tue, 26 Jun 2001 07:48:00 -0000
Message-id: <20010626104909.B6427@redhat.com>
References: <s1sithjcndc.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00341.html

On Tue, Jun 26, 2001 at 11:43:59PM +0900, Kazuhiro Fujieda wrote:
>The following patch makes Cygwin daemons more easier to use on Win9x.
>It allows daemons run without their console window and terminate
>silently without annoying us with the "End task" dialog twice.
>
>My patch against syscalls.cc isn't perfect. It doesn't consider the
>case where an application run on the tty mode or re-attach the
>console as its controlling terminal. But it works well practically.
>
>2001-06-26  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* syscalls.cc (setsid): Detach process from its console if
>	the current controlling terminal is the console device.
>	* exception.cc (ctrl_c_handler): Send SIGTERM to myself when catch
>	CTRL_LOGOFF_EVENT.

I don't think it is appropriate to detach the console after a call to
setsid().  I have tested this on UNIX recently and I believe that a
program can continue to write to a tty after calling setsid().

cgf
