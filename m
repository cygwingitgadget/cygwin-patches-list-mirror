From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>, <cygwin-patches@cygwin.com>
Subject: RE: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Wed, 09 May 2001 21:09:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA7@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00220.html

> -----Original Message-----
> From: Brian Keener [ mailto:bkeener@thesoftwaresource.com ]
> Sent: Thursday, May 10, 2001 2:03 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: [patch] setup.exe changes for 
> Redownload/Reinstall Current
> version or Sources only - Part 2
> 
> 
> 
> Pretty sure that extra is the new stuff for the source file which is 
> referenced in the change log, but as I said - I am unclear how setup 
> should (as you say) honor the mount point and thus what I 
> need to do to 
> fix.  If you could provide some additional clarification.

The map_filename function needs to be extended with the mount point
logic from cygwin1.dll. I spent 20 odd minutes looking in vain for an
old email thread from DJ about this. (It's come up before).

IIRC essentially setup.exe only looks at / and creates the inital mount
points if they don't exist, but _doesn't use them_. Anyway - grab the
mount point logic from the cygwin source and see if you can link to that
file in building setup.exe. (It's better not to fork the mount point
logic code, as it should only need to be changed in one place).

Rob
 
> bk
> 
> 
> 
