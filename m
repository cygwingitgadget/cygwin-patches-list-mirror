Return-Path: <cygwin-patches-return-3383-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12214 invoked by alias); 13 Jan 2003 12:50:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12196 invoked from network); 13 Jan 2003 12:50:04 -0000
Subject: Re: [PATCH] Make wait4 a pthread cancellation point
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0301131330030.237-300000@algeria.intern.net>
References: <Pine.WNT.4.44.0301131330030.237-300000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D+CDrMI8pSlHTtSo3gFe"
Organization: 
Message-Id: <1042462189.27737.41.camel@lifelesslap>
Mime-Version: 1.0
Date: Mon, 13 Jan 2003 12:50:00 -0000
X-SW-Source: 2003-q1/txt/msg00032.txt.bz2


--=-D+CDrMI8pSlHTtSo3gFe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 477

On Mon, 2003-01-13 at 23:43, Thomas Pfaff wrote:
> Attached is a patch and a test case for wait4 (used by wait, wait3 and
> waitpid).
>=20
> 2003-01-13  Thomas Pfaff  <tpfaff@gmx.net>
>=20
> 	* wait.cc: Include thread.h
> 	(wait4): Add pthread_testcancel call.
> 	Wait for child process and cancellation event.
> 	* thread.cc: Update list of cancellation points.

Looks good, please check it in.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-D+CDrMI8pSlHTtSo3gFe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+IrXtI5+kQ8LJcoIRAoIhAJ9F49/eSsiwWKJEyrQChVfteRdPYwCeL9NT
hqEXInMMfRFqaUs0c0BH1ig=
=K109
-----END PGP SIGNATURE-----

--=-D+CDrMI8pSlHTtSo3gFe--
