Return-Path: <cygwin-patches-return-3714-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26049 invoked by alias); 19 Mar 2003 10:24:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25965 invoked from network); 19 Mar 2003 10:24:35 -0000
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303191055370.272-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0303191055370.272-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iBzWJ66vUabfaoJdY48L"
Organization: 
Message-Id: <1048069469.5299.148.camel@localhost>
Mime-Version: 1.0
Date: Wed, 19 Mar 2003 10:24:00 -0000
X-SW-Source: 2003-q1/txt/msg00363.txt.bz2


--=-iBzWJ66vUabfaoJdY48L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1807

On Wed, 2003-03-19 at 21:15, Thomas Pfaff wrote:

> > Enabled by default. Sure, as long as they aren't turned off again, or
> > someone builds without them to get 386 support... Please, use the
> > compatible test, it won't alter the code much. You can test for <0 and
> > >0 safely.
>=20
> The mutex stuff does not work on i386 at all because it requires
> InterlockedCompareExchange. The reason to enable the Interlocked stuff in
> winbase.h was to keep cygwin running on Win95 that has no implementation
> for InterlockedCompareExchange. It simply can't be disabled without
> loosing support for Win95/NT3.5. All later Windows versions behave the
> same way than the inline ones, therefore it does not matter if the inlines
> were disabled again. Sure someone could only enable the inline
> InterlockedCompareExchange but why the hell he should do this.

Ah, I had missed that i386 was impossible no matter what. Ok, that use
is fine.

> > > > Secondly, IIRC lock_counter should be long, so the (long *) typecas=
ting
> > > > isn't needed.
> > >
> > > IMHO it should be unsigned since it makes no sense to have negative
> > > counter values. In practice it doesn't make any difference because th=
ere
> > > are not greater or smaller equations in the code.
> >
> > It's about type safety. Please, correct it.
>=20
> Why not create an InterlockedIncrement|Decrement that takes unsigned long
> arguments instead ? This has nothing to do with type safety but with lack
> of functions.

Either way, the typecast is not needed. Please either:
* make the variable long=20
* make unsigned variants of the interlockedIncrement|Decrement that will
throw (not C++, rather a processor exception) overflow or underflow as
appropriate.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-iBzWJ66vUabfaoJdY48L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eEVcI5+kQ8LJcoIRAv5HAKDUo1QXfgkFykWlPzfAyiUyyXq9XgCfSCA5
elgQIDKKQWDbLm7dEjU+Wmw=
=yOzi
-----END PGP SIGNATURE-----

--=-iBzWJ66vUabfaoJdY48L--
