Return-Path: <cygwin-patches-return-8589-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35018 invoked by alias); 29 Jun 2016 08:04:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35000 invoked by uid 89); 29 Jun 2016 08:04:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=mingw, WOW64, wow64, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jun 2016 08:04:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B08E4A80959; Wed, 29 Jun 2016 10:04:18 +0200 (CEST)
Date: Wed, 29 Jun 2016 08:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update FAQ listing required packages for building Cygwin
Message-ID: <20160629080418.GB981@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160628123927.6904-1-jon.turney@dronecode.org.uk> <20160628132120.GE23625@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20160628132120.GE23625@calimero.vinschen.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00064.txt.bz2


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 949

Hi Jon,

On Jun 28 15:21, Corinna Vinschen wrote:
> On Jun 28 13:39, Jon Turney wrote:
> > docbook2X is now required for building documentation
> > libiconv differences between x86_64 and x86 no longer exist
>=20
> Please apply.

Sorry, but that was not quite correct.  Apparently I only skimmed the
log text, not the actual patch.  Doh.

When building 32 bit Cygwin, you need the 64 bit Mingw compiler for
cyglsa64.dll.  The reason is that 32 bit cyglsa.dll won't work on 64 bit
systems, even if Cygwin itself is running under WOW64.  Since we don't
know if the user runs Cygwin on 32 bit or under WOW64, we have to create
*both* cyglsa DLLs for 32 bit Cygwin, while it's obviously sufficient to
build only the 64 bit version for 64 bit Cygwin.

Care to fix this part of your patch?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXc4ECAAoJEPU2Bp2uRE+gOnwP+wRdvP5zmYYClFBr67gMXhK+
HaakBaxf+mMqK5U86vqzFjf4tB8V/0mpR8oW/8bF10VgPD/NKSc5ChqdM4YCfC41
5Z4bovc5qGKrNF8HMC/Cw8vs7LktE//RK74G18ddN+U1vEdSlq8P5P+kTKOFqN9U
90cMP32wxOtq9P0m0JOHdAb4sKD3by4y0vUPQ4lQVHMYe/6Ns8lG70hWzUmfeHw3
JnZEuYwBi1OxvkSG40IUlchq8CTDKue53DpRoJ7ZYu8WUPhjHg4EYigdZRVMlchx
OqC8lwyza6P9bbbAaCpcw/bVdeT4F8amXdZ4w9iYZLLhEAG3jM7MLsOjRHfOaIX6
6XiFP4K0NHqYUwYktVQ+2fBPN61JsNjga4sVfG7tCd/i/GK1V/w4Nb42XjKU+SPr
RrAAIOEw0qEmM1tHtQhZ4gqhSSOjx5voDll/MQ+lUiwXqwWDpCSgvnhNODlUgG7O
KyG+Hpia7FPMmV8DcwdGBaaY8jld+Qd00OVJvH5miQxXYU8/mk+Wr0abGouSnRvd
dlStQfq/XPYbjrm4z5+cvOo9l8Njhnaguuybvb33OAm9kZmts365l18nYaqpRD8K
Yc72IrJX0bTmdyQ2ICRVOA9iD+I4aq8S3W8kZlPOg0rIMgzhEum2ZLydWf9uiRYN
biAMMh46AZwpNND1nyPh
=sGVQ
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
