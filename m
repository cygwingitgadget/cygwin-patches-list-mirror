From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Wed, 18 Jul 2001 04:02:00 -0000
Message-id: <20010718130154.E730@cygbert.vinschen.de>
References: <20010717221042.A426@dothill.com>
X-SW-Source: 2001-q3/msg00013.html

On Tue, Jul 17, 2001 at 10:10:42PM -0400, Jason Tishler wrote:
> Cygwin no longer correctly handles the case when the file passed to
> unlink() does not exist -- unlink() incorrectly returns 0.
> [...]
> Index: syscalls.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
> retrieving revision 1.128
> diff -u -p -r1.128 syscalls.cc
> --- syscalls.cc	2001/07/14 00:09:33	1.128
> +++ syscalls.cc	2001/07/18 01:54:21
> @@ -155,7 +155,7 @@ _unlink (const char *ourname)
>    if (h == INVALID_HANDLE_VALUE)
>      {
>        if (GetLastError () == ERROR_FILE_NOT_FOUND)
> -	goto ok;
> +	goto err;
>      }
>    else
>      {

IMO, that's rather late in the function to handle a nonexistant file.
I checked in a different solution which handles it more at the 
beginning of _unlink(). Thanks for tracking it down, though.

BTW, I have a naive question related to unlink. I had just another
look into SUSv2 and to my surprise it defines the following error
code:

[EBUSY]    The file named by the path argument cannot be unlinked
           because it is being used by the system or another process
	   and the implementation considers this an error.

which basically means, if we try to unlink a file and that fails,
we wouldn't have to force it by ugly tricks (delqueue) but just
return EBUSY and Cygwin would still be SUSv2 compliant.

All: Would that be ok to change or would you like to keep the current
     behaviour?
     
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
