Return-Path: <cygwin-patches-return-2928-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12882 invoked by alias); 4 Sep 2002 02:41:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12868 invoked from network); 4 Sep 2002 02:41:19 -0000
Subject: mingw - free_osfhnd
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-DmC/nJlGPZ57p5pGhTWE"
Date: Tue, 03 Sep 2002 19:41:00 -0000
Message-Id: <1031107292.31077.680.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00376.txt.bz2


--=-DmC/nJlGPZ57p5pGhTWE
Content-Type: multipart/mixed; boundary="=-tfJI9B7q4Ue8IE8ymXok"


--=-tfJI9B7q4Ue8IE8ymXok
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 129

Changelog:

2002-09-04  Robert Collins  <robertc@cygwin.com>

	* msvcrt.def: Export _free_osfhnd.

Is this ok Earnie/Danny?

Rob

--=-tfJI9B7q4Ue8IE8ymXok
Content-Disposition: attachment; filename=mingwfreeosf.patch
Content-Type: text/x-patch; name=mingwfreeosf.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 336

diff -rup mingw-runtime-2.1-1.orig/msvcrt.def mingw-runtime-2.1-1/msvcrt.def
--- mingw-runtime-2.1-1.orig/msvcrt.def	2002-06-15 01:00:39.000000000 +1000
+++ mingw-runtime-2.1-1/msvcrt.def	2002-09-04 12:33:31.000000000 +1000
@@ -213,6 +213,7 @@ _fpieee_flt
 _fpreset DATA
 _fputchar
 _fputwchar
+_free_osfhnd
 _fsopen
 _fstat
 _fstati64

--=-tfJI9B7q4Ue8IE8ymXok--

--=-DmC/nJlGPZ57p5pGhTWE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9dXLbI5+kQ8LJcoIRAiGQAJ9BjfMfw2PyEOR8wlxiRBn+JRwHYQCfV0/5
WgSsaqho4x2330/9Eo3TUpU=
=NhS7
-----END PGP SIGNATURE-----

--=-DmC/nJlGPZ57p5pGhTWE--
