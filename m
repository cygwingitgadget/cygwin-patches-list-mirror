Return-Path: <cygwin-patches-return-2930-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22802 invoked by alias); 4 Sep 2002 05:54:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22744 invoked from network); 4 Sep 2002 05:54:03 -0000
Subject: Re: mingw - free_osfhnd
From: Robert Collins <rbcollins@cygwin.com>
To: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20020904032929.33156.qmail@web14510.mail.yahoo.com>
References: <20020904032929.33156.qmail@web14510.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-nRvhbHe9q2xSH6gIBDcP"
Date: Tue, 03 Sep 2002 22:54:00 -0000
Message-Id: <1031118856.30795.710.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00378.txt.bz2


--=-nRvhbHe9q2xSH6gIBDcP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 676

On Wed, 2002-09-04 at 13:29, Danny Smith wrote:
>  --- Robert Collins <rbcollins@cygwin.com> wrote: > Changelog:
> >=20
> > 2002-09-04  Robert Collins  <robertc@cygwin.com>
> >=20
> > 	* msvcrt.def: Export _free_osfhnd.
> >=20
> > Is this ok Earnie/Danny?
>=20
> I can't see this in my msvcrt.dll.  Where do you see it?
> Danny

Its one of the undocumented internals... along with _get_osfhnd and
_set_osfhnd. (I think that _get_osfhnd is there already).

The NT Native port of squid, build with Visual C uses this when linking
to MSVCRT. As a reference in 1999 XEmacs started using this call, but
they defined it locally rather than patching mingw from what I can tell.

Rob

--=-nRvhbHe9q2xSH6gIBDcP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9dZ/5I5+kQ8LJcoIRAqwxAKCPFGhNaaWa22onqycBQBZ4glIxkQCgwZn1
5NZPTs/gNWHYmKpNCJ42eKQ=
=EYLd
-----END PGP SIGNATURE-----

--=-nRvhbHe9q2xSH6gIBDcP--
