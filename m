Return-Path: <cygwin-patches-return-8360-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31873 invoked by alias); 29 Feb 2016 10:33:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31847 invoked by uid 89); 29 Feb 2016 10:33:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.7 required=5.0 tests=BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=12,7, Hx-languages-length:1147, 2.7.0, insertion
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Feb 2016 10:33:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3B77DA8040B; Mon, 29 Feb 2016 11:33:39 +0100 (CET)
Date: Mon, 29 Feb 2016 10:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
Message-ID: <20160229103339.GB3525@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56D3EF72.20504@patrick-bendorf.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <56D3EF72.20504@patrick-bendorf.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00066.txt.bz2


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1152

Hi Patrick,

On Feb 29 08:12, Patrick Bendorf wrote:
> /winsup/
> * ccwrap: fix build with non-english locale set

First of all, why fix it?  Without at least a short explanation what you
observe without this patch, this change seems arbitrary.

> ---
>  winsup/ccwrap | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/ccwrap b/winsup/ccwrap
> index 7580e7a..ef83085 100755
> --- a/winsup/ccwrap
> +++ b/winsup/ccwrap
> @@ -12,6 +12,7 @@ if ($ARGV[0] ne '++') {
>      $cxx =3D 1;
>  }
>  die "$0: $ccorcxx environment variable does not exist\n" unless exists
> $ENV{$ccorcxx};
> +$ENV{'LANG'} =3D 'C.UTF-8';
>  my @compiler =3D split ' ', $ENV{$ccorcxx};
>  if ("@ARGV" !~ / -nostdinc/o) {
>      my $fd;
> --
> 2.7.0

That won't work nicely for non-Cygwin build systems.  When cross
building Cygwin on, e.g., Linux, "C.UTF-8" is an unrecognized locale.
Ideally the above would test for the current build system being Cygwin
and use "C.UTF-8" on Cygwin, "C" otherwise.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1B6DAAoJEPU2Bp2uRE+gdmMP/RCoq655TleUsqKHbcHMvJFm
ck7TkyVL2/Ku+AvFQSCj8G/Uz2MMu0FD7pdlmmIQGKtjwqkbo0wGBMYGXZVoRb2c
KiSvuuc7C+ii9yaS/JTeqTRY/59bDY8jBjYUkwpuV3mkKM3QK9NRCtUZJdjDnWbL
22gHbO7h6A4D9Y70iJiiIWs/VRC0RFolVW0qR248CXz60KZE9XDZX5O5pY5opy1C
DA5bt6780yEUL4++1kO/t1idqoZ9iybrZQ+lkxayw0rGq50/zKw6MPokSBfDN0xc
S/rqbygdRiolHv5sV2iF8W82VhMiZEDicIQpC+AsQXKUfsvURVZTqDPooXidgqF4
i3GhqExkzSv8X3TttsXAPzt6ugX0TRn5FezEX2Fjqnq1mBMnzjl2ZCaASnhc0b9i
M0KZfHbO7JMDn1Op4fiFpnCTR/3dUwVG68bjcFYlUnAep6ll53R1PBXeQxMVJDUz
W+mXXpcqIfgHjj2zMlo7MomuGOxp9IhFsiq9OP66AW4KrSJzphiwS3PNohPRoUyW
rc2iWPMm1dF9zp0JCDvnGQPF8mHMnhv0Tqsyq/daaa/tqnFnm7yktHm7DVcvtx5S
p83vAdTbhgCcNkzYc/qL5SmZI+yFwDyCMkieoS7R/Lv/EM8fQ9isQVCnhvZoJYlw
VjOBJlwsUn7CGLpTumkk
=ygU3
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
