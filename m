Return-Path: <cygwin-patches-return-8430-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36400 invoked by alias); 20 Mar 2016 10:54:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36384 invoked by uid 89); 20 Mar 2016 10:54:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 10:54:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9D546A805AC; Sun, 20 Mar 2016 11:54:39 +0100 (CET)
Date: Sun, 20 Mar 2016 10:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 01/11] Remove unused and unsafe call to __builtin_frame_address
Message-ID: <20160320105439.GC25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00136.txt.bz2


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1636

On Mar 19 13:45, Peter Foley wrote:
> initial_sp has been unused since commit fbf23e3 back in 2000.
> Keep the value, so as to avoid changing the offset of magic_biscuit.
>=20
> winsup/cygwin/lib/_cygwin_crt0_common.cc:140:52:
> error: calling 'void* __builtin_frame_address(unsigned int)' with a
> nonzero argument is unsafe [-Werror=3Dframe-address]
>    u->initial_sp =3D (char *) __builtin_frame_address (1);
>=20
> winsup/cygwin/ChangeLog
> lib/_cygwin_crt0_common.cc (_cygwin_crt0_common): Initialize initial_sp
> with nullptr.
>=20
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>  winsup/cygwin/lib/_cygwin_crt0_common.cc | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib=
/_cygwin_crt0_common.cc
> index 718ce94..96ebeee 100644
> --- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
> +++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> @@ -135,9 +135,8 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
>    u->premain[3] =3D cygwin_premain3;
>    u->fmode_ptr =3D &_fmode;
>=20=20
> -  /* This is used to record what the initial sp was.  The value is needed
> -     when copying the parent's stack to the child during a fork.  */
> -  u->initial_sp =3D (char *) __builtin_frame_address (1);
> +  /* Unused */
> +  u->initial_sp =3D nullptr;

We're not building in C++11 mode yet.  I fixed that locally to use
NULL instead, which I'd prefer anyway.  Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7oFvAAoJEPU2Bp2uRE+g/WsP/j5npd1BP5tZiZcCkz5ttwkb
1qlLgUfOc3xwLoA0cQOH92ukDU+HwssKTNd26EcQ4IlMcIQayQby9VjzCBleBNLv
0mvTQzmmQThVLvf4thSsMUTI8TvmE107ihTQvfhDx55gPPxJ1TPY2KPvOtFBGrhF
o1tAhr8+C6021GMY9z8oyHWSOWS1D8LSOdBlwa6KtQ2ZLb8/Llrc1ZcvdxCA80QR
YcYucJqv61MwEnk3YXbaH2JL6MgjjfWgcoaFU3SMxLuDjhIJ0QTDHp2bAfgfSBg0
uGBx/II7rr9kXEVSZiqS31P7feVyohO4hiAuwcWOTzCOHTaL2V9FIROXX+qBEtYn
54rBiXs9kwb+KBd+oxROP72SRZuc8kjTMooSbhNzSxmuGRA1Od1w6UycaY0sqV1E
1R8h/2X66vzmZniFJnTSBF6sbHxvkLH+BjSV+op04H+TbbJI3z9tqRT9Bd0GGYj4
QPrFpI4U/LtTVuhU3rn8Mie3qDEfauLEXSS2nsgiWX/XuH7RaCyUqB0o4hsTlvfX
87Qq4HzD0KQiF6aV3LgqdcuxOfmA1f3w4SNnDx4rS/mr/LPFHSjwLeqn+T1/1pkK
h7VeFMyfqahhQCTehqFKbJJnzCGkwft5NmrNnHvV2zmG21yDCEUMqdyTDO6LdXc6
Ex4DzaW7JWKf/+i7h87M
=U/Vr
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
