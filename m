Return-Path: <cygwin-patches-return-3387-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10469 invoked by alias); 14 Jan 2003 10:59:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10459 invoked from network); 14 Jan 2003 10:59:43 -0000
Subject: Re: [PATCH] Make system a pthread cancellation point
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0301141143200.319-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0301141143200.319-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Di5wT5He3ieouvkFJotw"
Organization: 
Message-Id: <1042541969.25787.10.camel@lifelesslap>
Mime-Version: 1.0
Date: Tue, 14 Jan 2003 10:59:00 -0000
X-SW-Source: 2003-q1/txt/msg00036.txt.bz2


--=-Di5wT5He3ieouvkFJotw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 403

On Tue, 2003-01-14 at 21:50, Thomas Pfaff wrote:
> Sorry, no testcase for that patch (it is really to simple).

I think it really is worth adding test cases - even for simple things.

It prevents regressions, which is the main reason for testing in the
first place.

So, please, if a test case can be written, lets do so.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-Di5wT5He3ieouvkFJotw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+I+2RI5+kQ8LJcoIRAic5AJ9qDlfiqSTHDu/kMazZpc87QUfCOACePlDG
lo/EtJmoB+7fiXEgzFmuQTQ=
=Aew3
-----END PGP SIGNATURE-----

--=-Di5wT5He3ieouvkFJotw--
