From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Mon, 07 May 2001 21:32:00 -0000
Message-id: <20010508000842.A3591@redhat.com>
References: <VA.00000757.0015edd1@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00197.html

On Thu, May 03, 2001 at 05:06:38PM -0400, Brian Keener wrote:
>And now here is the actual diff for the change.

I've applied this patch.

I like the "Reinstall" option but I am not quite sure what the
"Sources" option does.  It will install the sources from the
requested source, whether it is the internet or the local directory,
right?

One problem that I had is that the installation of the sources
ignored my mount setting for /usr/src and/or /src.  It extracted
directly to (in my case) f:/cygwin/usr/src which made the extraction
invisible to me, since /usr/src is mounted elsewhere.

I don't know if this is a new problem of if setup.exe has always
worked like this, but this is a bug that could theoretically cause
us problems.  Anyone want to look at this one?

Thanks for the patch.

cgf
