From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: win95 and pshared mutex support for pthreads
Date: Tue, 24 Apr 2001 15:12:00 -0000
Message-id: <01b001c0cd0b$cf997950$0200a8c0@lifelesswks>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010424232202.A23753@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00146.html

----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, April 25, 2001 7:22 AM
Subject: Re: win95 and pshared mutex support for pthreads


> On Thu, Apr 19, 2001 at 08:38:18PM +1000, Robert Collins wrote:
> > The code is a little ugly, but it still passes all my testcases.
> >
> > The ABI HAS NOT CHANGED. It may have to support pshared condition
> > variables properly, but I wanted to get the win95 support submitted.
> >
> > Rob
> >
> > Thu Apr 19 20:22:00 2001  Robert Collins <rbtcollins@hotmail.com>
> >
> >  * password.cc (getpwuid): Check for thread cancellation.
> >  (getpwuid_r): Ditto.
> >  (getpwname): Ditto.
> >  (getpwnam_r): Ditto.
>
> Robert,
>
> may I ask why your new reentrant functions ignore the pw_gecos
> field? You know that it's very important when using ntsec?

I didn't realise that I ignored anything. If I missed copying a field
across it will be because I wrote from a spec and their struct
definition, not the cygwin internals. - Sorry.

Rob

> Chris, I assume that it's not a showstopper but I will patch
> it for 1.3.2.  My upcoming changes to the security code will
> need reentrant getpwxxx and getgrxxx functions.
>
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin
to
> Cygwin Developer
mailto:cygwin@cygwin.com
> Red Hat, Inc.
>
