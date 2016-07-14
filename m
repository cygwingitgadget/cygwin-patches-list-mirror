Return-Path: <cygwin-patches-return-8600-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95578 invoked by alias); 14 Jul 2016 17:12:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95499 invoked by uid 89); 14 Jul 2016 17:12:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Ray, states, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Jul 2016 17:12:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0A4B5A803F7; Thu, 14 Jul 2016 19:12:16 +0200 (CEST)
Date: Thu, 14 Jul 2016 17:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 01/01] machine/_types.h: __blkcnt_t should be signed
Message-ID: <20160714171215.GA19533@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOYw7dtjewWMjXR2iO5454smDBxDKkLP9HirZzT4hPqMzZdpeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <CAOYw7dtjewWMjXR2iO5454smDBxDKkLP9HirZzT4hPqMzZdpeQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q3/txt/msg00008.txt.bz2


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 616

On Jul 14 16:37, Ray Donnelly wrote:
> Hi,
>=20
> Please review and consider applying the attached patch. The commit messag=
e is:
>=20
> [1] states: "blkcnt_t and off_t shall be signed integer types."
> This causes pacman to fail when the size requirement
> of the net update operation is negative, instead it
> calculated a huge positive number.
>=20
> [1] http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.=
html

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXh8fvAAoJEPU2Bp2uRE+gScIP/2gJj4QAiG+I2kbG06+c+O1k
GH+1vTZZ2vm/ac/E59GR0muzNJCH9ubd3zVwV6bvQPdXf38R/bWXjGTmq3awbO82
O0FawzZBoLIG2gGpnfE72pu3MgqRNYYE7SKi52Pah0BQlzCZouaknIrvwd91CXjH
tx92JAqb5W76jDf9+VGhLJVi+FCqUBy50blCNna8FvPHIm3KaRboVePNgU5TTc/Y
4wfB17EbISOq8Wm6/HvCKz1C8wVvL2CY+emRU6e0B3sC6ix6hkbNoF6Vq/srQHDD
Q43yHUrNfOamsJs6c5h1/L+pSXURBELyXNQAiZP+A8v0ts12NIxorypA7/KPJaDh
zanWsw31IDpiy+2bClDC5mbw5z/B4ySU2k2LG54dBSL6Gi2XxtMw3sg/xR62iqyY
NQV25hhaIlcWAXGMEaQ/gAVybYdQFs74KUSDEf5D67GM2uV6tXIb+ip9w+bWEvMp
uVh85l4j3hWyfYz34McmVk5F54998CrDUT/YYh7uiRf0Li3KkRZMENxFHukcthUd
apjZDvqFe3Grun697KKntXyjWLNVTMXVv/6pfD6HaDJPPs1VOkXZOCJF3jpjCAoh
+x9EldSXyY3H11s60KleV3WV55sNC/A2w7LMgdF5ADK2t0JZfTRCEtnYT+bSZVq3
OLKxMDnLbhBcQfGw6BlQ
=QkZB
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
