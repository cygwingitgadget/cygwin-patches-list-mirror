Return-Path: <cygwin-patches-return-9609-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80432 invoked by alias); 4 Sep 2019 10:11:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80420 invoked by uid 89); 4 Sep 2019 10:11:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_SBL autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1204, management
X-HELO: mout-xforward.kundenserver.de
Received: from mout-xforward.kundenserver.de (HELO mout-xforward.kundenserver.de) (82.165.159.8) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 10:11:45 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N1wdd-1iBjc435KL-012Klu for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 12:11:41 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0ADD9A80659; Wed,  4 Sep 2019 12:11:41 +0200 (CEST)
Date: Wed, 04 Sep 2019 10:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 0/1] Fix PTY state management in pseudo console support.
Message-ID: <20190904101140.GN4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014535.1328-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
In-Reply-To: <20190904014535.1328-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00129.txt.bz2


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1222

On Sep  4 10:45, Takashi Yano wrote:
> Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
> introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
> has some bugs which cause mismatch between state variables and
> real pseudo console state regarding console attaching and r/w
> pipe switching. This patch fixes this issue by redesigning the
> state management.
>=20
> v5:
> Revise based on
> https://cygwin.com/ml/cygwin-patches/2019-q3/msg00111.html
>=20
> v4:
> Small bug fix again.
>=20
> v3:
> Fix the first issue (Bad file descriptor) reported in
> https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html
>=20
> v2:
> Small bug fixed from v1.
>=20
> Takashi Yano (1):
>   Cygwin: pty: Fix state management for pseudo console support.
>=20
>  winsup/cygwin/dtable.cc           |  38 +--
>  winsup/cygwin/fhandler.h          |   6 +-
>  winsup/cygwin/fhandler_console.cc |  25 +-
>  winsup/cygwin/fhandler_tty.cc     | 385 ++++++++++++++++--------------
>  winsup/cygwin/fork.cc             |  24 +-
>  winsup/cygwin/spawn.cc            |  65 ++---
>  6 files changed, 289 insertions(+), 254 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vjdwACgkQ9TYGna5E
T6AiXw//a4MWyuqW9tue8CakCRK7T780geomlRTxz2dj2TGcUIL013ocQndo+TOr
X+PXDbPMt1CPAx/2kZSZRiLcIm0VWT1SrIE/hpoaMdhkfy6adnGXzjxz9vjKcBDv
Cg0pOPFQwGsD4Au+I7iz1lz4lU67bsisz4Et8N5o75nZe3zp1rKrgnlqu8uBgqMH
WN82yaGQVGeoq100DcA0Pfzx+rYN9rNxLf+dlJFDTd0YWB2f7bPGSddxpKAB99ja
ftsK1fBSsqO3qU2cuu3Ic54Rv3hklyfrEU91eGFeysw2BA5bmjdtH/bhImpcD41a
v3X0eowzLjzrDfPY8UAar/WN4dyAcI3+/+6lfz4wgbay/4cVUnZCsh+chhKv0cL7
2fLsUkAoE1RBLL1YG7lXiIhVnD6qvQPjFYCEI/YZVggp/DWc/FijRmI7pp1wqOf3
lK+H4TXLuzre6osXqsCQD1g8gRocT5AaGrH7FcoLxD+8M5AWDH+h/BWGgX2070AO
wpPEP7vLSnsI81UVTWra9RZ67IcaIcv3INDUMJIBolr6mSZNerOqPhqEG/jheS8n
3la/sXacyodKJBiG76roxTmNEQxsxirGsQsqufvGoLUDEIowrpnmhPwJyingAfIb
nV2xTzAdjFPjHn1ueMLJSWCn+XUkQI3EsU20NlGrjJahSephuTM=
=0nw7
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
