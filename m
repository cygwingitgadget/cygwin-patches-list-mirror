Return-Path: <cygwin-patches-return-3654-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28949 invoked by alias); 28 Feb 2003 15:20:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28938 invoked from network); 28 Feb 2003 15:20:12 -0000
Subject: Re: [PATCH] Remove wrapper functions in pthread.cc
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0302281442110.371-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0302281442110.371-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KO2Ct5STn6TXaTkbeKuA"
Organization: 
Message-Id: <1046445602.29087.18.camel@localhost>
Mime-Version: 1.0
Date: Fri, 28 Feb 2003 15:20:00 -0000
X-SW-Source: 2003-q1/txt/msg00303.txt.bz2


--=-KO2Ct5STn6TXaTkbeKuA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 298

On Sat, 2003-03-01 at 00:53, Thomas Pfaff wrote:
> This patch removes all wrapper functions in pthread.cc that only add an
> additional function call. Export the functions in thread.cc instead.

Please apply.

Cheers,
Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-KO2Ct5STn6TXaTkbeKuA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+X34iI5+kQ8LJcoIRAp6oAKCWNOZ+515pqxdfBUKtJwQ4J4m4FgCgma46
KDwpyn1HIAXr2Xnl4esemM8=
=UPGX
-----END PGP SIGNATURE-----

--=-KO2Ct5STn6TXaTkbeKuA--
