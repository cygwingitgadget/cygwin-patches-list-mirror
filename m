Return-Path: <cygwin-patches-return-3633-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21403 invoked by alias); 27 Feb 2003 12:27:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21394 invoked from network); 27 Feb 2003 12:27:45 -0000
Subject: Re: [PATCH] MTInterface fixup_after_fork
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0302271021490.285-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0302271021490.285-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kxftFciKwj3zqgwiQqOf"
Organization: 
Message-Id: <1046348854.16694.20.camel@localhost>
Mime-Version: 1.0
Date: Thu, 27 Feb 2003 12:27:00 -0000
X-SW-Source: 2003-q1/txt/msg00282.txt.bz2


--=-kxftFciKwj3zqgwiQqOf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 336

On Thu, 2003-02-27 at 23:25, Thomas Pfaff wrote:
> Required for the rwlock patch.
>=20
> 2003-02-27  Thomas Pfaff  <tpfaff@gmx.net>
>=20
> 	* thread.cc (MTinterface::fixup_after_fork): Initialize mainthread
> 	prior to pthread objects.
>=20

Please apply.
Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-kxftFciKwj3zqgwiQqOf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+XgQ2I5+kQ8LJcoIRAqnqAKCSFUvzpqJLnp30uk+Vv35czCF23QCeJgLS
aZUdurB4LC9L75YYQ8ykjwI=
=oxr/
-----END PGP SIGNATURE-----

--=-kxftFciKwj3zqgwiQqOf--
