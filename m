Return-Path: <cygwin-patches-return-2991-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20174 invoked by alias); 17 Sep 2002 10:06:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20160 invoked from network); 17 Sep 2002 10:06:12 -0000
Subject: Re: [PATCH] new mutex implementation 2. posting
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209171121040.297-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0209171121040.297-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-e6GmKB1V3SljwhijGgg8"
Date: Tue, 17 Sep 2002 03:06:00 -0000
Message-Id: <1032257204.17674.192.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00439.txt.bz2


--=-e6GmKB1V3SljwhijGgg8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 945

On Tue, 2002-09-17 at 19:34, Thomas Pfaff wrote:
>=20
> This patch contains a new mutex implementation.
>=20
> The advantages are:
>=20
> - Same code on Win9x and NT. Actual are critical sections used on NT and
>   kernel mutexes on 9x.

Are you saying it uses critical sections on NT? (i.e. is that MS's
uinderlying implementation for semaphores?)

> - Posix compliant error codes.

I thought we where before. Can you be more specific?

> - State is preserved after fork as it should.

Likewise, I know this has already been implemented. What was not
preserved previously?

> - Supports both errorchecking and recursive mutexes.

This is nice. It shouldn't need a new implementation though. What I mean
is: lets understand the ramifications first.

> - Should be at least as fast as critical sections.

I don't understand how it can be, if semaphores are based on critical
sections, it can't be faster. Or am I wearing my dumb hat today?

Rob


--=-e6GmKB1V3SljwhijGgg8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hv6zI5+kQ8LJcoIRAlxNAJ9VJvhD/U4ilN67dY4eIYMjuUqHwQCfarXH
HT2C0XuqlGbVbvEgGwMHAPg=
=XQaX
-----END PGP SIGNATURE-----

--=-e6GmKB1V3SljwhijGgg8--
