Return-Path: <cygwin-patches-return-10142-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87468 invoked by alias); 28 Feb 2020 14:47:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86919 invoked by uid 89); 28 Feb 2020 14:47:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 14:47:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MDQqe-1jI6Eq1Mik-00AWao for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2020 15:47:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 03EB7A819D3; Fri, 28 Feb 2020 15:47:18 +0100 (CET)
Date: Fri, 28 Feb 2020 14:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Adjust the detailed behaviour of ESC sequences.
Message-ID: <20200228144717.GJ4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200227023350.868-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vKcNkqnJHUUp475E"
Content-Disposition: inline
In-Reply-To: <20200227023350.868-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00248.txt


--vKcNkqnJHUUp475E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 448

On Feb 27 11:33, Takashi Yano wrote:
> - This patch makes some detailed behaviour of ESC sequences such as
>   "CSI Ps L" (IL), "CSI Ps M" (DL) and "ESC M" (RI) in xterm mode
>   match with real xterm.
> ---
>  winsup/cygwin/fhandler.h          |  1 +
>  winsup/cygwin/fhandler_console.cc | 51 ++++++++++++++++++++++++++-----
>  2 files changed, 45 insertions(+), 7 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--vKcNkqnJHUUp475E
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ZJ/UACgkQ9TYGna5E
T6C64hAAkRl7MivK82/W7xxK2mQ1gibE6tovFfAL0qaAKp9ALNtaJWi3uh4LN86c
TlP9kbhTyKTbSczP+iCLXdLmKD2eQRstfOuVYZRkNW/Yhb5f23613Z4CTZ1GQoBH
pI9rPV89Cip9VGv2hyvvbMEf7M4N5aNaBXZLcAIC+l+/H+4XqDXGdSzDWeUbHOJ/
j8zTOe4CbrV5Qj/tCEF2yazagI+Tnn57M4QpF03dlfeQRlBEDRQtO+OIWcwgGzuy
MgdyHyDZGl7CQPm++4mOIyG3sb3rb7/InVwZwCpwsZLampYcv/OYQdPnJrlhoaYM
CQ8Ufk3K/Dxlr+bgMReOIirkadOdNxsgmLA7VvRYZfNjf3k17KWMfdaVzLp3dPBU
T5XANHmjCjTwN48kSAqbTmBwHG3Zwool2KG8p8g5vxay9EOU/UO7bxpc1+/ucUn4
wZVzg38eWPN+wuEpDb72PaCRkIdyQ6W4icRN4nzv3ChAcXxu4+9TOWwAuK12T+td
4/MHGxVyVKZv3jD2Gh5X67WwWau7hmC9IIjYngij5wbs5Jt30DcR9BI1sJ2d2kMU
8f5/lWQ1OcbClZydFFT0YxnLOYzABajhUVOBykgpXLunHMJ/cq+o29+/Kg1psln4
ZKPP2ydm7/Yhcf5B2rFpMfn7JYCW9wSVIFqhxWWlLhP+OINe1AM=
=WAfM
-----END PGP SIGNATURE-----

--vKcNkqnJHUUp475E--
