From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Sun, 05 Aug 2001 02:12:00 -0000
Message-id: <20010805111251.R23782@cygbert.vinschen.de>
References: <20010731203820.U490@cygbert.vinschen.de> <20010803144012.X23782@cygbert.vinschen.de> <996843821.24208.3.camel@lifelesswks> <20010803151518.Y23782@cygbert.vinschen.de> <996845317.24251.9.camel@lifelesswks> <20010804215935.N23782@cygbert.vinschen.de> <20010804172101.B4457@redhat.com>
X-SW-Source: 2001-q3/msg00054.html

On Sat, Aug 04, 2001 at 05:21:01PM -0400, Christopher Faylor wrote:
> On Sat, Aug 04, 2001 at 09:59:35PM +0200, Corinna Vinschen wrote:
> >I haven't found such a problem. I had no endless loop. However, I have
> >a redefined solution which doesn't use stat(). Instead it converts
> >the /etc/passwd and /etc/group paths to win32 paths and accesses them
> >directly using FileFirstFind() which should be way faster.
> 
> This is probably ok but there is a potential gotcha if the user changes
> a mount or makes a symbolic link to /etc/passwd or something.

Who would do that on a POSIX system?

IMO, we're just talking about rereading /etc/passwd and /etc/group
when it has changed it's content w/o restarting a process.

Why should a user expect to be able to change the path to the passwd
file w/o restarting a process?

> >If we additionally change the read_etc_passwd() and read_etc_group()
> >code so that direct win32 calls are used for reading the files, we could
> >perhaps speed up Cygwin again a few percent.
> 
> I think we'd get much more savings by moving /etc/passwd info into either
> the cygwin heap
      ^^^^^^^^^^^
      the best compromise

>                 or shared memory so that /etc/passwd wasn't read by
                     ^^^^^^^^^^^^^
		     the best way but difficult

> each exec'ed process.  Then the file would only be read when it was
> needed.

I will work on moving the stuff into cygheap.

However, I would still prefer to get the /etc/passwd path once,
translate it into a Win32 path and work with that. If each access
to passwd and group information requires checking file modification
time, it's not that clever to have to convert the path all the time,
IMO.

> Actually, it's possible that /etc/passwd isn't read by an exec'ed process
> now unless it needs to look up a uid other than it's own.  I don't know
> for sure.

It doesn't look so, at least with ntsec on which often needs the
uid/gid <-> SID mappings.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
