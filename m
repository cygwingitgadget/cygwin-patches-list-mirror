Return-Path: <cygwin-patches-return-8277-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55022 invoked by alias); 26 Nov 2015 09:28:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54546 invoked by uid 89); 26 Nov 2015 09:28:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Nov 2015 09:28:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6495BA805ED; Thu, 26 Nov 2015 10:27:58 +0100 (CET)
Date: Thu, 26 Nov 2015 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add MacType to BLODA
Message-ID: <20151126092758.GA3677@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5655AE66.5070208@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <5655AE66.5070208@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00030.txt.bz2


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 530

On Nov 25 13:49, David Macek wrote:
> One more patch. MacType was observed by several users to cause `GPGME: In=
valid crypto engine` failures in MSYS2. See <https://github.com/Alexpux/MSY=
S2-packages/issues/393>.
>=20
> I also removed two full stops in the sake of consistency.
>=20
> 	* faq-using.xml: Add Forefront TMG to the BLODA

Thanks David.  All patches applied.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVtCeAAoJEPU2Bp2uRE+gGvsQAJlwb+sxIkpyJ+KqUIU+4bAz
qffp8X5MA/D029tkh3brvJlq3ZwM8njaDOe/m920sO1sDZwcjmnh45ufhcphVX4H
w3yMsaSbcJLWgUYZhXpIUnWv4LaaNwMD6FggOC8wXF5etPZ7R/JRkXuyWc2PpoOb
RN5wh7d9kniEeNTgzDjzsAhY9qpS9BieVnN9h5oATgxtFpuzTtm3nsL0KQCx3onA
VmlNHbZULqcGWKWpzTeeXL9cDzemEY4xHJUs9oLfsIjhoLxs08D52vLs4t+KpTqe
UseJ4vYTB6CPcmP/iXU2cE3R2FzNBwfBknQT/uVmFbXP1+tQ8hq8weyyjDMI2iYX
va34JeJVV7LiNDiYj4OxrqatKsX2Wse8zJbKzhycA76ASRKEn7Ydp8o1ToKLX6Wb
ipT15JV+rUvyXaPLJlAYOfm7OSotY55PxVTPsDvNth0TjJRAkBtxcxSGPdxIYKQN
orklthkMpFArRIHEikcM/0vuw4n3MSV6Yx3iiH00ElAAkkjGPMOdvhxaCbx1HWG6
RhLEupziGvXXGaUPfchZsFhXFnMpuW530so/9k/MHxO6pFs3+QPtQA+O3FOtiM5Z
opl6PS/ht/NPLuh6FXhH3/l5Qz7IQuffS1M7hNCttdoVy+0KfleTkzjZVpnDf3N5
xkZPcHgeE07z2u0fU3Bl
=myLZ
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
