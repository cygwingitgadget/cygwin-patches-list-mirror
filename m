Return-Path: <cygwin-patches-return-3009-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31096 invoked by alias); 20 Sep 2002 12:50:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31081 invoked from network); 20 Sep 2002 12:50:24 -0000
Subject: Re: [PATCH] pthread_fork Part 3
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0208162232370.-283127@thomas.kefrig-pfaff.de>
References: <Pine.WNT.4.44.0208162232370.-283127@thomas.kefrig-pfaff.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-9wQUOOWK4+++08XohP5C"
Date: Fri, 20 Sep 2002 05:50:00 -0000
Message-Id: <1032526255.9135.61.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00457.txt.bz2


--=-9wQUOOWK4+++08XohP5C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 859

On Sat, 2002-08-17 at 06:55, Thomas Pfaff wrote:
>=20
> Pthread key destructor handling revised. IMHO it does not make sense to
> handle two lists with keys, one with all keys, one with its destructors.
> The destructors are now part of the key class.

I agree with the duplication of code. This is one area I'd really really
really like to use templates.=20

Chris, Corinna, if we ever get the chance to use templates please tell
me so! It makes code clarity and size so much better.

Anyway, yes, we should only have one list. So yes, please do refactor
the two together in the way I've arranged the pthread_keys::keys list.

Note that you have a comment on non thread safeness in the new
pthread_keys code. I thought I had addressed that in my list code, could
you either tell me I was also not thread safe, or correct that at the
same time?

Cheers,
Rob


--=-9wQUOOWK4+++08XohP5C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ixmvI5+kQ8LJcoIRAuc/AJ49+INYfEEXMXYfKRMLmTTr3BLxVQCgl00l
qaxno3OQnvaKOxV/e6DI3Tw=
=Kgve
-----END PGP SIGNATURE-----

--=-9wQUOOWK4+++08XohP5C--
