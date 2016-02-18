Return-Path: <cygwin-patches-return-8333-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47282 invoked by alias); 18 Feb 2016 11:30:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47232 invoked by uid 89); 18 Feb 2016 11:30:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.7 required=5.0 tests=BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=lightly, H*R:U*cygwin-patches, H*F:U*corinna-cygwin, ssp
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Feb 2016 11:30:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E621EA803FA; Thu, 18 Feb 2016 12:30:53 +0100 (CET)
Date: Thu, 18 Feb 2016 11:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ssp: Fixes for 64-bit
Message-ID: <20160218113053.GF8575@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1455792655-5424-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <1455792655-5424-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00039.txt.bz2


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 497

On Feb 18 10:50, Jon Turney wrote:
> Fix various 32/64-bit portability issues in ssp, the single-step profiler=
, and
> also build it for 64-bit.
>=20
> This didn't turn out to actually be very useful for what I wanted to use =
it for,
> so it's only been lightly tested.

Even so, better than today.  Feel free to apply the patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxattAAoJEPU2Bp2uRE+gH7QP/jzTfccj7YpcUGjQxwwu8gIm
mbSfYdrFA93KTEEcBaKxT3fuPGIUxhWSBCAYLLJWx0VWM27yuDedpJ7wKetxaC1e
SjofW//ef+LXnEnJSGMK6cUoybwcGmSisM3Ckg8aJqjGidG4pfIs4oVyVonIrCeJ
B/St9m+3zA9dB3pY0CkrA88XMem857EJwi6fSX+Oib0GKsaA8F19Zxt1jJj0CgjP
xnk7I4y9ofT+DNlC9a881h6ZYKaJs0GmKZBjRxkN54RKjqpGlvXBjkDb8dbc1zGs
Smvxzdh37Vnpxf1UwSrci5kzarbFYL3hRbkRnIsQhVxn2xduNEuzdWccWmHVnimZ
AhUIf4WRujzHVXxHNg1KcZdsaMaZ7ACJWcMonNsGyy3TrgYOxcEIEiE15FqG5lCi
HuTPrcEXof3BhDak7VYFRkL8V0rSMqgDTB9oAyx7ASXkhqtJHKdP8guh5fCu2KVI
CkX2MPvEqhYQMKjN0ftuQvOrLf094giYp2ZaglWCnmCG7Z+poDV+vaD0viRs2k5A
To2kyF4Nbo0RX8ZNudj7aQGlIoGGDIBpgFr+Us5bUxpOFWzHzk3Z5ZCgjWmvf5KR
e1ZjBciwHix1Y6/2LxZMpgL3UED1Qjlvt41b9r4Ov41KOt+ZWqdi1yiXud1irK0x
5qrFLZhaFjRJx5wfNI/A
=/kV7
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
