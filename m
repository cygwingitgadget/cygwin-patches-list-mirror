Return-Path: <cygwin-patches-return-3657-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19557 invoked by alias); 28 Feb 2003 22:33:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19440 invoked from network); 28 Feb 2003 22:33:30 -0000
Subject: Re: [PATCH] Remove wrapper functions in pthread.cc
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20030228164622.GB9304@redhat.com>
References: <Pine.WNT.4.44.0302281442110.371-200000@algeria.intern.net>
	 <1046445602.29087.18.camel@localhost>  <20030228164622.GB9304@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MXObJhew/xzX8uQYVoR+"
Organization: 
Message-Id: <1046471606.29104.26.camel@localhost>
Mime-Version: 1.0
Date: Fri, 28 Feb 2003 22:33:00 -0000
X-SW-Source: 2003-q1/txt/msg00306.txt.bz2


--=-MXObJhew/xzX8uQYVoR+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 663

On Sat, 2003-03-01 at 03:46, Christopher Faylor wrote:
> On Sat, Mar 01, 2003 at 02:20:03AM +1100, Robert Collins wrote:
> >On Sat, 2003-03-01 at 00:53, Thomas Pfaff wrote:
> >> This patch removes all wrapper functions in pthread.cc that only add an
> >> additional function call. Export the functions in thread.cc instead.
> >
> >Please apply.
>=20
> Woo hoo.  I've always wondered why these wrapper functions were necessary.

If you look in the changelogs, I'd been slowly removing them, as I
touched the relevant functions.

I have no idea why they were originally created ...


Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-MXObJhew/xzX8uQYVoR+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+X+O2I5+kQ8LJcoIRAog+AJwLP+MAUwzWd4mMd0SyJ3tKlE8k3gCfX93Y
P1b5PqghJLaS9G6GvPzdcys=
=43XG
-----END PGP SIGNATURE-----

--=-MXObJhew/xzX8uQYVoR+--
