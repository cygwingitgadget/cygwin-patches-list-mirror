Return-Path: <cygwin-patches-return-3006-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8942 invoked by alias); 20 Sep 2002 12:21:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8927 invoked from network); 20 Sep 2002 12:21:42 -0000
Subject: Re: [PATCH] new mutex implementation 2. posting
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209171121040.297-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0209171121040.297-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-F87vfAZLZeQ0H9/mK1A0"
Date: Fri, 20 Sep 2002 05:21:00 -0000
Message-Id: <1032524533.10933.52.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00454.txt.bz2


--=-F87vfAZLZeQ0H9/mK1A0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 296

On Tue, 2002-09-17 at 19:34, Thomas Pfaff wrote:

Thomas, the patch is incomplete.

pthread_cond::TimedWait needs updating as well...

also, please diff against current HEAD, the previous patch failed on the
mutex section (I'm not sure why, may be white space changes or
something).

Cheers,
Rob

--=-F87vfAZLZeQ0H9/mK1A0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ixL1I5+kQ8LJcoIRApDGAJ4wWVMgeCVMhBEnKPOPgwNu8EVh3wCgx5Ko
UVWR53XTAI9TC7x1Nrcdqfo=
=fGni
-----END PGP SIGNATURE-----

--=-F87vfAZLZeQ0H9/mK1A0--
