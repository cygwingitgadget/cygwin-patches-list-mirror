Return-Path: <cygwin-patches-return-8679-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62144 invoked by alias); 10 Jan 2017 15:41:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62114 invoked by uid 89); 10 Jan 2017 15:41:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1551, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 15:41:30 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 09E2B721E280D	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 16:41:25 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 934455E0500	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 16:41:23 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 71743A8041E; Tue, 10 Jan 2017 16:41:23 +0100 (CET)
Date: Tue, 10 Jan 2017 15:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Updated patches for /proc/<pid>/environ
Message-ID: <20170110154123.GA24502@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170110150209.87028-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20170110150209.87028-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00020.txt.bz2


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1790

On Jan 10 16:02, Erik Bray wrote:
> From: "Erik M. Bray" <erik.bray@lri.fr>
>=20
> Updated versions of the patch set originally submitted at
> https://cygwin.com/ml/cygwin-patches/2017-q1/msg00000.html
>=20
> I think all the indentation/whitespace/braces are cleaned up and consiste=
nt.
>=20
> I've also made sure that /proc/self/environ works now.
>=20
> All new code in these patches is licensed under the 2-clause BSD:
> [...]

You don't have to repeat that for any later patch you'd like to propose,
I added you to the CONTRIBUTORS file now.  Thank you!

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> Erik M. Bray (3):
>   Move the core environment parsing of environ_init into a new
>     win32env_to_cygenv function.
>   Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and
>     others.
>   Add a /proc/<pid>/environ proc file handler, analogous to
>     /proc/<pid>/cmdline.
>=20
>  winsup/cygwin/environ.cc          | 84 +++++++++++++++++++++++----------=
------
>  winsup/cygwin/environ.h           |  2 +
>  winsup/cygwin/fhandler_process.cc | 22 ++++++++++
>  winsup/cygwin/pinfo.cc            | 83 +++++++++++++++++++++++++++++++++=
++++-
>  winsup/cygwin/pinfo.h             |  4 +-
>  5 files changed, 157 insertions(+), 38 deletions(-)

Patchset applied.  The formatting in pinfo.cc was still not entirely
correct, but I tweaked it manually.  Please have a look into commit
171046d.


Thanks a lot!
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdQCjAAoJEPU2Bp2uRE+gBakP/3ZrOLkjgV4G/j7KHSiGqKfS
peo/NpEuu7/pBzrSeKISuunJQJqeUkKANJPf2J6gHRhykak2QYMmCLSeNA1Hc1M2
zU739SJ2K5nYvZYZJvdjhXmMPqPdOhi+YHCtb5k75m3DQs81yAyiDKjQn0H38/98
KnLAUAa0nFpZRfg16ODKtOHgp8Hk3rnszLD3qVufpTJXeUTXHmgejpajV7GN00zD
nmPX3pHT9yRhM0ruXSGLmFEeeSKJLUrK3HgbvNJ4y6d2Wlg7YGcHLEiR7iRvqS5u
JsBYzMCDyGEsW+Y4v/PtxzYq1Qb+RRCf1mN+iM1tIRCYD5sQlqvXR9oHeH8/rnZ1
AazdGqoMuKDV40scEDIMwSzlSbOm9DyYfliP6gstnYy3Al9braW2v61a1vQMd6bA
91LezeJf96EM6OAkQYB+OQnsXtShdkcGGjD20VhGPqYBxIcWT8qY8Rz24kI0KQNy
KlIuYOrPNxwcPyiK3rkYWUIWYY6cfgCmr8SAbxsWGjxPFoO+Lfis9CWa6o8yafxt
6vm5nKAuUO+P3T0ROQM2P8DZjrqRlHcgqKwYnNcWTosIOoWo4dW3tXzbuRajms9o
Iqy3wscllf4VDvv+EVpGA+vg2JCZA0bgiEUNLbMwN45RBKRKK/vXL4dyLAOe9HEy
HvRQJoM17dBFKV4kn93U
=x7oA
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
