From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: patch to rmdir
Date: Mon, 22 May 2000 07:57:00 -0000
Message-id: <20000522105658.A6307@cygnus.com>
References: <3927E038.FF38FB02@vinschen.de> <20000521184132.E1386@cygnus.com> <39290ADA.B1A4ED7A@vinschen.de>
X-SW-Source: 2000-q2/msg00071.html

On Mon, May 22, 2000 at 12:24:26PM +0200, Corinna Vinschen wrote:
>Chris Faylor wrote:
>>Does this fix the erroneous error when you do a:
>>
>>rmdir somefilethatisnotadirectory
>>
>>too?
>
>No.
>
>Is it worth to check that, too?  To figure out _why_ permission is
>denied is somewhat complicated and I'm sure that slows things down
>much.  The primary information (rmdir failed) is given back to the
>application, though.
>
>Nevertheless I'm hoping that samba 2.0.7 will have fixed that problems.

It's not that hard.  If you get an "EACCESS" and the file is not a
directory then the errno should be set to ENOTDIR.

It is important that Cygwin act like UNIX as much as possible and
I think that EACCESS is always wrong.

cgf
