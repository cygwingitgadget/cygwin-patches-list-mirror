Return-Path: <cygwin-patches-return-8501-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 69347 invoked by alias); 30 Mar 2016 12:31:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69334 invoked by uid 89); 30 Mar 2016 12:31:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Mar 2016 12:31:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A3D71A80909; Wed, 30 Mar 2016 14:31:08 +0200 (CEST)
Date: Wed, 30 Mar 2016 12:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Use just-built gcc for windres
Message-ID: <20160330123108.GI3793@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com> <1458740052-19618-3-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <1458740052-19618-3-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00207.txt.bz2


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 777

On Mar 23 09:34, Peter Foley wrote:
> When building cygwin in a combined tree with binutils,
> the just-built windres cannot find the just-buit gcc automatically.
> Parse the CC env variable to use the correct compiler, rather then
> falling back to the build-system's gcc which does not define the proper
> preprocessor macros.
>=20
> winsup/cygwin/ChangeLog
> mkvers.sh: Manually specify preprocessor based on $CC

Are you sure this works as desired?  In my standard cross build
environment, the only -B option added here is

  --preprocessor-arg=3D-B/build/cygwin/x86_64/vanilla/x86_64-pc-cygwin/newl=
ib/

?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+8cMAAoJEPU2Bp2uRE+griUP/iIDPJXJikbbRWEA9lDKxtvP
rTFJ8WpwVcp+fq4ECOQ4bjxbqK7iaINK8s1OWfN6aIlzKBqae8spDAzyJ71+WIfA
JBoLfuK6bY8uGGBaStioz6G9FevYML8uZx6tEETBhkp4WOhJDtkUd8Wub+sebJRO
OAYTxyYI0VHVaYK9ei7uFeP1rHvUDMKemNF2p2t8crJVcgTD/NVJV+PHQOXtcaQN
PUyO2wjAzz81TNPSDxDgbJr6E1zwETIZeBXaULgZoWDOvXV3ZiJvx6rOHBGqFcFm
065q7Hu174DZI48XM+VmQgvcWtpMXxb1sOGNjEFAzoEkb6EoE2TQU1EI1C2PkYoi
P6dZvgTat3ly7jas50C3K9TLZA8iJEkFqEY+nLv/rCBdSaccoM43E6SSZiE9ur49
GbKgVy9hBziHhEC5jg/Fu3NZqBXZHY/SrqNrSLjufjSzUNbVIeaPkXNASoTipxwo
odAMUsajQ6injGLD5LynlSgUfyUplHQkrPVc975Ld6DOR3R4Xb+a6Iq5Sz9jgaej
dC+FiQKCcZDTFGjct9VCVFn45dwuVhTAxTqOwScWA9XLCXD7UsPR98qj02uFAbn/
5EWnvOQtG9SIQfNAm5Te7emyi3kyBQZoH4mr+1zJyFrlJbxjDu1j/SewbfENJi5I
QabSoJRo2HEu883YCxWw
=dvHi
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
