From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: patch to rmdir
Date: Mon, 22 May 2000 03:36:00 -0000
Message-id: <39290ADA.B1A4ED7A@vinschen.de>
References: <3927E038.FF38FB02@vinschen.de> <20000521184132.E1386@cygnus.com>
X-SW-Source: 2000-q2/msg00070.html

Chris Faylor wrote:
> 
> Does this fix the erroneous error when you do a:
> 
> rmdir somefilethatisnotadirectory
> 
> too?

No.

Is it worth to check that, too? To figure out _why_
permission is denied is somewhat complicated and
I'm sure that slows things down much. The primary
information (rmdir failed) is given back to the
application, though.

Nevertheless I'm hoping that samba 2.0.7 will have
fixed that problems.

Corinna
