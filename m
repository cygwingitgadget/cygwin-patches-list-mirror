Return-Path: <cygwin-patches-return-3032-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 639 invoked by alias); 23 Sep 2002 21:32:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 625 invoked from network); 23 Sep 2002 21:32:50 -0000
Subject: Re: [PATCH] Reset threadcount after fork
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209231434400.294-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0209231434400.294-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-N+CcSj/an+xYIIj+/rN4"
Date: Mon, 23 Sep 2002 14:32:00 -0000
Message-Id: <1032816802.8314.15.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00480.txt.bz2


--=-N+CcSj/an+xYIIj+/rN4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 289

On Mon, 2002-09-23 at 22:36, Thomas Pfaff wrote:
>=20
> 2002-09-23  Thomas Pfaff  <tpfaff@gmx.net>
>=20
> 	* thread.cc (MTinterface::fixup_after_fork): Reset threadcount to
> 	1 after fork.

Why do we need this? MTinterface::Init is also called after fork, and
sets threadcount to 1.

Rob

--=-N+CcSj/an+xYIIj+/rN4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9j4iiI5+kQ8LJcoIRApuaAJ41CKXrnO5GFrS3qOf3+GCvx4dDpwCfTCDT
LW/q65e9IGBoIZAN2nc3tW4=
=iXix
-----END PGP SIGNATURE-----

--=-N+CcSj/an+xYIIj+/rN4--
