From: Jon Ericson <Jonathan.L.Ericson@jpl.nasa.gov>
To: <cygwin-patches@cygwin.com>
Cc: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: ispell package
Date: Wed, 28 Feb 2001 13:13:00 -0000
Message-id: <86ofvmjyvz.fsf@jon_ericson.jpl.nasa.gov>
X-SW-Source: 2001-q1/msg00134.html

Inspired by the recent call for contributors
( http://sources.redhat.com/ml/cygwin/2001-02/msg01512.html ), I
contacted Pierre A. Humblet, who maintains a Cygwin binary of ispell:
ftp://ftp.franken.de/pub/win32/develop/gnuwin32/cygwin/porters/Humblet_Pierre_A

He kindly gave me the go-ahead to contribute an "official" ispell
package, but expressed the following:

> The things that have kept me back from offering it are: 
> a) the Franken site is already well known and the ispell site points
>   to it, so users should have no problem finding it.
> b) Cygnus does not have a good mechanism to specify optional
>   packages and I already feel burdened having to upload
>   optional packages I could do without (turning them off
>   each time I upload is a pain). Thus I don't want
>   to impose ispell on others.
> c) What dictionaries to include ? (with impact on b))

Given that Cygwin is fairly English-centric at the moment, I plan on
packaging only the American and British dictionaries.  I wonder what
will happen when someone offers a German or Spanish or ... package?

In the meantime, I am starting on the instructions for building a
cygwin package
( http://cygwin.com/ml/cygwin-apps/2000-11/msg00055.html ).  Is the /usr
versus /usr/local a hard and fast rule?

Jon
