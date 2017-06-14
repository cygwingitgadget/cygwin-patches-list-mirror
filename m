Return-Path: <cygwin-patches-return-8782-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27107 invoked by alias); 14 Jun 2017 10:35:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27093 invoked by uid 89); 14 Jun 2017 10:35:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 14 Jun 2017 10:35:44 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4EB4D721E281A	for <cygwin-patches@cygwin.com>; Wed, 14 Jun 2017 12:35:46 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 84E525E0402	for <cygwin-patches@cygwin.com>; Wed, 14 Jun 2017 12:35:45 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 69008A80706; Wed, 14 Jun 2017 12:35:45 +0200 (CEST)
Date: Wed, 14 Jun 2017 10:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] readdir() with mount point dentry, return mount point INO
Message-ID: <20170614103545.GB14171@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <59402B22.4060001@pismotec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <59402B22.4060001@pismotec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00053.txt.bz2


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 813

On Jun 13 11:12, Joe Lowe wrote:
>=20
> This patch fixes a minor compatibility issue w/ cygwin mount point handli=
ng
> in readdir(), compared to equivalent behavior of Linux and MacOS.
> dentry.d_ino should indicate the INO of the mount point itself, not the
> target volume root folder.
>=20
> Changed return type from readdir_check_reparse_point to uint8_t, to avoid
> unnecessarily being implicitly cast to and from a signed int.
>=20=09
> Renamed a related local variable "attr" to "oattr" that was eclipsing a
> member variable with the same name.

Pushed.  Can you please send patches in `git format-patch' format?  Those
are nicer to apply.

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQRGBAAoJEPU2Bp2uRE+gM/YP/208U28wVVEGHf1Yuk0qYaYS
hTwg6FAR4uf2Cr5iyRcbupUattc1WM+7dnfZyPxf1B+Vr13h4CE4r2vNbQ4CrxOk
V0M5V5ngMoJwfdmGkJJiR6Bb4UbAliNi3RtkP5oT7xSCVbFhf1uA3UMSZ61sTOPU
p4FbnTnl6R9pIlCIlTYziEKWb9vCoTo00bW8z9TNcBl07Dk1CcfNjKlcEumirzi8
hjR1I8PYeaVfzKW/k6pPnw/uXtuNtAWqLF+iQcaeNUVgYi93dHyaa8y9o9Vwr5To
05QwzKLE3dkabF7LDGc7JM4BNWSYBGdY9aKnsAz459SAR3dxKm35Gh6bax/HOdny
lQvPZVPxtQBRSV7TcocdGYVXWAAsUBKm9cqs5C2Yi+JH7YNxxLkLrI8Hzx4514hL
GmYwvDs6I2APsLRPbNhtwh/dioG0NvW2QthMfu1yIk1/Ghp0TSAq6hJxHzln8+Em
Hfk57/D3kZ0ME0se35BUFuGyqGoVH36jO/9Kbs/x2KmYIr7KChuO/etcIslcyv8c
afETHrStP48rDSDmN4HwE4Ppq0a3ZI0zbnaRlkO14+frvfgp8DcpmB2oHN7ZswIF
TEyaPyKWZ/PChH/0j/kucox5bO9FtGOLpDNgO943ePO6dRjIqYYFNVfQpPgiFDE2
/t220ld+0vpitOGrTY3p
=7mj1
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
