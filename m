From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: updated: Categories and basic dependency handling for setup
Date: Wed, 13 Jun 2001 15:21:00 -0000
Message-id: <006c01c0f457$59d7f070$0200a8c0@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF7A00@itdomain002.itdomain.net.au> <20010613162448.M1144@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00290.html

----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, June 14, 2001 12:24 AM
Subject: Re: updated: Categories and basic dependency handling for setup


> On Wed, Jun 13, 2001 at 04:48:06PM +1000, Robert Collins wrote:
> > Sorry about this - trivial addition to the last patch, to handle
> > dependencies of dependencies.
> >
> >
> > Rob
>
> I just tried your patch in a local directory and it's somewhat
> wierd. I only added a
>
> category: shell
>
> to the `ash' part of setup.ini.
>
> If I have everything installed (I have a installed.db file in
> /etc/setup) the chooser contains the text `Nothing to install'.
> Clicking on `full' shows the `shell' category in ash. That's
> ok.

If a package is already installed, I ignored the category for the
default_trust. My theory being that you don't want to stop updateing
something you already have.

> If I have no installed.db file (pretending to have no Cygwin
> installation) I'm getting a list of all packages, except for
> `ash'. `ash' is only visible in the `full' view again and
> I have supposedly the version "2.4.PRE-STABLE" installed --
> which is a squid version number -- and `ash' is marked for
> being skipped.

I don't know where the version 2.4.PRE-STABLE is coming from, I'll look
into that.

Anything not
a) in category "Required"
b) is depended on by a package in category "Required" will be skipped by
default.

> Did I miss something?

No. I didn't explain my logic before :]. I've gone for a simple but
should do what we need approach - rather than features provided by
packages and dependencies requiring features, dependencies require
packages.

Example
ash is given category required
autoconf is given category dev
automake is given category dev, and requires: autoconf

on a clean install the user will see ash, but not automake or autoconf.
Clicking on full/part will show everything, and then clicking on
automake will add autoconf (in preference of current version, then prev,
then experimental) as well.

example 2
the above list is extended: gcc is added, with category required, and
requires:make
make is added, category dev

on a clean install the user will see ash, gcc and make.

Hope this clears is up a bit. I'll look into the funny version number is
coming from..
Rob

> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin
to
> Cygwin Developer
mailto:cygwin@cygwin.com
> Red Hat, Inc.
>
