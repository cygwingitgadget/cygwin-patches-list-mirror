From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: updated: Categories and basic dependency handling for setup
Date: Wed, 13 Jun 2001 20:52:00 -0000
Message-id: <20010613235238.A14365@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F065@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00295.html

On Thu, Jun 14, 2001 at 01:23:53PM +1000, Robert Collins wrote:
>Take 5:]

That installed cleanly modulo the recent commenting changes that
I *just* checked in.

Do you have a marked up setup.ini that you're using?

I have to say that this isn't exactly what I envisioned when we were
talking about categories.  While the low level execution was exactly
what I expected.  On the GUI layer, I'd thought we'd start out at the
"Category Level" and then click on the specific category to get an
expanded view.

I also thought that a package should be able to be part of more than
one category.

Also, if we do go with this, we'll have to diddle with the chooser
dialog box again.  I extended the size for the last release.  It's a
pain getting all of the controls to line up correctly after you expand
it.

cgf
