Return-Path: <cygwin-patches-return-3712-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9549 invoked by alias); 19 Mar 2003 09:52:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9480 invoked from network); 19 Mar 2003 09:52:08 -0000
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303170853450.77-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0303170853450.77-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jsphAJTM157TTDcYjUMb"
Organization: 
Message-Id: <1048067523.5305.132.camel@localhost>
Mime-Version: 1.0
Date: Wed, 19 Mar 2003 09:52:00 -0000
X-SW-Source: 2003-q1/txt/msg00361.txt.bz2


--=-jsphAJTM157TTDcYjUMb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1404

On Mon, 2003-03-17 at 19:17, Thomas Pfaff wrote:
> On Thu, 13 Mar 2003, Cygwin (Robert Collins) wrote:
>=20
> > This:
> >
> >    if (1 =3D=3D InterlockedIncrement ((long *)&lock_counter))
> >
> > is not safe. You can only check for equal to 0, less than 0, and greater
> > than 0 with InterlockedIncrement | Decrement.
> >
>=20
> The xadd based inline interlocked functions in winbase.h are now enabled
> by default, so it is valid to test for 1 at this point.

Enabled by default. Sure, as long as they aren't turned off again, or
someone builds without them to get 386 support... Please, use the
compatible test, it won't alter the code much. You can test for <0 and
>0 safely.

> It looks much cleaner to me to start a counter at 0 not at -1.
> And the code now supports UINT_MAX instead of INT_MAX waiting
> threads (even if INT_MAX threads are only academicical i see no reason to
> add a limit here).

Well there is a limit either way. I don't see any pragmatic difference.

> > Secondly, IIRC lock_counter should be long, so the (long *) typecasting
> > isn't needed.
>=20
> IMHO it should be unsigned since it makes no sense to have negative
> counter values. In practice it doesn't make any difference because there
> are not greater or smaller equations in the code.

It's about type safety. Please, correct it.

Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-jsphAJTM157TTDcYjUMb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eD3DI5+kQ8LJcoIRAs/5AJ0fvn8h6dh1Iwy6+HuDZZPkI3W38QCglq2E
YRUuuoIlv0IksefEhaXYeVs=
=ZDu5
-----END PGP SIGNATURE-----

--=-jsphAJTM157TTDcYjUMb--
