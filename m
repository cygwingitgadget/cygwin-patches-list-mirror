Return-Path: <cygwin-patches-return-8591-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35871 invoked by alias); 29 Jun 2016 14:27:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35847 invoked by uid 89); 29 Jun 2016 14:27:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=WOW64, wow64, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jun 2016 14:27:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A1EADA8035C; Wed, 29 Jun 2016 16:27:45 +0200 (CEST)
Date: Wed, 29 Jun 2016 14:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update FAQ listing required packages for building Cygwin
Message-ID: <20160629142745.GM981@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160628123927.6904-1-jon.turney@dronecode.org.uk> <20160628132120.GE23625@calimero.vinschen.de> <20160629080418.GB981@calimero.vinschen.de> <baf48ab3-351c-65c3-893b-cd59fb8ae16e@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <baf48ab3-351c-65c3-893b-cd59fb8ae16e@dronecode.org.uk>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00066.txt.bz2


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1265

On Jun 29 15:18, Jon Turney wrote:
> On 29/06/2016 09:04, Corinna Vinschen wrote:
> > Hi Jon,
> >=20
> > On Jun 28 15:21, Corinna Vinschen wrote:
> > > On Jun 28 13:39, Jon Turney wrote:
> > > > docbook2X is now required for building documentation
> > > > libiconv differences between x86_64 and x86 no longer exist
> > >=20
> > > Please apply.
> >=20
> > Sorry, but that was not quite correct.  Apparently I only skimmed the
> > log text, not the actual patch.  Doh.
> >=20
> > When building 32 bit Cygwin, you need the 64 bit Mingw compiler for
> > cyglsa64.dll.  The reason is that 32 bit cyglsa.dll won't work on 64 bit
> > systems, even if Cygwin itself is running under WOW64.  Since we don't
> > know if the user runs Cygwin on 32 bit or under WOW64, we have to create
> > *both* cyglsa DLLs for 32 bit Cygwin, while it's obviously sufficient to
> > build only the 64 bit version for 64 bit Cygwin.
>=20
> Yes, I somehow though it said mingw64-i686-gcc-core rather than
> mingw64-x86_64-gcc-core.
>=20
> How about the attached?

Should be fine, given that cyglsa is plain C.  Please go ahead.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXc9rhAAoJEPU2Bp2uRE+gJcUQAI0Potev6+pRq5xMVYjUevej
wyrOCwe4m5vLvg2L3VJldWXBZ5ynH7xApMz5kzn0GY4WEU+R/mVMxZhFqrgP6WYP
NbIzt7EU0qXSkP9ePLEQxU0hH4utt8kYTLIa1b2NW7XnCnJXbNtXuoS6sEhV50fu
8Qd1VHtFUjk8ENdBd1cl9848qGXle5KqzcDl1Skeldfnjw9TBOsQ0COiXlRiIQKn
Pez+CICwTzZwe40/xC8mlfeSQHQARnh4iywMjq4HMuFiWSniuRKm2fN/YkvBnyMY
1di628dy2f2G+gwBgonxiXB0zJRVDpTvUn8vGH/cvOE8Wul3IoozABDYGGRvm990
1YN6e3ZcNoKyM3/qzsaLoffW/0AM+f4c1rZ0I5pQDOc3NEAh1V2YoJ7NXFAiU61z
NTzja/El/B/h9mqGrWh2wqR1MtLAZIRedy0JZDxecukvzIF7oJHaMo7zTiePtMz0
P3JyFrIEfSsC80b5NyTB13BCW1E3UO0HaravTiRwnKYY3zRjUAc04Rq6duZ+v61j
kBeUlMOS9dlUUJ0NmKsLDbUflTcAJCWMjKC8EDgeswKxu8vo3WUM3jhzNZJXAGrJ
4agH6q8J4n55XhveeuG6Qd89zWOyeUe/fzYFt4CO46AaSWWUNd4maUpyi0jgHeF6
ZT5ddaB1WjmjC+flWzHd
=hNSl
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
