Return-Path: <cygwin-patches-return-3059-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32348 invoked by alias); 17 Oct 2002 08:46:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32284 invoked from network); 17 Oct 2002 08:46:21 -0000
Subject: Re: [PATCH] fix segv in pthread_mutex::init
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0210170959560.243-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0210170959560.243-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-LkLbzm/s3St08HpvohsR"
Date: Thu, 17 Oct 2002 01:46:00 -0000
Message-Id: <1034844379.11145.41.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q4/txt/msg00010.txt.bz2


--=-LkLbzm/s3St08HpvohsR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 785

On Thu, 2002-10-17 at 18:11, Thomas Pfaff wrote:
>=20
> This patch should fix the segfault in pthread_mutex::init by changing the
> test order for a valid object and checking for valid initializer object
> first..

I'm happy with the verifyable_object change. I'm not happy with the
pthread_mutex::init change (yet).

I've checked in the verifyable_object stuff, along with a
pthread_mutex::init change I am happy with.

The reason I wasn't happy with your change was threefold:
1) there is no need to add scoping to static calls within a class. Doing
so reduces readability, and should be avoided.
2) The test was no longer *obvious* at first read, whereas (IMO) what
I've checked in is.

Cheers,
Rob

--=20
---
GPG key available at: http://users.bigpond.net.au/robertc/keys.txt.
---

--=-LkLbzm/s3St08HpvohsR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9rnjaI5+kQ8LJcoIRAvhwAKCION9TskkdPoUl7xXAWBWz15GnMQCgpqyG
KMQ+mLHYKcfDrfhqqnilvjc=
=Cm3d
-----END PGP SIGNATURE-----

--=-LkLbzm/s3St08HpvohsR--
