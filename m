Return-Path: <cygwin-patches-return-3770-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15095 invoked by alias); 27 Mar 2003 19:55:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15086 invoked from network); 27 Mar 2003 19:55:44 -0000
Subject: Re: [PATCH] Change pthread equations
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303271347440.479-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0303271347440.479-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9eIYzQg2DqKixhQQafYc"
Organization: 
Message-Id: <1048794932.4371.23.camel@localhost>
Mime-Version: 1.0
Date: Thu, 27 Mar 2003 19:55:00 -0000
X-SW-Source: 2003-q1/txt/msg00419.txt.bz2


--=-9eIYzQg2DqKixhQQafYc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 648

On Thu, 2003-03-27 at 23:52, Thomas Pfaff wrote:
> 2003-03-27  Thomas Pfaff  <tpfaff@gmx.net>
>=20
> 	* thread.cc: Change 1=3D=3Dfoo equations to foo=3D=3D1 throughout.

Thanks again - please apply.

I don't know if you meant to do this:
-  return (pthread_equal ((*mutex)->owner, self)) && 1 =3D=3D
(*mutex)->recursion_counter;
+  return ((*mutex)->recursion_counter =3D=3D 1 && pthread_equal
((*mutex)->owner, self));

But it's actually more than just changing 1=3D=3Dfoo to foo=3D=3D1. If there
where side effects in pthread_equal, the meaning would have changed.
Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-9eIYzQg2DqKixhQQafYc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+g1c0I5+kQ8LJcoIRAhObAJ9AzrJ62MQho9DJGorQfzDapihacgCdFhZN
ZM5V/QjtFfCbn3afB7zTYak=
=vQsd
-----END PGP SIGNATURE-----

--=-9eIYzQg2DqKixhQQafYc--
