Return-Path: <cygwin-patches-return-3008-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29787 invoked by alias); 20 Sep 2002 12:45:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29773 invoked from network); 20 Sep 2002 12:45:49 -0000
Subject: Re: [PATCH] new mutex implementation 2. posting
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209201428100.279-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0209201428100.279-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Fo0GRWGgvEwwctXTCZpx"
Date: Fri, 20 Sep 2002 05:45:00 -0000
Message-Id: <1032525980.9116.55.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00456.txt.bz2


--=-Fo0GRWGgvEwwctXTCZpx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1050

On Fri, 2002-09-20 at 22:43, Thomas Pfaff wrote:
>=20
>=20
> On Fri, 20 Sep 2002, Robert Collins wrote:
>=20
> > On Tue, 2002-09-17 at 19:34, Thomas Pfaff wrote:
> >
> > Thomas, the patch is incomplete.
> >
> > pthread_cond::TimedWait needs updating as well...
>=20
> Yup, but it seems that this was broken on NT before i made my changes,
> because it was never updated to use Critical Sections when they are
> available.
=20
Uhmm, it was working for me :}. anyway, if you can make that consistent,
I will apply the semaphore based mutex code. I'm not 100% behind it, I
think we need to benchmark it, but lacking the facilities, I'm going to
accept it and tune later.

> > also, please diff against current HEAD, the previous patch failed on the
> > mutex section (I'm not sure why, may be white space changes or
> > something).
>=20
> Must wait until tomorrow.
> I will also recreate my pending patches 3 and 4 against current since your
> your patch has broken some parts of them.

Lets talk about those a little first. I'll email separately.

Rob

--=-Fo0GRWGgvEwwctXTCZpx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ixiXI5+kQ8LJcoIRAoI6AKCoMoHUb2cQo6JE0o66TxLavNgKwgCdHBxz
I3XLArd4yxoArVKZf60eRYA=
=bK1I
-----END PGP SIGNATURE-----

--=-Fo0GRWGgvEwwctXTCZpx--
