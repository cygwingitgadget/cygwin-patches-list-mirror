From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Tue, 08 May 2001 18:23:00 -0000
Message-id: <VA.0000075b.00481c6e@thesoftwaresource.com>
References: <VA.00000757.0015edd1@thesoftwaresource.com> <20010508000842.A3591@redhat.com>
X-SW-Source: 2001-q2/msg00205.html

Christopher Faylor wrote:
> "Sources" option does.  It will install the sources from the
> requested source, whether it is the internet or the local directory,
> right?
>
Correct.  Or it will download the sources from the Internet if you 
selected download from Internet.  "Sources only" and "Redo Sources" only 
applies to the current installed version since it is always on the left 
side of the selection window.  This is the equivalent of 
ReDownload/Reinstall for the Binaries package.  They only apply to the 
current since selecting any of the other version on the right side of the 
window gives you the option for source. 
 
> directly to (in my case) f:/cygwin/usr/src which made the extraction
> invisible to me, since /usr/src is mounted elsewhere.
>
> I don't know if this is a new problem of if setup.exe has always
> worked like this, but this is a bug that could theoretically cause
> us problems.  Anyone want to look at this one?

I'm not sure I ever noticed and/or knew where they go when installed.  I 
vaguely remember a change being discussed not long ago about changing 
and/or making it operator specified where the source was installed - but 
I haven't checked the ChangeLog yet.  It will be a few days for me to get 
a chance to check if anyone else wants a shot.

bk


