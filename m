Return-Path: <cygwin-patches-return-3031-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30647 invoked by alias); 23 Sep 2002 21:31:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30630 invoked from network); 23 Sep 2002 21:31:08 -0000
Subject: Re: [PATCH] pthread key destructor
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209231427310.294-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0209231427310.294-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-hGjkGvQkWxuLrYTO9zFD"
Date: Mon, 23 Sep 2002 14:31:00 -0000
Message-Id: <1032816700.8334.12.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00479.txt.bz2


--=-hGjkGvQkWxuLrYTO9zFD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 552

On Mon, 2002-09-23 at 22:34, Thomas Pfaff wrote:
>=20
> See
> http://www.opengroup.org/onlinepubs/007904975/functions/pthread_key_creat=
e.html
>=20
> I do not think that we should support more than one iterations at the
> moment. This seems to be a rather new addition to the pthread
> specification.

Hmm, I recall that being there for quite a while. But yes, I agree for
now, we won't worry.

Your patch was also slightly incorrect - we are meant to reset the value
*before* running the destrcutor. So I've implemented such a version.

Thanks.
Rob


--=-hGjkGvQkWxuLrYTO9zFD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9j4g7I5+kQ8LJcoIRAh4aAJwMep+lQYvhvaYK3bqhHItJLdqbuQCeMa1F
QEtF9mzDyZwB+NssAC9ZOQo=
=rTXd
-----END PGP SIGNATURE-----

--=-hGjkGvQkWxuLrYTO9zFD--
