Return-Path: <cygwin-patches-return-4401-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19767 invoked by alias); 15 Nov 2003 20:23:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19758 invoked from network); 15 Nov 2003 20:23:14 -0000
Subject: Re: For masochists: the leap o faith
From: Robert Collins <rbcollins@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20031115110332.GA6018@cygbert.vinschen.de>
References: <3FB4D81C.6010808@cygwin.com> <3FB53BAE.3000803@cygwin.com>
	 <20031114220708.GA26100@redhat.com> <3FB554AD.2090309@cygwin.com>
	 <20031115110332.GA6018@cygbert.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iztjMzq5VbQuaWFJVDX0"
Message-Id: <1068927791.1109.124.camel@localhost>
Mime-Version: 1.0
Date: Sat, 15 Nov 2003 20:23:00 -0000
X-SW-Source: 2003-q4/txt/msg00120.txt.bz2


--=-iztjMzq5VbQuaWFJVDX0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 761

On Sat, 2003-11-15 at 22:03, Corinna Vinschen wrote:
> On Sat, Nov 15, 2003 at 09:18:21AM +1100, Robert Collins wrote:
> > Christopher Faylor wrote:
> > >For the record, I don't have any problems with changing PATH_MAX to
> > >CYG_PATH_MAX as a first step for this change.  Small steps are, as
> > >always, appreciated.
> >=20
> > Alrighty, will commit that in a minute.
>=20
> Erm... making the name change is one thing but in limits.h you changed
> PATH_MAX to 4096-1, same for __FILENAME_MAX__ in cygwin/config.h and
> the same for MAXPATHLEN in sys/param.h.  Were these accidental checkins?

Oh ****. Yes, they where accidental and wrong. Sorry. I'll back them out
in a few minutes.

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-iztjMzq5VbQuaWFJVDX0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tostI5+kQ8LJcoIRAlv0AKDEdlLDBLy6RHqxJTGaT13GnljcEACbBRdT
dVBUqtdQY1sBJT9GK+op8rA=
=1s5I
-----END PGP SIGNATURE-----

--=-iztjMzq5VbQuaWFJVDX0--
