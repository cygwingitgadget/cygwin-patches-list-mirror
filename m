Return-Path: <cygwin-patches-return-3730-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9638 invoked by alias); 20 Mar 2003 08:15:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9627 invoked from network); 20 Mar 2003 08:15:21 -0000
Subject: Re: [PATCH] pthread_equal
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303200826001.232-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0303200826001.232-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lYhPzctIXsk8JEi2si+A"
Organization: 
Message-Id: <1048148117.912.12.camel@localhost>
Mime-Version: 1.0
Date: Thu, 20 Mar 2003 08:15:00 -0000
X-SW-Source: 2003-q1/txt/msg00379.txt.bz2


--=-lYhPzctIXsk8JEi2si+A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1289

On Thu, 2003-03-20 at 18:28, Thomas Pfaff wrote:
> On Wed, 19 Mar 2003, Robert Collins wrote:
>=20
> > On Thu, 2003-03-20 at 00:54, Thomas Pfaff wrote:
> > > 2003-03-19  Thomas Pfaff  <tpfaff@gmx.net>
> > >
> > > 	* pthread.cc (pthread_equal): Replacement for pthread_equal in
> > > 	thread.cc.
> > > 	* thread.cc: Rename pthread_equal to pthread::equal throughout.
> > > 	(pthread_equal): Remove.
> > > 	* thread.h (pthread::equal): New static method.
> >
> > This seems mostly pointless to me.
> >
> > A few notes:
> >
> > Why use a static method? you'll always have one pthread to compare to ,
> > so using operator =3D=3D is appropriate. In fact, operator =3D=3D alrea=
dy does
> > the right thing as it is the entire contents of pthread_equal.
> >
> > So: where pthread_equal is used internally, you could switch to (for
> > instance)
> > =3D=3D
> >  if (&thread =3D=3D joiner)
> > =3D=3D
>=20
> The only reason for this patch is to give the compiler the opportunity to
> do some inline optimizations. Without it it will always issue a function
> call only to test for equality of two pointers.

Huh? Not if you use the operator =3D=3D syntax it won't. The synthetic
operator =3D=3D is always inlined.

Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-lYhPzctIXsk8JEi2si+A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eXiVI5+kQ8LJcoIRAmG3AJ4kaNHllcRf5YUCDzRTKTAYOjSuVACfReEQ
u5omLNuB6PIbWhRVqwvy6gk=
=vcXl
-----END PGP SIGNATURE-----

--=-lYhPzctIXsk8JEi2si+A--
