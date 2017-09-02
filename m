Return-Path: <cygwin-patches-return-8846-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96868 invoked by alias); 30 Aug 2017 13:07:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96856 invoked by uid 89); 30 Aug 2017 13:07:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=enjoy, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Aug 2017 13:07:30 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 6A8B9721E280C	for <cygwin-patches@cygwin.com>; Wed, 30 Aug 2017 15:07:21 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id B81475E03A7	for <cygwin-patches@cygwin.com>; Wed, 30 Aug 2017 15:07:20 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A3226A805D3; Wed, 30 Aug 2017 15:07:20 +0200 (CEST)
Date: Sat, 02 Sep 2017 14:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
Message-ID: <20170830130720.GA18057@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca> <20170824093255.GI7469@calimero.vinschen.de> <20170824094028.GK7469@calimero.vinschen.de> <7d34bb5d-ecc3-4593-32ed-b3f69c680260@SystematicSw.ab.ca> <20170825094756.GN7469@calimero.vinschen.de> <20170829073520.GI16010@calimero.vinschen.de> <04edcc3e-3270-5a0b-14b8-cddaa80e006f@SystematicSw.ab.ca> <20170829191415.GL16010@calimero.vinschen.de> <f348ed5a-3d07-eb63-3c32-6565fc752924@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <f348ed5a-3d07-eb63-3c32-6565fc752924@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00048.txt.bz2


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1765

On Aug 29 18:09, Brian Inglis wrote:
> On 2017-08-29 13:14, Corinna Vinschen wrote:
> > On Aug 29 11:56, Brian Inglis wrote:
> >> got diverted during strptime testing due to time functions gmtime,
> >> localtime, mktime, strftime not properly handling struct
> >> tm->tm_year =3D=3D INT_MAX =3D> year =3D=3D INT_MAX + 1900 so year nee=
ds to
> >> be at least long in Cygwin 64,

That's not possible.  struct tm members are int per POSIX.  Values
beyond INT_MIN/INT_MAX are simply out of bounds.

> >> also affecting tzcalc_limits, and
> >> depending on what is required to properly handle time_t in Cygwin
> >> 32.
> >=20
> > Sounds like you're busy with time functions for a while ;)
>=20
> If either long or long long will fix both Cygwin 64 and 32 time_t and
> struct tm, patches should not be long coming to a bunch of newlib time

  time_t =3D=3D long =3D=3D 64 bit on Cygwin 64

This will not change at all, of course, but...

  time_t =3D=3D long =3D=3D 32 bit on Cygwin 32

This won't change anytime soon.  Just try to figure out how many
structures (e.g., struct stat, struct timeval) and functions are
affected.  If we really want to change Cygwin 32 to use a 64 bit time_t,
we either have an excessive lot of work to keep backward compatibility
with existing apps, or we send the entire current 32 bit distro into
pension and perform a backward incompatible bulk rebuild with 64 bit
time_t.  The latter would probably be the better approach.

Alternatively we just let Cygwin 32 bit as is and wait for my own
pension which will be earlier than 2038...

> Thanks. Enjoy your vacay.

Will do, thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZpriIAAoJEPU2Bp2uRE+gCfgQAKGulJOZrAYWWNqGoCBuTCDG
sokb5aosIVrLYbzGDLnyd9XqnBxnbJO4fKw2Rc7PrvCIHb549zAuW5nSAWoFqbUD
KduoMEwURtwtX9xsxk97hix7K5JP4S7xnlhKpDkW8tBJA8ZZO/HDfxFcqut6n+RK
cRlZBvuiJ8trmx5cCiI45Not8ypixu/nhaanmUOXzjJhbVfyALlcaL4ySBCzBfYJ
JlonY7gOZuZ983SisdRGFi9idFtAMjo3LjomMesevW9hAysXa3vcD2rTp6I6Ecf1
cnTaSUohYVssYLjd/NKDfcGpaX2XMTHFbGIELpEPEw7l74hNwtRE33LE1xeNut7w
ZT+IZwBVS5iICpwnmJI0pdKiu5qgTSSspWACFqK82fXqTV9u8mCy5KJxqAHKzdq5
p2Cv+gGyTnwq+DPgMlBOrMkZRWPcuf6OM/X9Z7lA9osQiWbSIkIaIVXudKManRU1
X1i+4uc4OyrVwH2g4SUyxNIp5iR2J9k5aS2K63h8+bymQFKOs3m+EwDoVUjcGe//
oiOxziK2MHBT2K4pUCLQ4cToi5Fkf6lX2uP5H5BTyr0d9n+JIoChrJMg4BA6rnIF
HHCfnafjNt6kwh/mJBvpwM1yhLaqEMAhlu1w3Hy+LlHHaJrJ4H/qhCg/zxm07yQ0
P/wQhGgHnRRfv2nj+yKC
=L3++
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
