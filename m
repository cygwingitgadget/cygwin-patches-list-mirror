Return-Path: <cygwin-patches-return-2987-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3939 invoked by alias); 17 Sep 2002 09:24:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3925 invoked from network); 17 Sep 2002 09:24:44 -0000
Subject: Re: [PATCH] pthread_fork Part 2
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0208162218020.-283127@thomas.kefrig-pfaff.de>
References: <Pine.WNT.4.44.0208162218020.-283127@thomas.kefrig-pfaff.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-bpYv06LK9nGhlULlqTxe"
Date: Tue, 17 Sep 2002 02:24:00 -0000
Message-Id: <1032254716.17676.185.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00435.txt.bz2


--=-bpYv06LK9nGhlULlqTxe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1736

On Sat, 2002-08-17 at 06:32, Thomas Pfaff wrote:
>=20
> Some small fixes in the pthread key handling.
> @@ -1020,16 +1020,27 @@ pthread_key::~pthread_key ()
>  int
>  pthread_key::set (const void *value)
>  {
> -  /*the OS function doesn't perform error checking */
> -  TlsSetValue (dwTlsIndex, (void *) value);
> +  if (dwTlsIndex =3D=3D TLS_OUT_OF_INDEXES ||

Not needed. dwTlsIndex is not set by anyone outside the class, AND
if TlsAlloc fails, then we set the magic to 0, causing a failure on
creation.=20

Are you covering the situation where the restoreFromSavedBuffer call
fails? If so, then we should cause the object to destroy itself in that
call, thus causing the VALID_OBJECT test to fail for future calls from
userland.

> +      !TlsSetValue (dwTlsIndex, (void *) value))

Please see the MS documentation on this. They explicitly state that they
perform minimal checking. Also, this should be an assert, as TlsSetValue
can only fail if you give it an invalid index, and our index is assigned
by the OS.

> +  if (dwTlsIndex =3D=3D TLS_OUT_OF_INDEXES)

Ditto to above.

> +    result =3D TlsGetValue (dwTlsIndex);

And again.

>=20=20
>  void
> @@ -1884,8 +1895,8 @@ __pthread_setspecific (pthread_key_t key
>  {
>    if (verifyable_object_isvalid (&key, PTHREAD_KEY_MAGIC) !=3D VALID_OBJ=
ECT)
>      return EINVAL;
> -  (key)->set (value);
> -  return 0;
> +
> +  return (key)->set (value);

Not needed, because of the above lack of changes.
Yes, what you are suggesting is good general programming practice, but
these are performance critical functions, and we are checking for a
situation that can't happen short of someone writing into our memory
space. If that happens, errors are the least of our problems :}.

Rob

--=-bpYv06LK9nGhlULlqTxe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hvT8I5+kQ8LJcoIRAjJ5AJ9KQ0n5DlSzYRWX2MK4q+UGFJ3hjwCfcomS
gQZb2Fd/RVdxzsCE0mjczdo=
=MbfE
-----END PGP SIGNATURE-----

--=-bpYv06LK9nGhlULlqTxe--
