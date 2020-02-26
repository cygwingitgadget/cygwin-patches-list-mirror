Return-Path: <cygwin-patches-return-10133-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16910 invoked by alias); 26 Feb 2020 20:17:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16858 invoked by uid 89); 26 Feb 2020 20:17:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 20:17:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MStKq-1iymBf2J94-00UGPf for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2020 21:17:01 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 10CB7A8276B; Wed, 26 Feb 2020 21:17:01 +0100 (CET)
Date: Wed, 26 Feb 2020 20:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix size of a buffer in the ps utility
Message-ID: <20200226201701.GX4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200226200835.34501-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="HVCoas+krw6dou6l"
Content-Disposition: inline
In-Reply-To: <20200226200835.34501-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2020-q1/txt/msg00239.txt


--HVCoas+krw6dou6l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 657

On Feb 26 20:08, Jon Turney wrote:
> Fix the size of a temporary buffer used in the ps utility, reported as a
> new warning by gcc-9.2.0
>=20
> ../../../../src/winsup/utils/ps.cc: In function 'const char* ttynam(int)':
> ../../../../src/winsup/utils/ps.cc:101:23: warning: 'sprintf' may write a=
 terminating nul past the end of the destination [-Wformat-overflow=3D]
> ../../../../src/winsup/utils/ps.cc:101:11: note: 'sprintf' output between=
 9 and 10 bytes into a destination of size 9
> ---
>  winsup/utils/ps.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is already fixed in git.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--HVCoas+krw6dou6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5W0jwACgkQ9TYGna5E
T6AFXw/9EGDFq/rvfQiwKbyPtIIcrPpl0XCykjDJdkbIww+nR9UMMhqnddLrwMb2
Pzp7ayaX1zRsa7IonR1Zz6xFhvWK9fvyUBaJ9+hMtLA3SDy+1m1qOYqRqcS8hwmt
mim8HjZkCoRi93cXj3OPpI6aDaNo8pclsQi/IKls/lLvm8zJTI8ZRH/UbEAlmnyu
13z+8gSGl3LgwXItY12BPtGyl1a2ZrcT59XPAEZuotWqSLp2vM+njgzo4IQwezxg
A4xYBvd5HFgX4a9KxMIQJsdVpSNdHp2KNH7fzjU/uwpBYip0bykVpZqpFwq4TzAE
bbgbEw9JOBOSLVuL2wI/GWGjHLyNXVz+rsVUq6PlIOVwQepPFA4uQAqyl7hZffW0
OLdKrFFpujYD7oc0zKV5YiP0vT9Q8vVPU/bJN27Rt4m+OnixSbPdil7ndprmzBfe
dJ1vsQ+k8rD36hZhRny03bquE6pTDlJLPsU6xwXe4vj80T+IqqatW03XVMrVxC/a
wEo+j9LEoOggOAMwC+q0hR6d+XYENmCZMSFm9Yi7RXR2LO+nmkO6s6vRGIn6K+1B
F8DxbUNGGnYhMD5G1lNXtOi4mMg7MI8TbxoFMn46qtuAjEVUmXtcfMGg5XIbnPP7
QtFrFdUA2/lW26KyFO5fEE31SJ/VuNA643vnF8NonTHpUJ7s/r0=
=8Qb+
-----END PGP SIGNATURE-----

--HVCoas+krw6dou6l--
