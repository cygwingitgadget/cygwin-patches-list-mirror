Return-Path: <cygwin-patches-return-3723-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13174 invoked by alias); 19 Mar 2003 23:20:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13082 invoked from network); 19 Mar 2003 23:20:18 -0000
Subject: Re: [PATCH] Add unsigned long Interlocked functions
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303191441120.257-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0303191441120.257-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/wHOQCv5TlsHo6893VVC"
Organization: 
Message-Id: <1048116013.5689.188.camel@localhost>
Mime-Version: 1.0
Date: Wed, 19 Mar 2003 23:20:00 -0000
X-SW-Source: 2003-q1/txt/msg00372.txt.bz2


--=-/wHOQCv5TlsHo6893VVC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 681

Looks good to me. Chris, you happy with the winbase stuff?

Rob

On Thu, 2003-03-20 at 00:49, Thomas Pfaff wrote:
> 2003-03-19  Thomas Pfaff  <tpfaff@gmx.net>
>=20
> 	* thread.cc (pthread_cond::Wait): Remove typecasts for unsigned
> 	long values when calling Interlocked functions. Use new UL functions
> 	instead.
> 	(pthread_mutex::_Lock): Ditto.
> 	(pthread_mutex::_TryLock): Ditto.
> 	* winbase.h (InterlockedIncrementUL): New inline function for type
> 	safety with unsigned parameters.
> 	(InterlockedDecrementUL): Ditto.
> 	(InterlockedExchangeUL): Ditto.
> 	(InterlockedCompareExchangeUL): Ditto.
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-/wHOQCv5TlsHo6893VVC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ePstI5+kQ8LJcoIRAsQvAJ9AdeAi1QmMo3aBMuaH5/UYGZ4CwwCfW2vU
bWKt6yDWwhw1aVg2YCsujE0=
=cEnp
-----END PGP SIGNATURE-----

--=-/wHOQCv5TlsHo6893VVC--
