Return-Path: <cygwin-patches-return-3011-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9164 invoked by alias); 20 Sep 2002 13:14:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9150 invoked from network); 20 Sep 2002 13:14:39 -0000
Subject: Re: [PATCH] pthread_fork Part 3
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209201453550.344-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0209201453550.344-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-pSxLuKa46CRGWsU5P4NM"
Date: Fri, 20 Sep 2002 06:14:00 -0000
Message-Id: <1032527712.9116.75.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00459.txt.bz2


--=-pSxLuKa46CRGWsU5P4NM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 651

On Fri, 2002-09-20 at 23:06, Thomas Pfaff wrote:

> If you want to work around this you must use a mutex to protect the entire
> list.

Or: don't delete foo; the keys, instead foo->deleteme();

pthread_key::pthread_key(){
  inuse_count =3D 1;
}

pthread_key::deleteme() {
  interlockedincrement(inuse_count)
  if interlockeddecrement (inuse_count) =3D=3D 0
    delete this;
}


pthread_key::rundestructor() {
if (interlockeddecrement(inuse_count) =3D=3D 0)
  delete this
}

This prevents the race you describe with no locks.

Still, this race is actually one ieee says we don't care about IIRC,
it's up to the user to synchronise calls like this.
Rob

--=-pSxLuKa46CRGWsU5P4NM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ix9fI5+kQ8LJcoIRAofZAJ9s99JyNc+RI4qPV9T8aCT0nCzGzQCgtilr
MGAjk1/ORVGxnFLYgyIA5NY=
=HCMk
-----END PGP SIGNATURE-----

--=-pSxLuKa46CRGWsU5P4NM--
