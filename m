Return-Path: <cygwin-patches-return-2833-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6785 invoked by alias); 16 Aug 2002 01:10:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6613 invoked from network); 16 Aug 2002 01:10:52 -0000
Subject: Re: [PATCH] pthread_fork
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0208151941420.-376009@thomas.kefrig-pfaff.de>
References: <Pine.WNT.4.44.0208151941420.-376009@thomas.kefrig-pfaff.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-q2MANmTIK8EziDHdq8+T"
Date: Thu, 15 Aug 2002 18:10:00 -0000
Message-Id: <1029460264.1058.16.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00281.txt.bz2


--=-q2MANmTIK8EziDHdq8+T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 912

On Fri, 2002-08-16 at 04:27, Thomas Pfaff wrote:
>=20
> This patch will fix the pthread key related problems with fork (key value
> is restored after fork) and some minor fork related fixes.

Thomas, Some feedback on this. (I know, less than a week - wow!)

Some general things:
MTinterface::init_pthread is breaking encapsulation of pthread, please
correct this.

You have moved more class specific code in to MTinterface. This further
breaks abstraction FWICS. Can you enlarge on your reasons for that?

Finally it seems to me that the pthread_before_fork new call could
(should) be called from pthread_atfork_prepare.

This is a rather big patch, covering several different things -
refactoring list code, altering initialisation of pthread classes,
handling fork better for pthreads, handling fork for pthead_key's. I'd
really like to see it as as series of smaller patches to debate more
specifcally.

Rob


--=-q2MANmTIK8EziDHdq8+T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9XFEmI5+kQ8LJcoIRAkJLAJ91rt4F+1h31HKesnABG79NHVqVCQCgiO4b
pBS8K7rOIkvzwrWekCFyjxo=
=o/5y
-----END PGP SIGNATURE-----

--=-q2MANmTIK8EziDHdq8+T--
