Return-Path: <cygwin-patches-return-3658-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22887 invoked by alias); 28 Feb 2003 22:38:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22877 invoked from network); 28 Feb 2003 22:38:24 -0000
Subject: Re: [PATCH] Remove wrapper functions in pthread.cc
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0302281624360.396-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0302281624360.396-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s2/zCc8otMWIdgrqUCA1"
Organization: 
Message-Id: <1046471899.29086.34.camel@localhost>
Mime-Version: 1.0
Date: Fri, 28 Feb 2003 22:38:00 -0000
X-SW-Source: 2003-q1/txt/msg00307.txt.bz2


--=-s2/zCc8otMWIdgrqUCA1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 577

On Sat, 2003-03-01 at 02:29, Thomas Pfaff wrote:
> On Fri, 28 Feb 2003, Robert Collins wrote:
>=20
> > On Sat, 2003-03-01 at 00:53, Thomas Pfaff wrote:
> > > This patch removes all wrapper functions in pthread.cc that only add =
an
> > > additional function call. Export the functions in thread.cc instead.
> >
> > Please apply.
> >
>=20
> Impossible until you have reviewed the other patches ;-)

Well, this patch is pretty straight forward to recreate :}.

Up to you when you apply it though.

Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-s2/zCc8otMWIdgrqUCA1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+X+TbI5+kQ8LJcoIRAtlbAJ0W+XA5f+H90nhwSGML4VicGNmLCACfRVwO
Su3garOpsNnRkheJuqOU0U4=
=n2DZ
-----END PGP SIGNATURE-----

--=-s2/zCc8otMWIdgrqUCA1--
