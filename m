Return-Path: <cygwin-patches-return-8165-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95882 invoked by alias); 15 Jun 2015 17:11:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95872 invoked by uid 89); 15 Jun 2015 17:11:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 17:11:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EFB39A807CE; Mon, 15 Jun 2015 19:11:47 +0200 (CEST)
Date: Mon, 15 Jun 2015 17:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/8] winsup/doc: Convert utils.xml to using refentry
Message-ID: <20150615171147.GE26901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline
In-Reply-To: <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00066.txt.bz2


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 655

On Jun 15 13:36, Jon TURNEY wrote:
> Convert utils.xml from using a sect2 to using a refentry for each utility
> program.
>=20
> Unfortunately, using refentry seems to tickle a bug in dblatex when gener=
ating
> pdf, which appears to not escape \ properly in the latex for refentry, so=
 use
> fop instead.

Uhm... wasn't Yaakov's patch from 2014-11-28 explicitely meant to drop
the requirement to use fop andd thus java?

Is there really no other way to handle that, rather than reverting to
fop?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVfwdTAAoJEPU2Bp2uRE+g60AP/ihrMwW4tmP+K28BSSk+RheK
9TDEgSacliWteULBK9J+Ort7G5UmrieaJIOnPuSjek4kv2TJUSwrN1e4fsROzph6
x49FLP1xYdDxdO9TOEb41uS5yu8Nd6oujW2czP2P3yoe8oyeWeWaPVXWhZbufz/Y
91CAe/7iGXV6N5D6dox2j+JSoPY73Tusu/rZyXwZvYogjfSaMwO4A7rsPpqe+Ydo
ctWyKlxHAKrhxAgL4IHLXRD7iKwvXp+ZskjRwzZH+YHWGpK4WX/kTtlvLUHDNX3c
c6RrR/hyRItKs9HBhpmsIKH9lMh8JtM3xUKCROwiIRMc2asn6f/FtIOZq59S0lMY
+QiszNVp5S5FAcZBI/y7uESB3Q4PRvau0noxfIwyDXHFpIThbMu2XFOXXNoU9TuE
pg5WpM9H7el7OgjI+TCI4Yddl27qKUB/rd8Nbhhwh1T3+YhTTqye9IPq4ffxL0yp
ObbvT0v/IB/QKXJ3kZI/sUHq9rCYgYiO2tki9Wehda4LEQYm90jAby6ZOL+BDHst
At3ZLsxMiXVYuop1vewa8JDTebmdFQWMQ2pg09MoMEEAjSakOIOm8lWPh1ISbL+X
YFiFPKpuuIsAGxHIeH6fvx/2AKKB9uWIWFpHrCb1v+uazO9XOKmIMFiN3dwu89c/
ZQTyLPAAy7lTpfJrqhti
=RKQK
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
