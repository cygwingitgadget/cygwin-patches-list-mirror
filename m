From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "CP List" <Cygwin-Patches@Cygwin.Com>
Cc: "Gareth Pearce" <tilps@hotmail.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Mon, 12 Nov 2001 14:32:00 -0000
Message-ID: <02c901c16bca$1a7e5fa0$0200a8c0@lifelesswks>
References: <OE65oDk9X2VFyBUMeEk0000ecac@hotmail.com> <01fe01c16916$a920a350$0200a8c0@lifelesswks> <3BEBC8F6.3B150BA3@yahoo.com> <021401c16976$7a591380$0200a8c0@lifelesswks> <3BEFCB8E.C0507FBD@yahoo.com>
X-SW-Source: 2001-q4/msg00205.html
Message-ID: <20011112143200.kZQp7zUgI0N7_ChtVcQxALH8sScBBgDAgNVtnzQagC8@z>

----- Original Message -----
From: "Earnie Boyd" <earnie_boyd@yahoo.com>


> Robert Collins wrote:
>
> > There was an earlier thread on skip vs keep, and what they mean.
> >
> > It was on cyg-apps IIRC.
> >
>
> That's fine, I half recall the thread and at the time didn't have time
to
> voice an opinion.  I know skip is intended for the not-installed
packages
> and keep is intended for the already-installed packages.  However, in
the
> current invocation skip is relative to both and IMO should still be
relative
> to both.  Skip for the not-installed means leave it not-installed
(i.e.:
> leave it as is) and skip for the already-installed means don't update
what I
> have (i.e.: leave it as is).  Setup does this now, there isn't a
coding
> change for it.  IMHO, keep should be removed in favor of skip.  As I
said,
> it may be too late to say anything but...
>

At this point, I'm against any code changes that aren't release
critical.

I'm happy for this to be debated to death for the HEAD branch though.
I'm not convinced that having a separate skip/keep for the user makes
sense, but then I'm not convinced that a spin control is best their
either..

Certainly the innards of choose.cc need reworking, and I'd kinda like to
do that before bit twiddling choose.cc's gui.

Rob
