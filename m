Return-Path: <cygwin-patches-return-2986-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2232 invoked by alias); 17 Sep 2002 09:15:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2216 invoked from network); 17 Sep 2002 09:15:37 -0000
Subject: Re: [PATCH] pthread_fork Part 1
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209161541580.90-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0209161541580.90-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-WCZEZvHFk9vXPObUhOJA"
Date: Tue, 17 Sep 2002 02:15:00 -0000
Message-Id: <1032254170.17693.178.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00434.txt.bz2


--=-WCZEZvHFk9vXPObUhOJA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 803

On Tue, 2002-09-17 at 18:48, Thomas Pfaff wrote:

>=20
> I have attached a small source file for testing.

Thanks. I've commited my reworked version.
=20
> My main goal was to get a working threaded perl, so this was the reference
> source for the final testing. With all patches applied (and the changed
> mutex implementation) i was able to build and run it without problems.

Cool. Well I'm onto the fork(2) patch.

Re: the mutex implementation.

Can you gather all the mutex patchs you sent (there where what, 3?) and
provide a single bug-free-as-far-as-you-know version?

If, and only if, it makes sense for me to review the patches sent for
the mutex previously, then I will. I know I wasn't happy with them at
that point, mainly because of things I think you've already address'd...

Cheers,
Rob

--=-WCZEZvHFk9vXPObUhOJA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hvLZI5+kQ8LJcoIRAuL5AJ4uILQ/qejOh2BYfVJNNWi1+6xm1QCeIjAi
/nztpNZZ/brDrIHLJ3ZDhd0=
=mWkm
-----END PGP SIGNATURE-----

--=-WCZEZvHFk9vXPObUhOJA--
