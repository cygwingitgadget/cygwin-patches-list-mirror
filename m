From: "Dr. Volker Zell" <Dr.Volker.Zell@oracle.com>
To: cygwin-patches@cygwin.com
Cc: bleau@igb.umontreal.ca
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Tue, 08 May 2001 09:21:00 -0000
Message-id: <kvitjb3j7r.fsf@vzell.de.oracle.com>
References: <VA.00000757.0015edd1@thesoftwaresource.com> <20010508000842.A3591@redhat.com>
X-SW-Source: 2001-q2/msg00204.html

>>>>> "Christopher" == Christopher Faylor <cgf@redhat.com> writes:

    Christopher> On Thu, May 03, 2001 at 05:06:38PM -0400, Brian Keener wrote:
    >> And now here is the actual diff for the change.

    Christopher> I've applied this patch.

    Christopher> I like the "Reinstall" option but I am not quite sure what the
    Christopher> "Sources" option does.  It will install the sources from the
    Christopher> requested source, whether it is the internet or the local directory,
    Christopher> right?

    Christopher> One problem that I had is that the installation of the sources
    Christopher> ignored my mount setting for /usr/src and/or /src.  It extracted
    Christopher> directly to (in my case) f:/cygwin/usr/src which made the extraction
    Christopher> invisible to me, since /usr/src is mounted elsewhere.

The same happened to me with the latest opengl-1.1.0-4.tar.gz package.
Some files were installed directly under in my case D:\usr\lib and D:\usr\bin.
But my mount table looks like the following so the files were effektively invisible
to me.

C:\gnu on /gnu type system (binmode)
D:\bin on /usr/bin type system (binmode)
D:\lib on /usr/lib type system (binmode)
C: on /dev/c type system (binmode)
D: on / type system (binmode)
b: on /b type system (binmode,noumount)
e: on /e type system (binmode,noumount)
f: on /f type system (binmode,noumount)


Ciao
  Volker
