Return-Path: <cygwin-patches-return-3368-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19458 invoked by alias); 10 Jan 2003 08:59:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19375 invoked from network); 10 Jan 2003 08:59:20 -0000
Subject: Re: [PATCH] Make sleep and usleep a cancellation point
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0301100943530.299-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0301100943530.299-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lx57DrDMwP8C2kuM72Bb"
Organization: 
Message-Id: <1042189146.17813.2.camel@lifelesslap>
Mime-Version: 1.0
Date: Fri, 10 Jan 2003 08:59:00 -0000
X-SW-Source: 2003-q1/txt/msg00017.txt.bz2


--=-lx57DrDMwP8C2kuM72Bb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 251

On Fri, 2003-01-10 at 19:53, Thomas Pfaff wrote:
> This patch will make sleep and usleep a pthread cancellation point.

Looks good to me. Please do a test case for them.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-lx57DrDMwP8C2kuM72Bb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+HotaI5+kQ8LJcoIRAhZ6AJ967+ERPmYKzJpzyLT3zuKILvBTxACgxqFh
yKDoQxPG1xjlbwvmg62n7Bk=
=VS5G
-----END PGP SIGNATURE-----

--=-lx57DrDMwP8C2kuM72Bb--
