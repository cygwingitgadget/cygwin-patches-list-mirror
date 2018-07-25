Return-Path: <cygwin-patches-return-9148-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111927 invoked by alias); 25 Jul 2018 07:44:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111915 invoked by uid 89); 25 Jul 2018 07:44:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=night, Hx-languages-length:719
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Jul 2018 07:44:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M5P83-1fvNJG1iHP-00zXTv for <cygwin-patches@cygwin.com>; Wed, 25 Jul 2018 09:44:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D9DC2A80D17; Wed, 25 Jul 2018 09:44:48 +0200 (CEST)
Date: Wed, 25 Jul 2018 07:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH final] POSIX Asynchronous I/O support
Message-ID: <20180725074448.GH3312@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180724053159.2676-1-mark@maxrnd.com> <a6116d52-d1a0-65d2-6bd4-be1e97d40a62@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <a6116d52-d1a0-65d2-6bd4-be1e97d40a62@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00043.txt.bz2


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 715

On Jul 24 15:29, Mark Geisert wrote:
> Last night I wrote:
> [...]
> > The implementation has been tested
> > with a couple different spot-check programs, as well as with iozone for
> > stress testing.  It's time to open it up for wider usage.
>=20
> It just occurred to me that I could provide my test programs as source or
> exes if that would be helpful.  Source could go to cygwin-developers and/=
or
> I could host both source and exes on my GitHub space.  Let me know.

Just keep it on Github.  You can put it under the Cygwin org if you like.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltYKnAACgkQ9TYGna5E
T6CR/w//WQczyv/bQ1Is+CSYrWaJx8EvKUgkdCE/kZPv4yT/mbyBGbIRifj4dGku
swdtJS0Ize4cQrsireqjH/s4IZA0vZP4tG91YoDDqy74mxuwoMizjwsxhcqcJxcG
8KxSjlBN/wcHo3Qx+n3FZRw9LyycwBwTlVIGITnCP4m3nVhAswIk3nts1CFCzNir
U6YVNib+tHQJoudWaYzWB+MRqfap/b22PQOrwwjn8MQ7NlmaVxc/sSbXuSDiBwt8
tk1u2wBD47LdK4TP6fAYDoG3PnSyg/rQzsIvGdimTlH6nwmGOLw8ZSRWwNLVYvy0
g9YhD9OUtwCgkgcgEVdNs7S1apW82mUt/QjvoEqXcVGKQM75EzvwTSnYCLVP0O3q
V1Tp0xq+G7+ca3aE0qoVjPKiR8t6F7ssXkHdfn4mH9WtLJ8QoADH/S2ncQ12umPC
UAgVlI3+RhuD/WvlSKlNiACfDGDxlWmu0XzYN3Hwvl2q2flsygZNgwCE/4VEtrRy
JUgbAYtsiHq7POETEk0m+WhEQSbPJK/MYNoSPHbCsliC4m7ERBEF89RnLXRYc1Or
MyHL9pg45umRKGXY0GMtsnpqlRmffSbjO8xGpWTsXO8mIkzLTEELykn+9WBbBgBb
K+nmCox2CSBrh1W4pBBR246JAfsGPiDw49R9fk7Sq0INzTIYt9Q=
=omF9
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
