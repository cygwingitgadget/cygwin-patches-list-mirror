Return-Path: <cygwin-patches-return-3759-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20331 invoked by alias); 27 Mar 2003 11:18:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20306 invoked from network); 27 Mar 2003 11:18:30 -0000
Subject: Re: [PATCH] The great pthread rename
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303271208480.486-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0303271208480.486-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VU7SwqdFmAPmhBa9yovV"
Organization: 
Message-Id: <1048763903.5593.17.camel@localhost>
Mime-Version: 1.0
Date: Thu, 27 Mar 2003 11:18:00 -0000
X-SW-Source: 2003-q1/txt/msg00408.txt.bz2


--=-VU7SwqdFmAPmhBa9yovV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 674

On Thu, 2003-03-27 at 22:11, Thomas Pfaff wrote:
> Do not try to force me to comment every bit of this patch ;-)
>=20
> 2003-03-27  Thomas Pfaff  <tpfaff@gmx.net>
>=20
> 	* thread.h: Change class names, methods, members and local vars
> 	according to the GNU coding style.
> 	* thread.cc: Ditto.
> 	* dcrt0.cc (dll_crt0_1): Rename pthread::initMainThread call to
> 	pthread::init_mainthread.
> 	* pthread.cc (pthead_getsequence_np): Rename pthread::isGoodObject
> 	call to pthread::is_good_object.

Reminds me why I don't require the GNU standards for setup.exe :}.

Thanks, and please apply.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-VU7SwqdFmAPmhBa9yovV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+gt3/I5+kQ8LJcoIRAvWpAJ9pBSlP5aqtedo6cE0A6doBz4D30wCfZlaG
4I85uZlj2DDfAT1/8Bh1s0I=
=pdET
-----END PGP SIGNATURE-----

--=-VU7SwqdFmAPmhBa9yovV--
