From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: updated: Categories and basic dependency handling for setup
Date: Thu, 14 Jun 2001 01:00:00 -0000
Message-id: <004301c0f4a8$2d6f0ef0$0200a8c0@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F069@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00299.html

By the way, just to be clear: I'm not going to put a changelog together
again, until the patch is fully acceptable - and I didn't mean to
include my temp change to getpkgbyname in the patch (I was tracking a
bug).

Rob

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, June 14, 2001 3:39 PM
Subject: RE: updated: Categories and basic dependency handling for setup



> -----Original Message-----
> From: Robert Collins
>
>
> > -----Original Message-----
> > From: Christopher Faylor [ mailto:cgf@redhat.com ]
> > Sent: Thursday, June 14, 2001 1:53 PM
> >
> >
> > On Thu, Jun 14, 2001 at 01:23:53PM +1000, Robert Collins wrote:
> > >Take 5:]
> >
> > That installed cleanly modulo the recent commenting changes that
> > I *just* checked in.
>
> Good timing :].
>
> > Do you have a marked up setup.ini that you're using?
>
> I have a couple of test ones, but not a fully done one. I'll put one
> together.
>

I have attach a development "group" package, and a roughly marked up
setup.ini that demonstrates dependencies (multiple levels thereof) and
using a signle emtpy package "development" to include all the
development packages by name.

This patch will also play much nicer from a usability point of view.

Rob

