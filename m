From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: tzname
Date: Tue, 27 Mar 2001 06:01:00 -0000
Message-id: <01aa01c0b6c6$293a4b80$0200a8c0@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF02E2B2@itdomain002.itdomain.net.au> <3AC09288.13581E12@yahoo.com> <018601c0b6c0$03170430$0200a8c0@lifelesswks> <3AC09C62.9EF2183B@yahoo.com>
X-SW-Source: 2001-q1/msg00253.html

----- Original Message -----
From: "Earnie Boyd" <earnie_boyd@yahoo.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Sent: Tuesday, March 27, 2001 11:57 PM
Subject: Re: tzname


> Robert Collins wrote:
> >
> > ----- Original Message -----
> > From: "Earnie Boyd" <earnie_boyd@yahoo.com>
> > To: "Robert Collins" <robert.collins@itdomain.com.au>
> >
> > Everything I've actually cross checked has matched.
> >
>
> That's good to hear.  I've used the opengroup for reference before and
> glad to know I can count on it.

<grin> it's not quite the same thing :]

> Q: Is _tznames an ANSI spec?  Cygwin supports both ANSI and POSIX.
>

No idea - I went to build a package (netsaint), it had tzname hard coded
(well that or tm->timezone via configure), so I goooooogled for tzname,
read the spec, compared with cygwin, tried a define.. it worked and
voila a patch was mailed.

My personal concept: patch the OS not the package :]

Rob.

