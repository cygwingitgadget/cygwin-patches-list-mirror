From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: RE: updated: Categories and basic dependency handling for setup
Date: Wed, 13 Jun 2001 21:09:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF7A01@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00296.html

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ]
> Sent: Thursday, June 14, 2001 1:53 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: updated: Categories and basic dependency 
> handling for setup
> 
> 
> On Thu, Jun 14, 2001 at 01:23:53PM +1000, Robert Collins wrote:
> >Take 5:]
> 
> That installed cleanly modulo the recent commenting changes that
> I *just* checked in.

Good timing :].
 
> Do you have a marked up setup.ini that you're using?

I have a couple of test ones, but not a fully done one. I'll put one
together.
 
> I have to say that this isn't exactly what I envisioned when we were
> talking about categories.  While the low level execution was exactly
> what I expected.  On the GUI layer, I'd thought we'd start out at the
> "Category Level" and then click on the specific category to get an
> expanded view.

That can be done. I figured putting something together would get the
comments coming in :].
I'm trying to avoid making a complex system, that needs lots of clicks
to make work. Thus I'm trying to use as much context and history as
possible (ie ignore category when a package is already installed).

I'm approaching category from the point of view that some things are
"Core" or "Required" and others are for "Development" and others are for
"XFree86". 

From that angle, it might be nice to turn on everything in "Development"
with one mouse click - and for that a separate screen, or a alternate
list display could be useful.

However: I think it's better to do that using package dependencies,
rather than whole-category manipulation. 

For example if we have a blank package, with no files in it, that
depends on gcc and binutils and make and autoconf and automake and ash
and cygwin. Call that package "Development workstation". Then by
clicking on "development workstation" I will get all the dependent
packages automatically, without needing a separate screen to switch
into.
 
I'll put a package demonstrating that in my setup.ini.

> I also thought that a package should be able to be part of more than
> one category.

That's easy enough to accomodate. But... it really depends on what you
mean by "category". I'm treating categories as more a visual indication
to the user, and for a basic default of "Required = install"/"anything
else = don't install"
 
> Also, if we do go with this, we'll have to diddle with the chooser
> dialog box again.  I extended the size for the last release.  It's a
> pain getting all of the controls to line up correctly after you expand
> it.

Sure :}.
 
> cgf
> 
