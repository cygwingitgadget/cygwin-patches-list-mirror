From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall Makefile.in patch
Date: Wed, 09 May 2001 06:46:00 -0000
Message-id: <20010509094441.E30036@redhat.com>
References: <Pine.NEB.4.30.0105090130300.18125-200000@cesium.clock.org>
X-SW-Source: 2001-q2/msg00208.html

On Wed, May 09, 2001 at 01:34:34AM -0700, Matt wrote:
>2001-05-09  Matt Hargett <matt@use.net>
>
>	* Makefile.in: Remove *.rc from clean.
>
>
>--
>
>Doing a make clean in the cinstall directory removed res.rc, which must
>then be checked out again. I thought this was fixed before?

I don't know if it was fixed before but I've checked in your patch.

Thanks.

cgf
