Return-Path: <cygwin-patches-return-4437-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23160 invoked by alias); 22 Nov 2003 07:22:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23151 invoked from network); 22 Nov 2003 07:22:34 -0000
Subject: Re: thunking, the next step
From: Robert Collins <rbcollins@cygwin.com>
To: Warren Young <warren@etr-usa.com>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
In-Reply-To: <3FBEAD42.6000803@etr-usa.com>
References: <3FB4C443.2040301@cygwin.com>
	 <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost>
	 <20031114191010.GA22870@redhat.com>
	 <20031117112126.GE18706@cygbert.vinschen.de>
	 <1069068688.2287.219.camel@localhost>
	 <20031117120229.GH18706@cygbert.vinschen.de>
	 <1069361541.1117.42.camel@localhost>
	 <20031121110223.GB8815@cygbert.vinschen.de>
	 <1069417379.18254.76.camel@localhost>  <3FBEAD42.6000803@etr-usa.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U3pRuab9JRN6T4yyccXC"
Message-Id: <1069485741.1167.3.camel@localhost>
Mime-Version: 1.0
Date: Sat, 22 Nov 2003 07:22:00 -0000
X-SW-Source: 2003-q4/txt/msg00156.txt.bz2


--=-U3pRuab9JRN6T4yyccXC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 748

On Sat, 2003-11-22 at 11:26, Warren Young wrote:
> Robert Collins wrote:
> >=20
> > http://www.jargon.8hz.com/jargon_35.html  - see thunk, and meaning 3 is
> > what I've been using.
>=20
> jargon.org is the official site, and it has a more detailed definition:
>=20
> http://www.catb.org/~esr/jargon/html/T/thunk.html

Uhm, thats catb.org :}. But yes, I did dig up an older copy of the TNHD.

> Beware of definition 4, which can cause confusion in the Windows=20
> environment.  It's the one I thought was being referred to when I first=20
> saw this subject line.

Identical in concept though: you call a 16 bit function, and a 32 bit
function is executed - via the thunk.

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-U3pRuab9JRN6T4yyccXC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQA/vw6sI5+kQ8LJcoIRAqzXAJjTIW/FgHRTPBdHO7Bviq6wlR1xAKDQmVnd
R7qft25pHWlI8Cx9Z8xmvg==
=K+va
-----END PGP SIGNATURE-----

--=-U3pRuab9JRN6T4yyccXC--
