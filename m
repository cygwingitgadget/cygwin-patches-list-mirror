Return-Path: <cygwin-patches-return-2979-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21827 invoked by alias); 16 Sep 2002 11:46:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21808 invoked from network); 16 Sep 2002 11:46:10 -0000
Subject: Re: [PATCH] check for valid pthread_self pointer
From: Robert Collins <rbcollins@cygwin.com>
To: Jason Tishler <jason@tishler.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20020816112218.GA892@tishler.net>
References: <Pine.WNT.4.44.0208071245020.353-200000@algeria.intern.net> 
	<20020816112218.GA892@tishler.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-wdWqR2UvjHkOT9b/Du6I"
Date: Mon, 16 Sep 2002 04:46:00 -0000
Message-Id: <1032176803.17676.135.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00427.txt.bz2


--=-wdWqR2UvjHkOT9b/Du6I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 627

On Fri, 2002-08-16 at 21:22, Jason Tishler wrote:
> Rob,
>=20
> On Wed, Aug 07, 2002 at 05:19:10PM +0200, Thomas Pfaff wrote:
> > This patch should fix the problem with the ipc-daemon started as
> > service and threads that are not created by pthread_create.
>=20
> Please evaluate and commit if OK -- the PostgreSQL folks could really
> use this.

BTW: they really should use pthread_create if they want to use threaded
code with cygwin. But you knew that right?

There is *no* guarantee that any pthread operations called from a non
cygwin created thread will operate correctly. We'll try... but there is
no guarantee.

Rob


--=-wdWqR2UvjHkOT9b/Du6I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hcSeI5+kQ8LJcoIRAhoQAJ9y/6bW3OZW9kaytqiz0LwVX6ygDQCfe+CI
DirHb45CK8/rLZGWqAr2tGE=
=aBk4
-----END PGP SIGNATURE-----

--=-wdWqR2UvjHkOT9b/Du6I--
