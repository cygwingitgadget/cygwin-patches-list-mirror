Return-Path: <cygwin-patches-return-3721-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27708 invoked by alias); 19 Mar 2003 22:05:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27516 invoked from network); 19 Mar 2003 22:05:16 -0000
Subject: Re: [PATCH] pthread_equal
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303191449530.257-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0303191449530.257-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pdHUA7Dt8z+r7MvlxLGn"
Organization: 
Message-Id: <1048111508.5305.166.camel@localhost>
Mime-Version: 1.0
Date: Wed, 19 Mar 2003 22:05:00 -0000
X-SW-Source: 2003-q1/txt/msg00370.txt.bz2


--=-pdHUA7Dt8z+r7MvlxLGn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 795

On Thu, 2003-03-20 at 00:54, Thomas Pfaff wrote:
> 2003-03-19  Thomas Pfaff  <tpfaff@gmx.net>
>=20
> 	* pthread.cc (pthread_equal): Replacement for pthread_equal in
> 	thread.cc.
> 	* thread.cc: Rename pthread_equal to pthread::equal throughout.
> 	(pthread_equal): Remove.
> 	* thread.h (pthread::equal): New static method.

This seems mostly pointless to me.

A few notes:

Why use a static method? you'll always have one pthread to compare to ,
so using operator =3D=3D is appropriate. In fact, operator =3D=3D already d=
oes
the right thing as it is the entire contents of pthread_equal.

So: where pthread_equal is used internally, you could switch to (for
instance)
=3D=3D
 if (&thread =3D=3D joiner)
=3D=3D

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-pdHUA7Dt8z+r7MvlxLGn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eOmTI5+kQ8LJcoIRAmpEAJ99DcrpkJ/AqyepYMYHPVBko3JnGwCdE8qS
sXY5YCGwyxCVtjDRQ4ihrQE=
=nnss
-----END PGP SIGNATURE-----

--=-pdHUA7Dt8z+r7MvlxLGn--
