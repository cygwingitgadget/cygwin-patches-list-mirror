From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Thu, 20 Dec 2001 04:08:00 -0000
Message-ID: <01db01c1894e$fc9370a0$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKIEAFCIAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00341.html
Message-ID: <20011220040800.8eui-bjYBm0K5ZTt8U-RqdEsN-92Gn7BWC3_hnR8EvU@z>

Last time around hopefully!

1) format your changelog with line wrap at 80 columns.
2) It's a changelog, so if you #if 0 and then remove a function during
your local testing, the final change is actually just a remove.
Likewise, chooser.[cc|h] should not be mentioned because it never exists
(from CVS's viewpoint).
3) You've _Still_ got blank lines in the log.
4) You've got multiple log entries - this is going in as a single
commit, so thats inappropriate (IMO, open to discussion).

In a nutshell: This is a Changelog from CVS 'NOW' to CVS 'after the
commit'.
The acid test I recommed you perform is to walk through the .diff with
the changelog
open beside you. Make sure all changes are listed, and you also get to
do a code walkthrough for free.

5) (Blame me) Remove the change to link against comctl32 - thats in CVS
now (I've checked in my working dir as I recently got stable again the
chooser). (Which, IMO is starting to 'get there'.)

It's not a historical set of notes that you've gone through in your
sandbox but rather an explanation of the desired effect of the change
getting committed.

Don't worry about sending updated source, I just need the ChangeLog and
it'll all get committed.

Rob

===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Thursday, December 20, 2001 5:19 PM
Subject: [PATCH] Update 2 - Setup.exe property sheet patch


> Changes as per your (Rob) last email, plus a few other improvements.
Diff, new
> files, and ChangeLog attached.
>
> --
> Gary R. Van Sickle
> Brewer.  Patriot.
>
