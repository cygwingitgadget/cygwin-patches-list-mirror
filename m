Return-Path: <cygwin-patches-return-8460-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72914 invoked by alias); 21 Mar 2016 19:28:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72895 invoked by uid 89); 21 Mar 2016 19:28:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:28:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C7EDEA803F7; Mon, 21 Mar 2016 20:28:12 +0100 (CET)
Date: Mon, 21 Mar 2016 19:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/5] Add nonnull annotation to posix_memalign.
Message-ID: <20160321192812.GF14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de> <CAOFdcFPxwdnyjbtAm5FVD6d4DhZB9Cm80kPzzNVaCPKfN9yX9Q@mail.gmail.com> <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00166.txt.bz2


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 618

On Mar 21 13:15, Peter Foley wrote:
> GCC 6.0+ asserts that the memptr argument to the builtin function
> posix_memalign is nonnull.
> Add the necessary annotation to the prototype and
> remove the now unnecessary check to fix a warning.
>=20
> newlib/Changelog
> newlib/libc/include/stdlib.h: Annotate arg to posix_memalign as
> non-null.
>=20
> winsup/cygwin/ChangeLog
> malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8EtMAAoJEPU2Bp2uRE+gq5UP/2jUOxni8c5FGkBv4zdbB6bF
75uyy4dpE1XYYd6aaoFEN8LE45OCCdRi3jP1BHABbQeEhz8hgWIKCzah8SbDdFA8
dCx2j7lHGOf2Q1bLmayypr6xvcnI4UTxmXTJ1BYMFka38PyxTES1D+KwQItaK0Es
zzYAVvaGW07M2vtKnmMUWY1bdMTPNEfebMj3wGS7eqYQf5c2wNKxsj65BNM6J59h
jAF6bgiuf3KM2ilyvlpg2B7JJgkiRYH/CKqzhzkxpAVDbJ/65wmKY1OCB26Kwq6M
xEPZM1jwbDzCnDzSsXzZBHag347QcDT91Q2fayGccrtQdc7SkqFUPd1WVkqlk1Jy
J2E5dAvKfVAQvVqZBHpmj7i/wDZtk/hPEmBMMbepIRSHy3hroGLtc0XkvhUdnKlI
rN47ZoZPZikVYLFNCToH7mC0UQs9NbwE11O8MFGznz1COYBPwgYT8XpEUtzp1hN9
K6DeaLXLZlhE0oCcAswPfU9hej+nbhYYMzOkd4UYWpq2N5It47ZVjlldTuZV+UG6
nLV2yVUvO5RgiJPQgZDXyhD8fw/fI4Uul18XFRngbEWSKjZLT5q0mubZJQfGFIqC
6/zYpvvvCz4BJfks+uRIDgZnX/2gPTaDscjFSIXa4feahRsJ35KEuM13sWqFA1Du
AoBJtJpgDO5WD+FJnq7c
=MQzO
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
