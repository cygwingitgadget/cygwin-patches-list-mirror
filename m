Return-Path: <cygwin-patches-return-3711-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29904 invoked by alias); 19 Mar 2003 09:48:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29740 invoked from network); 19 Mar 2003 09:48:00 -0000
Subject: Re: [PATCH] reorganize list handling of fixable pthread objects
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0302281144520.371-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0302281144520.371-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Bfjc0c/hbvlSsUyXCi4e"
Organization: 
Message-Id: <1048067273.5689.127.camel@localhost>
Mime-Version: 1.0
Date: Wed, 19 Mar 2003 09:48:00 -0000
X-SW-Source: 2003-q1/txt/msg00360.txt.bz2


--=-Bfjc0c/hbvlSsUyXCi4e
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 349

On Fri, 2003-02-28 at 22:10, Thomas Pfaff wrote:
> Reorganize the list handling of the pthreads objects by using the List
> template class and remove a lot of duplicate code.

This looks good, except for for_each. can you do a proper for_each
template implementation?

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-Bfjc0c/hbvlSsUyXCi4e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eDzJI5+kQ8LJcoIRAnqQAJ9mAa5P7L63ifF6HSo4d6N/fJGopwCglye+
GOvBQ2VXntdOFtNIkRDXWtk=
=l0/x
-----END PGP SIGNATURE-----

--=-Bfjc0c/hbvlSsUyXCi4e--
