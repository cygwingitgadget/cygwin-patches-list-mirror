Return-Path: <cygwin-patches-return-8733-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121675 invoked by alias); 6 Apr 2017 16:18:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121662 invoked by uid 89); 6 Apr 2017 16:18:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:867, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 06 Apr 2017 16:18:17 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 6E2C3721E281A	for <cygwin-patches@cygwin.com>; Thu,  6 Apr 2017 18:18:13 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 547565E04D6	for <cygwin-patches@cygwin.com>; Thu,  6 Apr 2017 18:18:12 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 35FFAA80BBF; Thu,  6 Apr 2017 18:18:12 +0200 (CEST)
Date: Thu, 06 Apr 2017 16:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Remove "function" from line to avoid dash objecting to this bash-ism
Message-ID: <20170406161812.GA1554@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.BSF.4.63.1704052252100.72447@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1704052252100.72447@m0.truegem.net>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00004.txt.bz2


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 848

On Apr  5 23:00, Mark Geisert wrote:
> I've been home-building the last few versions of Cygwin DLL on Windows wh=
ere
> I routinely have dash set as my non-interactive shell.  The only issue I =
run
> into is this one occurrence of the 'function' keyword in
> winsup/cygwin/mkvers.sh.  This patch gets rid of the keyword.
>=20
> FWIW using dash instead of bash has the build running 5%-10% faster.
> Cheers,
>=20
> ..mark
>=20
> > From fb9db7a75c7e391f451cb1df3c1e8463ef4c7bf3 Mon Sep 17 00:00:00 2001
> From: Mark Geisert <mark@maxrnd.com>
> Date: Wed, 5 Apr 2017 22:20:09 -0700
> Subject: [PATCH] Remove "function" from line to avoid dash objecting to t=
his
> bash-ism.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5mpEAAoJEPU2Bp2uRE+gr0MP/2gjIH5lWI6g6aQntnKINHTA
RPjUOIndLKm6BimkDNp9o87eCQdCfKKXq5K3YKh22OSJP5twmw1Q2bcXD9HMCKgI
QdfyLBARsqt56GjKLroDWUa1EqOJylCdof6rpUGJO6yuVwLg8238k7j8tNi/bwvO
IEEzjTi0EI7rmXa8A0PwnbW0TBglkJSqJFhkJZf7MlSOhReRGKZFgtTtnvCnBNQs
o3PvjzM/5dNa9UD539AwIPUe8NupnWGC/rHBJqvAjw8Snp5tF5cR4ucoqhXGJlyF
rPqCIriBkwab+vXbpRFSyKHQ0QRNEqpqIt6TH4jEqlZjny/YlHqUiKhjafDyc+1z
muRUSVWwLJok2mO6XYM/EcU06qQOdRcildL3JSMVMxTP4p5UDz415LzSr2CS5or6
As3Dduz/QYLFBxilnTgumxSO3WhzZwJt4WugvNfyb810xViHqSr22Um76MWjZy0w
/59seyhctntyPlEMFhTi/DKcrUfwnVFlIknpfNy+FQzNP1T+7RNUxHFJOusgbdUD
5Gkj2oEOUyb+qcYS/32g1CGHGykSwwLNl5wvqWoMxQXWdBrOsCnD/ZrSdPGz/wlM
Q9CSH9v4fdKY1631P5QzR+2tLOX98Vo05mMmHVCF8sDVtsF6K6VgHSYtgGLBuNL1
glFjvDDEbVp5S6JbqxJW
=YwW6
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
