Return-Path: <cygwin-patches-return-3375-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9988 invoked by alias); 10 Jan 2003 21:33:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9952 invoked from network); 10 Jan 2003 21:32:59 -0000
Subject: Re: [PATCH] Make sleep and usleep a cancellation point
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20030110162936.GD25027@redhat.com>
References: <Pine.WNT.4.44.0301100943530.299-200000@algeria.intern.net>
	 <1042189146.17813.2.camel@lifelesslap>  <20030110162936.GD25027@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3a8ZisQGO90YttOFMAb2"
Organization: 
Message-Id: <1042234366.3278.14.camel@lifelesslap>
Mime-Version: 1.0
Date: Fri, 10 Jan 2003 21:33:00 -0000
X-SW-Source: 2003-q1/txt/msg00024.txt.bz2


--=-3a8ZisQGO90YttOFMAb2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 645

On Sat, 2003-01-11 at 03:29, Christopher Faylor wrote:
> On Fri, Jan 10, 2003 at 07:59:06PM +1100, Robert Collins wrote:
> >On Fri, 2003-01-10 at 19:53, Thomas Pfaff wrote:
> >> This patch will make sleep and usleep a pthread cancellation point.
> >
> >Looks good to me. Please do a test case for them.
>=20
> Btw, I *love* this test case policy.  It's great.
>=20
> We should probably think about doing the same thing for every regression
> we find.

Works for me :}. I find that test-case based programming makes life *so*
much easier, it's really unbelievable.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-3a8ZisQGO90YttOFMAb2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Hzv+I5+kQ8LJcoIRAq0PAJ9gbuceP3NFDAm45ICqxhHzd8Ek+QCgrsrv
dtB9Auhms7Mn4Ojyn4snE9Y=
=ISxG
-----END PGP SIGNATURE-----

--=-3a8ZisQGO90YttOFMAb2--
